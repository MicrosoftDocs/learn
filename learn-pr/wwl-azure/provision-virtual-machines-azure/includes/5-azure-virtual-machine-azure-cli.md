
In this exercise you'll create a Linux virtual machine by performing the following operations using Azure CLI commands:

* Create a resource group and a virtual machine
* Install a web server
* View the web server in action
* Clean up resources

## Prerequisites

* An **Azure account** with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free).


## Login to Azure and start the Cloud Shell

1. Login to the [Azure portal](https://portal.azure.com) and open the Cloud Shell.

    :::image type="content" source="../media/cloud-shell-menu.png" alt-text="The location of Cloud Shell launch button.":::

1. After the shell opens be sure to select the **Bash** environment.

    :::image type="content" source="../media/shell-bash-selection.png" alt-text="Selecting the Bash environment.":::

## Create a resource group and virtual machine

1. Create a resource group with the `az group create` command. The command below creates a resource group named *az204-vm-rg*. Replace `<myLocation>` with a region near you.

    ```bash
    az group create --name az204-vm-rg --location <myLocation>
    ```

1. Create a VM with the `az vm create` command. The command below creates a Linux VM named *az204vm* with an admin user named *azureuser*.

    ```bash
    az vm create \
        --resource-group az204-vm-rg \
        --name az204vm \
        --image UbuntuLTS \
        --generate-ssh-keys \
        --admin-username azureuser \
        --public-ip-sku Standard
    ```
    
    It will take a few minutes for the operation to complete. When it is finished note the `publicIpAddress` in the output, you'll use it in the next step.
    
    > [!NOTE]
    > When creating VMs with the Azure CLI passwords need to be between 12-123 characters, have both uppercase and lowercase characters, a digit, and have a special character (`@`, `!`, etc.). Be sure to remember the password.

## Install a web server

1. By default, only SSH connections are opened when you create a Linux VM in Azure. Use `az vm open-port` to open TCP port 80 for use with the NGINX web server:

    ```bash
    az vm open-port --port 80 \
    --resource-group az204-vm-rg \
    --name az204vm
    ```

1. Connect to your VM by using SSH. Replace `<publicIPAddress>` in the example with the public IP address of your VM as noted in the previous output:

    ```bash
    ssh azureuser@<publicIPAddress>
    ```

1. To see your VM in action, install the NGINX web server. Update your package sources and then install the latest NGINX package.

    ```bash
    sudo apt-get -y update
    sudo apt-get -y install nginx
    ```

1. When done type `exit` to leave the SSH session.


## View the web server in action

Use a web browser of your choice to view the default NGINX welcome page. Use the public IP address of your VM as the web address. The following example shows the default NGINX web site:

:::image type="content" source="../media/view-nginx-welcome-page.png" alt-text="The default NGIX welcome page.":::


## Clean up Azure resources

You can now safely delete the *az204-vm-rg* resource group from your account by running the command below.

```bash
az group delete --name az204-vm-rg --no-wait
```
