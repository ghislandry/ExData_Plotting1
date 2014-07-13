# Reading the data in, we only read data of interest give the size of the file!

data.file <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                        header=F, sep=';')

colnames(data.file) <- names(read.table('household_power_consumption.txt',
                                        header=TRUE,sep=";",nrows=1))


days <- strptime(paste(data.file$Date, data.file$Time), "%d/%m/%Y %H:%M:%S") 


par(mfrow = c(1,1))

# Opening the plotting device
png(file= "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2,2))

with(data.file, plot(days, Global_active_power, type="l",
                     xlab = '', ylab= "Global Avtive Power"))
with(data.file, plot(days, Voltage, type="l",
                     xlab = "datetime", ylab= "Voltage"))
# 3rd plot
with(data.file, plot(days, Sub_metering_3, type="n",
                     xlab = '', ylab= "Energy sub metering", ylim=c(0,40)))
with(data.file, points(days, Sub_metering_1, type="l", xlab = ''))
with(data.file, points(days, Sub_metering_2, type="l", xlab = '', col="red"))
with(data.file, points(days, Sub_metering_3, type="l", xlab = '', col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd=1, lty=c(1,1,1), col=c("black", "red", "blue"), bty="n") #box.lty=0, box.lwd=0)

with(data.file, plot(days, Global_reactive_power, type="l",
                     xlab = "datetime", ylab= "Global_reactive_power"), ylim=c(0.0, 0.5))

# Closing the plotitng device
dev.off()