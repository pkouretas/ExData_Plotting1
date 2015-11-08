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


# ***********************
# PLOT 2
# ***********************
two_days_dt <- mutate(two_days, DateTime = paste(Date,Time))
two_days_dt$DateTime <- ymd_hms(two_days_dt$DateTime)

png(filename = "plot2.png", width = 480, height = 480)
plot(two_days_dt$DateTime, two_days_dt$Global_active_power, 
     xlab = "",
     ylab = "Global Active Power (kilowatts)", 
     type = "l")
dev.off()

