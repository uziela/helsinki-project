library("hgu133plus2hsensgprobe")
library(seqinr)

gc_func <- function(seq) {
  a <- strsplit(seq, split="")[[1]]
  return(GC(a))
}


probes <- data.frame(Gene_ID=substr(hgu133plus2hsensgprobe$Probe.Set.Name, 1, nchar(hgu133plus2hsensgprobe$Probe.Set.Name)-3), probe_seq=hgu133plus2hsensgprobe$sequence)

#counts <- summary(as.factor(probes$Gene_ID), maxsum=1000000)
#counts <- table(as.factor(probes$Gene_ID))

print(nrow(probes))

GCs <- character(0)
for (i in 1:length(probes$probe_seq)) {
	gc_temp <- gc_func(probes[i,]$probe_seq)
	GCs <- c(GCs, gc_temp)
	print(i)
}

probes$gc_content <- GCs

save(probes, file="probes_gc.RData")


