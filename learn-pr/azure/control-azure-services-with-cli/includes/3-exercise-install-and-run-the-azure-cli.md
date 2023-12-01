Let's install the Azure CLI on your local machine, then run a command to verify your installation. The method you use for installing the Azure CLI depends on your computer's operating system. Choose the steps for your operating system.

> [!NOTE]
> This exercise guides you through installing the Azure CLI tool locally. The remainder of the module will use the Azure Cloud Shell so you can leverage the free subscription support in Microsoft Learn. You can consider this exercise as an optional activity and just review the instructions if you prefer.

::: zone pivot="linux"

## Linux

Here, you'll install the Azure CLI on **Ubuntu Linux** using the Advanced Packaging Tool (**apt**) and the Bash command line.

> [!TIP]
> The following commands are for Ubuntu version 18.04. Other versions and distributions of Linux have different instructions. Follow the instructions in [Install the Azure CLI](/cli/azure/install-azure-cli) if you're using a different Linux version or have any problems.

1. Modify your sources list so that the Microsoft repository is registered and the package manager can locate the Azure CLI package:

    ```bash
    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list
    ```

1. Import the encryption key for the Microsoft Ubuntu repository. This allows the package manager to verify that the Azure CLI package you install comes from Microsoft.

    ```bash
    curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    ```

1. Install the Azure CLI:

    ```bash
    sudo apt-get install apt-transport-https
    sudo apt-get update && sudo apt-get install azure-cli
    ```

::: zone-end

::: zone pivot="macos"

## macOS

Here, you'll install the Azure CLI on macOS using the Homebrew package manager.

> [!IMPORTANT]
> If the **brew** command is unavailable, you might need to install the Homebrew package manager. For details, see the [Homebrew website](https://brew.sh/).

1. Update your brew repository to make sure you get the latest Azure CLI package:

    ```bash
    brew update
    ```

1. Install the Azure CLI:

    ```bash
    brew install azure-cli
    ```

::: zone-end

::: zone pivot="windows"

## Windows

Here, you'll install the Azure CLI on Windows using the MSI installer.

1. Go to [https://aka.ms/installazurecliwindows](https://aka.ms/installazurecliwindows) and select **Run** or **Open file** in the browser security dialog box.
1. In the installer, accept the license terms, then select **Install**.
1. In the **User Account Control** dialog, select **Yes**.

::: zone-end

## Running the Azure CLI

You can run the Azure CLI by opening a bash shell (Linux and macOS), or from the command prompt or PowerShell (Windows).

1. Start the Azure CLI and verify your installation by running the version check.

    ```azurecli
    az --version
    ```

::: zone pivot="windows"

> [!TIP]
> Running the Azure CLI from PowerShell has some advantages over running the Azure CLI from the Windows command prompt. PowerShell provides more tab-completion features than those available from the command prompt.

::: zone-end

You've set up your local machines to administer Azure resources with the Azure CLI. You can now use the Azure CLI locally to enter commands or execute scripts. The Azure CLI will forward your commands to the Azure datacenters, where they'll run inside your Azure subscription.
