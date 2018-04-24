#Dayal - An Introduction to R for Quantitative Economics, ch. 4
#install.packages("mosaic")
library("mosaic")
#install.packages("Quandl")
library("Quandl")

#Problem: in original code, Crude Oil Price Data doesn't work. (Fixed below)

#IFRI data: http://www.ifriresearch.net/resources/data/
#http://www.ifriresearch.net/wp-content/uploads/2012/06/carbon_livelihoods_dataset1.zip

#Fulton fish market data: http://people.brandeis.edu/~kgraddy/data.html
#http://people.brandeis.edu/~kgraddy/datasets/fishmayreq.txt


##Uploading data (ch. 3)
ifri_car_liv <- read.csv("~/R/ifri_car_liv.csv")
#head(ifri_car_liv)
#ifri_car_liv[1:5, c(2, 5, 6)]
#ifri_car_liv[1:5, c("cid", "ownstate")]
#str(ifri_car_liv)

fish <- read.delim("~/R/fishmayreq.txt")
#fishmayreq[1:5, c("pric", "quan")]

Oil_prices <- Quandl("BP/CRUDE_OIL_PRICES")       #need Quandl package
#head(Oil_prices)


##Creates demand & supply curves, calculates equilibrium

#defines inverse demand function, pD = (125 - 6q) / 8
pD <- makeFun(( aD - ( bD * q ) ) / cD ~ q,
              aD = 125, bD = 6,cD = 8)
#NB: expression to the left of ~ is fcn of variable to the right of it
#pD(20)       #when q=20, p=0.625

#plots demand curve
plotFun(pD, xlim = range(0, 30), ylim = range(5, 20), lty = 2, lwd = 1.5)
#xlim stands for the limits of x, ylim similarly. 
#get dotted line by lty = 2; lty stands for line type
#lwd adjusts width of line

#another inverse demand function, where aD = 150 instead of 125
pD2 <- makeFun((aD - (bD * q))/cD ~ q, aD = 150, bD = 6, cD = 8)

#plot both demand curves together
plotFun(pD, xlim = range(0, 30), ylim = range(5, 20), lty = 2, lwd = 1.7)
plotFun(pD2, xlim = range(0, 30), ylim = range(5, 20), lwd=1.7, add=TRUE)
  #add=TRUE adds second plot to the first

#defines supply function
pS <- makeFun((aS + (bS * q))/cS ~ q, aS = 12, bS = 2, cS = 5)

#plots S&D curves together
plotFun(pD, xlim = range(0, 30), ylim = range(5,20), lty = 2)
plotFun(pD2, xlim = range(0,30), ylim = range(5,20), add = TRUE)
plotFun(pS, xlim = range(0, 30), ylim = range(5,20), add = TRUE)

#At equilibrium, D = S, or D - S = 0 --> use findZeros function on excess demand
q.equil <- findZeros(((aD - (bD * q))/cD) - ((aS + (bS * q))/cS) ~ q, 
                     aD = 125, bD = 6, cD = 8, aS = 12, bS = 2, cS = 5)
q.equil
pD(q.equil)


##Fish data (Graddy, 2006)

xyplot(pric ~ quan,data=fish)     #see p. 23, fig. 4.4 left
#S&D both changing, can't identify each curve

xyplot(pric ~ jitter(stor), data = fish, type = c("p","r"))    #fig. 4.4R (stor = stormy)
#storms shift S curve, letting us identify D curve (using storms as IV)


##Crude Oil Price Data (BP)

Oil_prices$Date = 2016:1861     #manually converts Date to numeric
colnames(Oil_prices) <- c("Date", "Price.then", "Price.2016")     #change column names
xyplot(Price.2016 ~ Date, data = Oil_prices, type ="l")