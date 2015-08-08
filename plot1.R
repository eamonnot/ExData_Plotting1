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
  myData$Global_active_power <- as.numeric(as.character(myData$Global_active_power))
  
  # Plot One
  # Open the png graphical device so we write to png not to screen
  png(file="plot1.png", width = 480, height = 480, units="px")
  par(mfcol = c(1,1))
  # Plot Global active power as a histogram
  hist(myData$Global_active_power,xlab = "Global Active Power (kilowatts)", col="red", 
       main = "Global Active Power" )
  # Close the png graphical device
  dev.off()
  print ("Complete")
}

