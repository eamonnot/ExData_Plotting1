# Plot Two
myData <- read.table(file="household_power_consumption.txt",sep=";", header = TRUE)
myData$Date <- as.Date(strptime(myData$Date,"%d/%m/%Y"))
myData <- myData[myData$Date >= "2007-02-01" & myData$Date <= "2007-02-02",]
myData$datetime <- as.POSIXct(paste(myData$Date, myData$Time),"%Y-%m-%d %H:%M:%S")

myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))

#Plot 2
png(file="plot2.png", width = 480, height = 480, units="px")
par(mfcol = c(1,1))
with(myData,plot(datetime,Global_active_power,type="l", 
                 ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.off()