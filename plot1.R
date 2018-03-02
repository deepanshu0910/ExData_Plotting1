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

#### Read Global_active_power of req_data as numeric
req_data$Global_active_power <- as.numeric(as.character(req_data$Global_active_power))

#### Plot 1 -> Plots histogram of Global_active_power of req_data and saves as 
#### a png file of dimensions 480X480 pixels
plot1 <- function() {
  hist(req_data$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
}
plot1()