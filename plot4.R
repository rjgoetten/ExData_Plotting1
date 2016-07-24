library(data.table)
#Download, unzip & read data
if (!file.exists("data")){dir.create("data")} 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")
dataZip <- unzip("./data/Dataset.zip", exdir = "./data")
dataZip

con <- file("./data/household_power_consumption.txt")
data <- read.table(text = grep("^[1,2]/2/2007", readLines(con), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), header = TRUE, sep = ";")
View(data)

#Convert Date & Time
date <- as.Date(data$Date, format = '%d/%m/%Y')
dateTime <- as.POSIXct(paste(date, data$Time))
Sys.setlocale(category = "LC_ALL", locale = "english")

#Plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

#1
plot(dateTime, data$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatt)", type = "l")

#2
plot(dateTime, data$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#3
plot(dateTime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
points(dateTime, data$Sub_metering_2, xlab = "", ylab = "Energy sub metering", type = "l", col = "red")
points(dateTime, data$Sub_metering_3, xlab = "", ylab = "Energy sub metering", type = "l", col = "blue")
?legend
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")

#4
plot(dateTime, data$Global_reactive_power, xlab = "datetime", ylab = "Global_rective_power", type = "l")
dev.off()