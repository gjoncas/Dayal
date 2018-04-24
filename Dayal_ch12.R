#Dayal - An Introduction to R for Quantitative Economics, ch. 12

#Problem: can't plot multiple graphs together, datasets don't work

library("mosaic")
library("mosaicCalc")
library("readxl")

Y <- makeFun(A*(K^a)*(L^(1-a)) ~ K, a=0.5, A=2, L=200)
plotFun(Y, xlim = range(0,4000), xlab = "Capital(K)", ylab = "Output(Y)")

#Savings is fcn of income, which in turn is fc of capital: S = sY(K)
S <- makeFun(s*A*(K^a)*(L^(1-a)) ~ K, a=0.5, A=2, L=200, s=0.2)
plotFun(S, xlim = range(0,4000), xlab = "Capital(K)", ylab = "Savings(S)")

#Depreciation is a proportion of capital stock: Dep = dK
Dep <- makeFun(d*K ~ K, d=0.1)
# warning: using D instead of Dep causes confusion; D is command
plotFun(S, xlim = range(0,4000), xlab = "Capital(K)", ylab = "Savings(S)")
plotFun(Dep, d=0.1, xlim = range(0,4000), xlab = "Capital(K)", ylab = "Depreciation(D)", add=TRUE)
    #Error in FUN(X[[i]], ...) : arguments to layer() should be calls

#rate of change of capital is savings minus depreciation: dK/dt = S - dep  --> differential eqn
#intersection b/w savings & depreciation gives steady state capital stock, where dk/dt = 0
#therefore: use findZeros function
Steady.state.K <- findZeros((s*A*(K^a)*(L^(1-a)) - d * K) ~ K, a=0.5, A=2, L=200, s=0.2, d=0.1)
Steady.state.K

#solve for capital over time by integrating numerically
  #NB: need mosiacCalc package --> install.packages("mosaicCalc")
Solow <- integrateODE(dK ~ -dep*K+(s*A*(K^a)*(L^(1-a))), K=1000, a=0.5, A=2, L=200, s = 0.2, 
                      dep = 0.1, tdur = list(from = 0, to = 60))

#plot vector of capital values, stored in Solow$K,
plotFun(Solow$K(t) ~ t, t.lim = range(0, 60))
  #growth in K (and thus Y) tapers off --> need a boost to A (TFP)


#pretty sure this is the wrong dataset
#NB: uses readxl package --> install.packages("readxl")
myd = read_excel("~/R/mpd2018.xlsx", sheet = "Full data")

ratio.2010.1900 <- myd[111, 2:6]/myd[1, 2:6]
ratio.2010.1900

#plots per capita GDP in 1990 GK dollars for the UK     #GK dollars??
xyplot(UK ~ Year, data = myd, type = "l")

#plots log of series for UK, making it linear --> slope equals growth rate
xyplot(log(UK) ~ Year, data = myd, type = "l")

#comparisons for how different economies grew. 
#xyplot uses + sign to tell R that we want to plot a number of time series on the same graph.
#ladd function adds text to the graph plotted by xyplot, giving the coordinates to put text

xyplot(log(UK) + log(USA) + log(Argentina) + log(India) + log(Japan) ~ Year, data = myd, 
       type = "l", col="black", ylab="", auto.key = list(lines=TRUE, points=FALSE, columns=3))
ladd(grid.text("USA", x = 1960, y = 9.8, default.units = "native"))
ladd(grid.text("India", x = 2008, y = 7.2, default.units = "native"))
ladd(grid.text("Argentina", x = 1998, y = 8.5, default.units = "native"))
ladd(grid.text("Japan", x = 1960, y = 7.5, default.units = "native"))
ladd(grid.text("UK", x = 1960, y = 8.9, default.units = "native"))


#World Development Indicators - GDP per capita (constant 2005 US$)
gdp <- read.csv("~/R/gdp_pc_time.csv")

histogram(~X2010/1000, breaks = 20, type = "percent", data = gdp, 
          scales = list(x = list(at = seq(0, 80, 10))))
  #Error in eval(varsRHS[[1]], data, env) : object 'X2010' not found

gdp$ratio <- gdp$X2010/gdp$X1980
favstats(ratio, data = gdp)
subset(gdp, subset = ratio > 4 | ratio < 0.3, select = c(Country.Name, X1980, X2010, ratio))
xyplot(ratio ~ log10(X1980), data = gdp, type = c("p", "smooth"))