hpc <- read.table("household_power_consumption.txt",
                  skip = 66637, nrow = 2880, sep = ";",na.strings="?" ,
                  stringsAsFactors=FALSE,
                  col.names = colnames(read.table(
                    "household_power_consumption.txt",
                    nrow = 1, header = TRUE, sep=";")))


#hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

hpc <- cbind(hpc, DateTime=paste(hpc$Date,hpc$Time, sep=" "))

hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %H:%M:%S") 

#plot 1
png(filename ="plot1.png",width = 480, height = 480)
hist(hpc$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

#plot 2
png(filename ="plot2.png",width = 480, height = 480)
plot(hpc$DateTime,hpc$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()

#plot 3
png(filename ="plot3.png",width = 480, height = 480)
plot(hpc$DateTime,hpc$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="" )
points(hpc$DateTime, hpc$Sub_metering_1, type="l")
points(hpc$DateTime, hpc$Sub_metering_2, type="l",col="red")
points(hpc$DateTime, hpc$Sub_metering_3, type="l",col="purple")
legend("topright",lwd=1, col = c("black","red","purple"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


#plot 4
png(filename ="plot4.png",width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) 

plot(hpc$DateTime,hpc$Global_active_power,type="l",ylab="Global Active Power",xlab="")

plot(hpc$DateTime, hpc$Voltage, type="l", ylab="Voltage",xlab="datetime")

plot(hpc$DateTime,hpc$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="" )
points(hpc$DateTime, hpc$Sub_metering_1, type="l")
points(hpc$DateTime, hpc$Sub_metering_2, type="l",col="red")
points(hpc$DateTime, hpc$Sub_metering_3, type="l",col="purple")
legend("topright",lwd=1, bty="n", col = c("black","red","purple"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(hpc$DateTime,hpc$Global_reactive_power,type="l",xlab="datetime",ylab="Global reactive power")
dev.off()