[Hashicorp Terraform](https://www.terraform.io/) is an open-source tool for provisioning and managing cloud infrastructure. It codifies infrastructure in configuration files that describe the topology of cloud resources. These resources include virtual machines, storage accounts, and networking interfaces. The Terraform CLI provides a simple mechanism to deploy and version the configuration files to Azure. Understanding Terraform deployment, along with Azure Resource Manager templates and Ansible software install and configuration, assist you in adopting Infrastructure as Code (IaC) practices like those provided in the **SAP on Azure Deployment Automation Framework**. The [SAP on Azure Deployment Automation Framework](/azure/sap/automation/deployment-framework) contains tooling designed to enable automated deployment for SAP on Azure.

## Using Terraform

To follow along in this section, you need to sign in to the Azure CLI with an Azure subscription. The Terraform executable is integrated with Cloud Shell.

## Best practice: Authenticate via Azure service principal

> [!NOTE]
> Although the use of a service principal is not required for this lab running in the Azure Cloud Shell, it's a recommended security best practice when running CLI scripts.

Automated tools that deploy or use Azure services such as Terraform should always have restricted permissions. Instead of signing in to applications as a fully privileged user, Azure offers service principals. There are many options when [creating a service principal with the Azure CLI](/cli/azure/create-an-azure-service-principal-azure-cli). We use [az ad sp create-for-rbac](/cli/azure/ad/sp?#az-ad-sp-create-for-rbac) to create a service principal with a Contributor role. The Contributor role (the default) has full permissions to read and write to an Azure account.

## Terraform configuration files

Terraform HCL (HashiCorp Configuration Language) is designed to be readable.

:::image type="content" source="../media/example-azure-resource-manager-template-syntax-hcl-syntax.png" alt-text="Screenshot of Azure Resource Manager (ARM) Template Syntax vs HashiCorp Configuration Language (H C L) Syntax.":::

### Sample Terraform configuration file code to create an Azure Resource Group

The Terraform code is displayed in two parts that need to be combined in the *terraform_azure.tf* file you create. The code that follows defines the Azure Terraform provider.

```hcl
# 1-Define Terraform Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}
```

The following section creates a resource group named `myTerraformResourceGroup` in the `eastus` location.

```hcl
# 2-Create Resource Group
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "myTerraformResourceGroup"
    location = "eastus"

    tags = {
        environment = "Terraform Demo"
    }
}
```

In other sections, you reference the resource group with `azurerm_resource_group.myterraformgroup.name`.

## Use Terraform in the Azure Cloud Shell to deploy an Azure Resource Group

Next, you go through steps to deploy a resource group using Terraform in the Azure Cloud Shell. When the resource group deployment is completed, you can optionally follow steps to deploy a Linux Virtual Machine.

### Configure Terraform in the Azure Cloud Shell

1. Open The Azure Cloud Shell.

    :::image type="content" source="../media/shell-icon.png" alt-text="Screenshot of the icon that opens the  Azure Cloud Shell.":::

    Choose Bash to run your Azure CLI and Terraform commands.

1. Create a folder for using Terraform called *try_terraform* with the following bash command.

    ```dotnetcli
    mkdir try_terraform
    ```

1. Navigate to the try_terraform directory and create a file called *terraform_azure.tf* with the following commands.

    ```dotnetcli
    cd try_terraform
    touch terraform_azure.tf
    ```

1. Open the Azure Cloud Shell *editor* selecting the icon at the top of the Azure Cloud Shell or optionally run the `code.` command in the Cloud Shell.

    :::image type="content" source="../media/azure-cloud-shell-editor.png" alt-text="Screenshot of the Azure Cloud Shell editor icon that opens the Azure Cloud Shell.":::

1. In the Azure Cloud Shell editor, expand the *try_terraform* directory and select the file terraform_azure.tf.

1. Copy the [previous Terraform code](#sample-terraform-configuration-file-code-to-create-an-azure-resource-group) that starts with the comment **`# 1-Define Terraform Provider`** and paste it into the Cloud Shell editor in the terraform_azure.tf file. Save the file (Ctrl+S).

1. Now copy the [previous Terraform code](#sample-terraform-configuration-file-code-to-create-an-azure-resource-group) that starts with the comment **`# 2-Create Resource Group`** and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

### Create and apply a Terraform execution plan

In this section, you learn how to create an execution plan and apply it to your cloud infrastructure.

:::image type="content" source="../media/basic-terraform-commands.png" alt-text="Diagram emphasizing basic Terraform commands for: Init (initialize), Plan, Apply, Destroy.":::

With your Terraform template created, the next steps are:

- `terraform init` - initialize Terraform to ensure all the prerequisites to build
- `terraform plan` - review and validate the template
- `terraform apply` - apply the plan and deploy to Azure
- `terraform plan -destroy` and `terraform apply -destroy` - remove the plan deployment from Azure

### Init: Initialize the working folder

To initialize the Terraform deployment, run [terraform init](https://www.terraform.io/docs/commands/init.html) from the working directory containing Terraform configuration files. This command downloads the Azure modules required to create an Azure resource group.

Return to the Cloud Shell. It's OK to close Cloud Shell Editor to get more space for the Cloud Shell (**Ctrl+Q**). To initialize the directory for Terraform enter the following command.

```cmd
    terraform init
```

### Plan: preflight validation

After initialization, you create an execution plan by running [terraform plan](https://www.terraform.io/docs/commands/plan.html). We choose the simple file name `terraform_plan`, any name can be used. Run the following command.

```cmd
    terraform plan -out terraform_plan.tfplan
```

- The `terraform plan` command creates an execution plan but doesn't execute it. Instead, it determines what actions are necessary to create the configuration specified in your configuration files. This pattern allows you to verify whether the execution plan matches your expectations before making any changes to actual resources.
- The optional `-out` parameter allows you to specify an output file for the plan. Using the `-out` parameter ensures that the plan you reviewed is exactly what is applied.
- To read more about persisting execution plans and security, see the [security warning section](https://www.terraform.io/docs/commands/plan.html#security-warning).

### Apply: Deploy

Once you're ready to apply the execution plan to your cloud infrastructure, run [terraform apply](https://www.terraform.io/docs/commands/apply.html).

```cmd
    terraform apply terraform_plan.tfplan
```

The Azure resource group is deployed. After a few minutes, navigate in Azure to resource groups and find the *try_terraform* resource group

### Destroy: Reverse a Terraform execution plan

To continue deploying a Linux Virtual Machine along with a network skip this section and continue to the section [Use Terraform to deploy Linux Virtual Machines in Azure](#use-terraform-to-deploy-linux-virtual-machines-in-azure).

**To delete the Azure Resource Group**, *myTerraformResourceGroup*, use the following steps.

1. To reverse, or undo, the execution plan, you run [terraform plan](https://www.terraform.io/docs/commands/plan.html) and specify the `destroy` flag as follows:

    ```cmd
    terraform plan -destroy -out terraform_plan.destroy.tfplan
    ```

2. Run [terraform apply](https://www.terraform.io/docs/commands/apply.html) to apply the execution plan reversal.

    ```cmd
    terraform apply terraform_plan.destroy.tfplan
    ```

## Use Terraform to deploy Linux Virtual Machines in Azure

1. Open the Azure Cloud Shell *editor* selecting the icon at the top of the Azure Cloud Shell or optionally run the `code.` command in the Cloud Shell.

1. In the Azure Cloud Shell editor, expand the *try_terraform* directory and select the file terraform_azure.tf.

1. Add the Terraform code to the file terraform_azure.tf as instructed in the following sections. 

### Create virtual network

The following code creates a virtual network named `myVnet` in the `10.0.0.0/16` address space. 

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 3-Create Virtual Network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    tags = {
        environment = "Terraform Demo"
    }
}
```

The following section creates a subnet named `mySubnet` in the `myVnet` virtual network.

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 4-Create SubNet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "mySubnet"
    resource_group_name  = azurerm_resource_group.myterraformgroup.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = ["10.0.2.0/24"]
}
```

### Create public IP address

To access resources across the Internet, create and assign a public IP address to your VM. The following code creates a public IP address named `myPublicIP`.

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 5-Create Public IP for VM
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.myterraformgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Terraform Demo"
    }
}
```

### Create Network Security Group

Network Security Groups control the flow of network traffic in and out of your VM. The following code creates a network security group named `myNetworkSecurityGroup` and defines a rule to allow SSH traffic on TCP port 22.

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 6-Create NSG
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
    location            = "eastus"
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}
```

### Create virtual network interface card

A virtual network interface card (NIC) connects your VM to a given virtual network, public IP address, and network security group. The following code in a Terraform template creates a virtual NIC named `myNIC` connected to the virtual networking resources that you created.

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 7-Create VNet Interface Card
resource "azurerm_network_interface" "myterraformnic" {
    name                        = "myNIC"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.myterraformgroup.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}
```

### Create storage account for diagnostics

To store boot diagnostics for a VM, you need a storage account. These boot diagnostics can help you troubleshoot problems and monitor the status of your VM. The storage account you create is only to store the boot diagnostics data. As each storage account must have a unique name, the following code generates some random text.

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 8-Create Storage for Boot Diagnostics
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.myterraformgroup.name
    }

    byte_length = 8
}
```

Now you can create a storage account. The following section creates a storage account, with the name based on the random text generated in the preceding step.

Review the code that follows and copy and paste it into the Cloud Shell editor following the previously added code in the terraform_azure.tf file. Save the file (**Ctrl+S**).

```hcl
# 9-Create Storage Account
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.myterraformgroup.name
    location                    = "eastus"
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        environment = "Terraform Demo"
    }
}
```

### Create virtual machine

The final step is to create a VM and use all the resources created. The following code creates a VM named `myVM` and attaches the virtual NIC named `myNIC`. The latest `Ubuntu 18.04-LTS` image is used, and a user named `azureuser` is created with password authentication disabled.

> [!NOTE]
> The SSH public key file is specified in the `admin_ssh_key` block and will be generated for you. If your SSH public key filename is different or in a different location, update the `public_key` value as needed.

```hcl
# 10-Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { 
    value = tls_private_key.example_ssh.private_key_pem 
    sensitive = true
}

# 11-Create Virtual Linux Machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "myVM"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = file("~/.ssh/id_rsa.pub")
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Terraform Demo"
    }
}
```

To see Terraform in action using the commands introduced in the next section, create a file called *terraform_azure.tf* and paste the Terraform code sections into it. Save the file in a directory with no `.tf` files at or below the file path.

> [!IMPORTANT]
> The SSH public key file is specified in the `admin_ssh_key` block. If your SSH public key filename is different or in a different location, update the `public_key` value accordingly.

### Create and apply a Terraform execution plan

With your Terraform template created, in this section, you repeat the steps to create an execution plan and apply it to your cloud infrastructure. If the resource group ** created previously still exists, running steps below still work and won't recreate the resource group because Terraform is idempotent.

- `terraform init` - initialize Terraform to ensure all the prerequisites to build
- `terraform plan` - review and validate the template
- `terraform apply` - apply the plan and deploy to Azure
- `terraform plan -destroy` and `terraform apply -destroy` - remove the plan deployment from Azure

### Init

To initialize the Terraform deployment, run [terraform init](https://www.terraform.io/docs/commands/init.html) from the working directory containing Terraform configuration files. This step can be skipped if you completed the step to deploy the resource group.

```cmd
    terraform init
```

### Plan

After initialization, you create an execution plan by running [terraform plan](https://www.terraform.io/docs/commands/plan.html).

```cmd
    terraform plan -out terraform_plan.tfplan
```

### Apply

Once you're ready to apply the execution plan to your cloud infrastructure, run [terraform apply](https://www.terraform.io/docs/commands/apply.html).

```cmd
    terraform apply terraform_plan.tfplan
```

### Destroy: Reverse a Terraform execution plan

1. To reverse, or undo, the execution plan, you run [terraform plan](https://www.terraform.io/docs/commands/plan.html) and specify the `destroy` flag as follows:

    ```cmd
    terraform plan -destroy -out terraform_plan.destroy.tfplan
    ```

2. Run [terraform apply](https://www.terraform.io/docs/commands/apply.html) to apply the execution plan reversal.

    ```cmd
    terraform apply terraform_plan.destroy.tfplan
    ```
