#!/bin/bash
#PBS -N diff2dthreads_compare
#PBS -l select=1:node_type=skl:mem=5gb:ncpus=10
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -o job_compare_threads_serial.out
#PBS -q smp

WORKDIR=$(pwd)
if [[ -n "${PBS_O_WORKDIR}" ]]; then
    # we're running as a cluster job
    # change to the directory that the job was submitted from ...
    WORKDIR=$PBS_O_WORKDIR
    # ... and load the module(s)
    ml julia
fi
cd $WORKDIR

for i in 128 256 512 1028
do
    echo -e "\n\n#### Run $i"

    echo -e "-- single threaded"
    julia --project --threads 1 diffusion_2d_threads.jl $i
    echo -e ""

    echo -e "-- multithreaded (8 threads)"
    julia --project --threads 8 diffusion_2d_threads.jl $i
    echo -e ""
done