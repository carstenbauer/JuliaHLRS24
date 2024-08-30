#!/bin/bash

# Making module / ml available
# ------------------------------------------------------------
export MODULEPATH=/opt/system/modulefiles:/opt/training/modulefiles:/opt/hlrs/non-spack/modulefiles:/opt/hlrs/spack/current/modulefiles
source /opt/system/lmod/lmod/init/profile
# ------------------------------------------------------------

# Load julia
ml julia
ml nvidia/nvhpc # for MPI/CUDA
ml compiler/nvidia

# Pass on all arguments to julia
exec julia "${@}"
