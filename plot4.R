library(dplyr)
library(readr)
library(lubridate)

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
    filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
    mutate(Datetime = as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))


png("plot4.png", width = 480, height = 480, units = "px") 
par(mfrow=c(2,2))
with(full_data, plot(Datetime, Global_active_power, 
                     type="l",
                     ylab="Global Active Power (kilowatts)",
                     xlab="Datetime (Minute Resolution)"))
with(full_data, plot(Datetime, Voltage, 
                     type="l",
                     ylab="Voltage",
                     xlab="Datetime (Minute Resolution)"))
plot(full_data$Datetime, full_data$Sub_metering_1, 
     type='l', 
     xlab='Datetime (Minute Resolution)', 
     ylab='Energy Sub Metering')
lines(full_data$Datetime, full_data$Sub_metering_2, type='l', col="red")
lines(full_data$Datetime, full_data$Sub_metering_3, type='l', col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1,  cex = 0.7)
with(full_data, plot(Datetime, Global_reactive_power, 
                     type="l",
                     ylab="Global_Reactive_Power",
                     xlab="Datetime (Minute Resolution)"))
dev.off()
