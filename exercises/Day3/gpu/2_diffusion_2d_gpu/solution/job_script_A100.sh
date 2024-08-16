#!/bin/bash
#SBATCH --output=job_script_A100.out
#SBATCH --time=00:05:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=8gb
#SBATCH --partition=gpu-a100

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job -> load the module(s)
    ml nvhpc
fi

# some env vars
export CUDA_HOME=$NVHPC_ROOT/cuda/12.1
export JULIA_CUDA_MEMORY_POOL=none

for i in 1024 2048 4096 8192 16384
do
    echo -e "\n\n#### GPU run ns=$i"

    julia --project diffusion_2d_gpu.jl $i
done