#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --partition=compute
#SBATCH --output=job_script.out

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job → load modules
    ml nvhpc
fi

# OpenMPI settings
export OMPI_MCA_mpi_cuda_support=0

# run MPI code
mpiexecjl -n 4 julia --project diffusion_2d_mpi.jl
# combine the results and visualize them
julia --project visualize_mpi.jl