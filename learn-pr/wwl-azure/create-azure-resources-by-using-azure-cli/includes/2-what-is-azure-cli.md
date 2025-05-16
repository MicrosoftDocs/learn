<!-- markdownlint-disable MD041 -->

The Azure Command-Line Interface (CLI) is a cross-platform command-line tool to connect to Azure and execute administrative commands on Azure resources. It allows the execution of commands through a terminal using interactive command-line prompts or a script.

To use the Azure CLI, you first must install it on Linux, macOS, or Windows. Azure CLI can also be run inside a Docker container, or through Azure Cloud Shell.

To execute Azure CLI commands, launch a command-line shell environment such as:

* Bash or PowerShell 7 on Linux or macOS
* cmd.exe, Windows PowerShell of PowerShell 7 on Windows
* Bash or PowerShell on Azure Cloud Shell

At the shell prompt, you execute Azure CLI reference commands.

Installation and command execution is explained in depth later in this module. Before you begin these exercises, take time to understand the Azure CLI tool.

## Azure CLI reference types

Azure CLI commands are either part of the **core** Azure CLI service, or they're an **extension**. Extensions are optional add-ons. The reference type determines the release schedule, status, and installation method.

* **Core**: Azure CLI references that are published as a permanent part of the CLI are called **core** references. All core references install with the Azure CLI and you can't choose a subset of references. If you run the CLI through Azure Cloud Shell, core references are always up to date.

* **Extensions**: Extensions aren't shipped as part of the CLI but run as CLI commands. Some extensions are a permanent part of the Azure CLI, but often, an extension gives you access to preview and experimental commands. A single reference group can have both core and extension commands. On first use, you're prompted to install an extension.

## Azure CLI reference status

Regardless of reference type, Azure CLI references fall into three status categories: **GA** (Generally Available), **public preview**, or **deprecated**. It's the reference command status (not type) that determines stability.

| | GA  | Public preview | Deprecated
|-|-|-|-|
| **Stability** | Permanent | Can change in response to customer feedback. Is subject to the terms of [Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/). | Will be removed.

## Azure CLI reference pattern

The Azure CLI reference pattern follows a simple `reference group and subgroup name`, `command`,`--parameter`, `parameter value` pattern. For example, switching between subscriptions is a common task.

* Reference group name: `az account`
* Command: `set`
* Parameter: `--subscription`
* Parameter value: `"my subscription name"`

```azurecli
# Change your default subscription
az account set --subscription "my subscription name"
```

## Executing Azure CLI commands

Execute Azure CLI reference commands interactively or through a script.

* **Interactive**: For Windows operating systems, launch a shell such as cmd.exe, or for Linux or macOS, use Bash. Then issue the command at the shell prompt. For example, to restart an Azure virtual machine, you would use the `az vm restart` command:

  ```azurecli
  az vm restart --group MyResourceGroup --name MyVm
  ```

* **Scripted**: To automate repetitive tasks, you assemble the CLI commands into a shell script using the script syntax of your chosen shell, and then you execute the script. Here's an example that executes a Bash script named `myScriptFile.sh` that passes in a resource group parameter value.

  ```azurecli
  # Bash syntax
  ./myScriptFile.sh myResourceGroupName
  ```

Now that you've had an introduction to the Azure CLI tool, choose the environment that works best for you and install the Azure CLI.
