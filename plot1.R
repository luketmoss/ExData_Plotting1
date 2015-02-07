#Define input file
hpc_file <- file("./data/household_power_consumption.txt")

#read the file, use grep to only get data from 1/2/2007 and 2/2/2007
hpc <- read.table(text = grep("^[1,2]/2/2007", readLines(hpc_file), value = TRUE), 
                 col.names = c("Date", "Time", "Global_active_power", 
                               "Global_reactive_power", "Voltage", 
                               "Global_intensity", "Sub_metering_1", 
                               "Sub_metering_2", "Sub_metering_3"), 
                 sep = ";", header = TRUE)
close(hpc_file)

#Generate png with plot
png(filename="plot1.png", width = 480, height = 480)
hist(hpc$Global_active_power, col = "red", main = paste("Global Active Power"), 
     xlab = "Global Active Power (kilowatts)")
dev.off()