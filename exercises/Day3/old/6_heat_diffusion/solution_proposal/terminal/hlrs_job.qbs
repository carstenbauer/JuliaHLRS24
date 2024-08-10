#!/bin/bash
#PBS -N heat_diffusion
#PBS -l select=1:node_type=clx-ai:ncpus=36:mem=100gb
#PBS -l walltime=00:15:00
#PBS -q smp
#PBS -j oe
#PBS -o hlrs_job.output

# change to the directory that the job was submitted from
[[ -z "${PBS_O_WORKDIR}" ]] && PBS_O_WORKDIR=$(pwd)
cd "$PBS_O_WORKDIR"

# load necessary modules
ml julia
ml system/nvidia/ALL.ALL.550.54.15

# run program
#julia --project heat_diffusion_animation.jl
julia --project heat_diffusion_cpu.jl
julia --project -t 2 heat_diffusion_cpu_loop_multithreaded.jl
julia --project heat_diffusion_gpu.jl
julia --project heat_diffusion_gpu_kernels.jl
