# Libraries

package::libraries()

## set working directory

wdset("D:/COVID-19/read-data/JHU")

# Get Data 

states <- my_read("../USA/state.csv")
counties <- my_read("../USA/county.csv")

## From https://github.com/CSSEGISandData/COVID-19

fips_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/UID_ISO_FIPS_LookUp_Table.csv"
us_deaths_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_US.csv"
us_cases_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_US.csv"
global_deaths_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
global_cases_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
global_recovered_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"

# Wrangling

global_deaths <- global_read(global_deaths_url)
global_cases <- global_read(global_cases_url)
global_recovered <- global_read(global_recovered_url)

us_deaths <- us_read(us_deaths_url)
us_cases <- us_read(us_cases_url)  

# Save

write_csv(us_read(fips_url), "JHU_us_fips.csv")

write_csv(global_deaths, "JHU_global_deaths_wide.csv")
write_csv(global_cases, "JHU_global_cases_wide.csv")
write_csv(global_recovered, "JHU_global_recovered_wide.csv")

write_csv(us_deaths, "JHU_us_deaths_wide.csv")
write_csv(us_cases, "JHU_us_cases_wide.csv")


#### Longer

# Get Data, Wrangling, & Save

global_cases_long <- global_cases %>% 
  pivot_longer(c(-state,-country), names_to = "date", values_to = "cases") %>% 
  write_csv("JHU_global_cases.csv")

global_deaths_long <- global_deaths %>% 
  pivot_longer(c(-state,-country), names_to = "date", values_to = "deaths")  %>% 
  write_csv("JHU_global_deaths.csv")

global_recovered_long <- global_recovered %>% 
  pivot_longer(c(-state,-country), names_to = "date", values_to = "recovered") %>% 
  write_csv("JHU_global_recovered.csv")

us_cases_long <- us_cases %>% 
  pivot_longer(c(-state,-county), names_to = "date", values_to = "cases") %>% 
  write_csv("JHU_us_cases.csv")

us_deaths_long <- us_deaths %>% 
  pivot_longer(c(-state,-county), names_to = "date", values_to = "deaths") %>% 
  write_csv("JHU_us_deaths.csv")

## Joining

global <- left_join(left_join(global_cases_long, global_deaths_long), global_recovered_long) 

global$date <- as.Date(global$date, "%m/%d/%y")    
  
global <- global %>% mutate(active = cases - (deaths + recovered))  %>% 
  write_csv("JHU_global.csv")

us_pop <- left_join(left_join(us_cases_long, us_deaths_long), counties)

us_pop$date <- as.Date(us_pop$date, "%m/%d/%y") 

us_pop <- us_pop %>% select(date, county, state, state_abbr, cases, deaths, pop) %>% 
  write_csv("JHU_us_pop.csv")

us <- us_pop %>% select(- pop) %>% write_csv("JHU_us.csv")

# Wrangling, & Save

us_state <- us %>% 
  group_by(state, date) %>% 
  summarise(cases = sum(cases), deaths = sum(deaths)) %>% 
  write_csv("JHU_us_state.csv") 

china_state <- global %>% 
  filter(country == "China") %>% 
  group_by(state, date) %>% 
  my_jhu_wrangle() %>% 
  write_csv("JHU_china_state.csv")

china <- global %>% 
  filter(country == "China") %>% 
  group_by(date) %>% 
  my_jhu_wrangle() %>% 
  write_csv("JHU_china.csv")

world <- global %>% 
  group_by(country, date) %>% 
  my_jhu_wrangle() %>% 
  write_csv("JHU_world.csv")

earth <- global %>% 
  group_by(date) %>% 
  my_jhu_wrangle() %>% 
  write_csv("JHU_earth.csv")

usa <- us %>% 
  group_by(date) %>% 
  summarise(cases = sum(cases), deaths = sum(deaths)) %>% 
  write_csv("JHU_usa.csv")