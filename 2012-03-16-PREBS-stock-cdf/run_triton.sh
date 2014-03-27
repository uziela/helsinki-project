#! /bin/bash
#SBATCH --time=1-00:00:00 --mem-per-cpu=16000
#SBATCH -p largemem

input_dir=$1
my_cdf=$2
dataset_dir=$3

srun ./runall.sh $input_dir $my_cdf $dataset_dir
