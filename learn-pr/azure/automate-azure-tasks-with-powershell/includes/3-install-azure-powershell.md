Suppose you have chosen Azure PowerShell as your automation solution. Your administrators prefer to run their scripts locally rather than in the Azure Cloud Shell. The team uses machines that run Linux, macOS, and Windows. You need to get Azure PowerShell working on all their devices. 

## What must be installed?
We'll go through the actual installation instructions in the next unit, but let's look at the two components which make up Azure PowerShell.

- **The base PowerShell product** This comes in two variants: PowerShell on Windows, and PowerShell Core on macOS and Linux.
- **The Azure PowerShell module** This extra module must be installed to add the Azure-specific commands to PowerShell.

> [!TIP]
> PowerShell is included with Windows (but might have an update available). You will need to install PowerShell Core on Linux and macOS.

Once the base product is installed, you then add the Azure PowerShell module to your installation.

## How to install PowerShell Core
On both Linux and macOS, you use a package manager to install PowerShell Core. The recommended package manager differs by OS and distribution.

> [!NOTE]
> PowerShell Core is available in the Microsoft repository, so you'll first need to add that repository to your package manager.

### Linux
On Linux, the package manager will change based on the Linux distribution you choose.

| Distribution(s)  | Package manager |
|------------------|-----------------|
| Ubuntu, Debian   | `apt-get`       |
| Red Hat, CentOS  | `yum`           |
| OpenSUSE         | `zypper`        |
| Fedora           | `dnf`           |

### Mac
On macOS, you will use `Homebrew` to install PowerShell Core.

In the next section, you will go through the detailed installation steps for some common platforms.