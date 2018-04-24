#Dayal - An Introduction to R for Quantitative Economics, ch. 10
library("mosaic")
library("arm")

#IFRI data: http://www.ifriresearch.net/resources/data/
#http://www.ifriresearch.net/wp-content/uploads/2012/06/carbon_livelihoods_dataset1.zip
ifri <- read.csv("~/R/ifri_car_liv.csv")

#rename variables
#NB: not actually renaming; creates new variables with same data
ifri$carbon <- ifri$zbio
ifri$liveli <- ifri$zliv

#rows 80-100 are NA, so we choose rows without missing data
ifri <- ifri[1:80, ]

#rename ownership & rulematch dummy variables to make plots more readable
ifri$f_own <- factor(ifri$ownstate, labels = c("Community", "State"))   #1=State, 0=Community
ifri$f_rule <- factor(ifri$rulematch, labels = c("Low", "High"))        #1=High, 0=Low

#liveli: index of forest livelihoods
histogram(~liveli, data = ifri, type = "percent")

#carbon: carbon storage
histogram(~carbon, data = ifri, type = "percent")

xyplot(carbon ~ liveli, data = ifri, type = c("p", "smooth", "r"))

#pp. 66-7: We are interested in seeing how the levels of livelihoods & carbon 
          #vary among forests with different forest sizes, with ownership by 
          #community or state, and by perception of rules by forest users.

#layout: get one row, four column layout
#span: changes amount of smoothing
xyplot(carbon ~ liveli | cut(lnfsize, 4), data = ifri, type = c("p", "r", "smooth"), 
       layout = c(4, 1), span = 1)

#scatterplot of carbon vs. liveli conditional on both ownstate and rulematch
xyplot(carbon ~ liveli | f_own + f_rule, data = ifri, type = c("p", "r", "smooth"), 
       layout = c(4, 1), span = 0.8)


#Multiple regression
mod1 <- lm(carbon ~ liveli + ownstate + liveli:ownstate + rulematch + lnfsize + 
          lnfsize:liveli + liveli:rulematch, data = ifri)
  #NB: colons are used for interactions between variables
display(mod1)

#uses mplot command in mosaic --> figure showing coefficients & confidence intervals
mod.1 <- makeFun(mod1) 
mplot(mod1, which = 7)

#Residuals vs. Fitted
mplot(mod1, which = 1)    #scatter plot
histogram(~resid(mod1), breaks = 10, fit = "normal", type = "density")

#1) use xyplot to plot the scatter of points of carbon versus liveli. 
#2) use plotFun to plot the line of fit of mod1 of carbon vs liveli, 
      #with lnfsize = 5, ownstate = 0.5 and rulematch = 0.5. 
#3) plot another line of fit, changing only lnfsize to 9. 
#4) we use ladd to label the lines

xyplot(carbon ~ liveli, data = ifri, col = 'gray60')
plotFun(mod.1(liveli, lnfsize=5, ownstate=0.5, rulematch=0.5) ~ liveli, add=TRUE, lty=1)
plotFun(mod.1(liveli, lnfsize=9, ownstate=0.5, rulematch=0.5) ~ liveli, add=TRUE, lty=2)
ladd(grid.text("high lnfsize",x=1,y=1, default.units="native"))
ladd(grid.text("low lnfsize",x=0,y=-1, default.units="native"))
  #conclusion: higher forest size associated with higher carbon storage & livelihoods

#similar to above, but varying ownstate
xyplot(carbon ~ liveli, data = ifri, col = 'gray60')
plotFun(mod.1(liveli, lnfsize=7, ownstate=0, rulematch=0.5) ~ liveli, add=TRUE, lty=1)
plotFun(mod.1(liveli, lnfsize=7, ownstate=1, rulematch=0.5) ~ liveli, add=TRUE, lty=2)
ladd(grid.text("State", x=1.7, y=0.5, default.units = "native"))
ladd(grid.text("Community", x=0, y=1.5, default.units="native"))
    #community-owned forests: -ve association b/w carbon storage & livelihoods
    #state-owned forests: virtually no association between them

#similar to above, but varying rulematch
xyplot(carbon ~ liveli, data = ifri, col = 'gray60')
plotFun(mod.1(liveli, lnfsize=7, ownstate=0.5, rulematch=0) ~ liveli, add=TRUE, lty=1)
plotFun(mod.1(liveli, lnfsize=7, ownstate=0.5, rulematch=1) ~ liveli, add=TRUE, lty=2)
ladd(grid.text("High rulematch", x=1, y=1, default.units="native"))
ladd(grid.text("Low rulematch", x=0, y=-1, default.units="native"))
    #higher level of rule match (local users perceive rules to be appropriate)
    #is associated with higher levels of carbon storage and livelihoods