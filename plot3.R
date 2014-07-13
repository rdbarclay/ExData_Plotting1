## read  the power table into the data frame
data = read.table("household_power_consumption.txt",header=TRUE,na.strings='?',
                  sep=';',colClasses=c('character','character','numeric','numeric',
                                       'numeric','numeric','numeric','numeric','numeric'))
# extract only the records that are for feb, 1&2nd in 2007
data2 = subset(data, Date == '1/2/2007'|Date == '2/2/2007')
# convert data to a date data type
data3 = transform(data2, Date = as.Date(Date,'%d/%m/%Y'))
# combine the date and time into a vector z 
z = paste(data3$Date, data3$Time)
# create a new vector of combined date and time using strptime
datTime =strptime(z,"%Y-%m-%d %H:%M:%S")
# add the new vector to the data frame as the fist column
data4 =cbind(datTime,data3)
## Plot 3
# open graphics device and set file name to plot3.png set ht/width to 480 pixels
png(filename='plot3.png',height=480,width=480,units='px')
# start plot and label y axis
plot(data4$datTime,data4$Sub_metering_1,type='l',ylab='Energy sub metering',xlab='')
# add next line in red
lines(data4$datTime,data4$Sub_metering_2,col='red')
#add next line in blue
lines(data4$datTime,data4$Sub_metering_3,col='blue')
# set the legend with names, and colored lines
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lwd=1,lty=c(1,1,1))
# close the graphics device
dev.off()