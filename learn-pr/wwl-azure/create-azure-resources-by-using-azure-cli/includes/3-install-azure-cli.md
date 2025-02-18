<!-- markdownlint-disable MD041 -->

In this unit, you consider the best environment to use when running Azure CLI commands. You install the Azure CLI on your local machine, and find the Azure CLI version installed.

## Chose your environment

The Azure CLI runs in Bash, PowerShell, and Windows command shell (Cmd.exe). With few exceptions, any task you can perform in the Azure portal can also be accomplished using the Azure CLI. Here are some factors to consider when choosing the most appropriate scripting tool for your needs:

* **Automation**: Do you need to automate complex or repetitive tasks? Azure PowerShell and the Azure CLI support automation, whereas the Azure portal doesn't.

* **Learning curve**: Do you need to complete a task quickly without learning new commands or syntax? The Azure portal is user-friendly and doesn't require learning commands or syntax. In contrast, Azure PowerShell and the Azure CLI require an understanding of command shell syntax and the specific requirements for each command.

* **Team skillset**: Does your team have existing expertise? For instance, if your team is already using PowerShell to manage other products like Windows, Exchange Server, or Microsoft 365, they might find Azure PowerShell to be a more comfortable and efficient choice.

> [!NOTE]
> This exercise guides you through creating a _local installation_ of Azure CLI.
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

For more Linux installation options, including the supported versions of Ubuntu and Debian, see [Install Azure CLI on Linux](/cli/azure/install-azure-cli-linux)

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

## Connect to Azure

When you're working with a local install of the Azure CLI, you need to authenticate before you can execute Azure commands. There are several ways to log into Azure:

* Azure Cloud Shell
* Interactively
* Managed identity
* Service principal

| Authentication method | Advantage |
|-|-|
| [Azure Cloud Shell](/azure/cloud-shell/overview) | Azure Cloud Shell automatically logs you in and is the easiest way to get started. |
| [Sign in interactively](./authenticate-azure-cli-interactively.md) | This is a good option when learning Azure CLI commands and running the Azure CLI locally. Login through your browser with the [az login](/cli/azure/reference-index#az-login) command. Interactive login also gives you a subscription selector to automatically set your default subscription. |
| [Sign in with a managed identity](./authenticate-azure-cli-managed-identity.md) | [Managed identities](/entra/identity/managed-identities-azure-resources/overview) provide an Azure-managed identity for applications to use when connecting to resources that support Microsoft Entra authentication. Using a managed identity eliminates the need for you to manage secrets, credentials, certificates, and keys. |
| [Sign in using an service principal](./authenticate-azure-cli-service-principal.md) | When you write scripts, using a [service principal](/entra/identity-platform/app-objects-and-service-principals) is the recommended authentication approach. You grant just the appropriate permissions needed to a service principal keeping your automation secure. |

1. If you chose to install the Azure CLI locally, log into Azure using the `az login` command:

   ```azurecli
   az login
   ```

   The Azure CLI typically launches your default browser to open the Azure sign-in page. If the Azure sign-in page doesn't launch, follow the command-line instructions and enter an authorization code at [https://aka.ms/devicelogin](https://aka.ms/devicelogin).

1. If you have access to multiple subscriptions, you're prompted to select an Azure subscription at time of login.
