ml purge
ml julia
ml nvidia/nvhpc
ml compiler/nvidia
ml unload mpi/openmpi

#export OMPI_MCA_opal_cuda_support=1
export OMPI_MCA_btl_openib_warn_no_device_params_found=0
