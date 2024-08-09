# Exercises - Day 3

## Multithreading

### `1_montecarlo_pi_multithreading`

**Learnings:** multithreading a simple algorithm, balancing uniform and non-uniform workload.

In this exercise, you will parallelize the famous Monte Carlo algorithm that can produce the value of π=3.141... with desirable precision. Specifically, you will parallelize the algorithm using Julia's multithreading tools (e.g. `@threads` and `@spawn`).

### `2_diffusion_2d_multithreading`

**Learnings:** solving a physical (stencil) problem in parallel, strong scaling benchmark

Considering the 2D diffusion equation, you will implement a multithreaded, iterative stencil solver for the equation.

**Note:** Later in the course, we will come back to this very solver and (1) move it to the GPU and (2) parallelize it with MPI, to run it on multiple compute nodes (and multiple GPUs).

### `3_daxpy_cpu` (cluster needed)

**Learnings:** NUMA domains, thread pinning, maximal memory bandwidth of a compute node.

You'll consider a multithreaded DAXPY kernel. You'll explore the basic topology of a Noctua 2 compute node and will study how thread affinity and memory initialization can influence the performance dramatically (keyword: NUMA). You'll estimate the scaling of the maximal memory bandwidth on a Noctua 2 node as a function of the number of Julia threads.

## GPU

### `4_saxpy_gpu`

**Learnings:** using GPU array abstractions, writing a basic CUDA kernel, maximal memory bandwidth of a GPU.

You'll try to measure the maximal, obtainable memory bandwidth of a GPU. To that end, you'll consider different GPU implementations of SAXPY. Specifically, you'll move the computation to the GPU using array abstractions and will then hand-write a custom CUDA kernel. Afterwards, you'll compare your variants to a built-in CUBLAS implementation by NVIDIA.

### `5_diffusion_2d_gpu`

**Learnings:** moving an iterative stencil solver to the GPU, strong scaling benchmark

We'll revisit the 2D diffusion example (see `diffusion_2d_multithreaded` above) and translate the multithreaded computation into a CUDA kernel. How much more efficient will the GPU variant be?

### `5_juliaset_gpu`

**Learnings:** a glimpse into hardware-agnostic coding

In this exercise, we consider the problem of computing an image of the Julia Set. We will compare a CPU variant to a parallel GPU implementation (a custom CUDA kernel) which both call the same Julia function.















## Old

### `2_juliaset` (multithreading)

Here, we will compute an image of the [Julia set](https://en.wikipedia.org/wiki/Julia_set) using a sequential and and two multithreaded variants (`@threads` and `@spawn`). In particular, you will see the benefit of load balancing for certain workloads.

### `6_heat_diffusion` (GPU)

We'll consider the heat equation, a partial differential equation (PDE) describing the diffusion of heat over time, in two spatial dimensions. You will implement an explicit, iterative stencil solver for the equation and will learn how to move this solver from the CPU to the GPU by either using array abstractions or explicit CUDA kernels. Finally, you'll compare the performance of the different variants.

