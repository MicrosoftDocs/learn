In this exercise, you configure network access to a virtual machine (VM) running on Azure.

You start by creating a Linux VM and installing Nginx, a popular web server, on that VM. To make your web server accessible, you then create a network security group (NSG) rule that allows inbound access on port 80 (HTTP).

There are many ways to create and manage VMs, including their network settings. For example, you can use the Azure portal, the Azure CLI, Azure PowerShell, or an Azure Resource Manager (ARM) template.

Here, you use the Azure CLI. The Azure CLI enables you to connect to Azure and run administrative commands on Azure resources. As with other command-line interfaces, you can run commands directly from a terminal or you can add commands to a Bash script or a PowerShell script. The Azure CLI runs on Windows, macOS, or Linux.

Here, you access the Azure CLI from Azure Cloud Shell. Cloud Shell is a browser-based shell experience that you use to manage and develop Azure resources. Think of Cloud Shell as an interactive console that runs in the cloud.

If you're new to the Azure CLI or to Cloud Shell, just follow along.

## Create a Linux virtual machine and install Nginx

Use the following Azure CLI commands to create a Linux VM and install Nginx. After your VM is created, you'll use the Custom Script Extension to install Nginx. The Custom Script Extension is an easy way to download and run scripts on your Azure VMs. It's just one of the many ways you can configure the system after your VM is up and running.

1.  From Cloud Shell, run the following `az vm create` command to create a Linux VM:
    
    ```azurecli
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name my-vm \
      --image UbuntuLTS \
      --admin-username azureuser \
      --generate-ssh-keys
    
    ```
    
    Your VM will take a few moments to come up. You name the VM **my-vm**. You use this name to refer to the VM in later steps.
2.  Run the following `az vm extension set` command to configure Nginx on your VM:
    
    ```azurecli
    az vm extension set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --vm-name my-vm \
      --name customScript \
      --publisher Microsoft.Azure.Extensions \
      --version 2.1 \
      --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
      --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
    
    ```
    
    This command uses the Custom Script Extension to run a Bash script on your VM. The script is stored on GitHub. While the command runs, you can choose to [examine the Bash script](https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh?azure-portal=true) from a separate browser tab. To summarize, the script:
    1.  Runs `apt-get update` to download the latest package information from the internet. This step helps ensure that the next command can locate the latest version of the Nginx package.
    2.  Installs Nginx.
    3.  Sets the home page, */var/www/html/index.html*, to print a welcome message that includes your VM's host name.

Nice work. In practice, you can create a standalone network security group that includes the inbound and outbound network access rules you need. If you have multiple VMs that serve the same purpose, you can assign that NSG to each VM at the time you create it. This technique enables you to control network access to multiple VMs under a single, central set of rules.

## Continue

That's all for this exercise. The sandbox will keep running, and you'll come back to this point in a few topics to make the website accessible.

## 
