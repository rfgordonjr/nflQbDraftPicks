## Introduction

On the [May 1st episode of The Bill Simmons Podcast](https://open.spotify.com/episode/2CA9fancUIX8mcCvtINQCh?si=8j9liBziSxGXmAe7U7VpRQ) Bill says around the 32:58 mark that the Dolphins should have considered drafting a 2nd quarterback with their 3rd pick in the first round of the 2020 draft. Here's the full quote:

> Its 50/50 right? if you take a qb in the first round the math over the last 20 years say you have a 50% chance of hitting on the guy and there are all these factors, theres no way to know for sure... its 50/50. 

Let's unpack this. According to Simmons,

- The probability that a pick that is used on a quarterback in the first round is a "good" one is 0.5.
- There's math somewhere that shows this.
- Factors exist that support this hypothesis.

Let's see if this has any merit. 5 seconds of google searching offers nothing that matches this hypothesis. Its entirely possible its true, but I haven't spent the time looking for it. Figured it would be more fun to estimate it myself anyway!

Let's do the following:

- Pull all the data from first round quarterback selections from the last 20 years.
- Define what "good" means. We'll use a combination of these two:
    - Started a Super Bowl
    - Named to a Pro Bowl
- Find factors that contribute to the likelihood of "good."

## First Round QBs by Year

Here's the list of QBs taken in the first round per year since 1999 (excluding 2020 picks since they haven't had a chance to show if they're 'good' pros yet).

Remember that we're defining a QB as 'good' if they've ever started a super bowl or made a Pro Bowl:


|Name               | YearDrafted| sbStarts|everProBowl |goodQB |
|:------------------|-----------:|--------:|:-----------|:------|
|Kyler Murray       |        2019|        0|FALSE       |FALSE  |
|Daniel Jones       |        2019|        0|FALSE       |FALSE  |
|Dwayne Haskins     |        2019|        0|FALSE       |FALSE  |
|Baker Mayfield     |        2018|        0|FALSE       |FALSE  |
|Sam Darnold        |        2018|        0|FALSE       |FALSE  |
|Josh Allen         |        2018|        0|FALSE       |FALSE  |
|Josh Rosen         |        2018|        0|FALSE       |FALSE  |
|Lamar Jackson      |        2018|        0|TRUE        |TRUE   |
|Mitchell Trubisky  |        2017|        0|TRUE        |TRUE   |
|Patrick Mahomes    |        2017|        1|TRUE        |TRUE   |
|Deshaun Watson     |        2017|        0|TRUE        |TRUE   |
|Jared Goff         |        2016|        1|TRUE        |TRUE   |
|Carson Wentz       |        2016|        0|TRUE        |TRUE   |
|Paxton Lynch       |        2016|        0|FALSE       |FALSE  |
|Jameis Winston     |        2015|        0|TRUE        |TRUE   |
|Marcus Mariota     |        2015|        0|FALSE       |FALSE  |
|Blake Bortles      |        2014|        0|FALSE       |FALSE  |
|Johnny Manziel     |        2014|        0|FALSE       |FALSE  |
|Teddy Bridgewater  |        2014|        0|TRUE        |TRUE   |
|EJ Manuel          |        2013|        0|FALSE       |FALSE  |
|Andrew Luck        |        2012|        0|TRUE        |TRUE   |
|Robert Griffin     |        2012|        0|TRUE        |TRUE   |
|Ryan Tannehill     |        2012|        0|TRUE        |TRUE   |
|Brandon Weeden     |        2012|        0|FALSE       |FALSE  |
|Cam Newton         |        2011|        1|TRUE        |TRUE   |
|Jake Locker        |        2011|        0|FALSE       |FALSE  |
|Blaine Gabbert     |        2011|        0|FALSE       |FALSE  |
|Christian Ponder   |        2011|        0|FALSE       |FALSE  |
|Sam Bradford       |        2010|        0|FALSE       |FALSE  |
|Tim Tebow          |        2010|        0|FALSE       |FALSE  |
|Matthew Stafford   |        2009|        0|TRUE        |TRUE   |
|Mark Sanchez       |        2009|        0|FALSE       |FALSE  |
|Josh Freeman       |        2009|        0|FALSE       |FALSE  |
|Matt Ryan          |        2008|        1|TRUE        |TRUE   |
|Joe Flacco         |        2008|        1|FALSE       |TRUE   |
|JaMarcus Russell   |        2007|        0|FALSE       |FALSE  |
|Brady Quinn        |        2007|        0|FALSE       |FALSE  |
|Vince Young        |        2006|        0|TRUE        |TRUE   |
|Matt Leinart       |        2006|        0|FALSE       |FALSE  |
|Jay Cutler         |        2006|        0|TRUE        |TRUE   |
|Alex Smith         |        2005|        0|TRUE        |TRUE   |
|Aaron Rodgers      |        2005|        1|TRUE        |TRUE   |
|Jason Campbell     |        2005|        0|FALSE       |FALSE  |
|Eli Manning        |        2004|        2|TRUE        |TRUE   |
|Philip Rivers      |        2004|        0|TRUE        |TRUE   |
|Ben Roethlisberger |        2004|        3|TRUE        |TRUE   |
|J.P. Losman        |        2004|        0|FALSE       |FALSE  |
|Carson Palmer      |        2003|        0|TRUE        |TRUE   |
|Byron Leftwich     |        2003|        0|FALSE       |FALSE  |
|Kyle Boller        |        2003|        0|FALSE       |FALSE  |
|Rex Grossman       |        2003|        0|FALSE       |FALSE  |
|David Carr         |        2002|        0|FALSE       |FALSE  |
|Joey Harrington    |        2002|        0|FALSE       |FALSE  |
|Patrick Ramsey     |        2002|        0|FALSE       |FALSE  |
|Michael Vick       |        2001|        0|TRUE        |TRUE   |
|Chad Pennington    |        2000|        0|FALSE       |FALSE  |
|Tim Couch          |        1999|        0|FALSE       |FALSE  |
|Donovan McNabb     |        1999|        0|TRUE        |TRUE   |
|Akili Smith        |        1999|        0|FALSE       |FALSE  |
|Daunte Culpepper   |        1999|        0|TRUE        |TRUE   |
|Cade McNown        |        1999|        0|FALSE       |FALSE  |

## Summary of Early Results

Look's like its more of a 42% chance of a good pick if we just look at the raw numbers:

|goodQB | count|  percent|
|:------|-----:|--------:|
|FALSE  |    35| 57.37705|
|TRUE   |    26| 42.62295|

![](https://github.com/rfgordonjr/nflQbDraftPicks/blob/master/plots/simplePlot.png)

This varies greatly on a year-to-year basis:

![](https://github.com/rfgordonjr/nflQbDraftPicks/blob/master/plots/simplePlotPerYear.png)