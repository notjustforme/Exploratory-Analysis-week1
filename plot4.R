library(sqldf)
library(dplyr)
#read data
data<-read.csv.sql("./household_power_consumption/household_power_consumption.txt",sql = "select * from file where Date='1/2/2007' OR Date='2/2/2007'",sep = ";")
data[data=="?"]<-NA
#convert date/time
datetime<-paste(data$Date,data$Time)
data$times<-strptime(datetime,"%d/%m/%Y %H:%M:%S")

#subset data
data_use<-data[,c(-1,-2)]

#plot 
#setting the layout of plotting
par(mfrow=c(2,2))

#plot (1,1)
with(data_use,plot(times,Global_active_power,type = "l",xlab="",ylab = "Global Active Power"))

#plot (1,2)
with(data_use,plot(times,Voltage,type = "l",xlab="datetime",ylab = "Voltage"))

#plot (2,1)
with(data_use,plot(times,Sub_metering_1,type = "l",col="black",xlab = "",ylab="Energy sub metering"))
lines(data_use$times,data_use$Sub_metering_2,col="red")
lines(data_use$times,data_use$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","red","blue"),cex=0.3,bty = "n")

#plot (2,2)
with(data_use,plot(times,Global_reactive_power,type = "l",xlab = "datetime",ylab = "Global_reactive_power"))

#creat PNG file
dev.print(device=png,file="plot4.png",height=480,width=480)
