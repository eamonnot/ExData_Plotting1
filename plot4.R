myData <- read.table(file="household_power_consumption.txt",sep=";", header = TRUE)
myData$Date <- as.Date(strptime(myData$Date,"%d/%m/%Y"))
myData <- myData[myData$Date >= "2007-02-01" & myData$Date <= "2007-02-02",]
myData$datetime <- as.POSIXct(paste(myData$Date, myData$Time),"%Y-%m-%d %H:%M:%S")


myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))
myData$Global_reactive_power <- as.numeric(as.character(myData$Global_reactive_power))
myData$Voltage <- as.numeric(as.character(myData$Voltage))

myData$Sub_metering_1 <- as.numeric(as.character(myData$Sub_metering_1))
myData$Sub_metering_2 <- as.numeric(as.character(myData$Sub_metering_2))
myData$Sub_metering_3 <- as.numeric(as.character(myData$Sub_metering_3))

#Plot 4

png(file="plot4.png")

par(mfcol = c(2,2))

# Plot Top Right
with(myData,plot(datetime,Global_active_power,type="l", 
                 ylab = "Global Active Power (kilowatts)", xlab = ""))

# Plot Bottom Right
with(myData,plot(datetime,Sub_metering_1,type="l", ylab = "Energy sub metering", xlab = ""))
with(myData,lines(datetime,Sub_metering_2,col="red"))
with(myData,lines(datetime,Sub_metering_3,col="blue"))

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  lty=c(1,1,1),
       col=c("black","red","blue"),cex=0.8);

# Plot Top Left
with(myData,plot(datetime,Voltage,type="l"))

# Plot Bottom Left
with(myData,plot(datetime,Global_reactive_power,type="l"))

dev.off()