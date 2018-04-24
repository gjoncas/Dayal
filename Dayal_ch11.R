#Dayal - An Introduction to R for Quantitative Economics, ch. 11

#Problem: favstats mixes treatment & control group together

library("mosaic")
library("arm")
#install.packages("MatchIt")
library("MatchIt")
data(lalonde)
trellis.par.set(theme.mosaic(bw = TRUE))

str(lalonde)

#treatment: labor training program --> 6-18 months work exp. to ppl with econ & social problems
#want to know: whether treatment (treat) increased earnings in 1978 (re78)

densityplot(~age, groups=factor(treat),data=lalonde,col=c("grey30","black"), auto.key=TRUE)
histogram(~factor(black)|factor(treat),data=lalonde,type='percent')

#favstats in mosiac --> descriptive statistics for treatment & control groups
favstats(lalonde$age, groups=treat, data=lalonde)   #adds both groups together
  #maximum age in the treatment group is 48; in the control group it is 55. 

favstats(lalonde$black, groups=treat, data=lalonde) #mixes together
  #~84% of treatment group is black, versus only 20% of the control group

#match the data using coarsened exact matching method
m.out <- matchit(treat ~ age + educ + black + hispan + married + nodegree + re74 + re75, 
                 data = lalonde, method = "cem")
#NB: need cem package --> install.packages("cem")

plot(m.out, type = "hist")        #NB: need to make the plot screen big, otherwise won't show
m.data <- match.data(m.out)

densityplot(~age, groups=factor(treat),data=m.data,col=c("grey30","black"), auto.key=TRUE)
histogram(~factor(black)|factor(treat),data=m.data,type='percent')
favstats(lalonde$age,data=m.data,groups=treat)

#Comparing treatment & control
favstats(lalonde$re78, data = lalonde, groups = treat)    #still mixes groups together
favstats(lalonde$re78, data = m.data, groups = treat)

#compare diff in treatment & control group, before & after matching
  #run regressions & plot the results
fit1 <- lm(re78~treat,data=lalonde)
display(fit1)
fit.1 <- makeFun(fit1)
xyplot(re78 ~ jitter(treat),data=m.data,pch=1)
plotFun(fit.1(treat)~treat,add=TRUE)
fit2 <- lm(re78~treat,data=m.data)
display(fit2)
fit.2 <- makeFun(fit2)
xyplot(re78 ~ jitter(treat),data=m.data,pch=1)
plotFun(fit.2(treat)~treat,add=TRUE)

#matching before analysis, and adjusting for covariates after matching
fit3 <- lm(re78 ~ treat + age + educ + black + hispan + married + nodegree + re74 + re75, 
           data = m.data)
display(fit3)
  #conclusion: not much diff b/w estimate of treatment effects in fit2 (1001) & fit3 (1012)