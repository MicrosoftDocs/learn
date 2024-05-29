In this unit, you'll learn how to check the version of **PowerShell** installed on your local machine and install the latest version.

> [!NOTE]
> This exercise guides you through creating a local installation of PowerShell tools. The remainder of this module uses the Azure Cloud Shell, so you can leverage the free subscription support in Microsoft Learn. If you prefer, consider this exercise as an optional activity and just review the instructions.

::: zone pivot="linux"

## Linux

Installing PowerShell for Linux involves using a package manager. We'll use **Ubuntu 18.04** for our example, but we have [detailed instructions for other versions and distributions in our documentation](/powershell/scripting/install/installing-powershell-core-on-linux).

Install PowerShell on Ubuntu Linux using the Advanced Packaging Tool (**apt**) and the Bash command line.

1. Import the encryption key for the Microsoft Ubuntu repository. This key enables the package manager to verify that the PowerShell package you install comes from Microsoft.

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    ```

1. Register the **Microsoft Ubuntu repository** so the package manager can locate the PowerShell package:

    ```bash
    sudo curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/18.04/prod.list
    ```

1. Update the list of packages:

    ```bash
    sudo apt-get update
    ```

1. Install PowerShell:

    ```bash
    sudo apt-get install -y powershell
    ```

1. Start PowerShell to verify that it installed successfully:

    ```bash
    pwsh
    ```

::: zone-end

::: zone pivot="macos"

## macOS

On macOS, install **PowerShell** by using the Homebrew package manager.

> [!IMPORTANT]
> If the **brew** command is unavailable, you might need to install the Homebrew package manager. For details, go to the [Homebrew website](https://brew.sh/).

1. Install Homebrew-Cask to obtain more packages, including the PowerShell package:

    ```bash
    brew install --cask powershell
    ```

1. Start PowerShell to verify that it installed successfully:

    ```bash
    pwsh
    ```

::: zone-end

::: zone pivot="windows"

## Windows

Windows PowerShell is included with the Windows operating system; however, we recommend installing PowerShell 7.0.6 LTS, PowerShell 7.1.3, or higher for use with Azure Az PowerShell module PowerShell. You can check which version is installed using the following steps:

1. In the **System tray search box**, type **PowerShell**. You may have multiple shortcut links:
    - PowerShell 7 (x64) - The 64-bit version. Generally, you should choose this shortcut.
    - Windows PowerShell - The 64-bit version included with Windows.
    - Windows PowerShell (x86) - A 32-bit version installed on 64-bit Windows.
    - Windows PowerShell ISE - The Integrated Scripting Environment (ISE) is used for writing scripts in Windows PowerShell.
    - Windows PowerShell ISE (x86) - A 32-bit version of the ISE on Windows.

1. Select the best-match PowerShell icon.

1. Type the following command to determine the version of PowerShell installed.

    ```powershell
    $PSVersionTable.PSVersion
    ```

    *or*

    ```powershell
    pwsh -ver
    ```

    If the major version number is lower than 7, follow the instructions to [upgrade existing Windows PowerShell](/powershell/scripting/install/installing-powershell-on-windows#upgrading-an-existing-installation). It's important to install the SDK to support .NET tools, as well.

    You need the [.NET SDK installed](/dotnet/core/sdk) to run this command.

    ```powershell
    dotnet tool install --global PowerShell
    ```

    After the .NET tool is installed, run the PowerShell version command again to verify your installation.

::: zone-end

You'll also need to set up your local machine(s) to support PowerShell. In the next unit, we'll review commands you can add, including the Azure Az PowerShell module.
