cat("\014")
# Loading Data set
data<-read.table("./household_power_consumption.txt", header=T, sep=';',na.strings="?",nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
# Sub-setting the Data set
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
names(data)
sub_data<-subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data)
#Creating Plot
gap<-as.numeric(sub_data$Global_active_power)
png("plot1.png", width=480, height=480)
## Converting dates
datetime <- paste(as.Date(sub_data$Date), sub_data$Time)
sub_data$Datetime <- as.POSIXct(datetime)

# Creating image
windows()
with(sub_data, {
  plot(Sub_metering_1~Datetime, type="l",ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  })
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

