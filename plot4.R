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

png("plot4.png") #opens PNG graphic device

#creates grid for plotting charts
par(mfcol = c(2, 2))

#Chart1:
#plots and annotes empty chart
with(data, plot(datetime, Global_active_power, type = "n", main = "", xlab = "", 
                ylab = "Global Active Power (kilowats)"))
#includes timeseries Global_active_power data
with(data, lines(datetime, Global_active_power))

#Chart2:
#plots and annotes empty chart
with(data, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
                ylab = "Energy sub metering"))
#includes sub-metering timeseries data
with(data, lines(datetime, Sub_metering_1, col = "black"))
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))

#Chart3:
#plots and annotes empty chart
with(data, plot(datetime, Voltage, main = "", type = "n"))
#includes timeseries Voltage data
with(data, lines(datetime, Voltage))

#Chart4:
#plots and annotes empty chart
with(data, plot(datetime, Global_reactive_power, main = "", type = "n"))
#includes timeseries Global_reactive_power data
with(data, lines(datetime, Global_reactive_power))

dev.off() #closes PNG graphic device