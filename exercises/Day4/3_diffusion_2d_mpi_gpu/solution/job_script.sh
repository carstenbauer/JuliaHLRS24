#!/bin/bash
#SBATCH --output=job_script.out
#SBATCH --time=00:05:00
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --mem-per-cpu=4gb
#SBATCH --partition=gpu-v100

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job -> load the module(s)
    ml nvhpc
fi

# some env vars
export OMPI_MCA_mpi_cuda_support=1
export CUDA_HOME=$NVHPC_ROOT/cuda/12.1
export JULIA_CUDA_MEMORY_POOL=none

# run MPI + CUDA code on 4 GPUs
mpiexecjl -n 4 julia --project diffusion_2d_mpi_gpu.jl
# combine the results and visualize them
julia --project visualize_mpi.jl

# run with higher resolution
mpiexecjl -n 4 julia --project diffusion_2d_mpi_gpu.jl 16384 nosave