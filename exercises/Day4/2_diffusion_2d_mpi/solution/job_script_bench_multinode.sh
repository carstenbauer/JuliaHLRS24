#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --partition=compute
#SBATCH --output=job_script_bench_multinode.out

if [[ -n "${SLURM_JOBID}" ]]; then
    # we're running as a cluster job → load modules
    ml nvhpc
fi

# OpenMPI settings
export OMPI_MCA_mpi_cuda_support=0

# run MPI code
for i in 1 4 8 9 12 16
do
    echo -e "\n\n#### Run nranks=$i"
    # mpiexecjl -n $i --map-by numa --bind-to core --report-bindings julia --project diffusion_2d_mpi.jl 1024 nosave
    mpiexecjl -n $i --report-bindings julia --project diffusion_2d_mpi.jl 1024 nosave
done
