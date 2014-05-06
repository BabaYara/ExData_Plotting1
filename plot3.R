### Plot 3

# Download and Load Data
if(!file.exists("./data")){dir.create("./data")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp = tempfile()
download.file(fileurl, temp)
data = read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)

# Correct Date Structure
data$Date = as.Date(data$Date, "%d/%m/%Y")
data$Global_active_power = as.double(data$Global_active_power)
data$Sub_metering_1 = as.double(data$Sub_metering_1)
data$Sub_metering_2 = as.double(data$Sub_metering_2)
data$Sub_metering_3 = as.double(data$Sub_metering_3)

# Subset data for required period
set1 = subset(data, Date == "2007-02-01")
set2 = subset(data, Date == "2007-02-02")
df = rbind(set1, set2)

# Combind Date and Time Variable
datetime = paste(df$Date, df$Time)
df$DateTime = strptime(datetime, "%Y-%m-%d %H:%M:%S")

# Make Plot3
png(filename = "plot3.png", width = 480, height = 480)
plot(df$DateTime, df$Sub_metering_1, type = "l",
         xlab = "",
         ylab = "Energy Sub metering",
         main = "")
lines(df$DateTime, df$Sub_metering_2, col = "red")
lines(df$DateTime, df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.off()
