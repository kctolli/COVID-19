# Libraries

package::libraries()

## set working directory

wdset("D:/COVID-project/read-data/USA")

# Get Data

state <- us_states()
counties <- us_counties()
city <- us_cities()

pop <- my_read("./population_2018.csv") %>% 
  rename(state = State) %>% rename(population = Population)

county_pop <- my_read("./county_pop.csv") %>% 
  rename(state = State) %>% rename(county = County) %>% rename(pop = `2019`)

# Wrangling

continental_state <- my_continent(state) %>% 
  select(name, state_abbr) %>% 
  rename(state = name) %>% 
  left_join(., pop)

continental_county <- my_continent(counties) %>% 
  select(name, state_name, state_abbr) %>% 
  rename(county = name) %>% 
  rename(state = state_name)

continental_city <- my_continent(city) %>% 
  select(city, state_name, state_abbr, county_name, population) %>% 
  rename(county = county_name) %>% 
  rename(state = state_name)

county <- left_join(continental_county, county_pop) %>% 
  select(county, state, state_abbr, pop)

us <- sum(pop$population)

# Save

write_csv(continental_state, "state.csv")
write_csv(county, "county.csv")
write_csv(continental_city, "city.csv")
