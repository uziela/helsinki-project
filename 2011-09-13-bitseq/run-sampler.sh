#!/bin/sh

# 2011 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

if [ $# != 3 ] ; then
        echo "
Usage: 

./runall.sh [Parameters]

Parameters:
<input-file>  - input file1 (.sra)
<human-genome-file> - directory with cdna of human genome (.fa format)
<prefix> - TRUE or FALSE. Does .map file contain hg19_ens_Gene_ prefix?

"
        exit 1
fi

current=`pwd`

input_file=$1
genome_file=$2
prefix=$3

echo "runall.sh is running..."

base_genome=`basename $genome_file .fa`
dir_genome=`dirname $genome_file`

if [ ! -f $dir_genome/$base_genome.1.ebwt ] ; then
	cd $dir_genome
	bowtie-build -f -o 2 -t 12 --ntoa $base_genome.fa $base_genome
	cd $current
fi


base_file=`basename $input_file .sra`
base_file=`basename $base_file .lite` # in case we were working with .lite.sra file...
dir_name=`dirname $input_file`

if [ ! -f $dir_name/$base_file.fastq ] ; then
	fastq-dump $input_file --outdir $dir_name
fi

if [ ! -f $dir_name/$base_file.map ] ; then
	bowtie -t -v 2 -3 0 -a -m 50 $dir_genome/$base_genome $dir_name/$base_file.fastq $dir_name/$base_file.map 2> $dir_name/$base_file.map.bowtieLog
fi

if [ ! -f $dir_name/$base_file.prob ] ; then
	if [ $prefix = "TRUE" ] ; then
		parseAlignment.py -a $dir_name/$base_file.map -t ensGene.tr -o $dir_name/$base_file.prob -i fastq33 --transcriptPrefix hg19_ens_Gene_ 
	elif [ $prefix = "FALSE" ] ; then
		parseAlignment.py -a $dir_name/$base_file.map -t ensGene.tr -o $dir_name/$base_file.prob -i fastq33
	else
		echo "ERROR: incorrect prefix parameter"
		exit 1
	fi
fi

if [ ! -f $dir_name/$base_file-CS.rpkmS-0 ] ; then
	#estimateExpression -GS $dir_name/$base_file.map $dir_name/$base_file.rpkmS parameters.txt -T $current/ensGene.tr -C 1
	estimateExpression -CS $dir_name/$base_file $dir_name/$base_file parameters.txt -T ensGene.tr -C 4 
fi

if [ ! -f $dir_name/$base_file.rpkm ] ; then
	transposeLargeFile $dir_name/$base_file-CS.rpkmS-* $dir_name/$base_file.rpkm
fi

if [ ! -f $dir_name/$base_file.mean ] ; then
	getVariance -o $dir_name/$base_file.mean $dir_name/$base_file.rpkm
fi

if [ ! -f ensGene.tr.genes ] ; then
        tail -n +2 ensGene.tr > ensGene.tr.noheader
        cut -d " " -f 1 ensGene.tr.noheader > ensGene.tr.genes
        cut -d " " -f 2 ensGene.tr.noheader > ensGene.tr.transcripts
fi

if [ ! -f $dir_name/$base_file.mean.genes ] ; then
	tail -n +4 $dir_name/$base_file.mean | cut -f 1 -d " " > $dir_name/$base_file.mean.noheader
	paste -d " " ensGene.tr.genes $dir_name/$base_file.mean.noheader | sort > $dir_name/$base_file.mean.columns
	cat $dir_name/$base_file.mean.columns | ./scripts/sum_genes.pl > $dir_name/$base_file.mean.genes
	paste -d " " ensGene.tr.transcripts $dir_name/$base_file.mean.noheader > $dir_name/$base_file.mean.transcripts
fi

echo "runall.sh done."
