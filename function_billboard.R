library(tidyverse)
library(rvest)

page <- read_html("https://www.billboard.com/charts/billboard-200")

titles <- page %>%
  html_nodes(".chart-element__information__song") %>%
  html_text() 

scrape_page <- function(url){
  
  # read page
  page <- read_html(url)
  
  # scrape titles
  titles <- page %>%
    html_nodes(".chart-element__information__song") %>%
    html_text() 
  
  # scrape artists
  artists <- page %>%
    html_nodes(".chart-element__information__artist") %>%
    html_text()
  
  
  # scrape lastweek 
  last <- page %>%
    html_nodes(".chart-element__meta.text--last") %>%
    html_text() 
  
  # scrape peak 
  peak <- page %>%
    html_nodes(".chart-element__meta.text--peak") %>%
    html_text() 
  
  # scrape weeks 
  week <- page %>%
    html_nodes(".chart-element__meta.text--week") %>%
    html_text() 
  
  # create and return tibble
  tibble(
    title = titles, 
    artist = artists,
    last = last,
    peak = peak,
    week = week
  )
  
}

# write out data frame
write_csv(billboard, file = "data/billboard.csv")

