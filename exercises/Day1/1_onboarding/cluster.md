# Exercise: Cluster Onboarding

The purpose of this exercise is to get you going with Julia on the cluster.

We will be using VS Code below but you can also use a regular terminal if you feel comfortable with it and prefer the minimalistic experience.

## Connecting via SSH (with VSCode)
1. Open Visual Studio Code (e.g. from a terminal by executing `code`)
2. Press `CTRL + SHIFT + P` (opens the popup menu) and type and select `Remote-SSH: Connect to Host...`
3. When asked for it, input `training.hlrs.de` for the hostname and press `Enter`.
5. Wait a bit...

After some time, you should have VS Code running on the cluster. 🎉

## Opening the workshop folder

1. Open a terminal in VSCode by either pressing `CTRL + ~` or running the command `Terminal: Create New Terminal`.

2. In the terminal in the bottom, navigate to your copy of the workshop materials: `cd $SCRATCH/JuliaHLRS24`.
 
4. Execute `code -r .` to tell the VS Code session to switch into the active folder (such that you see the workshop directory in the file tree in the left pane).

## Using Julia

To make Julia available on the cluster, we need to load the necessary system modules.

1. Load the modules for this course:
   
    ```
    module load julia
    module load nvidia/nvhpc    # for MPI/CUDA (not needed today)
    module load compiler/nvidia # for MPI/CUDA (not needed today)
    ```
    
2. Inside of the workshop directory `$SCRATCH/JuliaHLRS24` (you should still be there), start Julia with `julia --project`.
    - The `--project` flag is important and tells Julia to use the local Julia environment of the workshop. You can use it anywhere inside of `JuliaHLRS24`, including its subdirectories.

3. The following Julia commands should work now:

    ```julia
    using SysInfo
    sysinfo()
    ```
    
4. Close the Julia REPL with `CTRL + D` or calling `exit()`.

**Note: Never forget to pass `--project` to `julia` when you start Julia from the command line from inside the workshop directory. Otherwise, no packages won't be available.**

## BONUS: Using the Julia VSCode extension on the cluster

While manually starting Julia via `julia --project` in the terminal is fine, you won't get any special integration with VS Code this way (e.g. plots won't show up in the VS Code plot pane, no in-line evaluation, you can't open jupyter notebooks using Julia, etc.). For all of these things to work, you need to setup the Julia extension (once).

### Installing the Julia extension

As there is no internet on the cluster, we have to install the extension from file.

1. Open the extension tab in the sider bar on the left (`CTRL + SHIFT + X`).
2. Click on the three dots in the top-right corner of the side bar and select `Install from VSIX...`.
* Enter the following path and press Enter:

```
/shared/akad-julia/julialang.language-julia-1.121.1.vsix
```

After a while, the Julia extension should be installed.

### Pointing the extension to `julia_wrapper.sh`

So far, the extension doesn't know anything about `module`s on the cluster and can't find `julia`. We need to point it to the wrapper script, which is located at

```
/shared/akad-julia/julia_wrapper.sh
```

To set the relevant setting:

1. Press `CTRL + ,` (comma) to open the Settings.
2. Select the tab (at the top) that says "training.hlrs.de".
3. Search for "julia executable" and copy-paste the path above into the text field of the setting.
4. Close the settings tab.

**Note:** You should only have to do this **once**. VS Code should remember the setting for the rest of the course.

### Testing the Julia VS Code integration

1. Start the "integrated Julia REPL", press `ALT+J` followed by `ALT+O`. Alternatively, you can press `CTRL+SHIFT+P` and then execute the command `Julia: Start REPL`. Either way, a Julia REPL should pop up in the bottom (might take some time the first time).

The very first time you do this, the VSCodeServer package will precompile (for about a minute). Wait until you see the `julia>` input prompt.

Note that while the REPL at the bottom visually looks identical to if you simply had executed `julia --project` in a terminal, this "integrated Julia REPL" is special in the sense that it is connected to the Julia extension and VS Code (e.g. plots should show up in the VS Code plot pane etc.).

2. Run the following Julia commands in the "integrated Julia REPL" at the bottom:

    ```julia
    using Plots
    x = -π:0.1:π
    plot(x, sin.(x))
    ```
    
If everything is working, a sine plot should show up in the VS Code plot pane.

Here are a few more commands that could be useful for controlling the integrated Julia REPL:

* Open integrated Julia REPL: `Alt-J Alt-O`
* Kill integrated Julia REPL: `Alt-J Alt-K`
* Restart integrated Julia REPL: `Alt-J Alt-R`

You're done 🎉. Feel free to play around further and then close VS Code.
