Like most application frameworks, you can run your MEAN stack application in many different environments. You can run your application on a physical computer in your server room, on a virtual machine, or in containers.

Here you'll run your application on a VM running on Azure. MEAN supports many different operating systems. For learning purposes, you'll use Ubuntu Linux here.

## Create an Ubuntu Linux VM

Normally, you create a _resource group_ before you create other resources on Azure. A resource group is a container that holds the resources that are related for an Azure solution. For this exercise, the Azure sandbox provides a resource group for you. However, when working in your own Azure subscription, you'd run the following command to create a resource group in a location near you.

> [!NOTE]
> The following `az group create` code sample is for you to run with your own account, not this sandbox!

```azurecli
az group create \
  --name <resource-group-name> \
  --location <resource-group-location>
```

1. From Cloud Shell, run the `az vm create` command to create an Ubuntu VM:

    ```azurecli
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name MeanStack \
      --image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

    The command takes about two minutes to complete. When the command finishes, you'll see output similar to this:

    ```json
    (Output Example)
    {
      "fqdns": "",
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Compute/virtualMachines/MeanStack",
      "location": "eastus",
      "macAddress": "00-0D-3A-1E-1B-3B",
      "powerState": "VM running",
      "privateIpAddress": "10.0.0.5",
      "publicIpAddress": "104.211.9.245",
      "resourceGroup": "<rgn>[sandbox resource group name]</rgn>",
      "zones": ""
    }
    ```

    The VM's name is *MeanStack*. You'll use this name in future commands to identify the VM you want to work with.

1. Open port 80 on the VM to allow incoming HTTP traffic to the web application you'll later create.

    ```azurecli
    az vm open-port \
      --port 80 \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name MeanStack
    ```

1. Create an SSH connection to your VM.

    Although the output from the `az vm create` command displays your VM's public IP address, you may find it useful to store the address in a Bash variable.

    Start by running `az vm show`. This command saves the IP address in a Bash variable named `ipaddress`.

    ```azurecli
    ipaddress=$(az vm show \
      --name MeanStack \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --show-details \
      --query [publicIps] \
      --output tsv)
    ```

1. Connect to your VM like this.

    ```bash
    ssh azureuser@$ipaddress
    ```

    When prompted, enter **yes** to save the VM's identity locally so future connections are trusted.

    You'll use the SSH connection to configure software on the virtual machine in the next parts.

## Summary

With your Ubuntu VM ready to go, you're ready to install each component of the MEAN stack. You'll start by installing MongoDB.
