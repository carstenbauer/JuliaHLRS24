#!/bin/bash
#PBS -N diff2dmpi_bench
#PBS -l select=1:node_type=skl:mpiprocs=4
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -o job_script_bench.out
#PBS -q smp

WORKDIR=$(pwd)
if [[ -n "${PBS_O_WORKDIR}" ]]; then
    # we're running as a cluster job
    # change to the directory that the job was submitted from ...
    WORKDIR=$PBS_O_WORKDIR
    # ... and load the module(s)
    ml julia
    ml nvidia/nvhpc
    ml compiler/nvidia
fi
cd $WORKDIR

# hide some OpenMPI warnings/info messages on the cluster
export OMPI_MCA_mpi_cuda_support=0
export OMPI_MCA_btl_openib_warn_no_device_params_found=0

# run MPI code
mpiexecjl -n 4 julia --project diffusion_2d_mpi.jl 1024 nosave