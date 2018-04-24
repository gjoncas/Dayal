#Dayal - An Introduction to R for Quantitative Economics, ch. 7
library("mosaic")
#install.packages("arm")

x <- c(1, 1.25, 2, 2.5, 3)

#calculating variance of x step-by-step
mean(x)
length(x)
dev.x <- x - mean(x)    #deviation of each x from the mean
t(dev.x) %*% dev.x      #transpose of dev.x times dev.x
Var_calc_x <- t(dev.x) %*% dev.x/(length(x) - 1)
Var_calc_x

#confirm variance using built-in function
var(x)

#compute covariance by hand
y <- c(1.5, 2.5, 3.4, 3.5, 4)
var(y)
mean(y)
length(y)
dev.y <- y - mean(y)
dev.y
covar_calc_yx <- t(dev.y) %*% dev.x/(length(y) - 1)
covar_calc_yx

#plot x & y, then calculate correlation
xyplot(y ~ x)
cor(y, x)

#make some 2-by-2 matrices
A <- matrix(c(2, 3, 3, 4), ncol = 2)
B <- matrix(c(2, 3, 4, 5), ncol = 2)
M <- B + A
t(A)              #transposes matrix A

#solving equations 2w+3z = 7 and 3w+4z = 10, i.e. AD = c
C = c(7, 10)
D <- solve(A) %*% C


#Running a regression
Cons = c(1, 1, 1, 1, 1)
Dat <- data.frame(Response = y, Cons = Cons, Predictor = x)
X <- cbind(Cons, x)
fit <- lm(Response ~ Predictor, data = Dat)
coef(fit)

#compute coefficients by hand
b1 = cov(y, x)/var(x)
b0 = mean(y) - (b1 * mean(x))

#use matrix formula for least squares
matcoeff <- solve(t(X) %*% X) %*% t(X) %*% y

#plot regression line
fitM <- makeFun(fit)
xyplot(Response ~ Predictor, data = Dat)
plotFun(fitM, add = TRUE)