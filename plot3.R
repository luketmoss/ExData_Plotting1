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

#Convert dates
hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(datetime)

#Generate png with plot
png(filename="plot3.png", width = 480, height = 480)
with(hpc, {
    plot(Sub_metering_1 ~ Datetime, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()