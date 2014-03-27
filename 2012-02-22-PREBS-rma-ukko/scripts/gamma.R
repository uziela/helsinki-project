#load("../output-sorted/thesis/Marioni-basic-new/PREBS_probe_table.RData")
png("gamma.png", width = 360, height = 360)

load("./output/Marioni-basic/PREBS_probe_table.RData")
#vals <- probe_table[,1]
vals <- c(probe_table)
v <- ecdf(vals)

load("./output/B-cells-basic/PREBS_probe_table.RData")
vals2 <- probe_table[,1]
v2 <- ecdf(vals2)

load("./output/LAML-basic/PREBS_probe_table.RData")
vals3 <- probe_table[,1]
v3 <- ecdf(vals3)

t <- 1:200;
plot(t, v(t), type='l', xlab="x", ylab="Cumulative distribution function") 
lines(t, pgamma(t, 0.2, rate=0.03), col='red')
#lines(t, pgamma(t, 0.17, rate=0.01), col='green')
#lines(t, pgamma(t, 0.2, rate=0.008), col='purple')
#lines(t, v3(t), col='orange')
#lines(t, v2(t), col='blue')

lines(t, pgamma(t, 0.16581619, rate=0.01311483), col='green')


#legend("bottomright",c("Marioni et al.", "alpha=0.2, beta=0.03","Cheung et al.","alpha=0.17, beta=0.01"),lwd=c(2.5,2.5,2.5,2.5),col=c("black", "red", "blue", "green"))

legend("bottomright",c("Marioni et al.", "alpha=0.2, beta=0.03","alpha=0.165, beta=0.013"),lwd=c(2.5,2.5,2.5),col=c("black", "red", "green"))

dev.off()

#lines(t, pgamma(t, 0.2, rate=0.015), col='red')
