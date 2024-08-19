#!/bin/bash

# Making module / ml available
# ------------------------------------------------------------
export MODULEPATH=/opt/system/modulefiles:/opt/training/modulefiles:/opt/hlrs/non-spack/modulefiles:/opt/hlrs/spack/current/modulefiles
source /opt/system/lmod/lmod/init/profile
# ------------------------------------------------------------

# Load julia
module load julia
module load nvhpc # for MPI/CUDA

# Pass on all arguments to julia
exec julia "${@}"
