#! /bin/sh

if [ $# != 1 ] ; then
	echo "
Usage: 

./fastq-dump.sh <sra-dir>

"
	exit 1
fi

sra_dir=$1

for i in $sra_dir/*.sra ; do
	base=`basename $i .sra`
	sbatch -o logs/fastq_"$base".log -e logs/fastq_"$base".err scripts/fastq-dump-triton.sh $i
done
