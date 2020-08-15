# Libraries

package::libraries()

## set working directory

wdset("D:/COVID-19/read-data/OWID")

# Get Data & Wrangling

states <- my_read("../USA/state.csv")
counties <- my_read("../USA/county.csv")

## From https://github.com/owid/covid-19-data

covid <- my_read("https://github.com/owid/covid-19-data/raw/master/public/data/owid-covid-data.csv") %>% 
  select(- iso_code) %>% rename(country = location)
  
full <- my_read("https://github.com/owid/covid-19-data/raw/master/public/data/ecdc/full_data.csv") %>% 
  rename(country = location)

owid <- full_join(covid, full) %>% write_csv("owid_data.csv")

ecdc <- my_read("https://github.com/owid/covid-19-data/raw/master/public/data/ecdc/COVID-2019%20-%20ECDC%20(2020).csv") %>% 
  rename(country = Country) %>% rename(day = Year) %>% 
  write_csv("owid_ecdc.csv")

continent <- owid %>% group_by(date, continent) %>% my_owid_wrangle()

world <- owid %>% group_by(date) %>% my_owid_wrangle()
