library(data.table)

unzip("exdata_data_household_power_consumption.zip")
data <- "household_power_consumption.txt"
power <- read.table(data, header = TRUE, sep = ";")
subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

subMet1 <- as.numeric(subpower$Sub_metering_1)
subMet2 <- as.numeric(subpower$Sub_metering_2)
subMet3 <- as.numeric(subpower$Sub_metering_3)
globalactivepower <- as.numeric(subpower$Global_active_power)
globalreactivepower <- as.numeric(subpower$Global_reactive_power)
voltage <- as.numeric(subpower$Voltage)

png("Plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(subpower$Time, globalactivepower, type = "l", xlab = " ", ylab = "Global Active Power")

plot(subpower$Time, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(subpower$Time, subMet1, type = "l", ylab = "Energy Submetering", xlab = " ")
lines(subpower$Time, subMet2, type = "l", col = "red")
lines(subpower$Time, subMet3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col = c("black", "red", "blue"))

plot(subpower$Time, globalreactivepower, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()