# Libraries

pacman::p_load(pacman)
p_load(tidyverse)
p_load(lubridate, sf, USAboundaries, ggrepel, maps, leaflet, dygraphs)

## set working directory

setwd("D:/COVID-project/read-data/OWID")

## turn off scientific notation 

options(scipen = 999)

# Functions 

my_read <- function(df){read_csv(df) %>% unique() %>% na.omit()}

# Get Data & Wrangling

states <- my_read("../USA/state.csv")
counties <- my_read("../USA/county.csv")

## From https://github.com/owid/covid-19-data

covid <- my_read("https://github.com/owid/covid-19-data/raw/master/public/data/owid-covid-data.csv") %>% 
  select(- iso_code) %>% rename(country = location)
  
full <- my_read("https://github.com/owid/covid-19-data/raw/master/public/data/ecdc/full_data.csv") %>% 
  rename(country = location)

ecdc <- my_read("https://github.com/owid/covid-19-data/raw/master/public/data/ecdc/COVID-2019%20-%20ECDC%20(2020).csv") %>% 
  rename(country = Country) %>% rename(day = Year)

## Joins 

covid_data <- full_join(covid, full)

# Save

write_csv(covid_data, "owid_data.csv")

write_csv(ecdc, "owid_ecdc.csv")

