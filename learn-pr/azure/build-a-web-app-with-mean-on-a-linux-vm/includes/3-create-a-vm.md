Like most application frameworks, you can run your MEAN stack application in many different environments. You can run your application on a physical computer in your server room, on a virtual machine, or in containers.

Here you run your application on a virtual machine (VM) running on Azure. MEAN supports many different operating systems. For learning purposes, we use Ubuntu Linux here.

[!INCLUDE[](../../../includes/azure-optional-exercise-subscription-note.md)]

[!INCLUDE[](../../../includes/azure-optional-exercise-create-resource-group-note.md)]

## Create an Ubuntu Linux VM

Normally, you create a *resource group* before you create other resources on Azure. A resource group is a container that holds the resources that are related for an Azure solution. If you haven't already created a resource group, you can run the following command to create a resource group in a location near you.

```azurecli
az group create \
  --name <resource-group-name> \
  --location <resource-group-location>
```

1. Open the [Azure Cloud Shell](https://shell.azure.com/), then select **Settings** > **Go to Classic version**.

1. From Cloud Shell, run the `az vm create` command to create an Ubuntu VM. Replace **myResourceGroupName** in the following example with the name of an existing resource group, or the name of the resource group that you created for this exercise.

    ```azurecli
    az vm create \
      --resource-group "myResourceGroupName" \
      --name MeanStack \
      --image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

    The command takes about two minutes to complete. When the command finishes, you see output similar to this example:

    ```json
    (Output Example)
    {
      "fqdns": "",
      "id": "/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/myResourceGroupName/providers/Microsoft.Compute/virtualMachines/MeanStack",
      "location": "eastus",
      "macAddress": "00-0D-3A-1E-1B-3B",
      "powerState": "VM running",
      "privateIpAddress": "10.0.0.5",
      "publicIpAddress": "104.211.9.245",
      "resourceGroup": "myResourceGroupName",
      "zones": ""
    }
    ```

    The VM's name is *MeanStack*. You'll use this name in future commands to identify the VM you want to work with.

1. Open port 80 on the VM to allow incoming HTTP traffic to the web application that you create later.

    ```azurecli
    az vm open-port \
      --port 80 \
      --resource-group "myResourceGroupName" \
      --name MeanStack
    ```

1. Create an SSH connection to your VM.

    Although the output from the `az vm create` command displays your VM's public IP address, you might find it useful to store the address in a Bash variable.

    Start by running `az vm show`. This command saves the IP address in a Bash variable named `ipaddress`.

    ```azurecli
    ipaddress=$(az vm show \
      --name MeanStack \
      --resource-group "myResourceGroupName" \
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

With your Ubuntu VM ready to go, you're ready to install each component of the MEAN stack. You start by installing MongoDB.
