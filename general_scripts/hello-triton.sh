#! /bin/sh
#SBATCH --time=0-00:01:00 --mem-per-cpu=2500
#SBATCH --error=/triton/ics/scratch/uzielak1/2012-02-09-test-triton/logs/hello.%j.err
#SBATCH --output=/triton/ics/scratch/uzielak1/2012-02-09-test-triton/logs/hello.%j.log
#SBATCH -p play

cd /triton/ics/scratch/uzielak1/2012-02-09-test-triton
srun ./scripts/hello.sh
