library(data.table)

unzip("exdata_data_household_power_consumption.zip")
data <- "household_power_consumption.txt"
power <- read.table(data, header = TRUE, sep = ";")
subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")
globalactivepower <- as.numeric(subpower$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(globalactivepower, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()