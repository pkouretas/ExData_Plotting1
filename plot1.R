
# *************************
# initial setup
# *************************
library(lubridate)
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
# PLOT 1
# ***********************
png(filename = "plot1.png", width = 480, height = 480)
hist(two_days$Global_active_power, 
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()