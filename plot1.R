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

##Plot 1
# open png device - call file plot1.png and set ht/width in pixels
png(filename="plot1.png",height=480,width=480, units ='px')
# create the plot
hist(data4$Global_active_power,col='red',xlab="Global Active Power (kilowatts)",main='Global Active Power')
# close the graphics device
dev.off()
