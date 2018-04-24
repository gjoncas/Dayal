#Dayal - An Introduction to R for Quantitative Economics, ch. 5

#problem: can't compute derivatives, World Bank dataset isn't available

library("mosaic")

#makes linear functions
y1 <- makeFun(a + b * x ~ x, a = 2, b = 2)
y2 <- makeFun(a + b * x ~ x, a = 20, b = -0.5)

#plots the function
plotFun(y1, xlim = range(0,30), ylab = "y1, y2")
plotFun(y2, xlim = range(0,30), add = TRUE, lty = 2, lwd = 2)

#computes the derivative
dy1.dx <- D(a + b * x ~ x, a = 2, b = 2)      #this doesn't work
dy1.dx

dy2.dx <- D(a + b * x ~ x, a = 20, b = -0.5)
dy2.dx

#plots the derivative
plotFun(dy1.dx, xlim = range(0, 30), ylim = range(-2,5))
ladd(panel.abline(a = 2, b = 0, lty = 1, col = "black"))
# a here corresponds to b in makeFun
ladd(panel.abline(a = -0.5, b = 0, lty = 2, col = "black"))

#computes elasticity
ey1.x <- makeFun(b * x/(a + b * x) ~ x, a = 2, b = 2)
ey2.x <- makeFun(b * x/(a + b * x) ~ x, a = 20, b = -0.5)
ey1.x

#plots elasticity
plotFun(ey1.x, xlim = range(0, 30), ylim = range(-2,2))
plotFun(ey2.x, xlim = range(0, 30), ylim = range(-2,2), add = TRUE, lty = 2, lwd = 2)

#makes log-log function
y1 <- makeFun(exp(a + b * log(x)) ~ x, a = 1.5, b = 1.8)
y2 <- makeFun(exp(a + b * log(x)) ~ x, a = 1.5, b = -1.1)

#plots log-log function
plotFun(y1, xlim = range(0,30))
plotFun(y2, xlim = range(0,30), ylim = range(0,5), lty = 2, lwd = 2)

#takes derivative
dy1.dx <- D(exp(a + b * log(x)) ~ x, a = 1.5, b = 1.8)
dy1.dx
dy2.dx <- D(exp(a + b * log(x)) ~ x, a = 1.5, b = -1.1)
dy2.dx

#plots derivative
plotFun(dy1.dx, xlim = range(0, 30), ylim = range(0,120))
plotFun(dy2.dx, xlim = range(0, 30), ylim = range(1,-6), lty = 2, lwd = 2)

#computes elasticity
ey1.x <- makeFun(b ~ x, b = 1.8)
ey2.x <- makeFun(b ~ x, b = -1.1)
ey1.x

#plots elasticity
plotFun(ey1.x, xlim = range(0, 30))
ladd(panel.abline(a = 1.8, b = 0, col = "black"))         #a here is b in the makeFun

plotFun(ey2.x, xlim = range(0, 30), lty = 2, lwd = 2)     #a here is b in the makeFun
ladd(panel.abline(a = -1.1, b = 0, col = "black", lty = 2))


#World Bank (2014) online Databank, World Development Indicators
#http://databank.worldbank.org/data/home.aspx
CO2 <- read.csv("~/Documents/R/RMa2/elasticity/CO2pc_gnipc2005ppp.csv")

#plots CO2 per capita against GDP per capita
xyplot(CO2pc ~ GNIpc, data = CO2, ylim = c(0,30))

mod1 <- lm(CO2pc ~ I(GNIpc/1000), data = CO2)

library("arm")
display(mod1)

CO2mod <- makeFun(mod1)
xyplot(CO2pc ~ GNIpc, data = CO2, ylim = c(0,30))
plotFun(CO2mod(GNIpc) ~ GNIpc, add = TRUE)

xyplot(resid(mod1) ~ fitted(mod1), type = c("p", "smooth"))
histogram(~resid(mod1), fit = "normal")

histogram(~CO2pc, data = CO2, fit = "normal")
histogram(~log(CO2pc), data = CO2, fit = "normal")
histogram(~GNIpc, data = CO2, fit = "normal")
histogram(~log(GNIpc), data = CO2, fit = "normal")

l.CO2pc <- log(CO2$CO2pc)
l.GNIpc <- log(CO2$GNIpc)
mod2 <- lm(l.CO2pc ~ l.GNIpc, data = CO2)
display(mod2)

xyplot(l.CO2pc ~ l.GNIpc, data = CO2, type = c("r","p"))
xyplot(l.CO2pc ~ l.GNIpc, data = CO2, type = c("p","smooth"))

xyplot(resid(mod2) ~ fitted(mod2), type = c("p", "smooth"))
histogram(~resid(mod2), fit = "normal")