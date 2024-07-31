#!/bin/bash

# Making module / ml available
# ------------------------------------------------------------
export MODULEPATH=/opt/system/modulefiles:/opt/training/modulefiles:/opt/hlrs/non-spack/modulefiles:/opt/hlrs/spack/current/modulefiles
source /opt/system/lmod/lmod/init/profile
# ------------------------------------------------------------

# Load julia
module load julia

# Load NVIDIA driver if on a GPU node
if [[ "$HOSTNAME" == "n011501" ||  "$HOSTNAME" == "n010301" ||  "$HOSTNAME" == "n011101" ||  "$HOSTNAME" == "n010701" ]]; then
    module load system/nvidia/ALL.ALL.550.54.15
fi

# Pass on all arguments to julia
exec julia "${@}"
