#!/bin/bash
#SBATCH --job-name=diff2dthreads
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=5gb
#SBATCH --partition=compute
#SBATCH --output=job_script.out
#SBATCH --account=research-eemcs-diam

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job → load modules
    module use /projects/julia/modulefiles
    module load julia
fi

for i in 256 512 1228
do
    echo -e "\n\n#### Run ns=$i"

    echo -e "-- single threaded"
    julia --project --threads 1 diffusion_2d_threads.jl $i
    echo -e ""

    echo -e "-- multithreaded (12 threads), dynamic scheduling"
    julia --project --threads 12 diffusion_2d_threads.jl $i
    echo -e ""

    echo -e "-- multithreaded (12 threads), static scheduling"
    julia --project --threads 12 diffusion_2d_threads.jl $i static
    echo -e ""
done