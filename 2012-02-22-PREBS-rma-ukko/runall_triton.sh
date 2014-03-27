#! /bin/sh
#SBATCH --time=0-04:00:00 --mem-per-cpu=4000
#SBATCH -p short
#SBATCH --error=logs/prebs_rma.%j.err
#SBATCH --output=logs/prebs_rma.%j.log

srun ./runall.sh "$@"
