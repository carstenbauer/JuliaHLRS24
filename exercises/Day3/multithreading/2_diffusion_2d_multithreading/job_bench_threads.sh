#!/bin/bash
#PBS -N diff2dthreads_bench
#PBS -l select=1:node_type=skl:mem=150gb:ncpus=40
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -o job_bench_threads.out
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

# for i in 128 256 512 1028
for i in 512 2048 6144
do
    echo -e "\n\n#### Run $i"

    # echo -e "-- single threaded"
    # julia --project --threads 1 diffusion_2d_threads.jl $i
    # echo -e ""

    julia --project --threads 8 bench_threads.jl $i # benchmark multithreaded variants
done