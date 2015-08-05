myData <- read.table(file="household_power_consumption.txt",sep=";", header = TRUE)
myData$Date <- as.Date(strptime(myData$Date,"%d/%m/%Y"))
myData <- myData[myData$Date >= "2007-02-01" & myData$Date <= "2007-02-02",]
myData$datetime <- as.POSIXct(paste(myData$Date, myData$Time),"%Y-%m-%d %H:%M:%S")

myData$Sub_metering_1 <- as.numeric(as.character(myData$Sub_metering_1))
myData$Sub_metering_2 <- as.numeric(as.character(myData$Sub_metering_2))
myData$Sub_metering_3 <- as.numeric(as.character(myData$Sub_metering_3))

#Plot 3
png(file="plot3.png", width = 480, height = 480, units="px")
par(mfcol = c(1,1))
with(myData,plot(datetime,Sub_metering_1,type="l", ylab = "Energy sub metering", xlab = ""))
with(myData,lines(datetime,Sub_metering_2,col="red"))
with(myData,lines(datetime,Sub_metering_3,col="blue"))


legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  lty=c(1,1,1),
       col=c("black","red","blue"),cex=0.8);

dev.off()