#!/bin/bash
#PBS -N saxpy_gpu
#PBS -l select=1:node_type=clx-ai:ncpus=36:mem=100gb
#PBS -l walltime=00:10:00
#PBS -q smp
#PBS -j oe
#PBS -o job_script.out

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

# run program
julia --project saxpy_gpu_exercise.jl