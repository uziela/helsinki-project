#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "runall.sh started with parameters: $*"

if [ $# != 5 ] ; then
	echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-dir> - Input directory (will also be used for output). Must have .CEL and .fastq files
<cdf> - cdf name
<mmseq-file> - mmseq file with gene expressions
<microarray-expressions> - file containing microarray expressions (array_expr_means.R)
<paired> - PAIRED or UNPAIRED

Commonly used CDFs:
HGU133Plus2_Hs_ENSG (Marioni, FIMM)
HGU133A2_Hs_ENSG	(Lungs_C)
HuEx10stv2_Hs_ENSG	(Lungs_S, brain)
HGFocus_Hs_ENSG		(Cheung)
"
	exit 1
fi

input_dir=$1
my_cdf=$2
mmseq_file=$3
array_expr_means=$4
pair_mode=$5
mode="RANGES"


cdf_package=`echo $my_cdf"cdf" | awk '{print tolower($0)}' | sed -e 's/_//g'`

run_name=`basename $input_dir`

paired=`ls -1 $input_dir/*_1.fastq 2>/dev/null | wc -l`	# do we have paired-ended files?
fasta=`ls -1 $input_dir/*.fa 2>/dev/null | wc -l`	# do we have fasta files instead of fastq?

fastq_files=`ls $input_dir/*.fastq 2>/dev/null`
fastq_files=`echo $fastq_files | sed -e "s/\s/,/g"`

fastq_files1=`ls $input_dir/*_1.fastq 2>/dev/null`					# for paired ended fastq files
fastq_files1=`echo $fastq_files1 | sed -e "s/\s/,/g"`
fastq_files2=`ls $input_dir/*_2.fastq 2>/dev/null`
fastq_files2=`echo $fastq_files2 | sed -e "s/\s/,/g"`

fasta_files=`ls $input_dir/*.fa 2>/dev/null`
fasta_files=`echo $fasta_files | sed -e "s/\s/,/g"`


if [ ! -d $input_dir/tophat ] ; then
  echo "------------------- stage 2 -------------------"
  echo "------------------- stage 2 -------------------" 1>&2
  if [ $fasta != 0 ] ; then
    echo "Aligning fasta unpaired reads"
    tophat -p 4 --transcriptome-only --max-multihits 1 --GTF ./Human_transcriptome/Homo_sapiens.GRCh37.65.gtf --transcriptome-index=./Human_transcriptome/known --output-dir $input_dir/tophat hg19 $fasta_files
  elif [ $paired == 0 ] ; then
    echo "Aligning fastq unpaired reads"
    tophat -p 4 --transcriptome-only --max-multihits 1 --GTF ./Human_transcriptome/Homo_sapiens.GRCh37.65.gtf --transcriptome-index=./Human_transcriptome/known --output-dir $input_dir/tophat hg19 $fastq_files
  else
    echo "Aligning fastq paired reads"
    tophat -p 4 --transcriptome-only --max-multihits 1 --GTF ./Human_transcriptome/Homo_sapiens.GRCh37.65.gtf --transcriptome-index=./Human_transcriptome/known --output-dir $input_dir/tophat hg19 $fastq_files1 $fastq_files2
  fi  
fi

if [ ! -f $input_dir/accepted_hits_precalc.RData ] ; then
	echo "------------------- stage 3 -------------------"
	echo "------------------- stage 3 -------------------" 1>&2
	#samtools sort -n $input_dir/tophat/accepted_hits.bam $input_dir/accepted_hits_sorted
	#samtools view -H $input_dir/accepted_hits_sorted.bam > $input_dir/accepted_hits_final.sam
	#samtools view $input_dir/accepted_hits_sorted.bam | grep -w "NH:i:1" >> $input_dir/accepted_hits_final.sam
	#samtools view -bS -o $input_dir/accepted_hits_final.bam $input_dir/accepted_hits_final.sam
	./scripts/bam_to_R_precalc.R $input_dir/tophat/accepted_hits.bam $input_dir/accepted_hits_precalc.RData $pair_mode
fi

#if [ $mode == "HTSEQ" ] ; then
#	# Get counts for probe regions
#	if [ ! -f $input_dir/probe_counts.RData ] ; then
#		echo "------------------- stage 4a -------------------"
#		echo "------------------- stage 4a -------------------" 1>&2
#		probe_mapping="cdf/""$my_cdf""_mapping.txt"
#		if [ ! -f $probe_mapping.gtf ] ; then
#			./scripts/htseq_format.R $probe_mapping $probe_mapping.gtf
#		fi
#		htseq-count -s no -o $input_dir/htseq-prebs-mapping.sam $input_dir/accepted_hits_final.sam $probe_mapping.gtf > $input_dir/htseq.count
#		cat $input_dir/htseq.count | grep "^xy" | sed -e "s/_/\t/g" | cut -f 2,3,4 > $input_dir/htseq2.count
#		./scripts/htseq_probe_counts.R $input_dir/htseq2.count $probe_mapping $input_dir/probe_counts.RData
#	fi	
#	# Calculate RPKM 
#	if [ ! -f $input_dir/accepted_hits_counts.RData ] ; then
#		echo "------------------- stage 5a -------------------"
#		echo "------------------- stage 5a -------------------" 1>&2
#		htseq-count -s no -o $input_dir/htseq-rpkm-mapping.sam $input_dir/accepted_hits_final.sam ./Human_transcriptome/Homo_sapiens.GRCh37.65.gtf >$input_dir/htseq_rpkm.count 
#		Rscript scripts/htseq_RPKM.R $input_dir/htseq_rpkm.count $input_dir/accepted_hits_counts.RData
#	fi
#fi

if [ $mode == "RANGES" ] ; then
	# Get counts for probe regions
	#if [ ! -f $input_dir/probe_counts.RData ] ; then
	#	echo "------------------- stage 4 -------------------"
	#	echo "------------------- stage 4 -------------------" 1>&2
	#	probe_mapping="cdf/""$my_cdf""_mapping.txt"
	#	Rscript scripts/count_overlaps.R $input_dir/accepted_hits.RData $input_dir/probe_counts.RData $probe_mapping
	#fi
	# Calculate RPKM 
	if [ ! -f $input_dir/accepted_hits_precalc_counts.RData ] ; then
		echo "------------------- stage 5 -------------------"
		echo "------------------- stage 5 -------------------" 1>&2
    #./scripts/getCounts_precalc.R $input_dir/accepted_hits_precalc.RData $input_dir/accepted_hits_precalc_counts.RData
    /cs/fs2/home/uziela/software/R-3.1.0/bin/Rscript scripts/getCounts.R $input_dir/accepted_hits_precalc
	fi
fi


## Calculate PREBS
#if [ ! -f $input_dir/$run_name"_PREBS.RData" ] ; then
#	echo "------------------- stage 6 -------------------"
#	echo "------------------- stage 6 -------------------" 1>&2
#	Rscript scripts/gene_expressions.R $input_dir/probe_counts.RData $input_dir/$run_name"_PREBS.RData"
#fi

if [ ! -f $input_dir/merged_precalc.RData ] ; then
	echo "------------------- stage 7 -------------------"
	echo "------------------- stage 7 -------------------" 1>&2
	#mkdir $input_dir/plots
	./scripts/array_comp_precalc.R $array_expr_means $input_dir $mmseq_file $input_dir/accepted_hits_precalc_counts.RData $run_name

	#Rscript scripts/probe_plot.R $array_expr_means $input_dir $run_name $cdf_package
fi

echo "runall.sh done."
