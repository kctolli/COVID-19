wdset <- function(here){setwd(here); getwd()}

my_read <- function(df){read_csv(df) %>% unique() %>% na.omit()}

my_continent <- function(df){df %>% filter(!state_abbr %in% c("AK","HI","PR"))}

newyork <- function(df){df %>% filter(state_abbr == "NY")}

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
