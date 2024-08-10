## PARAMETER INITIALIZATION
function init_params(; ns=64, nt=ns^2÷40, kwargs...)
    L    = 10.0               # physical domain length
    D    = 1.0                # diffusion coefficient
    ds   = L / ns             # grid spacing
    dt   = ds^2 / D / 4.1     # time step
    cs   = range(start=ds / 2, stop=L - ds / 2, length=ns) .- 0.5 * L # vector of coord points
    nout = floor(Int, nt / 5) # plotting frequency
    return (; L, D, ns, nt, ds, dt, cs, nout, kwargs...)
end

## ARRAY INITIALIZATION
function init_arrays(params)
    (; cs) = params
    C  = @. exp(-cs^2 - (cs')^2)
    C2 = copy(C)
    return C, C2
end

## VISUALIZATION & PRINTING
function maybe_visualize(params, C, it=0)
    if params.do_visualize && (it % params.nout == 0)
        p = it ÷ params.nout
        plt = Plots.heatmap(params.cs, params.cs, C; clims=(0,1), c=:turbo, dpi=300)
        isinteractive() && display(plt)
        savefig(plt, "visualization_$p.png")
    end
    return nothing
end

function print_perf(params, t_toc)
    (; ns, nt) = params
    @printf("Time = %1.4e s, T_eff = %1.2f GB/s \n", t_toc, round((2 / 1e9 * ns^2 * sizeof(Float64)) / (t_toc / (nt - 10)), sigdigits=6))
    return nothing
end
