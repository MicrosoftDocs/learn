

## Basics of a WSL development workflow
 
1. Working between two file systems means paying attention to where project files are stored and where dev tools are stored.

2. Dev tool recommendations for a WSL development workflow include:

- Command line (or multiple command lines)
    Customized to suit your needs, with a specific starting directory, display set to a font and text size easy to read, colors to indicate links/warnings/etc., status that displays current directory path, Git status, etc.
- Code editor
    VS Code - Marketplace of helper extensions, intellisense, live reload, Remote-WSL, Git version control integration, Docker container integration, 
- Web browser
    Microsoft Edge - 
- Version control and credential management
    Git
- Code languages and frameworks
    NodeJS, Python, C#, C++, etc.
- Remote containers
    Docker

3. Example app development workflow that incorporates these development tools

4. Professional level scenarios for working with WSL: CI/CD pipeline, parody to a production environment for testing, cautions to consider for using WSL in a production environment.

What does a WSL development environment workflow look like that integrates both Windows and Linux tools? What unique aspects do I need to consider when working between file systems?

let's take a look at how it works in a practical development workflow for building or maintaining an app. This is a high-level overview, step-by-step guidance is available in the WSL documentation or a later WSL training module.

Typically we would start with the one-time install steps that include:

- Install WSL (and the Ubuntu distro by default)
- Install Visual Studio Code and the Remote-WSL Extension
- Install Windows Terminal
- Install Git and the Git Credential Manager

*These install steps are covered in more detail in a separate training module.*


![WSL workflow diagram showing Ubuntu, VS Code, Remote-WSL extension, and web browser.](../media/wsl-workflow.png)

Types of development work:

- Solo local development
- Collaborative remote development using version control
- CI/CD pipelines

The steps for setting up a WSL development environment would typically include:

- Open Ubuntu, set up your Linux user name and password, then reopen Ubuntu in Windows Terminal and customize your command prompt just how you like it.
- Install the code project or framework that you want to work with on Linux. This might mean installing frameworks like NodeJS, NextJS, or React, cloning a GitHub repo, or downloading a Docker container image. It will also likely mean using a package manager, updating/upgrading the packages available in your distribution, and possibly installing a version manager.
- Once your project is created or installed on your Linux file system (Ubuntu by default), you can open it in VS Code using the Remote-WSL extension. Once open, you can edit and debug your code, taking advantage of VS Code features like Intellisense code completion, linting, etc. because the remote extension handles the pathing for you between Linux (where your project code is stored) and Windows (where the VS Code app is stored).
- You can build and run your project code on Linux (in Ubuntu) and then view your project using the Microsoft Edge web browser and debug using VS Code. There is even support for live reloading as you update your code.

## Two file systems

Lastly, and possibly MOST importantly, you will need to remember that because WSL utilizes both Windows and Linux, you will be working between two different file systems. The Windows file system (also known as "NTFS" or the " New Technology File System") is typically your C: drive. Any Linux distributions that you install will be listed under a "Linux" labeled drive that can be viewed in your Windows File Explorer. These file systems can work together, but there are several things to know about effectively using them that are covered in a separate training module. The main thing to know is that if you are seeking to run and test your application on Linux, it is best to store your project files on the Linux file system, as the performance will be much faster.

## GUI apps and more

Thanks to the seamless integration that WSL provides, you can launch Linux tools and applications from PowerShell in Windows, or launch Windows tools and apps from Bash in Linux. You can also now use Linux GUI applications, which are also integrated with Windows and can be pinned and launched from the Start menu. Additionally, WSL supports more advanced tasks, like using GPU acceleration for training Machine Learning models, building custom distributions, mounting disk, connecting USB devices, accessing Linux networking apps, and configuring advanced settings and shared environment variables. These will be covered in other training modules, for now, let's move on to look at how WSL works - including the option to choose an architecture that best meets your needs.

![Screenshot of Windows File Explorer with Linux directory open](../media/windows-file-explorer.png)

# Distributions

Another important thing to understand about WSL is that you are able to install MULTIPLE Linux distributions. Linux has a big variety of different "flavors," known as distributions or distros. Because Linux is opensource, anyone can customize their own version of the OS, with whatever associated applications, tools, and utilities needed. This software is often combined into "packages" that are available in online repositories and can be downloaded using a "package manager." The package manager is used to install that software and the different distributions often have different package managers. For example, Ubuntu is one of the most popular Linux distributions and is the default installed by WSL. Ubuntu (and it's predecessor Debian) use a package manager called "apt" or "apt-get". So the command to install an app would be `apt install <package_name>`. Another popular distribution is OpenSuse, which uses the Zypper package manager, with the command `zypper install <package_name>` to install an app. So you will need to learn a bit about whatever Linux distribution you choose to use and remember that when you see a tutorial that uses a command like `apt-get install <package_name>`, you may need to translate that to the command associated with your distribution's package manager.

## Bash

Being able to use the Bash command-line, or "Borne Again SHell", is one of the big advantages of WSL. For many developers, it makes the comparisons between Windows and Mac feel more like apples-to-apples. Many developers prefer using a command-line interface (CLI) to using a graphic-user interface (GUI) because it can be more efficient, not requiring you to navigate menus, options, and windows with a mouse. It also enables you to automate common tasks using a script. PowerShell is the Windows version of Bash, and with WSL, switching between the two is seamless. WSL even enables you to mix PowerShell and Bash commands together. For example, the command to list files and directories in    is `ls`. The same command in PowerShell is `dir`, but now thanks to WSL, you can use these commands interchangeably.

## Linux / GNU

Linux is also known as "GNU", which stands for "GNU's Not Unix." Without getting in too deep to history, Linux is the kernel (core part of the OS) and GNU is the larger opensource project that created the operating system, including the GNU C Compiler, Bash command-line shell, utilities, and the Emacs text editor. It was created as a Unix-compatible operating system made up of free software.

## Windows Terminal

Brief

## Visual Studio Code and the Remote-WSL Extension

Code editing, debugging, live-reload, intellisense, handling paths between Linux and Windows file systems.

## Microsoft Edge web browser

On Windows, see your web app running.

## Using WSL in a Business or Enterprise setting

- Brief mention that using WSL in an Enterprise setting may require firewall adjustments
- Mention that WSL can be used to create Linux distro images to distribute within your compan

Notes for this unit:

WSL is designed as a tool for 

Explain the unique aspects of working between two file systems and important considerations.

cross-platform development of applications
Many Linux application developers have Windows OS machines and use remote Linux servers for work by connecting through SSH (like installing PuTTY software on Windows). These Linux servers/machines are generally shared among multiple developers for their development work. However, very often developers want their own machine instance and that is when a virtual machine (VM) is used.
Web dev, system admin, 
On Windows OS based systems, there are VM solutions like VirtualBox or VMware, through which you can install any Linux distro (or any operating system for that matter) you like from an installer ISO. But many developers do not like this due to the performance (it’s very slow and heavy for the overall host system), compatibility issues, lack of tools and support.
Leveraging Microsoft development tools
As WSL is natively integrated with the Windows OS, developers can build and debug Linux applications with Windows tools like Visual Studio Code and Visual Studio. Visual Studio Code (https://code.visualstudio.com) is a free and powerful IDE, which has an extension that allows you to attach VSCode to WSL directly (refer to the document explaining this process at https://code.visualstudio.com/docs/remote/wsl). This helps developers to use the powers of the GUI IDE of Windows and command line of Linux simultaneously. There are many other extensions (code formatting, Git history, Docker, etc) in VSCode that give developers lots of flexibility.
Linux compilers and core utilities
because its native, linux and windows both use/share the same network-interface (opening a server-port in linux opens the same port in windows).
Linux software that is expecting to be able to control the drivers probably won’t work (because after all WSL is running on the NT kernel, not Linux). For example WiFi sniffing apps that want to put the WiFi card in promiscuous mode probably won’t work.
Otherwise, there don’t seem to be many disadvantages, even GUI software works normally after installing an X11 server for Windows and setting the appropriate exports in your .profile - it looks cursed, but it works:
I have a set of quite diverse workflows, which includes,

python-dev with venvs in deb wsl, using vscode / pycharm. VScode has the functionality to work seamlessly with wsl. But not quite stable, sometimes starts, sometimes waits, sometimes does not start at all. Pycharm needs ultimate edition to work with wsl.
Docker image builds , wokrs seamlessly with wsl using host docker.
Kubernetes using Kubernetes desktop works fine. Also, kubectl and k9s in wsl seamlessly integrate with host.
Other than that, I open around 20–30 tabs on chrome occasional webex. Onenote, maybe some music playing in tidal / spotify. Everything works but didn’t felt stable at all. Many times app and os crash.
High resource utilization, compare to linux on similar workloads. The windows installation was scrubbed for all bloatware after a fresh installation. I am not quoting a ~100% cpu here. But over all , it reflects in battery level. For identical conservative cpu governer. but high memory usage was directly visible (2–3X) , again for same workloads.
The only reason to switch back to Linux was due to stability problems. Apps crash, os freezes. I didn’T dig down to find why

To use a WSL deveopment environment, the main thing that you need to keep in mind is simply that you are working between two separate, but integrated, file systems and 