load("marioni_detail.RData")
marioni_ranks <- data.frame(Gene_ID=marioni_detail$Gene_ID)
for (i in 2:ncol(marioni_detail)) {
	ranks <- rank(marioni_detail[,i], ties.method="random")
	#print(head(ranks))
	marioni_ranks[,i] <- ranks/(length(ranks)+1)
}

colnames(marioni_ranks) <- colnames(marioni_detail)
save(marioni_ranks, file="marioni_ranks.RData")
