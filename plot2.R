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

#### Read Global_active_power of req_data as numeric and converting Date and Time
#### variables of req_data in POSIXct format
req_data$Global_active_power <- as.numeric(as.character(req_data$Global_active_power))
req_data <- transform(req_data, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#### Plot 2 -> Plot timestamp as x-axis and Global_active_power as y-axis of req_data 
#### and saves as a png file of dimensions 480X480 pixels
plot2 <- function() {
  plot(req_data$timestamp,req_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
}
plot2()