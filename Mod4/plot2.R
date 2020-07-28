library(sqldf); library(dplyr); library(ggplot2); library(jpeg)
df <- read.csv(file = "df.csv")
df <- df[-1]
df$datetime <- as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
png("plot2.png", width = 480, height = 480)
with(df, plot(x = datetime, y = Global_active_power, main = 'Global Active Power', ylab = 'Global Active Power (in kilowatt)', type = 'l', xlab = ''))
dev.off()
