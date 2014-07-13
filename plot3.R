# Reading the data in, we only read data of interest given the size of the file!

data.file <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                        header=F, sep=';')

colnames(data.file) <- names(read.table('household_power_consumption.txt',
                                        header=TRUE,sep=";",nrows=1))

# To get daytime on the plot!
days <- strptime(paste(data.file$Date, data.file$Time), "%d/%m/%Y %H:%M:%S") 



# Opening the plotting device
png(file= "plot3.png", width = 480, height = 480, units = "px")

#Set up the plotting region
with(data.file, plot(days, Sub_metering_3, type="n",
                     xlab = '', ylab= "Energy sub metering", ylim=c(0,40)))

# Plotting 
with(data.file, points(days, Sub_metering_1, type="l", xlab = ''))
with(data.file, points(days, Sub_metering_2, type="l", xlab = '', col="red"))
with(data.file, points(days, Sub_metering_3, type="l", xlab = '', col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, lty=c(1,1,1), col=c("black", "red", "blue"))

# Closing the plotitng device
dev.off()