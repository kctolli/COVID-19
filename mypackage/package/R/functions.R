wdset <- function(here){setwd(here); getwd()}
my_read <- function(df){read_csv(df) %>% unique() %>% na.omit()}
my_continent <- function(df){df %>% filter(!state_abbr %in% c("AK","HI","PR"))}
newyork <- function(df){df %>% filter(state_abbr == "NY")}

Sys.Yesterday <- function(date = Sys.Date()){date - 1}
Sys.Week <- function(date = Sys.Date()){date - 7}
Sys.Biweek <- function(date = Sys.Date()){date - 14}
Sys.Nextweek <- function(date = Sys.Date()){date + 7}

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
