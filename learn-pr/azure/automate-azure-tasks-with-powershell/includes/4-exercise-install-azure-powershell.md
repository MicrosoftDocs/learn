
In this exercise, you will install Azure PowerShell on your local machine. Please choose the steps for your operating system.

## Install PowerShell Core
On Linux and macOS, the first step is to install PowerShell Core.

### Linux
Here you will install PowerShell Core on Ubuntu Linux using the Advanced Packaging Tool (**apt**) and the Bash command line. 

> [!NOTE] The commands listed below are for Ubuntu version 18.04. If you are using a different version of Ubuntu, you must add a different repository. For details see [Installing PowerShell Core on Linux](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-powershell-core-on-linux).

1. Import the encryption key for the Microsoft Ubuntu repository. This will allow the package manager to verify that the PowerShell Core package you install comes from Microsoft.

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    ```
1. Register the Microsoft Ubuntu repository so the package manager can locate the PowerShell Core package.

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

### macOS
Here you will install PowerShell Core on macOS using the Homebrew package manager.

> [!IMPORTANT] If the **brew** command is unavailable, you may need to install the Homebrew package manager. For details see the [Homebrew website](https://brew.sh/).

1. Install Homebrew-Cask to obtain more packages, including the PowerShell Core package:

    ```bash
    brew tap caskroom/cask
    ```
1. Install PowerShell Core:

    ```bash
    brew cask install powershell
    ```

1. Start PowerShell Core to verify that it installed successfully:

    ```bash
    pwsh
    ```

## Install Azure PowerShell
After installing the base PowerShell product, you next need to install Azure PowerShell to add the Azure-specific commands.

### Windows
Here you will install Azure PowerShell on Windows using the **Install-Module** PowerShell command.

> [!IMPORTANT] You must have PowerShell version 5.0 or higher to install Azure PowerShell. To check your version of PowerShell, use the following command: 
>
> `$PSVersionTable.PSVersion` 
>
>If the version number is lower than 5.0, see [Upgrading existing Windows PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell?view=powershell-6#upgrading-existing-windows-powershell).

1. Open the **Start** menu and type **Windows PowerShell**.
1. Right-click the **Windows PowerShell** icon and select **Run as administrator**.
1. In the **User Account Control** dialog, select **Yes**.
1. Type the following command, and then press Enter:

    ```powershell
    Install-Module -Name AzureRM
    ```
1. If you are asked whether you trust modules from PSGallery, answer **Yes** or **Yes to All**.

### Linux or macOS
Here you will install Azure PowerShell on either Linux or macOS using the **Install-Module** PowerShell command. The procedure is the same for both operating systems.

1. In a terminal, type the following command to launch PowerShell Core with elevated privileges.

    ```bash
    sudo pwsh
    ```

1. Run the following command at the PowerShell Core prompt to install Azure PowerShell.

    ```powershell
    Install-Module AzureRM.NetCore
    ```

1. If you are asked whether you trust modules from PSGallery, answer **Yes** or **Yes to All**.

## Summary
Here, you setup your local machines to administer Azure resources with Azure PowerShell. You can now use Azure PowerShell locally to enter commands or execute scripts. Azure PowerShell will forward your commands to the Azure datacenters where they will run inside your Azure subscription.