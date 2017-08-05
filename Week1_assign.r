
```{r}
library(data.table)
library(lubridate)

temp <- fread("./hfh/household_power_consumption.txt", na.strings = "?")
temp[, lapply(.SD, dmy), .SDcols = 1] -> temp$Date
```

```{r}
date1 <- temp[Date == "2007-02-01"]
date2 <- temp[Date == "2007-02-02"]
temp2 <- list(date1, date2) 
temp3 <- rbindlist(temp2, use.names = T) 
```

```{r}
png("./Plot1.png", width = 480, height = 480, units = "px")
hist(temp3$Global_active_power, col = "red", xlab = "Global Active Power (Killowatts)", main = "Global Active Power")
dev.off()
```

```{r}
png("./Plot2.png", width = 480, height = 480, units = "px")
with(temp3, plot(DT2, Global_active_power, type = "l", ylab = "Global Active Power"))
dev.off()
```

```{r}
png("./Plot3.png", width = 480, height = 480, units = "px")
with(temp3, {
        plot( DT2,Sub_metering_1, type = "l", 
              ylab = "Global Active Power (kilowatts)", xlab = "")
        lines( DT2, Sub_metering_2 ,col = 'Red')
        lines( DT2, Sub_metering_3 ,col = 'Blue')})
dev.off()
```

```{r}
png("./Plot4.png",  width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(temp3, plot(DT2, Global_active_power, type = "l", ylab = "Global Active Power",xlab = "Datetime"))
with(temp3, plot(DT2, Voltage, type ="l", xlab = "Datetime"))
with(temp3, {
        plot( DT2,Sub_metering_1, type = "l", 
              ylab = "Global Active Power (kilowatts)", xlab = "Datetime")
        lines( DT2, Sub_metering_2 ,col = 'Red')
        lines( DT2, Sub_metering_3 ,col = 'Blue')})
with(temp3, plot(DT2, Global_reactive_power, type ="l",xlab = "Datetime"))
dev.off()
```
