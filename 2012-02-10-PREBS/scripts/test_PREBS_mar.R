#! /usr/bin/Rscript 

print(Sys.time())
source("scripts/PREBS.R")
#bam_files=c("bam_dir/input1.bam", "bam_dir/input2.bam")
#bam_files=c("../2012-02-09-mmseq/input-Marioni/kidney/accepted_hits_final.bam", "../2012-02-09-mmseq/input-Marioni/liver/accepted_hits_final.bam")
bam_files=c("Marioni-bam/kidney/accepted_hits_final.bam", "Marioni-bam/liver/accepted_hits_final.bam")
#bam_files=c("input-LAML/TCGA-AB-2803/accepted_hits_final.bam", "input-LAML/TCGA-AB-2805/accepted_hits_final.bam", "input-LAML/TCGA-AB-2806/accepted_hits_final.bam", "input-LAML/TCGA-AB-2807/accepted_hits_final.bam", "input-LAML/TCGA-AB-2810/accepted_hits_final.bam", "input-LAML/TCGA-AB-2812/accepted_hits_final.bam", "input-LAML/TCGA-AB-2814/accepted_hits_final.bam", "input-LAML/TCGA-AB-2816/accepted_hits_final.bam", "input-LAML/TCGA-AB-2817/accepted_hits_final.bam", "input-LAML/TCGA-AB-2818/accepted_hits_final.bam", "input-LAML/TCGA-AB-2819/accepted_hits_final.bam", "input-LAML/TCGA-AB-2820/accepted_hits_final.bam", "input-LAML/TCGA-AB-2821/accepted_hits_final.bam", "input-LAML/TCGA-AB-2822/accepted_hits_final.bam", "input-LAML/TCGA-AB-2825/accepted_hits_final.bam", "input-LAML/TCGA-AB-2826/accepted_hits_final.bam", "input-LAML/TCGA-AB-2828/accepted_hits_final.bam")

prebs_values <- prebs(bam_files, "cdf/HGU133Plus2_Hs_ENSG_mapping.txt", 1)

save(prebs_values, file="test_PREBS_values_mar.RData")

print(Sys.time())
