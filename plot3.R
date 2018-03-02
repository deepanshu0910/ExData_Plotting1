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

#### Read Sub_metering_1, Sub_metering_2 and Sub_metering_3 of req_data as numeric 
#### and converting Date and Time variables of req_data in POSIXct format
req_data <- transform(req_data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
req_data$Sub_metering_1 <- as.numeric(as.character(req_data$Sub_metering_1))
req_data$Sub_metering_2 <- as.numeric(as.character(req_data$Sub_metering_2))
req_data$Sub_metering_3 <- as.numeric(as.character(req_data$Sub_metering_3))

#### Plot 3 -> Plot timestamp as x-axis and lines Sub_metering_1, Sub_metering_2 
#### and Sub_metering_3 of as y-axis of req_data and saves as a png file of 
#### dimensions 480X480 pixels
plot3 <- function() {
  plot(req_data$timestamp,req_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(req_data$timestamp,req_data$Sub_metering_2,col="red")
  lines(req_data$timestamp,req_data$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
}
plot3()