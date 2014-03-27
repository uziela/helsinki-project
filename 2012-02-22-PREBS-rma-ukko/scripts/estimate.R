#! /usr/bin/Rscript 

fr <- function(x, k) {   
	alpha <- x[1]
	beta <- x[2]
	-sum(alpha*log(beta) - (alpha+k)*log(beta+1) + lgamma(alpha+k) - lgamma(k+1) - lgamma(alpha))
}

cargs <- commandArgs(trailingOnly = TRUE)

probe_table_file <- cargs[1] 

load(probe_table_file)

#k <- probe_table[,1]
k <- c(probe_table)
#k <- 2.3

#optim(c(0.2,0.03), fr)
#optim(c(0.2,0.03), fr, method="BFGS")
#optim(c(0.2,0.03), fr, method="CG")
optim(c(0.2,0.03), fr, NULL, k, method="L-BFGS-B", lower=0.0001, upper=10)
#optim(c(0.2,0.03), fr, method="L-BFGS-B", lower=0.0001, upper=10, control=list(fnscale=-1))

#opt <- optim(c(0.2,0.03), fr, method="L-BFGS-B", lower=0.0001, upper=10)
#opt$par[2]

#mat <- matrix(0,100,100)
#
#for (i in 1:100) {
#  for (j in 1:100) {
#    val1 <- i * 0.01
#    val2 <- j * 0.01
#		mat[i,j] <- fr(c(val1,val2))
#  }
#}
#
#png("estimate-laml-contour.png")
#library(graphics)
#filled.contour(mat, xlab="alpha", ylab="beta")
#dev.off()
#
#png("estimate-laml-scatter.png")
#library(scatterplot3d)
#scatterplot3d(mat, xlab="alpha", ylab="beta", zlab="f(alpha,beta)")
#dev.off()

