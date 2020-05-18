library(dplyr)
library(readr)

household_power_consumption <- read_delim("household_power_consumption.txt", 
                                          ";", escape_double = FALSE, na = "?", 
                                          trim_ws = TRUE)
household_power_consumption2 <- read_delim("household_power_consumption2.txt", 
                                          ";", escape_double = FALSE, na = "?", 
                                          trim_ws = TRUE)
full_data <- rbind(household_power_consumption, household_power_consumption2)


#We will only be using data from the dates 2007-02-01 and 2007-02-02.

full_data <- full_data %>%
    mutate(Date = as.Date(Date, format="%d/%m/%Y")) %>%
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")


png("plot1.png", width = 480, height = 480, units = "px") 
with(full_data, hist(Global_active_power, w = 0.5, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power"))
dev.off() 
