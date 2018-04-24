#Dayal - An Introduction to R for Quantitative Economics, ch. 13
library("mosaic")

#create vector x with 30 elements, give first element a value of 100
x = numeric(30)
x[1] = 100

#difference equation --> t stands for time
for (t in 2:30) {x[t] <- 0.5 * x[t - 1] + 2}

#make a vector 'time', which has the same values as t
time <- 1:30
xyplot(x ~ time, type = "l")

#white noise
white <- rnorm(80)
time <- 1:80
plot(white, type = "l", las = 1)
acf(white, las = 1, main = "")      #graph of autocorrelations

#add white noise to difference equations
x = numeric(80)
x[1] = 100
w <- 10 * rnorm(80)
for (t in 2:80) {x[t] <- 0.5 * x[t - 1] + 2 + w[t]}
plot(x, type = "l", las = 1)
acf(x, main = "", las = 1)      #graph of autocorrelations


#Random Walk
x = numeric(300)
x[1] = 200
w <- 10 * rnorm(300)
for (t in 2:300) {x[t] <- x[t - 1] + w[t]}  #random walk

#plot random walk & its graph of autocorrelations
plot(x, type = "l", las = 1)
acf(x, main = "")


#Example: Fishing
S = numeric(15)
S[1] = 2325000
r = 0.8
L = 3200000

for (t in 2:15) {S[t] <- S[t - 1] + (S[t - 1] * r) * (1 - S[t-1]/L)}
Time <- 1:15
xyplot(S/10^6 ~ Time, type = "p")

S2 = numeric(15)
K = numeric(15)
S2[1] = 2325000
K[1] = 120
r = 0.8
L = 3200000
a = 0.06157
b = 1.356
g = 0.562
n = 0.1
c <- c(190380, 195840, 198760, 201060, 204880, 206880, 215220, 277820, 382880, 
       455340, 565780, 686240, 556580,721640, 857000)
p <- c(232, 203, 205, 214, 141, 128, 185, 262, 244, 214, 384, 498, 735, 853, 1415)

#puts the two equations into a loop
for (t in 2:15) {
  S2[t] <- S2[t-1] + (S2[t-1] * r) * (1 - S2[t-1]/L) - a * K[t-1]^b * S2[t-1]^g
  K[t] <- K[t-1] + (n * (a * (K[t-1]^(b-1)) * (S2[t-1]^g) - c[t-1]/p[t-1]))
}

#plot K against S
xyplot(K ~ S2/10^6, type = "l")

#plot S against Time
xyplot(S2/10^6 ~ Time, type = "l")