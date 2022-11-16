Exercise: Run basic WSL commands

Using multiple command lines: PowerShell, CMD, Bash, multiple distros - Ubuntu, Alpine, Windows Terminal 
WSL admin commands
Bash commands (ls vs dir)

## Basic WSL commands

Cover the basic admin commands for WSL... in PowerShell.
Setting a default WSL distro

## Basic Bash commands

Bash commands (ls vs dir)

## Update and upgrade packages

We recommend that you update and upgrade the packages included with the Linux distribution once installed (and on a regular basis to ensure that you have the latest security updates). Each distribution has associated package managers to handle this. For Ubuntu or Debian, the package manager included is called "apt" (for Advanced Package Tool).

To update and upgrade packages for the default Ubuntu distribution using apt:

1. Open Ubuntu (you can find it in the Windows search menu once it's been installed).
2. Enter the command: `sudo apt update && upgrade`
3. Updating and upgrading packages requires elevated "sudo" (superuser do) permissions, so you will also need to enter the password that you created for the Linux distribution.

> [!NOTE]
> There are a few different ways to run multiple commands using BASH (the Linux command line).
https://dev.to/0xbf/run-multiple-commands-in-one-line-with-and-linux-tips-5hgm

sudo apt update && sudo apt upgrade
Windows does not automatically update or upgrade your Linux distribution(s). This is a task that most Linux users prefer to control themselves.