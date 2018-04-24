#Dayal - An Introduction to R for Quantitative Economics, ch. 14
library("mosaic")
library("tseries")
library("forecast")
library("AER")
library("xts")

data(AirPassengers)       #built-in dataset
APass <- AirPassengers
class(APass)
#head(APass)

#las option makes y-axis labels horizontal
plot(APass, las = 1)

APfirst <- ts(APass[1:12])
APlast <- ts(APass[133:144])
ts.plot(APlast, APfirst, las = 1, lty = c(1, 2))
monthplot(APass, las = 1)


#Phillips Curve
data("USMacroSW", package = "AER")
usm <- ts.intersect(USMacroSW, 4 * 100 * diff(log(USMacroSW[,"cpi"])))

#add in infl (for inflation) to the names of columns
colnames(usm) <- c((colnames(USMacroSW)), "infl")
colnames(usm)

unemp1 <- usm[, "unemp"]
unemp.before <- unemp1[time(unemp1) < 1970]
unemp.after <- unemp1[time(unemp1) >= 1970]
infl1 <- usm[, "infl"]
infl.before <- infl1[time(infl1) < 1970]
infl.after <- infl1[time(infl1) >= 1970]

#plot inflation versus unemployment before & after 1970
xyplot(infl.before ~ unemp.before, type = c("p", "smooth"))
xyplot(infl.after ~ unemp.after, type = c("p", "smooth"))

infl.1 <- usm[, "infl"]
plot(infl.1, las = 1)
acf(infl.1, main = "")

#Augmented Dickey-Fuller test
adf.test(usm[, "infl"])
  #conclusion: null hypothesis that unit root is present was not rejected

#difference inflation to achieve stationarity, then check graphically
diff.infl <- diff(usm[, "infl"])
plot(diff.infl)
acf(diff.infl, main = "")
adf.test(diff((usm[, "infl"])))
  #conclusion: null hypothesis of a unit root is now rejected

#use Arima function, choosing AR of order 2, integrated of order 1, and no MA terms
fit_ar4 <- Arima(infl1, order = c(2, 1, 0))
forecast(fit_ar4, level = 95)
plot(forecast(fit_ar4), las = 1, main = "")


#Volatility in the Stock Market
data("NYSESW", package = "AER")
dpc <- 100 * diff(log(NYSESW))
str(dpc)
length(dpc)

#plot data for the first year
dpc_init <- window(dpc, start = as.Date("1990-01-03"), end = as.Date("1991-01-03"))
plot(dpc_init, las = 1)

#estimate st. dev. at monthly intervals, then plot the result
dpc5 <- as.xts(dpc)
dpc_sd_monthly <- apply.monthly(dpc5, sd)
plot(dpc_sd_monthly, las = 1)