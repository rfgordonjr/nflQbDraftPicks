library(polite)
library(rvest)
library(dplyr)
library(tidyr)
library(here)

## Get First Round Draft Picks ####
session <- bow("http://www.drafthistory.com/index.php/positions/qb", force = TRUE)
session$robotstxt$permissions
colHeaders <- scrape(session, query=list(per_page=100)) %>%
  # html_nodes("tr") %>%
  html_nodes("th") %>% 
  html_text()
picks <- scrape(session, query=list(per_page=100)) %>%
  html_nodes("td") %>% 
  html_text() %>% 
  data.frame(., stringsAsFactors = FALSE) %>% 
  slice(2:8273) %>% 
  mutate(row = rep(1:1034, each = 8),
         cols = rep(colHeaders, 1034)) %>% 
  select(row, cols, value = '.') %>% 
  spread(cols, value) %>% 
  mutate(Year = gsub("^\\s+|\\s+$", "", Year),
         Year = na_if(Year, "")) %>% 
  tidyr::fill(Year) 
  
## Get List of QBs to start in a super bowl ####
sessionSB <- bow("https://en.wikipedia.org/wiki/List_of_Super_Bowl_starting_quarterbacks", force = TRUE)
sessionSB$robotstxt$permissions
# colHeadersSB <- scrape(sessionSB, query=list(per_page=100)) %>%
#   html_nodes("th") %>%
#   html_text() %>% 
#   data.frame(stringsAsFactors = FALSE) %>% 
#   slice(1:6) %>% 
#   select(colName = '.') %>% 
#   mutate(colName  = gsub('\n', '', colName))
colHeadersSB <- c("Season", "SuperBowl", "WinningQB", "WinningTeam", "LosingQB", "Team")
superbowlQBs <- scrape(sessionSB, query=list(per_page=100)) %>%
  html_nodes("td") %>%
  html_text() %>% 
  data.frame(stringsAsFactors = FALSE) %>% 
  slice(6:329) %>% 
  mutate(row = rep(1:54, each = 6),
         cols = rep(colHeadersSB, 54)) %>% 
  select(row, cols, value = ".") %>% 
  spread(cols, value) %>% 
  select(LosingQB, WinningQB) %>% 
  gather(Result, Name) %>% 
  select(Name, Result) %>% 
  arrange(Name) %>% 
  mutate(realName = gsub(pattern = "\\*",replacement = "",x = Name),
         realName = gsub("MVP", "", realName),
         realName = gsub("‡", "", realName),
         hof = grepl(pattern = "\\*",x = Name,ignore.case = TRUE),
         mvp = grepl("MVP",x = Name, ignore.case = TRUE),
         hofNYE = grepl("‡", Name, ignore.case = TRUE),
         win = grepl('win', Result, ignore.case=TRUE),
         loss = grepl('los', Result, ignore.case=TRUE))
sbQBsummary <- superbowlQBs %>% 
  group_by(realName) %>% 
  summarise(sbMvpTotal = sum(mvp),
            sbWinTotal = sum(win),
            sbLossTotal = sum(loss),
            sbStarts = n()) %>% 
  ungroup() 

## Get all pro-bowlers then filter QBs ####
# 2019
sessionPb2019 <- bow("https://www.pro-football-reference.com/years/2019/probowl.htm", force = TRUE)
## Note that pro-football-reference allows us to scrape years subdirectory: ##
sessionPb2019$robotstxt$permissions

## write a function for the rest ####
getPbQBs <- function(year){
  library(polite)
  library(rvest)
  library(dplyr)
  library(tidyr)
  
  urlToScrape <- paste0("https://www.pro-football-reference.com/years/", year, "/probowl.htm")
  sessionPb <- bow(urlToScrape, force = TRUE)
  headerPb <- c("Pos", "Player", "Conf", "Tm", "Age", "Yrs", "G", "GS", "Cmp", 
                    "Att_pass", "Yds_pass", "TD_throw", "Int_throw", "Att_rush", "Yds_rush", "TD_rush", "Rec", "Yds_recv", 
                    "TD_recv", "Solo", "Sk", "Int_pass", "All-pro teams")
  positions <- scrape(sessionPb, query=list(per_page=100)) %>%
    html_node("tbody") %>% 
    html_nodes("th") %>%
    html_text() %>% 
    data.frame(stringsAsFactors = FALSE) %>% 
    select(Pos = '.')
  # nrow(positions)
  scrape(sessionPb, query=list(per_page=100)) %>%
    html_node("tbody") %>% 
    html_nodes("td") %>%
    html_text() %>% 
    data.frame(stringsAsFactors = FALSE) %>% #View() #nrow() # 2662
    mutate(row = rep(1:nrow(positions), each = 22),
           cols = rep(headerPb[2:length(headerPb)], nrow(positions))) %>% 
    select(row, cols, value = '.') %>% #View()
    spread(cols, value) %>% # View() #names()
    # mutate(Player = gsub("+", "", Player)) %>% 
    bind_cols(positions) %>% 
    filter(Pos == 'QB') %>% 
    mutate(pbYear = year)
}
# View(getPbQBs(2019))
pbResults <- do.call(rbind, lapply(c(1999:2019), getPbQBs))
beepr::beep(4)

pbSummary <- pbResults %>% 
  mutate(Player = gsub("%", "", Player),
         Player = gsub("\\+", "", Player)) %>% 
  group_by(Player) %>% 
  summarise(numProBowls = n_distinct(pbYear)) %>% 
  ungroup() %>% 
  arrange(desc(numProBowls))

## Join all first round qb picks since 1999 ####
data <- picks %>% 
  filter(Year >= 1999, Year < 2020, Round == 1) %>% 
  left_join(sbQBsummary, by = c("Name" = "realName")) %>% 
  left_join(pbSummary, by = c("Name" = "Player")) %>% 
  mutate_all(~replace_na(., 0)) %>% 
  mutate(everProBowl = numProBowls > 0,
         goodQB = everProBowl | (sbStarts > 0)) 
write.csv(x = data,file = here::here('data', 'data.csv'),row.names = FALSE)
