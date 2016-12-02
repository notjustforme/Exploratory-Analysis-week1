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
with(data_use,plot(times,Sub_metering_1,type = "l",col="black",xlab = "",ylab="Energy sub metering"))
lines(data_use$times,data_use$Sub_metering_2,col="red")
lines(data_use$times,data_use$Sub_metering_3,col="blue")

#add legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col = c("black","red","blue"),cex = 0.7)

#creat PNG file
dev.print(device=png,file="plot3.png",height=480,width=480)

