library(dplyr)
library(tidyverse)

# Read the data (downloaded from dev.hsl.fi/citybikes/od-trips-2023/od-trips-2023.zip)
data <- read.csv("/Users/jaakkopentik/downloads/od-trips-2023/2023-08.csv")

# This shows the top 10 departure stations
top_departure_stations <- data %>% count(Departure.station.name, sort = TRUE) %>% slice_head(n = 10)

# This shows the top 10 return stations
top_return_stations <- data %>% count(Return.station.name, sort = TRUE) %>% slice_head(n = 10)

# This shows departures from a specific station
specific_departure_station <- data %>% count(Departure.station.name, sort = TRUE) %>% 
                              filter(Departure.station.name == "Korjaamo")

# This shows returns to a specific station
specific_return_station <- data %>% count(Return.station.name, sort = TRUE) %>% 
                           filter(Return.station.name == "Korjaamo")

# Most covered distance
most_covered_distance <- data %>% group_by(Departure.station.name) %>% 
                         select(Return.station.name, Covered.distance..m., Duration..sec..) %>% 
                         mutate(Distance.in.kilometers = Covered.distance..m. / 1000) %>%
                         mutate(Duration.in.hours = Duration..sec.. / 3600) %>% 
                         select(-Covered.distance..m., -Duration..sec..)

# Mean duration of all trips (in minutes)
mean_duration <- data %>% summarise(Mean.duration = mean(Duration..sec.. / 60))

# Most frequent trip between two stations
most_frequent_trip <- data %>% count(Departure.station.name, Return.station.name, sort = TRUE) %>%
                      slice_head(n = 10)

# Most frequent trip between two stations (other is specified)
trip_specific <- data %>% count(Departure.station.name, Return.station.name, sort = TRUE) %>%
                 filter(Departure.station.name == "Korjaamo") %>% slice_head(n = 10)
                        
