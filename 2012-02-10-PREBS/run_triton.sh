#! /bin/sh
#SBATCH --time=3-00:00:00 --mem-per-cpu=4000
#SBATCH -p smallmem
#SBATCH -c 4

input_dir=$1
my_cdf=$2
mmseq_file=$3
array_expr_means=$4

srun ./runall.sh $input_dir $my_cdf $mmseq_file $array_expr_means 0
