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
## plot 4
# open graphics device for png, set file name to plot4.png, set ht/width to 480 pixels
png(filename='plot4.png',height=480,width=480,units='px')
# create a two column by 2 row matrix for the graphs (column order)
par(mfcol = c(2,2))
# plot the upper left plot
with(data4,plot(datTime,Global_active_power,type='l',xlab='',ylab='Global Active Power'))
# plot the lower left plot
plot(data4$datTime,data4$Sub_metering_1,type='l',ylab='Energy sub metering',xlab='')
lines(data4$datTime,data4$Sub_metering_2,col='red')
lines(data4$datTime,data4$Sub_metering_3,col='blue')
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lwd=1,lty=c(1,1,1),bty='n',cex=.9)
# plot the upper right plot
with(data4,plot(datTime,Voltage,type='l',ylab='Voltage',xlab='datetime'))
# plot the lower right plot
with(data4,plot(datTime,Global_reactive_power,type='l',xlab='datetime'))
# close the graphics device
dev.off()