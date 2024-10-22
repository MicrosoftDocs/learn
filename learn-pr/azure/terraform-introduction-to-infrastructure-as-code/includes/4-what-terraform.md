You use Terraform for your resource provisioning. You want to learn more about Terraform modules so that you can make an informed decision about which language to use.

This unit covers the Terraform language and the benefits it provides to module authoring.

## Terraform language - HashiCorp Configuration Language (HCL)

The language used by Terraform is called HashiCorp Configuration Language normally shortened to HCL. The HCL language is used in other HashiCorp tools, such as Packer, but is most widely known as the language of Terraform.

The HCL language is used to declaratively deploy Azure resources. HCL is a domain-specific language. A domain-specific language is designed for a specific scenario or _domain_. HCL isn't meant to be used as a standard programming language for writing applications. HCL is used only to create Terraform modules. Terraform is intended to be easy to understand and straightforward to learn, regardless of your experience with other programming languages. Any Azure resource type and properties can be specified in Terraform modules.

> [!NOTE]
> If you've previously looked into using ARM templates, you'll notice that Terraform simplifies the template creation experience. It provides a syntax that's easier to understand, better support for modularity and reusable code, and improved type safety. Creating a JSON ARM template requires complicated expressions, and the final result might be verbose.

## Benefits of Terraform

Terraform provides many improvements over ARM template authoring, including:

- **Simpler syntax**: Terraform provides a simpler syntax for writing modules. You can reference parameters and variables directly, without using complicated functions. String interpolation is used in place of concatenation to combine values for names and other items. You can reference the properties of a resource directly by using its symbolic name instead of complex reference statements.

- **Modules**: You can break down complex deployments into smaller submodules and reference them in a root module. These modules provide easier management and greater reusability. You can even share your modules with your team or publically.

- **Automatic dependency management**: In most situations, Terraform automatically detects dependencies between your resources. This process removes some of the work involved in module authoring.

- **Type validation and IntelliSense**: The Terraform extensions for Visual Studio Code feature rich validation and IntelliSense for all Azure resource types. This feature helps provide an easier authoring experience.

Take a look at the following example of a Terraform module that defines an Azure storage account. The name of the storage account is automatically generated in the module. After deployment, the resource ID is returned as output to the user who executes the module.

```hcl
variable "name_prefix" {
  type    = string
  default = "storage"
}

locals {
  storage_account_name             = "${var.name_prefix}${random_id.random_suffix.hex}"
  storage_account_replication_type = "RAGRS"
}

resource "random_id" "random_suffix" {
    byte_length = 4
}

resource "azurerm_resource_group" "example" {
  name     = "storage-resource-group"
  location = "eastus"
}

resource "azurerm_storage_account" "example" {
  name                      = local.storage_account_name
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  sku                       = "Standard"
  account_replication_type  = local.storage_account_replication_type
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  enable_https_traffic_only = true
}

output "storage_account_resource_id" {
  value = azurerm_storage_account.example.id
}
```
