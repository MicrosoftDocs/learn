Up until now, you have been running Bash commands in a Linux VM. That's a great way to practice Bash commands because you can't do any harm. If something goes terribly awry, you can delete the VM and start all over again.

You can also execute Bash commands in the Azure Cloud Shell. The drop-down list in the upper-left corner of the Cloud Shell lets you choose between two languages: PowerShell and Bash. The same Bash commands that make it easy to work with Linux can also be used with the Azure CLI (`az`) commands used to create and manage Azure resources. Let's demonstrate by disconnecting from the VM and returning to the Cloud Shell.

1. First, return to the Cloud Shell by running the following command in the VM: 

	```bash
	exit
	```

1. Make sure **Bash** is selected in the upper-left corner of the Cloud Shell. Let's say you want to see an up-to-date list of the VM images available in Azure. Do that with the command: 

	```bash
	az vm image list --all --output table
	```

	That's a lot of images.

1. While you can narrow the list using the `--publisher`, `--sku`, or `–-offer` options, you can also use `grep`, Linux's universal pattern matching program, to find what you're looking for. To find the images for CentOS, a popular Red Hat Enterprise Linux (RHEL) clone, use the following command:

	```bash
	az vm image list --all --output table | grep CentOS
	```

	This pipes output from the `az` command to `grep`, which filters out lines lacking the string "CentOS."

1. Now use the following command to list information about the VM that you created:

	```bash
	az vm show --resource-group bash-vm-rg --name bash-vm
	```

	Once more, that's a lot of output — this time in [JavaScript Object Notation](https://wikipedia.org/wiki/JSON) (JSON) format.

1. Perhaps what you really wanted to know was what operating system the VM is running. See if this makes it easier: 

	```bash
	az vm show --resource-group bash-vm-rg --name bash-vm | grep osType
	```

Applying what you know about Bash to the Azure Cloud Shell makes the latter easier to work with. And given that a sysadmin's work never ends, any tool that reduces the workload is a welcome tool indeed.

## Delete the resource group

You are almost finished, but one important task remains: deleting the VM that you created at the start of this module. The VM that you created is a relatively inexpensive one, but it is still charging your Azure subscription — even when it is isn't doing anything.

You could delete the VM with an `az vm delete` command. But that would leave behind other resources that were created along with the VM, including a virtual IP address, a virtual network and network interface, a virtual disk, and a Network Security Group (NSG). By deleting the resource group, you can delete all of these resources in one fell swoop.

To that end, run the following command:

```bash
az group delete --resource-group bash-vm-rg
```

Answer yes when prompted for confirmation and within a few minutes, the resource group and everything in it will be deleted.