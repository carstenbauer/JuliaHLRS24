#!/bin/bash
#PBS -N cache_bandwidths
#PBS -l select=1:node_type=skl:mem=5gb:ncpus=1
#PBS -l walltime=00:15:00
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
julia --project cache_bandwidths_solution.jl
# julia --project cache_bandwidths_strided_solution.jl