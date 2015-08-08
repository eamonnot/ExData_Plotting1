# Set the filename
filename = "household_power_consumption.txt"
fileZip = "exdata_data_household_power_consumption.zip"
## First check that the txt file exists in the current working directory
if (!file.exists(filename)){
  ## If not check if the zip exists
  if (!file.exists(fileZip)){
    ## If not download the zip
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    # Note you may need to change the method depending on your system
    download.file(fileURL, fileZip, method="wget")
  }
  ## Should now have the Zip file, so unzip it
  if (file.exists(fileZip)) {
    unzip(fileZip)
  }
}

if (file.exists(filename)){
  # Now ready to read the data and make the plot
  myData <- read.table(file=filename,sep=";", header = TRUE)
  myData$Date <- as.Date(strptime(myData$Date,"%d/%m/%Y"))
  # Subset the data to just the two dates in February
  myData <- myData[myData$Date >= "2007-02-01" & myData$Date <= "2007-02-02",]
  # Create datetime field as a combination of Date and Time
  myData$datetime <- as.POSIXct(paste(myData$Date, myData$Time),"%Y-%m-%d %H:%M:%S")
  
  # Convert needed values to numeric
  myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))
  myData$Global_reactive_power <- as.numeric(as.character(myData$Global_reactive_power))
  myData$Voltage <- as.numeric(as.character(myData$Voltage))
  
  myData$Sub_metering_1 <- as.numeric(as.character(myData$Sub_metering_1))
  myData$Sub_metering_2 <- as.numeric(as.character(myData$Sub_metering_2))
  myData$Sub_metering_3 <- as.numeric(as.character(myData$Sub_metering_3))
  
  #Plot 4
  # Plot Global active power as a histogram
  png(file="plot4.png",width = 480, height = 480, units="px")
  # Create a 2 x 2 panel, filling by column 
  par(mfcol = c(2,2))
  
  # Plot Top Right
  with(myData,plot(datetime,Global_active_power,type="l", 
                   ylab = "Global Active Power (kilowatts)", xlab = ""))
  
  # Plot Bottom Right, which is plot 3
  with(myData,plot(datetime,Sub_metering_1,type="l", ylab = "Energy sub metering", xlab = ""))
  with(myData,lines(datetime,Sub_metering_2,col="red"))
  with(myData,lines(datetime,Sub_metering_3,col="blue"))
  
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  lty=c(1,1,1),
         col=c("black","red","blue"),cex=0.8);
  
  # Plot Top Left
  # Plot a line of voltage against datetime
  with(myData,plot(datetime,Voltage,type="l"))
  
  # Plot Bottom Left
  # Plot a line of global_ractive_power against datetime
  with(myData,plot(datetime,Global_reactive_power,type="l"))
  
  # Close the png graphical device
  dev.off()
  print ("Complete")
}