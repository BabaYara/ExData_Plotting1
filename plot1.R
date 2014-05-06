### Plot 1

# Download and Load Data
if(!file.exists("./data")){dir.create("./data")}
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp = tempfile()
download.file(fileurl, temp)
data = read.table(unz(temp, "household_power_consumption.txt"), header = T, sep = ";")
unlink(temp)

# Correct Column Classes
data$Date = as.Date(data$Date, "%d/%m/%Y")
data$Time = strptime(data$Time, "%H:%M:%S")
data$Global_active_power = as.double(data$Global_active_power)


# Subset data for required period
set1 = subset(data, Date == "2007-02-01")
set2 = subset(data, Date == "2007-02-02")
df = rbind(set1, set2)

# Make Plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red")
dev.off()
