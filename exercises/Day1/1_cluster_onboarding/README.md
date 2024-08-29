# Exercise: Cluster Onboarding

The purpose of this exercise is to get you going on the cluster. If you already have (a lot of) cluster experience, the exercise probably won't take you long. I still recommend you to do it, especially the Julia related parts, to make sure that you're prepared for what is to come later in the course.

## Task 1: Terminal → Cluster → Julia

### Connecting via SSH
1. Open a terminal.
2. Type `ssh accountsname@training.hlrs.de` and press `Enter`.
3. When asked for it, enter your account password.

You're on the cluster. 🎉

But you don't have Julia (try `julia`). 🙁

### Loading Julia
4. Load the modules for this course:
   
    ```
    module load julia
    module load nvhpc # for MPI/CUDA (not needed today)
    ```
5. Try `julia` again.

Great, we have Julia. But we don't have any packages in the "global" environment (try, e.g., `using SysInfo`).

### Starting Julia in the course environment
6. If it is still open, close Julia (`exit()` or `CTRL + D`).

7. Use `cd $SCRATCH/JuliaHLRS24` to navigate to (your copy of) the workshop materials.

8. Anywhere within this directory (including subdirectories) you can use `julia --project` to start Julia in the workshop environment. Do it and try running this Julia code:

   ```julia
   using SysInfo
   sysinfo()
   ```

Hopefully, it works now. 😉

**Note: Don't forget to pass `--project` to `julia` for the rest of the workshop (on the cluster and on the laptop)! Otherwise, no packages won't be available.**

## Task 2: Submitting a job

1. Within the workshop materials directory, do `cd exercises/Day1/1_cluster_onboarding`
2. Inspect the file `job_script.sh` (e.g. `cat job_script.sh`) to get a feeling for how it looks.
3. Submit the job to the scheduler with `qsub job_script.sh`.
4. Check with `qstat -rnw` that the job is either queued up (status `Q`) or that it is running (status `R`).
5. Once the job has run, see the outputfile `job_script.out` for the result.

## Task 3: VSCode → Cluster → Julia (extension)

### Connecting via SSH
1. Open Visual Studio Code
2. Press `CTRL + SHIFT + P` (opens the popup menu) and type and select `Remote-SSH: Connect to Host...`
3. When asked for it, input `accountname@training.hlrs.de` for the hostname.
4. When asked for it, enter your account password.
5. Wait for (potentially) quite some time... (since there is no internet on the cluster, the VS Code server backend will be downloaded locally and then copied to the cluster...)

After some time, you should have VS Code running on the cluster. 🎉

6. Using the terminal in the bottom (if it's not there, press `CTRL + ~`), run `code -r $SCRATCH/JuliaHLRS24` to tell the VS Code session to switch into this folder (such that you see the file tree in the left pane etc.).

In it's current form, this setup gives you a terminal (in the bottom) plus a nice editor on the cluster. Using the steps from Task 1 above, you could now use the terminal to start Julia. 

However, you won't get any Julia integration into VS Code this way (e.g. no in-line evaluation, plots won't show up in the plot pane, you can't open jupyter notebooks using Julia, etc.). For the latter to work, you need to setup the Julia extension once.

### Installing the Julia extension

As there is no internet on the cluster, we have to install the extension from file.

1. Open the extension tab in the sider bar on the left (`CTRL + SHIFT + X`), click on the three dots at the top and select `Install from VSIX...`.
* Enter the following path and press Enter:

```
/shared/training/ws/sca50297-jlhpc/shared/julialang.language-julia-1.104.1.vsix
```

After a while, the Julia extension should be installed.

However, it can't find `julia` yet, because the extension doesn't know anything about `module`s on the cluster.

### Pointing the extension to `julia_wrapper.sh`

The Julia wrapper script is rather simple: It loads the necessary modules (i.e. `module julia`) and then acts like `julia`. The path to the script is:

```
/shared/training/ws/sca50297-jlhpc/shared/julia_wrapper.sh
```

1. To set the relevant setting, press `CTRL + ,` (comma) to open the Settings.
2. Select the tab (at the top) that says "training.hlrs.de".
3. Search for "julia executable" and copy-paste the path above into the text field of the setting.

**Note:** You should only have to do this **once**, as it should remember the setting for the rest of the course.

### Testing Julia VS Code integration

Let's test that things are working.

4. In a regular terminal at the bottom (`CTRL + ~`), do `code -r $SCRATCH/JuliaHLRS24`. This tells VS Code to switch to the workshop directory.
5. Now, press `ALT+J` followed by `ALT+O`. Alternatively, you can press `CTRL+SHIFT+P` and the execute the command `Julia: Start REPL`. Either way, a Julia REPL should pop up in the bottom (might take some time the first time).

Note that while the REPL in the bottoms visually looks identical to if you simply had executed `julia` in a terminal, this "integrated Julia REPL" is special in the sense that it is connected to the Julia extension and VS Code. Among other things, it gives you in-line evaluation and plots should now show up in the VS Code Plots pane. Let's try this.

5. Open the file `inlineeval.jl` (find it under `exercises/Day1/1_cluster_onboarding` in the file tree in the left pane).
6. In the editor, click on the line `3+3` and press `SHIFT+Enter`. The result should show up next to the line.
7. Repeat this step with the next line.
8. Finally, run all the lines under "plot something". If everything works as expected, the plot should show up in the VS Code plot pane.

Here are a few more commands that could be useful for controlling the integrated Julia REPL:

* Open integrated Julia REPL: `Alt-J Alt-O`
* Kill integrated Julia REPL: `Alt-J Alt-K`
* Restart integrated Julia REPL: `Alt-J Alt-R`
