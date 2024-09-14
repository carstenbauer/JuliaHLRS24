isoncluster() = isdir("/zhome") || isdir("/scratch")
println("\n\n\tUsing ", isoncluster() ? "cluster" : "default", " preferences.")
if isoncluster()
    cp(joinpath(@__DIR__, "LocalPreferences_Cluster.toml"),
        joinpath(@__DIR__, "LocalPreferences.toml"); force=true)
else
    cp(joinpath(@__DIR__, "LocalPreferences_Default.toml"),
        joinpath(@__DIR__, "LocalPreferences.toml"); force=true)
end

using Pkg
println("\n\n\tActivating environment in $(pwd())...")
Pkg.activate(@__DIR__)
println("\n\n\tInstantiating environment... (i.e. downloading + precompiling packages)");
Pkg.instantiate()
Pkg.precompile()

Pkg.build("IJulia") # to be safe
Pkg.precompile()

println("\n\n\tDownloading CUDA artifacts", isoncluster() ? " and precompiling the runtime" : "", " ...");
using CUDA
if isoncluster()
    CUDA.precompile_runtime()
    if CUDA.functional()
        CUDA.versioninfo()
    end
end

println("\n\n\tInstalling mpiexecjl ...");
using MPI
MPI.install_mpiexecjl(; force=true)
println("\n\n\t!!!!!!!!!!\n\tYou need to manually put mpiexecjl on PATH. Put the following into your .bashrc (or similar):");
println("\t\texport PATH=$(joinpath(DEPOT_PATH[1], "bin")):\$PATH");
println("\t!!!!!!!!!!")

if length(ARGS) == 1 && ARGS[1] == "full" && (Sys.islinux() || Sys.isapple())
    println("\n\n\t -- FULL MODE: Modifying `.bashrc`/`.zshrc` ...!")
    bashrc = joinpath(ENV["HOME"], ".bashrc")
    zshrc = joinpath(ENV["HOME"], ".zshrc")
    if isfile(bashrc)
        entry = "\nexport PATH=$(joinpath(first(DEPOT_PATH), "bin")):\$PATH\n"
        open(bashrc, "a") do f
            write(f, entry)
        end
    else
        println("\t\t `.bashrc` not found. Skipping!")
    end
    if isfile(zshrc)
        entry = "\nexport PATH=$(joinpath(first(DEPOT_PATH), "bin")):\$PATH\n"
        open(zshrc, "a") do f
            write(f, entry)
        end
    else
        println("\t\t `.zshrc` not found. Skipping!")
    end

    if Sys.islinux() && !isoncluster()
        println("\n\n\t -- FULL MODE: Installing LIKWID ...!")
        likwid_dir = joinpath(@__DIR__, "orga", "likwid_local_install")
        cd(likwid_dir) do
            run(`sh install_likwid.sh`)
        end
    end
end

println("\n\n\tDone!")
