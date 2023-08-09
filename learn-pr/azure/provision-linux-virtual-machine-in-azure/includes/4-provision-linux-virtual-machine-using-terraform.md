Terraform implements and controls a target infrastructure by using configuration files that describe the desired state of its components. The basic format of the files and their general syntax&mdash;expressed in the Hashicorp Configuration Language (HCL)&mdash;are the same regardless of the cloud choice. However, individual component descriptions are cloud-dependent, as determined by the corresponding Terraform provider.

Although there are several Terraform providers that support Azure infrastructure management, AzureRM is of particular relevance. The AzureRM provider facilitates provisioning and configuration of common Azure IaaS resources, such as virtual machines, storage accounts, and networking interfaces. There are also additional non-cloud-specific providers that you might want to incorporate into your deployments. These include the random provider, which helps with avoiding resource naming conflicts by generating pseudo-random character strings, and the tls provider that simplifies management of asymmetric keys for securing Linux authentication.

Terraform is available as a single binary downloadable from the [Hashicorp website](https://developer.hashicorp.com/terraform/downloads). This binary implements the Terraform command-line interface (CLI), which you can then invoke from a shell session to initialize Terraform and process configuration files. You can use Terraform CLI from any of the shells that support Azure CLI.

> [!NOTE]
> 
> When using Azure Cloud Shell, make sure you run the current version of Terraform by following the instructions provided in the Microsoft Learn article [Configure Terraform in Azure Cloud Shell with Bash](/azure/developer/terraform/get-started-cloud-shell-bash).

## Deploy a Linux VM by using Terraform

Terraform offers the ability to define, preview, and deploy resources to a provider-specific cloud infrastructure. The provisioning process begins with creating configuration files that use the HCL syntax, which enables you to designate the target cloud environment&mdash;such as Azure&mdash;and the resources that make up your cloud infrastructure. After all relevant configuration files are in place (typically within the same file system location), you can generate an execution plan that allows you to preview the resulting infrastructure changes before the actual deployment. This requires you to initialize Terraform to download the provider modules necessary to implement cloud resources. After you validate the changes, you apply the execution plan to deploy the infrastructure.

> [!NOTE]
> 
> Generating an execution plan is optional, but we recommend you do so because it enables you to identify any impact from the planned deployment without affecting the target environment. When you deploy Azure resources interactively, Terraform supports Azure CLI authentication transparently by reusing your credentials to access the target Azure subscription.

The process of provisioning an Azure VM running Linux by using Terraform typically involves the following sequence of high-level steps:

- Identify the suitable VM image.
- Identify the suitable VM size.
- Create configuration files that define the Azure VM resource with its dependencies.
- Initialize Terraform.
- Generate a Terraform execution plan.
- Initiate a Terraform deployment.

To identify the suitable VM image and size, follow the steps described in Unit 4 of this module. This unit focuses on Terraform-specific tasks.

### Create configuration files

> [!NOTE]
> 
> The filenames that you choose for your Terraform files are arbitrary, although it's a good practice to choose a name that reflects the file content or purpose, and you should use ".tf" for the file extension.

To deploy a Linux VM by using Terraform, you begin by creating a directory that will host configuration files. Next, create a file named _providers.tf_ that enforces the Terraform version and designates the providers you'll rely on when defining the resources included in your deployment. This file should have the content displayed in the following code snippet:

```terraform
terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```

In the same directory, create a file named _main.tf_ using the following code, which defines the Azure VM configuration and its dependencies:

```terraform
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

# Create virtual network
resource "azurerm_virtual_network" "terraform_network" {
  name                = "lnx-tf-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "terraform_subnet" {
  name                 = "subnet0"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.terraform_network.name
  address_prefixes     = ["10.1.0.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "terraform_public_ip" {
  name                = "lnx-tf-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "terraform_nsg" {
  name                = "lnx-tf-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "ssh"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "terraform_nic" {
  name                = "lnx-tf-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic_configuration"
    subnet_id                     = azurerm_subnet.terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terraform_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "lnx-tf-nic-nsg" {
  network_interface_id      = azurerm_network_interface.terraform_nic.id
  network_security_group_id = azurerm_network_security_group.terraform_nsg.id
}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "lnx-tf-ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "lnx-tf-vm" {
  name                  = "lnx-tf-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.terraform_nic.id]
  size                  = "Standard_F4s"

  os_disk {
    name                 = "lnx-tf-vm-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "lnx-tf-vm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.lnx-tf-ssh.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
  }
}
```

In the same directory, create another file named _variables.tf_ using the following code, that assigns the value to the variables appearing in the _main.tf_ file:

```terraform
variable "resource_group_location" {
  default     = "eastus"
  description = "Location of the resource group"
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription"
}
```

Lastly, create a file named _outputs.tf_ using the following code, which determines the output that displays following a successful deployment:

```terraform
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.lnx-tf-vm.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.lnx-tf-ssh.private_key_pem
  sensitive = true
}
```

### Initialize Terraform

To initialize the Terraform deployment, from the shell prompt, run the following command:

```bash
terraform init
```

This command downloads the Azure modules necessary to provision and manage Azure resources.

### Generate an execution plan

After initialization, create an execution plan by running terraform plan. The command creates an execution plan, but doesn't run it. Instead, it determines what actions are necessary to create the resources defined in your configuration files. The optional -out parameter allows you to specify an output file for the plan, which you can reference during the actual deployment. Using this file ensures that the plan you review matches the exact deployment outcome. Use the following command to generate an execution plan:

```bash
terraform plan -out <terraform_plan>.tfplan
```

### Initiate a deployment

When you're ready to apply the execution plan to your Azure environment, run terraform apply, including the name of the file you generated in the previous step. You'll have another chance to review the expected outcome. Terraform will prompt you for confirmation to proceed, although you can eliminate the prompt by adding the -auto-approve switch. Use the following command to initiate the deployment:

```bash
terraform apply <terraform_plan>.tfplan
```

The Azure VM will shortly begin running, typically within a couple of minutes. The terraform apply command output will include the list of outputs, but terraform will replace the value of tls_private_key with the \<sensitive> label:

```output
Apply complete! Resources: 12 added, 0 changed, 0 destroyed.
```

Outputs:

```output
public_ip_address = "74.235.10.136"
resource_group_name = "rg-flexible-shark"
tls_private_key = <sensitive>
```

To use the autogenerated private key for authenticating your SSH connection, store it in a file and then set the file's permissions to ensure it's not accessible by others. To accomplish this, run the following commands:

```output
terraform output -raw tls_private_key > id_rsa
chmod 600 id_rsa
```

At this point, you'll be able to connect to the Azure VM by running the following command (after replacing the \<public_ip_address> placeholder with the IP address you identified in the terraform apply-generated output):

```output
ssh -i id_rsa azureuser@<public_ip_address>
```
