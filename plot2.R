# Reading the data in, we only read data of interest give the size of the file!

data.file <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                        header=F, sep=';')

colnames(data.file) <- names(read.table('household_power_consumption.txt',
                                        header=TRUE,sep=";",nrows=1))


# To get week days on the plot!
days <- strptime(paste(data.file$Date, data.file$Time), "%d/%m/%Y %H:%M:%S") 

# Opening the plotting device
png(file= "plot2.png", width = 480, height = 480, units = "px")

# Plotting 
with(data.file, plot(days, Global_active_power, type="l",
                     xlab = '', ylab= "Global Active Power (kilowatts)"))


# Closing the plotitng device
dev.off()