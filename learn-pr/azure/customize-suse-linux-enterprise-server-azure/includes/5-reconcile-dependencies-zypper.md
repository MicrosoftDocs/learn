Zypper is a command-line package manager that automatically reconciles package dependencies.

With Apache webserver installed, it’s time to add MySQL database to your pay-as-you-go instance of SLES on Azure.

In this unit, we talk about how SUSE handles package dependencies and explain what zypper package manager is and how to use it for installation. 

## Packages alert you of dependencies…One. At. A. Time.

While individual packages can alert you to dependencies on other packages for defined activities or modules, these alerts are raised at the package level, meaning dependencies are triggered one at a time. You must manually select the next package before another dependency is surfaced, which triggers another package that you must select, and so on. For modules with many packages, adding a complete set of packages using this method can take a long time.  

## SUSE’s package manager, zypper, reconciles package dependencies  

SUSE created zypper, a command-line package manager, which makes use of libzpp (SAT solver) to reconcile package dependencies for you. With zypper, all related packages are flagged at once when you select an activity or grouping, so you can install, update, or delete them with a single command. The YaST GUI and TUI includes zypper built into it. YaST runs zypper automatically in the background every time you start. Compared to manually finding and selecting package dependencies through RPM, zypper saves time.  

## Packages and corresponding modules configuration are updated 

As soon as SUSE becomes aware of an error within a package, an update package is shipped. If you run pay-as-you-go, the updated packages are pushed out to a SUSE update infrastructure at your Azure datacenter location and on to your machine when you connect. If you run BYOS, you can download the updates through SUSE directly.  

## You can manually pull updates using zypper

The difference between a patch and an update is that a patch contains one or more packages and an update is always a single package. You can add additional parameters for the update or patch. , you can only install security fixes by selecting–category security. 

Let’s have a look at some basic zypper examples:  

- List available repositories where packages come with `sudo zypper lr` or `sudo zypper repos`.
- List available patches with `sudo zypper lp` or `sudo zypper list-patches`.
- List available updates with `sudo zypper lu` or `sudo zypper list-updates`.
- Install updates/patches with `sudo zypper up`, `sudo zypper update`, or `sudo zypper patch`.


## Command line vs. GUI (zypper vs. YaST)
You might be wondering why did we use YaST to load apache and now we’re using zypper to add mariadb? Does it matter which one I use? The short answer is no. Zypper and YaST do the same things; they just go about it differently. 

From command line, you can launch YaST and get a graphical menu that shows you all the different options you can use to administrate your system. Most of the time, graphical systems are preferred because they provide a visual overview of commands, so you don't need to remember everything.

Zypper's command-line interface is faster because you don’t have to navigate several windows or menu bars to execute the command. It also allows you to create your own workflow (or script), which isn't possible in a graphical environment. If you use the commands and parameters regularly, zypper can be a faster way to get things done.
