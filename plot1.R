# Author: Mihai Fecioru [5 Dec 2015]

# Input parameters are:
# - the file name to import (in our case is 
#   xdata-data-household_power_consumption.txt)
# - start ID of the section that needs to be imported. In our case, we get it 
#   using the following Unix cmd (we get the ID of the first line):
#      grep -n "1/2/2007" exdata-data-household_power_consumption.txt
# - end ID of the section that needs to be imported - the ID of the first line 
#   that needs to be excluded. In our case, we get it using the following Unix
#   cmd (we get the ID of the first line):
#      grep -n "3/2/2007" exdata-data-household_power_consumption.txt
loadData <- function(file_name, start_row, end_row) {
    header <- unlist(read.csv(file_name, nrows=1, sep = ";", header=FALSE))
    d <- read.table(file_name, nrows = end_row - start_row, 
                    skip = start_row - 1, sep = ";", header=FALSE, 
                    stringsAsFactors = FALSE);
    colnames(d) <- header
    d$Date <- as.Date(d$Date, "%d/%m/%Y")
    d$Time <- strptime(paste(d$Date, d$Time, sep = " "), "%Y-%m-%d %H:%M:%S")
    d
}

# Creates the png file and returns the dataframe
# The function assumes that the exdata-data-household_power_consumption.txt
# data file is in the same folder with this R script.
plot1 <- function() {

    # 66638 is the first line in the file with date 1/2/2007
    # 69518 is the first line in the file with date 3/2/2007
    dd<-loadData("exdata-data-household_power_consumption.txt", 66638, 69518);

    png(filename = "plot1.png", width = 480, height = 480, units = "px")

    hist(dd$Global_active_power, col="red", main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)")

    dev.off()    
    dd
}
