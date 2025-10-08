<!-- markdownlint-disable MD041 -->

The **Azure Command-Line Interface (CLI)** is a cross-platform command-line tool designed to connect to Azure and execute administrative commands on Azure resources. It provides a consistent, scriptable interface for managing your cloud infrastructure, whether you're working interactively at a terminal or automating tasks through scripts.

## What is Azure CLI?

**Azure CLI** allows you to:

- **Execute commands interactively:** Type commands at a terminal prompt and see immediate results.
- **Automate through scripts:** Combine commands in Bash, PowerShell, or other shell scripts for repetitive tasks.
- **Manage all Azure services:** Create, configure, delete, and monitor Azure resources using consistent syntax.
- **Work anywhere:** Install on Linux, macOS, Windows, Docker containers, or use Azure Cloud Shell.

## Installation and execution options

**Platform support:**

| Platform              | Shell Options                     | Installation Method                  |
| --------------------- | --------------------------------- | ------------------------------------ |
| **Linux**             | Bash, PowerShell 7                | Package manager (apt, yum) or script |
| **macOS**             | Bash, Zsh, PowerShell 7           | Homebrew or installer                |
| **Windows**           | cmd.exe, PowerShell, PowerShell 7 | MSI installer                        |
| **Docker**            | Bash                              | Pre-built container image            |
| **Azure Cloud Shell** | Bash, PowerShell                  | Built-in (no installation needed)    |

**Recommended environments:**

- **Azure Cloud Shell:** Pre-installed with always up-to-date Azure CLI and authentication automatically configured.
- **Bash on Linux/macOS:** Natural shell for Azure CLI with excellent scripting capabilities.
- **PowerShell 7:** Cross-platform PowerShell providing consistent experience across operating systems.
- **Windows Command Prompt (cmd.exe):** Basic Windows shell for simple command execution.

Installation details and command execution patterns are explained in depth later in this module. Before proceeding, let's understand the Azure CLI architecture and command structure.

## Azure CLI reference types

**Azure CLI commands** are organized into two categories: **core** references and **extensions**. Understanding the difference helps you manage your Azure CLI installation and access the latest features.

### Core references

**Core references** are permanent, built-in commands that install automatically with Azure CLI:

- **Always available:** Install with Azure CLI; no additional setup required.
- **Production-ready:** Stable, well-tested commands for everyday Azure management.
- **Auto-updated:** When using Azure Cloud Shell, core references are always current.
- **Comprehensive coverage:** Includes commands for most Azure services and common tasks.

**Examples of core reference groups:**

- `az account` - Manage Azure subscriptions
- `az group` - Manage resource groups
- `az storage` - Manage Azure Storage accounts
- `az vm` - Manage virtual machines
- `az network` - Manage networking resources

### Extensions

**Extensions** provide optional, specialized functionality that runs as Azure CLI commands:

- **Opt-in installation:** Not included by default; install when needed.
- **Access new features:** Get preview and experimental Azure capabilities before they become GA (Generally Available).
- **Flexible updates:** Update extensions independently from core Azure CLI.
- **Auto-prompt:** Azure CLI prompts you to install an extension on first use.

**Common use cases for extensions:**

- Preview features for Azure services
- Specialized tools for specific scenarios (e.g., Azure IoT, Azure ML)
- Vendor-provided commands for third-party integrations

**Example:** The first time you run an extension command, Azure CLI prompts you:

```bash
$ az aks create --resource-group myResourceGroup --name myAKSCluster
The command requires the extension aks-preview. Do you want to install it now? (Y/n): Y
```

## Azure CLI reference status

**Azure CLI commands have lifecycle stages** that indicate their stability and support level. The status (not the type) determines whether a command is production-ready.

### Three status categories

| Status                       | Stability                    | Use in Production | Support Level                                                                                           |
| ---------------------------- | ---------------------------- | ----------------- | ------------------------------------------------------------------------------------------------------- |
| **GA (Generally Available)** | Permanent                    | Yes               | Full Microsoft support                                                                                  |
| **Public Preview**           | Can change based on feedback | Use with caution  | Subject to [Azure Preview Terms](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) |
| **Deprecated**               | Will be removed              | No                | Migrate to replacement                                                                                  |

**Status details:**

- **GA (Generally Available):**

  - Production-ready, stable commands
  - Breaking changes only in major version updates
  - Full Microsoft support and SLA coverage
  - Recommended for production workloads

- **Public Preview:**

  - New features available for testing and feedback
  - May have breaking changes without notice
  - Limited support; report issues through GitHub or feedback channels
  - Test in development environments before production use

- **Deprecated:**
  - Command scheduled for removal in future release
  - Usually replaced by newer, better command
  - Migration path provided in documentation
  - Avoid using in new scripts or automation

**Important:** Both core and extension commands can have any status. A core command might be in preview, and an extension command might be GA.

## Azure CLI reference pattern

**Azure CLI uses a consistent, hierarchical command structure** that makes it easy to predict and remember commands. Once you understand the pattern, you can work with any Azure service.

### Command structure

**Syntax pattern:**

```
az <reference-group> <subgroup> <command> --<parameter> <value>
```

**Component breakdown:**

| Component           | Description                       | Example                                    |
| ------------------- | --------------------------------- | ------------------------------------------ |
| **az**              | Base command (always required)    | `az`                                       |
| **Reference group** | Azure service or category         | `account`, `group`, `storage`, `vm`        |
| **Subgroup**        | Specific resource type (optional) | `blob`, `container`, `disk`                |
| **Command**         | Action to perform                 | `create`, `list`, `delete`, `show`         |
| **Parameter**       | Options that modify behavior      | `--name`, `--resource-group`, `--location` |
| **Value**           | Data provided to parameter        | `myStorageAccount`, `eastus`               |

### Practical example: Change Azure subscription

**Scenario:** Switch your default Azure subscription.

**Command breakdown:**

```azurecli
az account set --subscription "my subscription name"
```

- **Reference group:** `az account` (manages Azure subscriptions)
- **Command:** `set` (changes the active subscription)
- **Parameter:** `--subscription` (specifies which subscription)
- **Parameter value:** `"my subscription name"` (your subscription name or ID)

### More command examples

**Create a resource group:**

```azurecli
az group create --name myResourceGroup --location eastus
```

- **Reference group:** `az group`
- **Command:** `create`
- **Parameters:** `--name` (resource group name), `--location` (Azure region)

**List storage accounts:**

```azurecli
az storage account list --resource-group myResourceGroup --output table
```

- **Reference group:** `az storage`
- **Subgroup:** `account`
- **Command:** `list`
- **Parameters:** `--resource-group` (filter by group), `--output` (format results)

**Restart a virtual machine:**

```azurecli
az vm restart --name myVM --resource-group myResourceGroup
```

- **Reference group:** `az vm`
- **Command:** `restart`
- **Parameters:** `--name` (VM name), `--resource-group` (containing group)

**Pattern recognition tip:** Commands follow natural language patterns. If you want to "create a storage account in a resource group", you'd use `az storage account create --resource-group`.

## Executing Azure CLI commands

**Azure CLI supports two execution modes:** interactive command-line use and automated script execution. Choose the approach that best fits your workflow.

### Interactive execution

**Interactive mode** allows you to type commands at a terminal prompt and see immediate results. This approach is ideal for:

- Learning Azure CLI commands and syntax
- Exploring Azure resources and their properties
- Quick one-time tasks (creating a test resource, checking status)
- Troubleshooting and debugging

**How it works:**

1. Open your preferred shell (Bash, PowerShell, cmd.exe, Azure Cloud Shell)
2. Type the Azure CLI command at the prompt
3. Press Enter to execute
4. View the results immediately

**Example:** Restart a virtual machine interactively:

```azurecli
az vm restart --resource-group MyResourceGroup --name MyVm
```

**Interactive workflow:**

```bash
# Check current subscription
$ az account show --output table

# List all resource groups
$ az group list --output table

# Create a storage account
$ az storage account create --name mystorageacct --resource-group myRG --location eastus
```

### Scripted execution

**Scripted mode** combines multiple Azure CLI commands into a script file for automation. This approach is essential for:

- Repetitive tasks (creating development environments daily)
- Complex multi-step operations (deploying entire applications)
- CI/CD pipelines (automated deployments)
- Infrastructure as Code (IaC) implementations

**How it works:**

1. Write Azure CLI commands in a script file (`.sh` for Bash, `.ps1` for PowerShell)
2. Add variables, loops, and conditional logic as needed
3. Make the script executable (Bash: `chmod +x script.sh`)
4. Execute the script with parameters

**Example:** Bash script that creates multiple storage accounts:

```bash
#!/bin/bash
# File: myScriptFile.sh

resourceGroup=$1
location="eastus"
accountCount=3

for i in $(seq 1 $accountCount); do
    accountName="storage${i}${RANDOM}"
    echo "Creating storage account: $accountName"
    az storage account create \
        --name $accountName \
        --resource-group $resourceGroup \
        --location $location \
        --sku Standard_LRS
done
```

**Execute the script:**

```bash
# Make script executable
chmod +x myScriptFile.sh

# Run script with resource group parameter
./myScriptFile.sh myResourceGroupName
```

**PowerShell script example:**

```powershell
# File: myScript.ps1

param (
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName
)

$location = "eastus"
$storageCount = 3

for ($i = 1; $i -le $storageCount; $i++) {
    $storageAccount = "storage$i$(Get-Random)"
    Write-Host "Creating storage account: $storageAccount"
    az storage account create `
        --name $storageAccount `
        --resource-group $ResourceGroupName `
        --location $location `
        --sku Standard_LRS
}
```

**Execute PowerShell script:**

```powershell
.\myScript.ps1 -ResourceGroupName "myResourceGroupName"
```

### Choosing the right execution mode

| Use Case                   | Interactive     | Scripted        |
| -------------------------- | --------------- | --------------- |
| **Learning**               | Best            | Not recommended |
| **One-time tasks**         | Best            | Not recommended |
| **Troubleshooting**        | Best            | Sometimes       |
| **Repetitive tasks**       | Not recommended | Best            |
| **Multi-step operations**  | Sometimes       | Best            |
| **CI/CD pipelines**        | Not recommended | Best            |
| **Infrastructure as Code** | Not recommended | Best            |

Now that you understand the Azure CLI architecture and command structure, let's choose the right environment and install Azure CLI.
