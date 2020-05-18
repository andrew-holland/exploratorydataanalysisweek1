library(dplyr)
library(readr)

household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          ";", escape_double = FALSE, na = "?", 
                                          trim_ws = TRUE)
household_power_consumption2 <- read_delim("household_power_consumption2.txt", 
                                          ";", escape_double = FALSE, na = "?", 
                                          trim_ws = TRUE)
full_data <- rbind(household_power_consumption, household_power_consumption2)
