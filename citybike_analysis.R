library(dplyr)
library(tidyverse)

# Read the data (downloaded from dev.hsl.fi/citybikes/od-trips-2021/od-trips-2021.zip)
data <- read.csv("/Users/jaakkopentik/downloads/od-trips-2021/2021-08.csv")

# This shows the top 10 departure stations
top_departure_stations <- data %>% count(Departure.station.name, sort = TRUE) %>% top_n(10, n)

# This shows the top 10 return stations
top_return_stations <- data %>% count(Return.station.name, sort = TRUE) %>% top_n(10, n)

# Most covered distance
most_covered_distance <- data %>% group_by(Departure.station.name) %>% 
                         select(Return.station.name, Covered.distance..m., Duration..sec..) %>% 
                         mutate(Distance.in.kilometers = Covered.distance..m. / 1000) %>%
                         mutate(Duration.in.hours = Duration..sec.. / 3600) %>% 
                         select(-Covered.distance..m., -Duration..sec..)

# Most frequent trip between two stations (top 10)
most_frequent_trip <- data %>% count(Departure.station.name, Return.station.name, sort = TRUE) %>%
                      top_n(10, n)

# Most frequent trip between two stations (other is specified)
trip_specific <- data %>% count(Departure.station.name, Return.station.name, sort = TRUE) %>%
                 filter(Departure.station.name == "Korjaamo") %>% top_n(10, n)
                        
