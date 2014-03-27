#! /bin/sh
#SBATCH --time=1-00:00:00 --mem-per-cpu=4000
#SBATCH -p smallmem
#SBATCH -c 4

input_dir=$1
transcript=$2
cd /triton/ics/scratch/uzielak1/2012-02-09-mmseq
srun ./run_mmseq_new.sh $input_dir $transcript
