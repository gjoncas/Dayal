#Dayal - An Introduction to R for Quantitative Economics, ch. 8
library("mosaic")
library("arm")      #for t-test

#normal distribution
n <- 1000     #sample size
mu <- 800     #mean
sd <- 35      #st. dev.
heights <- rnorm(n = n, mean = mu, sd = sd)     #rnorm: 'r' for random, 'norm' for normal
heights[1:10]
histogram(~heights, type = "percent")

#uniform distribution
n <- 1000
a <- 0
b <- 100
measures <- runif(n = n, min = a, max = b)      #runif: 'r' for random, 'unif' for uniform
measures[1:10]
histogram(~measures, type = "percent")

#binomial distribution
#what is the distribution of females per class that we observe in 1000 classrooms?
n <- 1000
N <- 30
p <- 0.5
females <- rbinom(n = n, size = N, prob = p)   #'r' for random, 'binom' for binomial
females[1:10]
histogram(~females, type = "percent")

#Central Limit Theorem
y <- runif(n = 1000, min = 0, max = 100)
histogram(~y, type = "percent", breaks = 10)
sample(y, size = 2)
M.s.2.y = do(50) * mean(sample(y, 2))
histogram(~M.s.2.y, type = "percent")
M.s.100.y = do(50) * mean(sample(y, 100))
histogram(~M.s.100.y, type = "percent")

#t-test - see if men & women's wages differ
n.w <- 48         #sample size: women
n.m <- 52         #sample size: women
mu.w <- 100       #mean: women
mu.m <- 90        #mean: men
sigma <- 2        #st. dev.
n <- n.w + n.m
y.w <- rnorm(n.w, mu.w, sigma)         #generates data for women in normal dist.
y.m <- rnorm(n.m, mu.m, sigma)
wages <- c(y.w, y.m)
gender <- rep(c(0,1), c(n.w, n.m))     #dummy: 0 for women, 1 for men
bwplot(factor(gender) ~ wages)
  #run regression
fit.wages <- lm(wages ~ gender)
display(fit.wages)                    #mean for men is 10 less than mu.w

#logit regression
  #purchase (yes or no), as fcn of income: once we cross a threshold, we buy
income <- 1:100
late.dd <- 1 + 0.02 * income          #latent variable: desire to purchase
late.star <- late.dd + rnorm(n = 100, mean = 1, sd = 0.5)
xyplot(late.star ~ late.dd)
purchase <- ifelse(late.star > 2.5, 1, 0)   #if desire >2.5, then we purchase (1)

  #scatter plot of purchase vs. income
xyplot(jitter(purchase) ~ income)
mylogit <- glm(purchase ~ income, family = "binomial")    #glm: generalized linear model
display(mylogit)
  #plot the fitted curve
mylo <- makeFun(mylogit)
xyplot(jitter(purchase) ~ income)
plotFun(mylo, add = TRUE)