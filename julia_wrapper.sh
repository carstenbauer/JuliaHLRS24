#!/bin/bash

# Making module / ml available
# ------------------------------------------------------------
export MODULEPATH=/etc/scl/modulefiles:/etc/scl/modulefiles:/apps/noarch/modulefiles:/apps/generic/modulefiles
source /usr/share/lmod/lmod/init/profile
# ------------------------------------------------------------

# Load julia
source /projects/julia/shared_bashrc.sh
module load nvhpc # for MPI/CUDA

# Pass on all arguments to julia
exec julia "${@}"
