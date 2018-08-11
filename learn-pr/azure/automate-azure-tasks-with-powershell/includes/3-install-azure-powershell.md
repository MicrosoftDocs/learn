## Motivation
Suppose you have chosen Azure PowerShell as your automation solution. Your administrators prefer to run their scripts locally rather than in the Azure Cloud Shell. The team uses machines that run Linux, macOS, and Windows. You need to get Azure PowerShell working on all their devices. 

## What must be installed?
There are two components to Azure PowerShell:
- the base PowerShell product
- the Azure PowerShell module that adds the Azure commands

The base product has two variants: PowerShell on Windows and PowerShell Core on Linux and Mac. PowerShell is included with Windows. You will need to install PowerShell Core on Linux and Mac devices. 

Once the base product is installed, you then add the Azure PowerShell module to your installation.

## How to install PowerShell Core
On both Linux and macOS, you use a package manager to install PowerShell Core. The recommended package manager differs by OS and distribution:
- Linux: **apt-get** on Ubuntu, **yum** on Red Hat, and **zypper** on OpenSUSE
- Mac: **Homebrew**

PowerShell Core is available in the Microsoft repository, so you'll first need to add that repository to your package manager.

## How to Install Azure PowerShell
The preferred installation method for the Azure PowerShell module is to use the **Install-Module** command from within PowerShell.

You need elevated privileges to install modules:
- On Windows you must run PowerShell as an administrator
- On Linux and macOS, you will use the **sudo** command to obtain elevated privileges

## Summary
On Windows, PowerShell is built-in, but you must install the Azure PowerShell module. On Linux and macOS, you must install both PowerShell Core and the Azure PowerShell module. In the next section, you will go through the detailed installation steps for some common platforms.