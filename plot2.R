### Plot 1

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

# Subset data for required period
set1 = subset(data, Date == "2007-02-01")
set2 = subset(data, Date == "2007-02-02")
df = rbind(set1, set2)

# Combind Date and Time Variable
datetime = paste(df$Date, df$Time)
df$DateTime = strptime(datetime, "%Y-%m-%d %H:%M:%S")

# Make Plot2
png(filename = "plot2.png", width = 480, height = 480)
plot(df$DateTime, df$Global_active_power, data = df, type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     main = "")
dev.off()