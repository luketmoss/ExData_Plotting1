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
comb_datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$comb_datetime <- as.POSIXct(comb_datetime)

#Generate png with plot
png(filename="plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(hpc, {
    plot(Global_active_power ~ comb_datetime, type = "l", 
         ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ comb_datetime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ comb_datetime, type = "l", ylab = "Energy sub metering",
         xlab = "")
    lines(Sub_metering_2 ~ comb_datetime, col = 'Red')
    lines(Sub_metering_3 ~ comb_datetime, col = 'Blue')
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ comb_datetime, type = "l", 
         ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()