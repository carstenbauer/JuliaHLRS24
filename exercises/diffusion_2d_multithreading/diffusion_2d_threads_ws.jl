# 2D linear diffusion solver - MPI
using Printf
using JLD2
using Base.Threads: @threads
using ThreadPinning
pinthreads(:cores)

# include(joinpath(@__DIR__, "../../shared.jl"))
include(joinpath(@__DIR__, "shared.jl"))

if !isinteger(sqrt(Threads.nthreads()))
    error("Number of threads must be square, e.g. 4, 9, or 16.")
end

# convenience macros simply to avoid writing nested finite-difference expression
macro qx(ix, iy) esc(:(-D * (C[$ix+1, $iy] - C[$ix, $iy]) / dx)) end
macro qy(ix, iy) esc(:(-D * (C[$ix, $iy+1] - C[$ix, $iy]) / dy)) end

function diffusion_step!(C2, C, params)
    (; dx, dy, dt, D) = params
    for iy in 1:size(C, 2)-2
        for ix in 1:size(C, 1)-2
            @inbounds C2[ix+1, iy+1] = C[ix+1, iy+1] - dt * ((@qx(ix+1, iy+1) - @qx(ix, iy+1)) / dx +
                                                             (@qy(ix+1, iy+1) - @qy(ix+1, iy)) / dy)
        end
    end
    return nothing
end

# MPI functions
@views function update_halo!(As, iA, tid, neighbors)
    myA = As[tid][iA]
    # "send", x-dimension
    (neighbors.left  != -1) && (As[neighbors.left][iA][:, 1]    .= myA[:, 2])
    (neighbors.right != -1) && (As[neighbors.right][iA][:, end] .= myA[:, end-1])

    # "send", y-dimension
    (neighbors.up   != -1)  && (As[neighbors.up][iA][1, :]     .= myA[2, :])
    (neighbors.down != -1)  && (As[neighbors.down][iA][end, :] .= myA[end-1, :])
    return nothing
end

function run_diffusion(; ns=64, nt=100, do_save=false)
    nthreads  = Threads.nthreads()
    d         = isqrt(nthreads)
    dims      = (d,d)

    tid2coords(tid) = divrem(tid - 1, d)
    coords2tid = (coords) -> begin
        r, c = coords
        r * d + c + 1
    end

    getneighbors = (tid) -> begin
        r, c  = tid2coords(tid)
        down  = r + 1 <  d ? coords2tid((r + 1, c)) : -1
        up    = r - 1 >= 0 ? coords2tid((r - 1, c)) : -1
        right = c + 1 <  d ? coords2tid((r, c + 1)) : -1
        left  = c - 1 >= 0 ? coords2tid((r, c - 1)) : -1
        (; left, right, up, down)
    end
    # tidgrid    = permutedims(reshape(1:nthreads, (d,d)), (2,1))
    # display(tidgrid)
    # display(getneighbors.(tidgrid))
    println("nthreads = $(nthreads), dims = $dims")

    neighbors = [getneighbors(tid) for tid in 1:nthreads]
    params    = [init_params_mpi(; dims, coords=tid2coords(tid), ns, nt, do_save) for tid in 1:nthreads]
    Cs        = [init_arrays_mpi(params[tid]) for tid in 1:nthreads]
    iC, iC2   = 1, 2
    t_tic     = 0.0
    # time loop
    for it in 1:nt
        # time after warmup (ignore first 10 iterations)
        (it == 11) && (t_tic = Base.time())
        # diffusion
        @threads :static for tid in 1:nthreads
            C  = Cs[tid][iC]
            C2 = Cs[tid][iC2]
            diffusion_step!(C2, C, params[tid])
        end
        @threads :static for tid in 1:nthreads
            update_halo!(Cs, iC2, tid, neighbors[tid])
        end
        iC, iC2 = iC2, iC # swap
        Y = @views Cs[1][iC][2:end-1, 2:end-1]
        @show sum(Y)
    end
    t_toc = (Base.time() - t_tic)
    # print performance
    print_perf(params[1], t_toc)
    # save to (maybe) visualize later
    if do_save
        for tid in 1:nthreads
            jldsave(joinpath(@__DIR__, "out_$(tid-1).jld2"); C = Array(Cs[tid][iC][2:end-1, 2:end-1]), lxy = (; lx=params[tid].L, ly=params[tid].L))
        end
    end
    return nothing
end

# Running things...

# enable save to disk by default
(!@isdefined do_save) && (do_save = true)
# enable execution by default
(!@isdefined do_run) && (do_run = true)

if do_run
    if !isempty(ARGS)
        run_diffusion(; ns=parse(Int, ARGS[1]), do_save)
    else
        run_diffusion(; ns=256, do_save)
    end
end
