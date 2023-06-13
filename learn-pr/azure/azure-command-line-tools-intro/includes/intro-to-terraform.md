The Terraform open-source IaC tool enables you
to define and provision cloud infrastructure by using a high-level configuration language known as
HashiCorp Configuration Language (HCL). Terraform codifies infrastructure in configuration files
that describe the desired state for your infrastructure. Terraform can manage any infrastructure--such
as public clouds, private clouds, and SaaS services--by using Terraform providers.

## Terraform providers for Azure infrastructure

Several Terraform providers enable the management of Azure infrastructure:

- **AzureRM**: Manage Azure Resource Manager resources such as virtual machines, storage accounts, and network
  interfaces.
- **AzureAD**: Manage Azure Active Directory resources such as groups, users, service principals, and
  applications.
- **AzureDevOps**: Manage Azure DevOps resources such as agents, repositories, projects, pipelines, and
  queries.
- **AzAPI**: Manage Azure resources by using the Azure Resource Manager APIs directly. This provider
  complements the AzureRM provider by enabling the management of the newest Azure resources.
- **Azure Stack**: Manage Azure Stack resources such as virtual machines, DNS, virtual networks, and storage.

## Create a storage account

All Terraform configurations must contain a `provider` block. The following HCL code specifies the Azure
Resource Manager provider (`azurerm`). An Azure resource group named
`storageaccountexamplerg` is defined in the `eastus` location. An Azure storage account
is created within the resource group. The storage account name is the first 24 characters of a
number generated via the `md5` function.

```hcl
terraform {
  required_version = ">=0.12"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = "eastus"
  name     = "storageaccountexamplerg"
}

resource "azurerm_storage_account" "example" {
  name                     = substr(md5(azurerm_resource_group.rg.id), 0, 24)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Hot"
}
```

## Run the Terraform code

Run `terraform init` to download the required Azure modules for managing your Azure resources:

```console
terraform init
```

Run `terraform plan` to determine what actions are necessary to create the configuration that you specified in your configuration files. Running the command creates an execution plan but doesn't apply it. This pattern
allows you to verify if the execution plan matches your expectations before you make any changes to
actual resources.

```console
terraform plan -out main.tfplan
```

After you verify the execution plan, run `terraform apply` to apply the plan. This command creates the
defined resources.

```console
terraform apply main.tfplan
```

## Verify the storage account

To verify the Azure storage account, you can use the `terraform state show` command. This command
shows the current state of the specified resource.

In the case of the storage account that you created in this module, the command shows the generated name, along with a complete list of storage account attributes and their values.

```console
terraform state show 'azurerm_storage_account.example'
```

## Clean up resources

When you no longer need the resources that you created in this module, run `terraform apply` with the
`-destroy` flag:

```console
terraform plan -destroy -out main.destroy.tfplan
```

Run `terraform apply` to apply the execution plan:

```console
terraform apply main.destroy.tfplan
```
