#Dayal - An Introduction to R for Quantitative Economics, ch. 9
library("mosaic")
library("arm")

ans <- anscombe         #dataset built into R
c(mean(ans$x1), mean(ans$x2), mean(ans$x3), mean(ans$x4))    #mean for each x variable
c(mean(ans$y1), mean(ans$y2), mean(ans$y3), mean(ans$y4))    #mean for each y variable

c(sd(ans$x1), sd(ans$x2), sd(ans$x3), sd(ans$x4))    #std. dev. for each x variable
c(sd(ans$y1), sd(ans$y2), sd(ans$y3), sd(ans$y4))    #std. dev. for each y variable

#shows regression results
fit1 <- lm(y1 ~ x1, data = ans)
fit2 <- lm(y2 ~ x2, data = ans)
fit3 <- lm(y3 ~ x3, data = ans)
fit4 <- lm(y4 ~ x4, data = ans)
display(fit1)
display(fit2)
display(fit3)
display(fit4)

#scatter plots for the 4 sets of y's & x's, choosing points (p) & regression lines (r)
xyplot(y1 ~ x1, data = ans, type = c("p","r"))
xyplot(y2 ~ x2, data = ans, type = c("p","r"))    #should use quadratic b/c curvature
xyplot(y3 ~ x3, data = ans, type = c("p","r"))    #outlier tilts fitted line upwards
xyplot(y4 ~ x4, data = ans, type = c("p","r"))    #after dropping extreme point, no relation

#scatter plots choosing (p) & loess smoother lines (smooth)
xyplot(y1 ~ x1, data = ans, type = c("p","smooth"))
xyplot(y2 ~ x2, data = ans, type = c("p","smooth"))
xyplot(y3 ~ x3, data = ans, type = c("p","smooth"))
xyplot(y4 ~ x4, data = ans, type = c("p","smooth"))