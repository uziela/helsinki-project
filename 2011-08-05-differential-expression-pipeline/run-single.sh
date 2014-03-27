#!/bin/sh

# Takes one short read file with extension .sra, converts it to necessary format and runs scripts to get read counts for each gene. The file has to be provided as parameter without .sra extension
# Author: Karolis Uziela 2011

base=$1
direc=$2

# in case we were working with .lite.sra file...
base=`basename $base .lite`

# skip processing if _counts.RData exists
if [ ! -f "$direc/$base""_counts.RData" ] ; then

# convert .lite.sra files to .fastq
if [ ! -f "$direc/$base"_1.fastq ] && [ ! -f "$direc/$base".fastq ] && [ ! -f "$direc/$base".fa ] ; then
	fastq-dump $direc/"$base"*.sra --outdir $direc
fi

# run bowtie using .sam as output format
if [ ! -f $direc/$base.sam ] ; then
	if [ -f "$direc/$base"_1.fastq ] ; then
		bowtie -S hg19 -1 "$direc/$base"_1.fastq -2 "$direc/$base"_2.fastq $direc/$base.sam
	elif [ -f "$direc/$base".fastq ] ; then
		bowtie -S hg19 "$direc/$base".fastq $direc/$base.sam
	elif [ -f "$direc/$base".fa ] ; then
		bowtie -S -f hg19 "$direc/$base".fa $direc/$base.sam
	fi
fi

# remove no longer neccessary .fastq files
if [ -f "$direc/$base".fastq ] ; then
        rm "$direc/$base".fastq
elif [ -f "$direc/$base"_1.fastq ] ; then
        rm "$direc/$base"_1.fastq "$direc/$base"_2.fastq
elif [ -f "$direc/$base".fa ] ; then
        rm "$direc/$base".fa
fi

# reformat .sam to .bam
if [ ! -f $direc/$base.bam ] ; then
samtools view -bS -o $direc/$base.bam $direc/$base.sam 
fi

# remove .sam file
rm $direc/$base.sam

# find gene exon ranges for human genome
if [ ! -f exons.RData ] ; then
Rscript matti_scripts/exonRanges.R
fi

# load .bam files to R format
if [ ! -f $direc/$base.RData ] ; then
Rscript matti_scripts/BamToR.R $direc/$base
fi

# count number of reads for each gene. Output is in counts, rpk and rpkm variables of $direc/$base_counts.RData file
Rscript matti_scripts/getCounts.R $direc/$base

#rm $direc/$base.bam $direc/$base.RData

fi


