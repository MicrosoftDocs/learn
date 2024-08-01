Let's install the Azure CLI on your local machine, then verify the Azure CLI version by executing the `az version` command. The method you use for installing the Azure CLI depends on your computer's operating system. Choose the steps for your operating system.

> [!NOTE]
> This exercise guides you through installing the Azure CLI tool locally. The remainder of the module will use the Azure Cloud Shell so you can leverage the free subscription support in Microsoft Learn. You can consider this exercise as an optional activity and just review the instructions if you prefer.

::: zone pivot="linux"

## Linux

Install the Azure CLI on **Ubuntu Linux** using the Advanced Packaging Tool (**apt**) and the Bash command line.

> [!TIP]
> The following commands are for Ubuntu version 22.04 (Jammy Jellyfish). Other versions and distributions of Linux have different instructions. Follow the instructions in [Install the Azure CLI](/cli/azure/install-azure-cli) if you're using a different Linux version or have install problems.

The easiest way to install the Azure CLI is through a script maintained by the Azure CLI team. This script runs all installation commands in one step. This script is downloaded via `curl` and piped directly to `bash` to install the CLI.

If you wish to inspect the contents of the script yourself before executing, download the script first using `curl` and inspect it in your favorite text editor.

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

::: zone-end

::: zone pivot="macos"

## macOS

Install the Azure CLI on macOS using the Homebrew package manager.

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

Install the Azure CLI on Windows using the Microsoft Installer (MSI).

1. Go to [https://aka.ms/installazurecliwindows](https://aka.ms/installazurecliwindows) to install the 32-bit version, or [https://aka.ms/installazurecliwindowsx64](https://aka.ms/installazurecliwindowsx64) to download the 64-bit version of the Azure CLI. Open the downloaded MSI file, by selecting **Run** or **Open file** in the browser security dialog box.
2. In the installer, accept the license terms, then select **Install**.
3. In the **User Account Control** dialog, select **Yes**.

If the Azure CLI was previously installed, running either the 32-bit or 64-bit MSI overwrites an existing installation.

::: zone-end

## Get the installed version

You can run the Azure CLI by opening a bash shell (Linux and macOS), or from the Windows command prompt (Cmd.exe), Windows PowerShell, or PowerShell 7.

1. Start the Azure CLI and verify your installation by running the version check.

    ```azurecli
    az version
    ```

::: zone pivot="windows"

::: zone-end

Your local machine is now set up to administer Azure resources with the Azure CLI. You can now use the Azure CLI locally to enter commands or execute scripts. The Azure CLI forwards your commands to the Azure data centers, where they run inside your Azure subscription.
