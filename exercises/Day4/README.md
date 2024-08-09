# Exercises - Day 4

## Distributed

### `1_montecarlo_pi_distributed`

**Learnings:** basics of distributed computing with Distributed and MPI

In these exercises, you will parallelize a simple Monte Carlo algorithm that can produce the value of π=3.141... with desirable precision. Specifically, you will parallelize the algorithm und MPI.jl and Distributed.jl.

### `2_diffusion_2d_mpi`

**Learnings:** solving a physical (stencil) problem in parallel with MPI, weak scaling benchmark

We revisit the 2D diffusion example from yesterday and parallelize it using MPI. In principle, this enables us to run the code at scale. We will switch from a strong scaling to a weak scaling approach.

### `3_mpi_diffusion_1d`

**Learnings:** overlapping MPI communication with computation

You will implement (parts of) a MPI-parallel solver, this time for the 1D diffusion equation, for simplicity. Specifically, you will use non-blocking MPI communication to overlap communication and computation.

### `4_mpi_bcast`

**Learnings:** even basic things are hard to do efficiently

In this exercise, we will implement our own basic variants of `MPI.Bcast!` (broadcasting) using basic MPI primitives. Specifically, you'll write a "naive" version and a more efficient binary-tree based variant.

### `5_diffusion_2d_multigpu`

**Learnings:** solving a physical (stencil) problem in parallel with MPI on multiple GPUs

We revisit the 2D diffusion example once more and parallelize it using MPI + CUDA. In principle, this enables us to run the code on multiple GPUs, potentially in different compute nodes, at scale.
