#!/bin/bash

# 2012 (C) Karolis Uziela, karolis.uziela@cs.helsinki.fi
# Antti Honkela group
# University of Helsinki
# Helsinki, Finland

echo "run_mmseq.sh started with parameters: $*"

if [ $# != 2 ] ; then
        echo "
Usage: 

./run-mmseq.sh [Parameters]

Parameters:
<input-dir> - Input directory (will also be used for output). Must have .sra files inside
<ref-genome> - Location of bowtie index for transriptome (without .fa extension)

"
        exit 1
fi

current=`pwd`

input_dir=$1
genome_file=$2

sra_files=`ls $input_dir/*.sra`

output_base=`basename $input_dir`

for i in $sra_files ; do
	base=`basename $i .sra`
	base=`basename $base .lite`
	if [ ! -f $input_dir/$base.fastq ] ; then
		if [ ! -f "$input_dir/$base"_1.fastq ] ; then
			echo "------------------- stage 1 -------------------"
			echo "------------------- stage 1 -------------------" 1>&2	
			fastq-dump --split-3 $i --outdir $input_dir
		fi
	fi
done

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

if [ ! -f $input_dir/$output_base.namesorted.bam ] ; then
	echo "------------------- stage 2 -------------------"
	echo "------------------- stage 2 -------------------" 1>&2
	if [ $fasta != 0 ] ; then
		echo "Aligning fasta unpaired reads"
		bowtie -a --best --strata -S -m 100 -X 400 -p 4 $genome_file -f $fasta_files | samtools view -F 0xC -bS - | samtools sort -n - $input_dir/$output_base.namesorted
	elif [ $paired == 0 ] ; then
		echo "Aligning fastq unpaired reads"
		bowtie -a --best --strata -S -m 100 -X 400 -p 4 $genome_file -q $fastq_files | samtools view -F 0xC -bS - | samtools sort -n - $input_dir/$output_base.namesorted
	else
		echo "Aligning fastq paired reads"
		bowtie -a --best --strata -S -m 100 -X 400 -p 4 $genome_file -q -1 $fastq_files1 -2 $fastq_files2 | samtools view -F 0xC -bS - | samtools sort -n - $input_dir/$output_base.namesorted
	fi
fi

if [ ! -f $input_dir/$output_base.hits ] ; then
	echo "------------------- stage 3 -------------------"
	echo "------------------- stage 3 -------------------" 1>&2
	bam2hits $genome_file.fa $input_dir/$output_base.namesorted.bam > $input_dir/$output_base.hits
	#rm $input_dir/$output_base.namesorted.bam
	sync
fi

if [ ! -f $input_dir/$output_base.mmseq ] ; then
	echo "------------------- stage 4 -------------------"
	echo "------------------- stage 4 -------------------" 1>&2
	mmseq $input_dir/$output_base.hits $input_dir/$output_base
	rm $input_dir/$output_base.hits
fi

echo "run_mmseq.sh done."
