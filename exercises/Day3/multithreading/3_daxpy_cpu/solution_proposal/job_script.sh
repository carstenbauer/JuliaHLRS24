#!/bin/bash
#PBS -N daxpy_cpu
#PBS -l select=1:node_type=skl:mem=150gb:ncpus=40
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

# run program
julia --project -t 20 daxpy_cpu.jl
