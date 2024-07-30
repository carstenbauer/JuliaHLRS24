#!/bin/bash
#PBS -N dense_matmul
#PBS -l select=1:node_type=skl:mem=5gb:ncpus=1
#PBS -l walltime=00:45:00
#PBS -j oe
#PBS -o hlrs_job.output

# change to the directory that the job was submitted from
cd "$PBS_O_WORKDIR"

# load necessary modules
ml julia

# run program
julia --project dense_matmul.jl 2048