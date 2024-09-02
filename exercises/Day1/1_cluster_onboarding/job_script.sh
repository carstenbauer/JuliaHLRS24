#!/bin/bash
#PBS -N cluster_onboarding
#PBS -l select=1:node_type=skl:mem=1gb:ncpus=1
#PBS -l walltime=00:02:00
#PBS -j oe
#PBS -o job_script.out
#PBS -q smp

module load julia

# for MPI/CUDA, not necessary today but will be on Day 3/4:
# module load nvidia/nvhpc
# module load compiler/nvidia

cd $PBS_O_WORKDIR

julia --project helloworld.jl
