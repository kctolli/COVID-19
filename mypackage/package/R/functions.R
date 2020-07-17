wdset <- function(here){setwd(here); getwd()}
my_read <- function(df){read_csv(df) %>% unique() %>% na.omit()}
my_continent <- function(df){df %>% filter(!state_abbr %in% c("AK","HI","PR"))}
newyork <- function(df){df %>% filter(state_abbr == "NY")}
short_name <- function(df)(df %>% rename(cases = us_cases) %>% rename(deaths = us_deaths))

Sys.Yesterday <- function(date = Sys.Date()){date - 1}
Sys.Week <- function(date = Sys.Date()){date - 7}
Sys.Biweek <- function(date = Sys.Date()){date - 14}
Sys.Nextweek <- function(date = Sys.Date()){date + 7}

filter_yesterday <- function(df){df %>% filter(date == Sys.Yesterday())}
filter_week <- function(df){df %>% filter(date == Sys.Week())}
filter_biweek <- function(df){df %>% filter(date == Sys.Biweek())}

my_owid_wrangle <- function(df){
  summarise(df,
      total_cases = sum(total_cases),
      total_deaths = sum(total_deaths),
      total_tests = sum(total_tests),
      new_cases = sum(new_cases),
      new_deaths = sum(new_deaths),
      new_tests = sum(new_tests),
      .groups = "keep")
}


my_jhu_wrangle <- function(df){
  summarise(df,
      cases = sum(cases),
      deaths = sum(deaths),
      active = sum(active),
      recovered = sum(recovered),
      .groups = "keep")
  }

us_read <- function(df){
  dat <- my_read(df) %>%
    select(- UID, - iso2, - iso3, - code3, - FIPS, -Lat, - Long_, - Combined_Key, - Country_Region) %>%
    rename(county = Admin2) %>%
    rename(state = Province_State)
  dat
}

global_read <- function(df){
  dat <- my_read(df) %>%
    select(-Lat, - Long) %>%
    rename(state = `Province/State`) %>%
    rename(country = `Country/Region`)
  dat
}

states <- function(){
  pacman::p_load(USAboundaries, tidyverse)
  states <- us_states() %>%
    filter(!state_abbr %in% c("AK","HI","PR")) %>%
    rename(state = name)
  states
}

county <- function(){
  pacman::p_load(USAboundaries, tidyverse)
  county <- us_counties() %>%
    rename(county = name) %>%
    select(- statefp, - jurisdiction_type) %>%
    rename(state = state_name)
  county
}

covid_prop <- function(df){
  df %>%
    mutate(case_pop = round(as.numeric(case_pop),4)) %>%
    mutate(case_death = round(as.numeric(case_death),4)) %>%
    mutate(death_pop = round(as.numeric(death_pop),4)) %>%
    mutate(death_case = round(as.numeric(death_case),4))
}

leaflet_manip <- function(df){
  df %>% filter_yesterday() %>%
    filter(!state %in% c("Alaska", "Hawaii")) %>%
    st_as_sf() %>%
    ungroup() %>%
    mutate(per_cases = as.numeric((cases/pop)*100)) %>%
    mutate(per_deaths = as.numeric((deaths/pop)*100))
}
