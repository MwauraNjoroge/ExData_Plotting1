#first Date and Time Entry in file
fileStartTime <- as.POSIXct("2006-12-16 17:24:00")
#first Date and Time entry to be read
readStartTime <- as.POSIXct("2007-02-01 00:00:00")
#last Date and Time entry to be read
readEndTime <- as.POSIXct("2007-02-02 23:59:00")
#read data between first and last Date and Time entries to be read (both inclusive)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", skip = as.numeric(readStartTime - fileStartTime)*24*60,
                   nrows = (as.numeric(readEndTime-readStartTime)*24*60 + 1))
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                 "Voltage", "Global_intensity", "Sub_metering_1", 
                 "Sub_metering_2", "Sub_metering_3")

#Convert Date and Time values to R Date/Time class
data$datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

png("plot2.png") #opens PNG graphic device
#plots and annotes empty chart
with(data, plot(datetime, Global_active_power, type = "n", main = "", xlab = "", 
                ylab = "Global Active Power (kilowats)"))
#includes timeseries Global_active_power data
with(data, lines(datetime, Global_active_power))
dev.off() #closes PNG graphic device