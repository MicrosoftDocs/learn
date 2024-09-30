## Introduction

You're guided through the creation of the compute resources that host your application within Azure.

There are multiple methods to deploy infrastructure in Azure, including the Azure portal, Azure CLI, and Infrastructure as Code templates including Bicep and Terraform.

In this module, we show you how to deploy a preconfigured [Bicep](/azure/azure-resource-manager/bicep/overview?tabs=bicep) template that encapsulates the compute resources required for your application.

The key resources deployed are:

- Virtual Machine (VM) running Linux (Ubuntu 24.04 LTS).
- Azure Database for Postgres running [Postgres 16 or above](https://www.postgresql.org/download/).
- A [Managed Identity](/entra/identity/managed-identities-azure-resources/overview) to enable secure access from the VM to the database.
- [Role-Based Access Controls (RBAC)](/azure/role-based-access-control/overview) including roles to access the database as an administrator, and more restrictive roles for the application itself.
- A Virtual Network for both the VM and database.

As this is a test/dev workload, and we're looking to keep things both cost-effective and performant, we've chosen the following configuration for you:

The VM SKU is a Standard D2s v4 (2 vcpus, 8 GB memory). P10 Premium Solid State Disk (SSD) with 3200 max IOPs with 128 GB storage. It has an attached P10 128 GB Premium SSD with 500 IOPs for the OS disk which can be upgraded to match the VMs IOPs as required.

The database SKU is a General Purpose, D2ds_v4, 2 vCores, 8-GB RAM with 3200 max IOPs. It has a P10 128GB Premium SSD with 500 IOPs which can be upgraded to match the compute IOPs as required.

At the completion of the module, you delete these resources to save cost. However, you can also turn the VM and database off when not in use to save compute cost, and pay only for the storage used. This workload can also be scaled up as needed.

The Bicep template in this module utilizes [Azure Verified Modules (AVM)](https://azure.github.io/Azure-Verified-Modules/) which is "an initiative to consolidate and set the standards for what a good Infrastructure-as-Code module looks like". These modules are maintained by Microsoft and encapsulate many best practices for deploying resources in Azure. 

## Azure Subscription and Azure CLI 

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/) before you begin.

This module requires Azure CLI version 2.0.30 or later. 

Run the below command to find the version:

```bash
az --version
```

If you need to install or upgrade, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Sign in to Azure using the CLI

In order to run commands in Azure using the CLI, you need to sign in first. Sign in using the `az login` command.

## Create a resource group

A resource group is a container for related resources. All resources must be placed in a resource group. The [az group create](/cli/azure/group) command creates a resource group.

```bash
az group create \
    --name 240900-linux-postgres \
    --location westus2
```

## Deploy the Bicep template using the Azure CLI

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure you want to deploy to Azure, and then use that file throughout the development lifecycle to repeatedly deploy your infrastructure. Your resources are deployed in a consistent manner.

The bicep file we're using to deploy the compute resources is located at [deploy/vm-postgres.bicep](./deploy/vm-postgres.bicep). It contains a Virtual Machine, a Virtual Network, a Managed Identity, a Network Security Group for the VM. You can read 
more about Bicep on [What is Bicep?](/azure/azure-resource-manager/bicep/overview?tabs=bicep).

If you run this command on your local machine, first clone the example repo to your machine.

```bash
git clone https://github.com/Azure-Samples/linux-postgres-migration.git
```

Then navigate to the linux-postgres-migration directory:

```bash
cd linux-postgres-migration
```

Run the following az CLI command to deploy the bicep template.

```bash
az deployment group create \
    --resource-group 240900-linux-postgres \
    --template-file deploy/vm-postgres.bicep
```

## Resources
- [Azure Verified Modules (AVM)](https://azure.github.io/Azure-Verified-Modules/)
- [Install Azure CLI](/cli/azure/install-azure-cli)
- [Bicep Documentation](/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [Create a resource group using Azure CLI](/cli/azure/group)
- [Azure Role-Based Access Controls (RBAC)](/azure/role-based-access-control/overview) 
- [Azure Managed Identity](/entra/identity/managed-identities-azure-resources/overview)
- [What is Bicep?](/azure/azure-resource-manager/bicep/overview?tabs=bicep)