In this unit, you will install **PowerShell** on your local machine.

> [!NOTE]
> This exercise guides you through installing the PowerShell tools locally. The remainder of the module will use the Azure Cloud Shell so you can leverage the free subscription support in Microsoft Learn. You can consider this exercise as an optional activity and just review the instructions if you prefer.

::: zone pivot="linux"

## Linux

Installing PowerShell for Linux will involve using a package manager. We will use **Ubuntu 18.04** for our example here, but we have [detailed instructions for other versions and distributions in our documentation](https://docs.microsoft.com/powershell/scripting/install/installing-powershell-core-on-linux).

You will install PowerShell Core on Ubuntu Linux using the Advanced Packaging Tool (**apt**) and the Bash command line. 

1. Import the encryption key for the Microsoft Ubuntu repository. This will allow the package manager to verify that the PowerShell Core package you install comes from Microsoft.

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    ```

1. Register the **Microsoft Ubuntu repository** so the package manager can locate the PowerShell Core package.

    ```bash
    sudo curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/18.04/prod.list
    ```

1. Update the list of packages.

    ```bash
    sudo apt-get update
    ```

1. Install PowerShell Core.

    ```bash
    sudo apt-get install -y powershell
    ```

1. Start PowerShell to verify that it installed successfully.

    ```bash
    pwsh
    ```

::: zone-end

::: zone pivot="macos"

## MacOS

On macOS, the first step is to install **PowerShell Core**. This is done using the Homebrew package manager.

> [!IMPORTANT]
> If the **brew** command is unavailable, you may need to install the Homebrew package manager. For details see the [Homebrew website](https://brew.sh/).

1. Install Homebrew-Cask to obtain more packages, including the PowerShell Core package:

    ```bash
    brew install --cask powershell
    ```

1. Start PowerShell Core to verify that it installed successfully:

    ```bash
    pwsh
    ```

::: zone-end

::: zone pivot="windows"

## Windows

PowerShell is included with Windows, however there may be an update available for your machine. The Azure support we are going to use requires PowerShell with a major version of 5.0 or higher. You can check the version you have installed through the following steps:

1. Open the **Start** menu and type **Windows PowerShell**. There may be multiple shortcut links available:
    - Windows PowerShell - this is the 64-bit version and generally what you should choose.
    - Windows PowerShell (x86) - this is a 32-bit version installed on 64-bit Windows.
    - Windows PowerShell ISE - The Integrated Scripting Environment (ISE) is used for writing scripts in PowerShell. 
    - Windows PowerShell ISE (x86) - A 32-bit version of the ISE.

1. Select the Windows PowerShell icon.

1. Type the following command to determine the version of PowerShell installed.

    ```powershell
    $PSVersionTable.PSVersion
    ```

If the major version number is lower than 5.0, follow these instructions for [upgrading existing Windows PowerShell](https://docs.microsoft.com/powershell/scripting/install/installing-windows-powershell#upgrading-existing-windows-powershell).

::: zone-end

You have setup your local machine(s) to support PowerShell. Next, we will talk about additional commands you can add including the Azure module.
