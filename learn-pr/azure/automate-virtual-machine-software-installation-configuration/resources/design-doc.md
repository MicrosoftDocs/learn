# Design Document

## Title

Automate the installation and configuration of software in your Azure Virtual Machines

## Role(s)

- Administrator
- Solution Architect

## Level

- Beginner

## Product(s)

- Azure
- Azure Virtual Machines
- Azure CLI

## Prerequisites

- Basic understanding of Azure Virtual Machines

## Summary

Learn how to use the cross-platform Azure CLI to create a virtual machine in Azure, and use a custom script to install and configure a web server. Automate the installation of PHP and the creation of a dynamic home page, then use a web browser to test your installation.

NOTE: This module should use pivots to allow learners to choose whether to create a Linux VM with Apache/NGNIX or Windows with IIS.

## Learning objectives

  - Automate the creation of a Windows or Linux virtual machine
  - Automate the installation and configuration of web server software on your virtual machine
  - Connect to your virtual machine using a web browser to verify your installation

## Chunk your content into subtasks

Identify the subtasks of *Automate the installation and configuration of software in your Azure Virtual Machines*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|---|---|---|---|---|
| Automate the creation of a virtual machine | TBD | Exercise | 1 | Yes |
| Automate the installation of a web server | TBD | Exercise | 2 | Yes |
| Automate the installation of PHP | TBD | Exercise | 2 | Yes |
| Automate the installation of creation of a dynamic home page | TBD | Exercise | 2 | Yes |
| Manually verify the web server by browsing | TBD | Exercise | 3 | Yes |

## Outline the units

1. **Introduction**

    You work in the Operations team of an Internet Service Provider. You are responsible for managing the Windows and Linux virtual machines. Your current process for provisioning virtual machines is to create them. Once created you remotely install the missing software, and configure it manually. You'd like to be more productive and automate how your company builds web servers, so they can run dynamic PHP websites as soon as they have been provisioned.

1. **Automate the installation of a virtual machine**

    - Explain all the components needed to host a fully configured VM on Azure: Resource Group, VNet, Public IP Address, NSG, and NIC

    - PIVOT 1 - Automate the creation of a Linux virtual machine
        - Explain the `az vm create` options for Linux machines
        - Show the different Linux distros that can be used
        - Discuss the authentication options, creating shared ssh keys vs username and password

    - PIVOT 2 - Automate the creation of a Windows virtual machine
        - Explain the `az vm create` options for Windows machines
        - Show the different Windows distros that can be used
        - Discuss the Azure Hybrid Benefit license

    - Explain that all the above steps created the whole machine and components with Azure templates and redeployed using a single command `az deployment group create`

1. **Exercise - Automate the installation of a virtual machine**

    - PIVOT 1 - Automate the creation of a Linux virtual machine
        - Use the Cloud Shell to create a fully configured Ubuntu VM with a shared SSH key (Resource Group, VNet, Public IP Address, NSG, and NIC)
        - az vm create --resource-group myResourceGroup --name linuxVM --location eastus --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
        - Connect with `ssh` check what's running

    - PIVOT 2 - Automate the creation of a Windows virtual machine 
        - Use the Cloud Shell to create a fully configured Windows VM (Resource Group, VNet, Public IP Address, NSG, and NIC)
        - az vm create --resource-group myResourceGroup --name linuxVM --location eastus --image Ubuntu2204 --admin-username azureuser --generate-ssh-keys
        - Open port 80 for RDP connections and use `mstsc /v:publicIpAddress` check what's running

1. **Automate the configuration of a web server**

    List the content that will enable the learner to automate the configuration of a web server:

    - PIVOT 1 - Linux virtual machine
        - Describe the options for automating the configuration of Linux machines
            - cloud-init <- this will be the chosen method for the rest of the module
            - Azure Custom Script Extensions
                - DSCForLinux
                - CustomScript
        - Automate the installation and configuration of an NGINX web server
            - Using Cloud-init, adding nginx package, setting up sites-available using write_files
        - Automate the installation and configuration of PHP
            - Using Cloud-init, adding php7.2 and php7.2-fpm package, setting up NGINX to process PHP files with `fastcgi_pass    unix:/run/php/php7.2-fpm.sock;` using write_files
        - Automate the installation of creation of a dynamic home page
            - Using Cloud-init, create a PHP page using write_files, setup NGINX to return the php files as the default site

    - PIVOT 2 - Windows virtual machine
        - Describe the options for automating the configuration of Windows machines
            - Azure Custom Script Extensions
                - CustomScriptExtension
                - DSC
        - Automate the installation and configuration of an IIS web server
            - Using az vm extension set --publisher Microsoft.Compute --version 1.8 --name CustomScriptExtension --vm-name windowsVM --resource-group myResourceGroup --settings '{"commandToExecute":"powershell.exe Install-WindowsFeature -Name Web-Server"}'
        - Automate the installation and configuration of PHP
            - Using a custom PowerShell script to install and configure PHP
        - Automate the installation of creation of a dynamic home page
            - Using a custom PowerShell script to create the php file

1. **Exercise - Automate the configuration of a web server**

    List the steps which apply the learning content from previous unit:

    - See steps at the bottom of the design

    - PIVOT 1 - Linux virtual machine
        - Automate the installation and configuration of an Apache/NGINX web server
        - Automate the installation and configuration of PHP
        - Automate the installation of creation of a dynamic home page

    - PIVOT 2 - Windows virtual machine
        - Automate the installation and configuration of an IIS web server
        - Automate the installation and configuration of PHP
        - Automate the installation of creation of a dynamic home page

    - Verify the web server by browsing to the home page

1. **Summary**

    - Restate the scenario problem(s)
    - Show how the learner solved the scenario problem(s)
    - Describe the experience without the product
    - Describe the business impact

## Notes

- [Windows virtual machines in Azure](/azure/virtual-machines/windows/)
- [Tutorial - Deploy applications to a Windows virtual machine in Azure with the Custom Script Extension](/azure/virtual-machines/windows/tutorial-automate-vm-deployment)
- [Tutorial - How to use cloud-init to customize a Linux virtual machine in Azure on first boot](/azure/virtual-machines/linux/tutorial-automate-vm-deployment)
- [Cloud-init support for virtual machines in Azure](/azure/virtual-machines/linux/using-cloud-init)
- [Create a Linux virtual machine in Azure](/training/modules/create-linux-virtual-machine-in-azure/)
- [Create a Windows virtual machine in Azure](/training/modules/create-windows-virtual-machine-in-azure/)
- [Manage virtual machines with the Azure CLI](/training/modules/manage-virtual-machines-with-azure-cli/)
- [Use the Azure Custom Script Extension Version 2 with Linux virtual machines](/azure/virtual-machines/extensions/custom-script-linux#azure-cli)

### Steps for both machines

az network vnet create \
    --name vmsVnet \
    --address-prefix 192.168.0.0/16 \
    --subnet-name vmsSubnet \
    --subnet-prefix 192.168.1.0/24 \
    --resource-group vmsVM  

az network public-ip create \
    --name vmsPublicIP \
    --dns-name vmspublicdns \
    --resource-group vmsVM

az network nsg create \
    --name vmsNetworkSecurityGroup \
    --resource-group vmsVM

az network nsg rule create \
    --nsg-name vmsNetworkSecurityGroup \
    --name vmsNetworkSecurityGroupRuleSSH \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow \
    --resource-group vmsVM

az network nsg rule create \
    --nsg-name vmsNetworkSecurityGroup \
    --name vmsNetworkSecurityGroupRuleWeb \
    --protocol tcp \
    --priority 1001 \
    --destination-port-range 80 \
    --access allow \
    --resource-group vmsVM

az network nic create \
    --name vmsNic \
    --vnet-name vmsVnet \
    --subnet vmsSubnet \
    --public-ip-address vmsPublicIP \
    --network-security-group vmsNetworkSecurityGroup \
    --resource-group vmsVM

az vm availability-set create \
    --name vmsAvailabilitySet \
    --platform-fault-domain-count 3 \
    --platform-update-domain-count 3 \
    --resource-group vmsVM

### Steps for Linux machine

az vm create \
    --name linuxVM \
    --availability-set vmsAvailabilitySet \
    --nics vmsNic \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --generate-ssh-keys \
    --custom-data cloud_init.txt \
    --resource-group vmsVM

### Steps for Windows machine

export SECUREPASSWORD=$(date +%s | sha256sum | base64 | head -c 32)
echo $SECUREPASSWORD

az vm create \
    --name windowsVM \
    --image Win2019Datacenter \
    --availability-set vmsAvailabilitySet \
    --nics vmsNic \
    --admin-username azureuser \
    --admin-password $SECUREPASSWORD \
    --resource-group vmsVM

... will set up the rest with a PowerShell setup.ps1 script run with CustomscriptExtension

az vm extension set \
   --name CustomscriptExtension \
   --publisher Microsoft.compute \
   --vm-name windowsVM \
   --resource-group vmsVM \
   --settings '{ "fileUris": ["https://raw.githubusercontent.com/PhilStollery/windows-vm-php-setup/master/setup.ps1"], "commandToExecute": "powershell.exe ./setup.ps1" }'
