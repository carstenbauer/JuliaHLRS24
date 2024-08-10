#!/bin/bash
#PBS -N diff2dgpu
#PBS -l select=1:node_type=clx-ai:ncpus=36:mem=100gb
#PBS -l walltime=00:10:00
#PBS -j oe
#PBS -o job_bench_gpu.out
#PBS -q smp

WORKDIR=$(pwd)
if [[ -n "${PBS_O_WORKDIR}" ]]; then
    # we're running as a cluster job
    # change to the directory that the job was submitted from ...
    WORKDIR=$PBS_O_WORKDIR
    # ... and load the module(s)
    ml julia
    ml system/nvidia/ALL.ALL.550.54.15
fi
cd $WORKDIR

for i in 1024 2048 4096 8192 16384
do
    echo -e "\n\n#### GPU run ns=$i"

    julia --project diffusion_2d_gpu.jl $i
done
