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
with(data_use,plot(times,Global_active_power,type = "l",xlab="",ylab = "Global Active Power (kilowatts)"))

#creat PNG file
dev.print(device=png,file="plot2.png",height=480,width=480)
