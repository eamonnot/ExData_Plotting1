myData <- read.table(file="household_power_consumption.txt",sep=";", header = TRUE)
myData$Date <- as.Date(strptime(myData$Date,"%d/%m/%Y"))
myData <- myData[myData$Date >= "2007-02-01" & myData$Date <= "2007-02-02",]
myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))


# Plot One

png(file="plot1.png")
par(mfcol = c(1,1))
hist(myData$Global_active_power,xlab = "Global Active Power (kilowatts)", col="red", 
     main = "Global Active Power" )
 
dev.off()