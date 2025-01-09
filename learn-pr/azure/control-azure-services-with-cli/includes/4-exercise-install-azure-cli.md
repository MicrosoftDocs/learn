<!-- markdownlint-disable MD041 -->

In this unit, you learn how to determine the version of Azure CLI installed on your local machine
and how to install the latest version.

> [!NOTE]
> This exercise guides you through creating a local installation of Azure CLI.
> However, the remainder of this module uses Azure Cloud Shell to use the free Microsoft Learn
> sandbox environment. If you prefer, you can consider this exercise optional and only review the
> instructions.

::: zone pivot="windows"

## Install Azure CLI on Windows

1. Download and install the latest release of the Azure CLI. When the installer asks if it can make changes to your computer, select the "Yes" box.

   > [!div class="nextstepaction"]
   > [Latest MSI of the Azure CLI (32-bit)](https://aka.ms/installazurecliwindows)

   > [!div class="nextstepaction"]
   > [Latest MSI of the Azure CLI (64-bit)](https://aka.ms/installazurecliwindowsx64)

  If you previously installed the Azure CLI, running either the 32-bit or 64-bit Microsoft installer (MSI) overwrites an existing installation.

1. After the installation is complete, **close and reopen any active terminal window to use the Azure CLI**.

1. Open a Windows Command Prompt to run the Azure CLI.

This exercise guided you through using the Microsoft Installer. For more Windows installation options, see [Install Azure CLI on Windows](/cli/azure/install-azure-cli-windows)

::: zone-end

::: zone pivot="linux"

## Install Azure CLI on Linux

1. Determine your version of Ubuntu

   ```bash
   source /etc/os-release
   ```

   For supported versions of Ubuntu, see [Before you begin](/cli/azure/install-azure-cli-linux?pivots=apt#before-you-begin).

1. Install Azure CLI on Ubuntu Linux using the Advanced Packaging Tool (**apt**) and the Bash command line.

   ```bash
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   ```

For more Linux installation options, including the supported versions of Ubuntu and Debian, see [Install Azure CLI on Linux](/cli/azure/install-azure-cli-linux).

::: zone-end

::: zone pivot="macos"

## Install Azure CLI on macOS

1. If you don't have homebrew available on your system, [install homebrew](https://docs.brew.sh/Installation.html) before continuing.

1. Update your brew repository information and run the Azure CLI `install` command.

   ```bash
   brew update && brew install azure-cli
   ```

For more information, including troubleshooting in macOS, see [Install Azure CLI on macOS](/cli/azure/install-azure-cli-macos).

::: zone-end

Your local machine is now set up to administer Azure resources with the Azure CLI. You can now use the Azure CLI locally to enter commands or execute scripts. The Azure CLI forwards your commands to the Azure data centers, where they run inside your Azure subscription.

## Get the Azure CLI version

Determine the Azure CLI version by using the `az version` command.

```azurecli
az version
```

You can expect the following response from Azure CLI:

```output
{
  "azure-cli": "x.yy.z",
  "azure-cli-core": "x.yy.x",
  "azure-cli-telemetry": "x.y.z",
  "extensions": {}
}
```

## Find Azure CLI commands

The Azure CLI lets you control nearly every aspect of every Azure resource. You can work with resource groups, storage, virtual machines, Microsoft Entra ID, containers, machine learning, and so on.

Commands in the CLI are structured in *groups* and *subgroups*. Each group represents a service provided by Azure, and the subgroups divide commands for these services into logical groupings. For example, the `storage` group contains subgroups including **account**, **blob**, and **queue**.

So, how do you find the particular commands you need? One way is to use `az find`. Take a quick tour of Azure CLI commands by following these examples:

1. Find the most popular commands related to the word **blob**:

   ```azurecli
   az find blob
   ```

1. Show the most popular commands for an Azure CLI command group, such as `az vm`:

   ```azurecli
   az find "az vm"
   ```

1. Show the most popular parameters and subcommands for an Azure CLI command:

   ```azurecli
   az find "az vm create"
   ```

## Get help on Azure CLI commands

If you already know the name of the command you want, the `--help` argument for that command gets you more detailed information on the command and a list of the available subcommands for a command group. Continuing with our VM examples, here's how you can get a list of the subgroups and commands for managing VM images:

```azurecli
az vm image --help
```

## Connect to Azure

When you're working with a local install of the Azure CLI, you need to authenticate before you can execute Azure commands by using the Azure CLI **login** command.

```azurecli
az login
```

The Azure CLI typically launches your default browser to open the Azure sign-in page. If the Azure sign-in page doesn't launch, follow the command-line instructions and enter an authorization code at [https://aka.ms/devicelogin](https://aka.ms/devicelogin).

After successfully signing in, you'll be connected to your Azure subscription.
