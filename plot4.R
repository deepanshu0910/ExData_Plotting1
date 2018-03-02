#### Download the file if it does not exist
if(!file.exists("household_power_consumption.txt")) {
  t <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",t)
  power_consumption_data <- unzip(t)
  unlink(t)
}

#### Read the data in the variable, pw_data
pw_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#### Read Date variable of pw_data as.Date
pw_data$Date <- as.Date(pw_data$Date, format="%d/%m/%Y")

#### Fetch only the required of 2007-02-01 and 2007-02-02 in variable, req_data
req_data <- pw_data[(pw_data$Date=="2007-02-01") | (pw_data$Date=="2007-02-02"),]

#### Read Global_active_power, Voltage, Global_reactive_power, Sub_metering_1, 
#### Sub_metering_2 and Sub_metering_3 of req_data as numeric and converting Date 
#### and Time variables of req_data in POSIXct format
req_data$Global_active_power <- as.numeric(as.character(req_data$Global_active_power))
req_data <- transform(req_data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
req_data$Voltage <- as.numeric(as.character(req_data$Voltage))
req_data$Sub_metering_1 <- as.numeric(as.character(req_data$Sub_metering_1))
req_data$Sub_metering_2 <- as.numeric(as.character(req_data$Sub_metering_2))
req_data$Sub_metering_3 <- as.numeric(as.character(req_data$Sub_metering_3))
req_data$Global_reactive_power <- as.numeric(as.character(req_data$Global_reactive_power))

#### Plot 4 -> Collection of four graphs which is saved as a png file of 480X480 pixels
plot4 <- function() {
  par(mfrow=c(2,2))
  
  ## Plot 1 -> Plot timestamp as x-axis and Global_active_power as y-axis of req_data 
  plot(req_data$timestamp,req_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  ## Plot 2 -> Plot timestamp as x-axis and Voltage as y-axis of req_data
  plot(req_data$timestamp,req_data$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ## Plot 3 -> Plot timestamp as x-axis and lines Sub_metering_1, Sub_metering_2 and 
  ## Sub_metering_3 of as y-axis of req_data 
  plot(req_data$timestamp, req_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(req_data$timestamp, req_data$Sub_metering_2, col="red")
  lines(req_data$timestamp, req_data$Sub_metering_3, col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
  
  ## Plot 4 -> Plot timestamp as x-axis and Global_reactive_power as y-axis of req_data
  plot(req_data$timestamp,req_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
}
plot4()