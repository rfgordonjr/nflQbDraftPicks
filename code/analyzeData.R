library(dplyr)
library(ggplot2)
library(here)

data <- read.csv(file = here::here('data', 'data.csv'),stringsAsFactors = FALSE)

## simple count of good vs not-good qbs picked in first round ####
data %>% 
  ggplot(aes(goodQB)) +
  geom_bar()
data %>% 
  group_by(goodQB) %>% 
  summarise(count = n()) %>% 
  ungroup()

## How much does it vary by year? ####
data %>% 
  group_by(Year) %>% 
  summarise(percentGood = 100*mean(goodQB)) %>% 
  ungroup() %>% 
  ggplot(aes(Year, percentGood)) +
  geom_point() +
  geom_line() +
  labs(title = "Percent of Good QBs Selected in First Round",
       subtitle = "Good means either started a super bowl or named to a Pro Bowl",
       x = "Year Drafted",
       y = "Percent of Good QBs Selected in First Round"
       )
