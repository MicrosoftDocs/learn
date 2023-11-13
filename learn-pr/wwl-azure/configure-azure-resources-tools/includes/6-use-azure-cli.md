Azure CLI is a command-line program to connect to Azure and execute administrative commands on Azure resources. It runs on Linux, macOS, and Windows, and allows administrators and developers to execute their commands through a terminal, command-line prompt, or script instead of a web browser. For example, to restart a VM, you would use a command such as the following:

```azurecli
az vm restart -g MyResourceGroup -n MyVm

```

Azure CLI provides cross-platform command-line tools for managing Azure resources. You can install the CLI locally on computers running the Linux, macOS, or Windows operating systems. You can also use Azure CLI from a browser through Azure Cloud Shell.

In both cases, Azure CLI can be used interactively or through scripts:

 -  **Interactive**. First, for Windows operating systems, launch a shell such as cmd.exe, or for Linux or macOS, use Bash. Then issue the command at the shell prompt.
 -  **Scripted**. Assemble the Azure CLI commands into a shell script using the script syntax of your chosen shell. Then execute the script.

Azure CLI lets you control nearly every aspect of every Azure resource. You can work with resource groups, storage, VMs, Microsoft Entra ID, containers, machine learning, and so on.

Commands in the CLI are structured in *groups* and *subgroups*. Each group represents a service provided by Azure, and the subgroups divide commands for these services into logical groupings. For example, the `storage` group contains subgroups including **account**, **blob**, **share**, and **queue**.

So, how do you find the particular commands you need? One way is to use `az find`. For example, if you want to find commands that might help you manage a storage blob, you can use the find command:

```azurecli
az find blob

```

If you already know the name of the command you want, the `--help` argument for that command will get you more detailed information on the command, and for a command group, a list of the available subcommands. For example, here's how you can get a list of the subgroups and commands for managing blob storage:

```azurecli
az storage blob --help

```

> [!NOTE]
> Bookmark the [Azure CLI Reference](/cli/azure/).
