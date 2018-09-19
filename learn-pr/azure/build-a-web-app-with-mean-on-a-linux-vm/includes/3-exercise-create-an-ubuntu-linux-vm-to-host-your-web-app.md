The MEAN stack of components requires a server. It could be a Linux machine or virtual machine running in your own server room, or it can be configured on a cloud-based virtual machine. In this module, we will set up the stack to run on an Ubuntu Linux virtual machine running on Azure.

In this unit, you will be creating a new Ubuntu Linux virtual machine hosted on Azure. You could also install your MEAN stack components on an existing virtual machine or physical host machine. By creating a new one with this exercise, you can tie together all the components into an Azure resource group for easier management and clean-up after you complete the exercises.

## Provision an Ubuntu Linux VM

[!include[](../../../includes/azure-sandbox-activate.md)]

### Creating a resource group

Normally, the first thing you'll do when creating a new set of resources is create a _resource group_ to own them all. This is an unnecessary step in the Azure Sandbox, but when you are working in your own subscription use the following command to create a resource group in a location near you.

```azurecli
az group create --name <resource-group-name> --location <resource-group-location>
```

> [!IMPORTANT]
> You do not need to create a resource group with the Azure Sandbox. Instead use the pre-created resource group named **<rgn>[Sandbox Resource Group]</rgn>**.

1. In the Cloud Shell on the right, type the following command to create a new Ubuntu Linux VM. Substitute your preferred admin username and password for `<vm-admin-username>` and `<vm-admin-password>`.

    ```azurecli
    az vm create \
        --resource-group <rgn>[Sandbox resource group name]</rgn> \
        --name MeanDemo \
        --image UbuntuLTS \
        --admin-username <vm-admin-username> \
        --admin-password <vm-admin-password> \
        --generate-ssh-keys
    ```

    Take note of your admin username and password to allow you to connect to this VM later.

    This command takes about two minutes to complete. When the command finishes, the resulting output will look similar to this.

    ```json
    {
        "fqdns": "",
        "id": "...",
        "location": "<resource group location>",
        "macAddress": "00-0D-3A-3A-54-EC",
        "powerState": "VM running",
        "privateIpAddress": "10.0.0.4",
        "publicIpAddress": "<the public IP address of the newly created machine>",
        "resourceGroup": "<rgn>[Sandbox resource group name]</rgn>",
        "zones": ""
    }
    ```

    You will also want to save the public IP address of the newly created VM in order to connect to the VM.

1. Try connecting to your new VM.

    From the Cloud Shell, run the following command. Substitute your admin username and your VM's public IP address from above for the `<vm-admin-username>` and `<vm-public-ip>` placeholders.

    ```bash
    ssh <vm-admin-username>@<vm-public-ip>
    ```

    The first time you connect to the machine, you'll be asked if you trust the remote machine. By answering `yes`, the machine's ECDSA key fingerprint will be saved locally, so subsequent connections will be trusted. You'll then be prompted for your password, which you'll see every time you connect.

    If everything looks fine, type `exit` to close the SSH session.

1. Open port 80 on the VM to allow incoming HTTP traffic to the new web application that you will create.

    ``` bash
    az vm open-port --port 80 --resource-group <rgn>[Sandbox resource group name]</rgn> --name MeanDemo
    ```

    This command will open up the HTTP port on your VM that was named "MeanDemo" when it was created.

## Summary

With your new Ubuntu Linux VM ready to go, we can now connect to it to start installing the various components of the MEAN stack.