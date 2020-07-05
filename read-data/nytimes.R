# Libraries

pacman::p_load(pacman)
p_load(tidyverse)
p_load(lubridate, sf, USAboundaries, ggrepel, maps, leaflet, dygraphs)

## set working directory

setwd("D:/COVID-project/read-data/nytimes")

## turn off scientific notation 

options(scipen = 999)

# Functions

my_read <- function(df){read_csv(df) %>% unique() %>% na.omit()}

# Get Data 

states <- my_read("../USA/state.csv")
counties <- my_read("../USA/county.csv")

## From https://github.com/nytimes/covid-19-data

nytimes_US <- "https://github.com/nytimes/covid-19-data/raw/master/us.csv"
nytimes_states <- "https://github.com/nytimes/covid-19-data/raw/master/us-states.csv"
nytimes_counties <- "https://github.com/nytimes/covid-19-data/raw/master/us-counties.csv"

# Wrangling

us_df <- my_read(nytimes_US) %>% 
  rename(us_cases = cases) %>% 
  rename(us_deaths = deaths) %>% 
  write_csv("nytimes_us.csv")

states_df <- my_read(nytimes_states) %>% 
  select(- fips) %>% 
  write_csv("nytimes_states.csv")
  

counties_df <- my_read(nytimes_counties) %>% 
  select(- fips) %>% 
  write_csv("nytimes_counties.csv")

## Joins 

county_pop <- left_join(counties, counties_df, by = c("county", "state")) %>% 
  select(date, state, state_abbr, county, cases, deaths, pop) 

county <- county_pop %>% select(-pop)

county_proportions <- county_pop %>% 
  mutate(case_death = cases / deaths) %>% 
  mutate(case_pop = cases / pop) %>% 
  mutate(death_pop = deaths/ pop) %>% 
  mutate(death_case = 1 / case_death)

state_pop <- left_join(states, states_df) %>%
  select(date, state, state_abbr, cases, deaths, population) %>% 
  rename(pop = population)

state <- state_pop %>% select(-pop)

state_proportions <- state_pop %>% 
  mutate(case_death = cases / deaths) %>% 
  mutate(case_pop = cases / pop) %>% 
  mutate(death_pop = deaths/ pop) %>% 
  mutate(death_case = 1 / case_death)

# Save
write_csv(county_pop, "nytimes_county_pop.csv")
write_csv(county, "nytimes_county.csv")
write_csv(county_proportions, "nytimes_county_proportions.csv")

write_csv(state_pop, "nytimes_state_pop.csv")
write_csv(state, "nytimes_state.csv")
write_csv(state_proportions, "nytimes_state_proportions.csv")