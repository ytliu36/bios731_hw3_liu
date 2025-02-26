#!/bin/env bash
#SBATCH --account=yli2635
#SBATCH --job-name=bios731_hw3
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=yutong.liu@emory.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10gb  # Memory for each job
#SBATCH --time=12:00:00  # Time for each job
#SBATCH --output=sim_%A_%a.out
#SBATCH --partition=day-long-cpu,wrobel
#SBATCH --array=1-4

## in total 4 scenarios 
# activate conda environment
module load R
# Set working directory
workDir="/scratch/BIOS731/ytliu/bios731_hw3_liu/"

# Use the array task ID to specify the sim run
n_sim=${SLURM_ARRAY_TASK_ID}

cd "${workDir}"

Rscript simulation/run_simulations.R --scen ${n_sim}
