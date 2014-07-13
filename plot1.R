# Reading the data in, we only read data of interest given the size of the file!

data.file <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                        header=F, sep=';')

colnames(data.file) <- names(read.table('household_power_consumption.txt',
                                        header=TRUE,sep=";",nrows=1))

data.file <- transform(data.file, Date = as.Date(Date, "%m/%d/%y"), 
                       Time = strptime(Time, "%H:%M:%S"))

# Opening the plotting device
png(file= "plot1.png", width = 480, height = 480, units = "px")

# Plotting 
hist(data.file$Global_active_power, col="red", 
     main=" Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

# Closing the plotitng device
dev.off()