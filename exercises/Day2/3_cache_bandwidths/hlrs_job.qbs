#!/bin/bash
#PBS -N cache_bandwidths
#PBS -l select=1:node_type=skl
#PBS -l walltime=00:15:00
#PBS -j oe
#PBS -o hlrs_job.output

# change to the directory that the job was submitted from
cd "$PBS_O_WORKDIR"

# load necessary modules
ml julia

# run program
julia --project cache_bandwidths_solution.jl
# julia --project cache_bandwidths_strided_solution.jl