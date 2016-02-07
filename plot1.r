# 1st plot 
# read data only if it is not read into R yet. 
# !! Normally reading required once but i added reading part in the beginning of every plotting scripts since it is mentioned like this in the assignment instructions. 

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


png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
	
hist(econs.df$Global_active_power,col = "red",xlab = "Global Active Powers (kilowatts)", main = "Global Active Power")

dev.off()
