
# *************************
# initial setup
# *************************
library(lubridate, dplyr)
if (!exists("dat")){
    # we assume the file is on the parent folder
    filename <- "household_power_consumption.txt"
    path2file <- paste("../", filename, sep = "")
    dat <- read.table(path2file, header = T, sep = ";", na.strings = "?", stringsAsFactors = F)
    dat$Date <- as.Date(dmy(dat$Date))
}


dt1 <- "2007-02-01"
dt2 <- "2007-02-02"
two_days <- dat[(dat$Date == dt1 | dat$Date == dt2), ]


# *************************
# transform data 
# *************************
two_days_dt <- mutate(two_days, DateTime = paste(Date,Time))
two_days_dt$DateTime <- ymd_hms(two_days_dt$DateTime)

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# ********** plot (1,1) *************
plot(two_days_dt$DateTime, two_days_dt$Global_active_power, 
     xlab = "",
     ylab = "Global Active Power", 
     type = "l")

# ********** plot (1,2) *************
plot(two_days_dt$DateTime, two_days_dt$Voltage, 
     xlab = "datetime",
     ylab = "Voltage", 
     type = "l")

# ********** plot (2,1) *************
plot(two_days_dt$DateTime, two_days_dt$Sub_metering_1, col = "black",
     xlab = "", ylab = "Energy sub metering", type = "l")
points(two_days_dt$DateTime, two_days_dt$Sub_metering_2, col = "red", type = "l")
points(two_days_dt$DateTime, two_days_dt$Sub_metering_3, col = "blue", type = "l")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = c(1,1,1), 
       bty = "n")

# ********** plot (2,2) *************
plot(two_days_dt$DateTime, two_days_dt$Global_reactive_power, 
     xlab = "datetime",
     ylab = "Global_reactive_power", 
     type = "l")
dev.off()