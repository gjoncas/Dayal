#Dayal - An Introduction to R for Quantitative Economics, ch. 6

#Problem: can't layer charts on top of one another

library("mosaic")

#Cobb-Douglas production function
plotFun(A*(L^0.7)*(K^0.3) ~ L, K=20, A=5, ylim = range(-5,101), xlim = range(-1,21))

#this doesn't work
#Error in FUN(X[[i]], ...) : arguments to layer() should be calls
plotFun(A*(L^0.7)*(K^0.3) ~ L, K=20, A=5, ylim = range(-5,151), xlim = range(-1,21))
plotFun(A*(L^0.7)*(K^0.3) ~ L, K=40, A=5, ylim = range(-5,151), xlim = range(-1,21), lty=2, add=TRUE)

plotFun(A*(L^0.7)*(K^0.3) ~ L, K=20, A=5, ylim = range(-5,151), xlim = range(-1,21))
plotFun(A*(L^0.7)*(K^0.3) ~ L, K=20, A=10,ylim = range(-5,151), xlim = range(-1,21), lty=2, add=TRUE)

plotFun(A*(L^0.7)*(K^0.3) ~ K, L=20, A=5, ylim = range(-5,101), xlim = range(-1,21))

#plot isoquants
plotFun(A*(L^0.7)*(K^0.3) ~ L & K, A=5, filled=FALSE, xlim = range(0,21), ylim = range(0,100))

#Cobb-Douglas production function, 3D view
plotFun(A*(L^0.7)*(K^0.3) ~ L & K, A=5, filled=FALSE, xlim = range(0,21), ylim = range(0,100), surface=TRUE)
  #Error in loadNamespace(name) : there is no package called 'manipulate'