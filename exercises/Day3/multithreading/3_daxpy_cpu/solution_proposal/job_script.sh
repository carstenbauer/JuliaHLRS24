#!/bin/bash
#SBATCH --job-name=daxpy_cpu
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=5gb
#SBATCH --partition=compute
#SBATCH --output=job_script.out
#SBATCH --exclusive
#SBATCH --account=research-eemcs-diam

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job → load modules
    # ml julia
    ml nvhpc
fi

# run program
julia --project -t 12 daxpy_cpu.jl
