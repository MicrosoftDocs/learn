**Azure CLI** is a command-line program you use to connect to Azure and execute administrative commands on Azure resources.

It runs on Linux, macOS, and Windows operating systems.

Instead of a web browser, it allows administrators and developers to execute their commands through a terminal or a command-line prompt (or script).

For example, to restart a VM, you would use a command such as:

```azurecli
az vm restart -g MyResourceGroup -n MyVm

```

Azure CLI provides cross-platform command-line tools for managing Azure resources.

You can install it locally on computers running the Linux, macOS, or Windows operating systems.

You can also use Azure CLI from a browser through Azure Cloud Shell.

In both cases, you can use Azure CLI interactively or through scripts:

 -  Interactive. For Windows operating systems, launch a shell such as cmd.exe, or for Linux or macOS, use Bash. Then issue the command at the shell prompt.
 -  Scripted. Assemble the Azure CLI commands into a shell script using the script syntax of your chosen shell, and then execute the script.
