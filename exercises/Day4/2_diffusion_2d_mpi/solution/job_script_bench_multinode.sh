#!/bin/bash
#PBS -N diff2dmpi_bench_multinode
#PBS -l select=4:node_type=skl:ncpus=40:mem=80gb:mpiprocs=2
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -o job_script_bench_multinode.out
#PBS -q smp

ml julia
ml nvidia/nvhpc
ml compiler/nvidia
cd $PBS_O_WORKDIR

# OpenMPI settings
export OMPI_MCA_mpi_cuda_support=0
export OMPI_MCA_btl_openib_warn_no_device_params_found=0

# run MPI code
for i in 1 2 4 8
do
    echo -e "\n\n#### Run nranks=$i"
    mpiexec -n $i --hostfile $PBS_NODEFILE --map-by ppr:1:numa --bind-to core --report-bindings julia --project diffusion_2d_mpi.jl 1024 nosave
done
