# What is WSL?

Windows Subsystem for Linux (WSL) lets you install and run Linux distributions on Windows. This can be a bit confusing because Linux, like Windows, is also an operating system (OS)... so you're running two operating systems, integrated with one another.

## WSL, Dual-booting, and Virtual Machines

In the past, this required loading both a Windows and a Linux OS onto your machine and completely rebooting when you wanted to switch between them. Known as "dual-booting", this method is slow and disconnected. The alternative was using a Virtual Machine (VM), an emulation of a computer system. WSL requires fewer resources (CPU, memory, storage) than a full VM and allows closer integration between the Linux software and the Windows software.

## Linux / GNU

Linux is also known as "GNU", which stands for "GNU's Not Unix." Without getting in too deep to history, Linux is the kernel (core part of the OS) and GNU is the larger opensource project that created the operating system, including the GNU C Compiler, Bash command-line shell, utilities, and the Emacs text editor. It was created as a Unix-compatible operating system made up of free software.

## Bash

Being able to use the Bash command-line, or "Borne Again SHell", is one of the big advantages of WSL. For many developers, it makes the comparisons between Windows and Mac feel more like apples-to-apples. Many developers prefer using a command-line interface (CLI) to using a graphic-user interface (GUI) because it can be more efficient, not requiring you to navigate menus, options, and windows with a mouse. It also enables you to automate common tasks using a script. PowerShell is the Windows version of Bash, and with WSL, switching between the two is seamless. WSL even enables you to mix PowerShell and Bash commands together. For example, the command to list files and directories in Bash is `ls`. The same command in PowerShell is `dir`, but now thanks to WSL, you can use these commands interchangeably.

## Distributions

Another important thing to understand about WSL is that you are able to install MULTIPLE Linux distributions. Linux has a big variety of different "flavors," known as distributions or distros. Because Linux is opensource, anyone can customize their own version of the OS, with whatever associated applications, tools, and utilities needed. This software is often combined into "packages" that are available in online repositories and can be downloaded using a "package manager." The package manager is used to install that software and the different distributions often have different package managers. For example, Ubuntu is one of the most popular Linux distributions and is the default installed by WSL. Ubuntu (and it's predecessor Debian) use a package manager called "apt" or "apt-get". So the command to install an app would be `apt install <package_name>`. Another popular distribution is OpenSuse, which uses the Zypper package manager, with the command `zypper install <package_name>` to install an app. So you will need to learn a bit about whatever Linux distribution you choose to use and remember that when you see a tutorial that uses a command like `apt-get install <package_name>`, you may need to translate that to the command associated with your distribution's package manager.

## Two file systems

Lastly, and possibly MOST importantly, you will need to remember that because WSL utilizes both Windows and Linux, you will be working between two different file systems. The Windows file system (also known as "NTFS" or the " New Technology File System") is typically your C: drive. Any Linux distributions that you install will be listed under a "Linux" labeled drive that can be viewed in your Windows File Explorer. These file systems can work together, but there are several things to know about effectively using them that are covered in a separate training module. The main thing to know is that if you are seeking to run and test your application on Linux, it is best to store your project files on the Linux file system, as the performance will be much faster.

## GUI apps and more

Thanks to the seamless integration that WSL provides, you can launch Linux tools and applications from PowerShell in Windows, or launch Windows tools and apps from Bash in Linux. You can also now use Linux GUI applications, which are also integrated with Windows and can be pinned and launched from the Start menu. Additionally, WSL supports more advanced tasks, like using GPU acceleration for training Machine Learning models, building custom distributions, mounting disk, connecting USB devices, accessing Linux networking apps, and configuring advanced settings and shared environment variables. These will be covered in other training modules, for now, let's move on to look at how WSL works - including the option to choose an architecture that best meets your needs.

![Screenshot of Windows File Explorer with Linux directory open](../media/windows-file-explorer.png)