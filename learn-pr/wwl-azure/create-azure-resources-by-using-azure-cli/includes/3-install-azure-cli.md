<!-- markdownlint-disable MD041 -->

In this unit, you learn how to choose the best environment for running **Azure CLI** commands, install **Azure CLI** on your local machine, and verify the installation by checking the version.

## Choose your environment

**Azure CLI** runs in **Bash**, **PowerShell**, and **Windows Command Prompt** (Cmd.exe). With few exceptions, any task you can perform in the **Azure portal** can also be accomplished using **Azure CLI**. Here are some factors to consider when choosing the most appropriate scripting tool for your needs:

- **Automation:** Do you need to automate complex or repetitive tasks? **Azure PowerShell** and **Azure CLI** support automation, whereas the **Azure portal** doesn't.

- **Learning curve:** Do you need to complete a task quickly without learning new commands or syntax? The **Azure portal** is user-friendly and doesn't require learning commands or syntax. In contrast, **Azure PowerShell** and **Azure CLI** require an understanding of command shell syntax and the specific requirements for each command.

- **Team skillset:** Does your team have existing expertise? For instance, if your team is already using **PowerShell** to manage other products like **Windows**, **Exchange Server**, or **Microsoft 365**, they might find **Azure PowerShell** to be a more comfortable and efficient choice.

> [!NOTE]
> This exercise guides you through creating a _local installation_ of **Azure CLI**.
> However, the remainder of this module uses **Azure Cloud Shell** in the free Microsoft Learn
> sandbox environment. If you prefer, you can consider this install exercise optional and only review the
> instructions.

## Installation methods by platform

The following sections provide platform-specific installation instructions for **Azure CLI**. Choose the section that matches your operating system.

::: zone pivot="windows"

## Install Azure CLI on Windows

1. Download and install the latest release of **Azure CLI**. When the installer asks if it can make changes to your computer, select the **Yes** box.

   > [!div class="nextstepaction"] > [Latest MSI of the Azure CLI (32-bit)](https://aka.ms/installazurecliwindows)

   > [!div class="nextstepaction"] > [Latest MSI of the Azure CLI (64-bit)](https://aka.ms/installazurecliwindowsx64)

   If you previously installed **Azure CLI**, running either the 32-bit or 64-bit **Microsoft Installer (MSI)** overwrites an existing installation.

1. After the installation is complete, **close and reopen any active terminal window** to ensure the environment variables are refreshed.

1. Open **Windows Command Prompt**, **PowerShell**, or **Windows Terminal** to run **Azure CLI** commands.

This exercise guided you through using the **Microsoft Installer**. For more Windows installation options, see [Install Azure CLI on Windows](/cli/azure/install-azure-cli-windows).

::: zone-end

::: zone pivot="linux"

## Install Azure CLI on Linux

1. Determine your version of **Ubuntu** or **Debian**:

   ```bash
   source /etc/os-release
   echo "OS: $NAME"
   echo "Version: $VERSION"
   ```

   For supported versions of **Ubuntu** and **Debian**, see [Before you begin](/cli/azure/install-azure-cli-linux?pivots=apt#before-you-begin).

1. Install **Azure CLI** on **Ubuntu** or **Debian** using the **Advanced Packaging Tool (apt)** and the **Bash** command line:

   ```bash
   curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
   ```

1. Verify the installation completed successfully:

   ```bash
   az version
   ```

For more Linux installation options, including **Red Hat Enterprise Linux (RHEL)**, **CentOS**, **Fedora**, and other distributions, see [Install Azure CLI on Linux](/cli/azure/install-azure-cli-linux).

::: zone-end

::: zone pivot="macos"

## Install Azure CLI on macOS

1. If you don't have **Homebrew** available on your system, [install Homebrew](https://docs.brew.sh/Installation.html) before continuing.

1. Update your **Homebrew** repository information and run the **Azure CLI** `install` command:

   ```bash
   brew update && brew install azure-cli
   ```

1. Verify the installation:

   ```bash
   az version
   ```

For more information, including troubleshooting in **macOS**, see [Install Azure CLI on macOS](/cli/azure/install-azure-cli-macos).

::: zone-end

Your local machine is now set up to administer **Azure** resources with **Azure CLI**. You can now use **Azure CLI** locally to enter commands or execute scripts. **Azure CLI** forwards your commands to the **Azure data centers**, where they run inside your **Azure subscription**.

## Verify Azure CLI installation

Verify your **Azure CLI** installation by returning the **Azure CLI** version using the `az version` command:

```azurecli
az version
```

You can expect the following response from **Azure CLI**:

```output
{
  "azure-cli": "2.65.0",
  "azure-cli-core": "2.65.0",
  "azure-cli-telemetry": "1.1.0",
  "extensions": {}
}
```

> [!NOTE]
> The version numbers shown above are examples. Your installed version may be different depending on when you installed **Azure CLI**.

## Authentication methods

When you're working with a local install of **Azure CLI**, you need to authenticate before you can execute **Azure** commands. There are several ways to authenticate with **Azure** using **Azure CLI**:

The following table compares the most common authentication methods:

| Authentication method                                                        | Best for                               | Advantage                                                                                                                                                                                                                                      |
| ---------------------------------------------------------------------------- | -------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **[Azure Cloud Shell](/azure/cloud-shell/overview)**                         | Quick testing and learning             | **Azure Cloud Shell** automatically authenticates you and is the easiest way to get started. No local installation required.                                                                                                                   |
| **[Interactive login](/cli/azure/authenticate-azure-cli-interactively)**     | Local development and learning         | Login through your browser with the `az login` command. **Interactive login** gives you a subscription selector to automatically set your default subscription.                                                                                |
| **[Managed identity](/cli/azure/authenticate-azure-cli-managed-identity)**   | Azure-hosted applications and services | **Managed identities** provide an **Azure-managed identity** for applications to use when connecting to resources that support **Microsoft Entra** authentication. Eliminates the need to manage secrets, credentials, certificates, and keys. |
| **[Service principal](/cli/azure/authenticate-azure-cli-service-principal)** | Production automation and CI/CD        | When you write scripts, using a **service principal** is the recommended authentication approach. You grant only the appropriate permissions needed to a **service principal**, keeping your automation secure.                                |

## Sign in interactively

1. If you chose to install **Azure CLI** locally, authenticate to **Azure** using the `az login` command:

   ```azurecli
   az login
   ```

   **Azure CLI** typically launches your default browser to open the **Azure sign-in** page. If the **Azure sign-in** page doesn't launch, follow the command-line instructions and enter an authorization code at [https://aka.ms/devicelogin](https://aka.ms/devicelogin).

1. If you have access to multiple subscriptions, you're prompted to select an **Azure subscription** at time of login.

> [!IMPORTANT]
> Starting in 2025, **Microsoft** enforces mandatory **multifactor authentication (MFA)** for **Azure CLI** and other command-line tools. The new **MFA** requirements impact **Microsoft Entra ID** user identities. They do not affect workload identities, such as **service principals** and **managed identities**.
