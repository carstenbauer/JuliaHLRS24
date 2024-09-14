# Exercise: Laptop Onboarding

The purpose of this exercise is to get you going with Julia on the laptop.

We will be using VS Code below but you can also use a regular terminal if you feel comfortable with it and prefer the minimalistic experience.

## Opening the workshop folder in VS Code

1. Open Visual Studio Code (e.g. from a terminal by executing `code`)
 
2. Open a terminal in VSCode by either pressing `CTRL + ~` or running the command `Terminal: Create New Terminal`.

2. In the terminal in the bottom, navigate to the workshop materials: `cd ~/JuliaHLRS24`.
 
4. Execute `code -r .` to tell the VS Code session to switch into the active folder (such that you see the workshop directory in the file tree in the left pane).

## Using Julia
    
1. Inside of the workshop directory `~/JuliaHLRS24` (you should still be there), start Julia with `julia --project`.
    - The `--project` flag is important and tells Julia to use the local Julia environment of the workshop. You can use it anywhere inside of `JuliaHLRS24`, including its subdirectories.

3. The following Julia commands should work now:

    ```julia
    using SysInfo
    sysinfo()
    ```
    
4. Close the Julia REPL with `CTRL + D` or calling `exit()`.

**Note: Never forget to pass `--project` to `julia` when you start Julia from the command line from inside the workshop directory. Otherwise, no packages won't be available.**

## BONUS: Using the Julia VSCode extension

While manually starting Julia via `julia --project` in the terminal is fine, you won't get any special integration with VS Code this way (e.g. plots won't show up in the VS Code plot pane, no in-line evaluation, etc.). For all of these things to work, you need to use the Julia extension.

We have already installed the Julia extension on the laptops.

1. Start the "integrated Julia REPL", press `ALT+J` followed by `ALT+O`. Alternatively, you can press `CTRL+SHIFT+P` and then execute the command `Julia: Start REPL`. Either way, a Julia REPL should pop up in the bottom (might take some time the first time).

The very first time you do this, the VSCodeServer package might precompile. Wait until you see the `julia>` input prompt.

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
