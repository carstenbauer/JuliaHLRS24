#!/bin/bash
#SBATCH --output=job_script.out
#SBATCH --time=00:05:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=8gb
#SBATCH --partition=gpu-v100

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job -> load the module(s)
    module use /projects/julia/modulefiles
    module load julia
    module load nvhpc
fi

export JULIA_CUDA_MEMORY_POOL=none

for i in 1024 2048 4096 8192 16384
do
    echo -e "\n\n#### GPU run ns=$i"

    julia --project diffusion_2d_gpu.jl $i
done
