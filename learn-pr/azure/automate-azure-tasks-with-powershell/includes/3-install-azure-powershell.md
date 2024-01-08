Suppose you've chosen Azure PowerShell as your automation solution. Your administrators prefer to run their scripts locally rather than in the Azure Cloud Shell. The team uses machines that run Linux, macOS, and Windows. You need to get Azure PowerShell working on all their devices.

## What must be installed?

We'll go through the actual installation instructions in the next unit, but let's look at the two components that make up Azure PowerShell.

- **The base PowerShell product**: This comes in two variants: Windows PowerShell and PowerShell 7.x, which you can install on Windows, macOS, and Linux.
- **The Azure Az PowerShell module**: You need to install this extra module to add the Azure-specific commands to PowerShell.

> [!TIP]
> PowerShell 7.0.6 LTS, PowerShell 7.1.3, or higher is the version of PowerShell we recommend for use with the Azure Az PowerShell module on all platforms.

Once you've installed the base product, you'll then add the Azure PowerShell module to your installation.

## How to install PowerShell

On both Linux and macOS, you'll use a package manager to install PowerShell Core. The recommended package manager differs by OS and distribution.

> [!NOTE]
> PowerShell is available in the Microsoft repository, so you'll first need to add that repository to your package manager.

### Linux

On Linux, the package manager will change based on the Linux distribution you choose.

| Distribution(s)  | Package manager |
|------------------|-----------------|
| Ubuntu, Debian   | `apt-get`       |
| Red Hat, CentOS  | `yum`           |
| OpenSUSE         | `zypper`        |
| Fedora           | `dnf`           |

### Mac

On macOS, use `Homebrew` to install PowerShell.

In the next section, we'll go through the detailed installation steps for some common platforms.
