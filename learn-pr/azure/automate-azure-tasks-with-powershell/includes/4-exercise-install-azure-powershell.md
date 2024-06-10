<!-- markdownlint-disable MD041 -->

In this unit, you learn how to determine the version of **PowerShell** installed on your local
machine and how to install the latest version. You also learn how to install the **Az** PowerShell
module.

> [!NOTE]
> This exercise guides you through creating a local installation of the **Az** PowerShell module.
> However, the remainder of this module uses Azure Cloud Shell to leverage the free Microsoft Learn
> sandbox environment. If you prefer, you can consider this exercise optional and simply review the
> instructions.

::: zone pivot="windows"

## Install PowerShell on Windows

Windows PowerShell is included with the Windows operating system. However, we recommend installing
the latest stable version of PowerShell 7 for use with Azure PowerShell. Follow these steps to
determine which version of PowerShell is installed:

1. In the **System Tray Search Box**, type <kbd>PowerShell</kbd>. You might see multiple shortcuts:
   - **PowerShell 7 (x64)**: 64-bit version of PowerShell 7 (recommended).
   - **Windows PowerShell**: 64-bit version of Windows PowerShell, included with Windows.
   - **Windows PowerShell (x86)**: 32-bit version of Windows PowerShell, included on 64-bit versions
     of Windows.
   - **Windows PowerShell ISE**: 64-bit Integrated Scripting Environment (ISE) for writing Windows
     PowerShell scripts.
   - **Windows PowerShell ISE (x86)**: 32-bit ISE, included on 64-bit versions of Windows.

1. **Open PowerShell version 7**:

   To open PowerShell version 7, select the **PowerShell 7 (x64)** shortcut. If PowerShell version 7
   isn't installed, open Windows PowerShell and use **Windows Package Manager (Winget)** to install
   the latest stable version of PowerShell 7:

   ```powershell
   winget install --id Microsoft.Powershell --source winget
   ```

   For detailed installation instructions, see
   [Installing PowerShell on Windows](/powershell/scripting/install/installing-powershell-on-windows).

1. **Determine the PowerShell version**:

   Run the following command to check the version of PowerShell:

   ```powershell
   $PSVersionTable.PSVersion
   ```

1. **Set the PowerShell execution policy**:

   - Check the current execution policy:

     ```powershell
     Get-ExecutionPolicy -List
     ```

   - If the execution policy is set to `Restricted`, change it to `RemoteSigned` or less
     restrictive:

     ```powershell
     Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
     ```

   - **Confirm the execution policy change**:

     You're prompted to confirm the change:

     ```Output
     The execution policy helps protect you from scripts that you do not trust. Changing the
     execution policy might expose you to the security risks described in the
     about_Execution_Policies help topic at https:/go.microsoft.com/fwlink/?LinkID=135170. Do you
     want to change the execution policy? [Y] Yes [A] Yes to All [N] No [L] No to All [S] Suspend
     [?] Help (default is "N"): Y
     ```

     Enter <kbd>Y</kbd> or <kbd>A</kbd>, then press <kbd>Enter</kbd>.

::: zone-end

::: zone pivot="linux"

## Install PowerShell on Linux

Installing PowerShell on Linux involves using a package manager. The following instructions are for
supported versions of Ubuntu. For other distributions, see
[Install PowerShell on Linux](/powershell/scripting/install/installing-powershell-on-linux).

Install PowerShell on Ubuntu Linux using the Advanced Packaging Tool (**apt**) and the Bash command
line:

1. Update the list of packages

   ```bash
   sudo apt-get update
   ```

1. Install prerequisite packages

   ```bash
   sudo apt-get install -y wget apt-transport-https software-properties-common
   ```

1. Determine your version of Ubuntu

   ```bash
   source /etc/os-release
   ```

1. Download the Microsoft repository keys

   ```bash
   wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
   ```

1. Register the Microsoft repository keys

   ```bash
   sudo dpkg -i packages-microsoft-prod.deb
   ```

1. Delete the Microsoft repository keys file

   ```bash
   rm packages-microsoft-prod.deb
   ```

1. Update the list of packages after adding the Microsoft repository

   ```bash
   sudo apt-get update
   ```

1. Install PowerShell

   ```bash
   sudo apt-get install -y powershell
   ```

1. Start PowerShell

   ```bash
   pwsh
   ```

::: zone-end

::: zone pivot="macos"

## Install PowerShell on macOS

To install PowerShell on macOS, use the Homebrew package manager.

> [!IMPORTANT]
> If the `brew` command isn't found, you must install Homebrew. For details, see the
> [Homebrew website](https://brew.sh/).

Install Homebrew by running the following command:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

1. Once Homebrew is installed, install the latest stable release of PowerShell 7:

   ```bash
   brew install powershell/tap/powershell
   ```

1. Start PowerShell to verify that it installed successfully:

   ```bash
   pwsh
   ```

For detailed installation instructions, see
[Installing PowerShell on macOS](/powershell/scripting/install/installing-powershell-on-macos).

::: zone-end

### Install the Az PowerShell module

The **Az** PowerShell module is available from a global repository called the PowerShell Gallery.
You can install the module on your local machine using the `Install-Module` cmdlet.

::: zone pivot="windows"

To install the latest version of the **Az** PowerShell module, follow these steps:

1. **Open PowerShell version 7**

1. Install the **Az** PowerShell Module:

   ```powershell
   Install-Module -Name Az -Scope CurrentUser -Repository PSGallery
   ```

   This command installs the **Az** PowerShell module for your current user, which is controlled by
   the **Scope** parameter.

   - **NuGet installation prompt**:

     The installation relies on `NuGet` to retrieve components. You might be prompted to download
     and install the latest version of `NuGet`:

     ```Output
     NuGet provider is required to continue PowerShellGet requires NuGet provider version
     '2.8.5.201' or newer to interact with NuGet-based repositories. The NuGet provider must be
     available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
     'C:\Users\<username>\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install
     the NuGet provider by running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201
     -Force'. Do you want PowerShellGet to install and import the NuGet provider now? [Y] Yes [N] No
     [S] Suspend [?] Help (default is "Y"):
     ```

     Enter <kbd>Y</kbd> and press <kbd>Enter</kbd>.

   - **Untrusted repository prompt**:

     By default, the PowerShell Gallery isn't configured as a trusted repository. You're prompted to
     confirm that you want to install the module from an untrusted repository:

     ```Output
     You are installing the modules from an untrusted repository. If you trust this repository,
     change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you
     want to install the modules from 'PSGallery'? [Y] Yes [A] Yes to All [N] No [L] No to All [S]
     Suspend [?] Help (default is "N"):
     ```

     Enter <kbd>Y</kbd> or <kbd>A</kbd>, then press <kbd>Enter</kbd>.

   You should now see the **Az** PowerShell module installing.

:::zone-end

::: zone pivot="linux,macos"

The process for installing the **Az** PowerShell module on Linux and macOS is straightforward and
uses the same commands.

1. **Launch PowerShell**:

   - Open a terminal and run the following command:

     ```bash
     pwsh
     ```

1. Install the **Az** PowerShell Module:

   - At the PowerShell prompt, enter the following command:

     ```powershell
     Install-Module -Name Az -Scope CurrentUser -Repository PSGallery
     ```

   - **Untrusted repository prompt**:

     By default, the PowerShell Gallery isn't configured as a trusted repository. You're prompted to
     confirm that you want to install the module from an untrusted repository:

     ```Output
     You are installing the modules from an untrusted repository. If you trust this repository,
     change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you
     want to install the modules from 'PSGallery'? [Y] Yes [A] Yes to All [N] No [L] No to All [S]
     Suspend [?] Help (default is "N"):
     ```

     Enter <kbd>Y</kbd> or <kbd>A</kbd>, then press <kbd>Enter</kbd>.

   You should see the **Az** PowerShell module installing.

:::zone-end
