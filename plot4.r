# 4th plot 
# read data only if it is not read into R yet. 
# !! Normally reading required once but i added reading script in the beginning of every plotting scripts since it is mentioned like this in the assignment instructions. 

# !! install(only if not installed yet) and load sqldf to make selection of filtering desired dates.
# install.packages("sqldf")
library(sqldf)

# set file name having the data and set its attributes
file2read <- file("household_power_consumption.txt")
attr(file2read, "file.format") <- list(sep = ";", header = TRUE)

# read selecting only data in the desired dates. 
econs.df <- sqldf("select * from file2read where Date in ('1/2/2007','2/2/2007')")

# check the dim for ensuring the data is correctly red. (looks correct since 2 days should have 2880 minutes.)
dim(econs.df)

# fix time to time format
econs.df$Date <- as.Date(econs.df$Date,"%d/%m/%Y")
econs.df$DateTime <- paste(econs.df$Date, econs.df$Time)
econs.df$DateTime <- strptime(econs.df$DateTime, "%Y-%m-%d %H:%M:%S")

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

par(mfrow=c(2,2))
	
with(econs.df, {
	plot(econs.df$DateTime, econs.df$Global_active_power, type="n",xlab="",ylab = "Global Active Power")
	lines(econs.df$DateTime, econs.df$Global_active_power)
	})

with(econs.df, {
	plot(econs.df$DateTime, econs.df$Voltage, type="n",xlab="datetime",ylab = "Voltage")
	lines(econs.df$DateTime, econs.df$Voltage)
	})
	
with(econs.df, {
	plot(DateTime,Sub_metering_1,type = "n",ylab = "Energy sub metering", xlab="")
	lines(DateTime,Sub_metering_1)
	lines(DateTime,Sub_metering_2,col="red")
	lines(DateTime,Sub_metering_3,col="blue")
	legend("topright",pch = 1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")
	})
	
with(econs.df, {
	plot(econs.df$DateTime, econs.df$Global_reactive_power, type="n",xlab="datetime",ylab = "Global_reactive_power")
	lines(econs.df$DateTime, econs.df$Global_reactive_power)
	})

dev.off()