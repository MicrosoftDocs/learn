You download Terraform for use in Azure via Azure Marketplace, Terraform Marketplace, or Azure VMs.

## Azure Marketplace

Azure Marketplace offers a fully configured Linux image containing Terraform with the following characteristics:

 -  The deployment template will install Terraform on a Linux (Ubuntu 16.04 LTS) VM and tools configured to work with Azure. Items downloaded include:
    
     -  Terraform (latest)
     -  Azure CLI 2.0
     -  Managed Service Identity (MSI) VM extension
     -  Unzip
     -  Jq
     -  apt-transport-https
 -  This image also configures a remote back-end to enable remote state management using Terraform.

## Terraform Marketplace

The Terraform Marketplace image makes it easy to get started using Terraform on Azure without installing and configuring Terraform manually. There are no software charges for this Terraform VM image. You pay only the Azure hardware usage fees that are assessed based on the size of the VM that's provisioned.

## Azure VMs

You can also deploy a Linux or Windows VM in Azure VM's IaaS service, install Terraform and the relevant components, and then use that image.
