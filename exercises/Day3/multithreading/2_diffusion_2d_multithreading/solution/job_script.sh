#!/bin/bash
#PBS -N diff2dthreads
#PBS -l select=1:node_type=skl:mem=5gb:ncpus=10
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -o job_script.out
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

for i in 256 512 1028
do
    echo -e "\n\n#### Run ns=$i"

    echo -e "-- single threaded"
    julia --project --threads 1 diffusion_2d_threads.jl $i
    echo -e ""

    echo -e "-- multithreaded (10 threads), dynamic scheduling"
    julia --project --threads 10 diffusion_2d_threads.jl $i
    echo -e ""

    echo -e "-- multithreaded (10 threads), static scheduling"
    julia --project --threads 10 diffusion_2d_threads.jl $i static
    echo -e ""
done