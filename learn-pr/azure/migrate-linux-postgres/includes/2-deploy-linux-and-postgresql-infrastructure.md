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

At the completion of the module, you delete these resources to save cost. However, you can also turn off the VM and database when not in use to save compute cost, and pay only for the storage used. This workload can also be scaled up as needed.

The Bicep template in this module utilizes [Azure Verified Modules (AVM)](https://azure.github.io/Azure-Verified-Modules/) which is "an initiative to consolidate and set the standards for what a good Infrastructure-as-Code module looks like". Microsoft maintains these modules and they encapsulate many best practices for deploying resources in Azure. 

## Azure Subscription and Azure CLI 

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/) before you begin.

This module requires Azure CLI version 2.0.30 or later. 

Find the version with the following command:

```bash
az --version
```

If you need to install or upgrade, see [Install Azure CLI](/cli/azure/install-azure-cli).

## Sign in to Azure using the CLI

In order to run commands in Azure using the CLI, you need to sign in first. Sign in using the `az login` command.

```bash
az login
```

## Create a resource group

A resource group is a container for related resources. All resources must be placed in a resource group. The [az group create](/cli/azure/group) command creates a resource group.

```bash
az group create \
    --name 240900-linux-postgres \
    --location westus2
```

## Deploy the Bicep template using the Azure CLI

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure you want to deploy to Azure, and then use that file throughout the development lifecycle to repeatedly deploy your infrastructure. Your resources are deployed in a consistent manner.

The bicep file we're using to deploy the compute resources is located at [deploy/vm-postgres.bicep](https://github.com/Azure-Samples/linux-postgres-migration/blob/main/deploy/vm-postgres.bicep). It contains a Virtual Machine, a Virtual Network, a Managed Identity, a Network Security Group for the VM. You can read 
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

At the completion of the deployment, you see JSON output that confirms the resources are deployed.

In this next section, you'll configure and explore Role-based Access Control (RBAC) roles and network security rules on your deployed infrastructure using the Azure portal.

We can encode these roles and rules into our Bicep template we choose to use the Azure portal for this section. The Azure portal provides a visual interface that makes it easier to understand the relationships between resources and the permissions that are assigned to them.

## Open the Resource Group in the Azure portal

Open the Azure portal at [https://portal.azure.com](https://portal.azure.com).

In the left-hand navigation pane, select **Resource groups**.

In the **Resource groups** blade, select the Resource Group `240900-linux-postgres`.

At the top-right, you should see **Deployments:** `... Succeeded`. Here you can check on the status of your Bicep template deployment. 

## View the Virtual Machine's Network Security Group (NSG)

Select the Virtual Machine, `vm-1`.

Select the **Networking** section and then **Network settings** on the left-hand side.

Here you can see the Network Security Group (NSG), `240900-linux-postgres-nsg` that is attached to the same subnet of our virtual network, `240900-linux-postgres-vnet`, as the Virtual Machine.

The NSG is also visible inside the Resource Group. It contains a set of inbound and outbound security rules that control the traffic to and from the Virtual Machine.

## Return to the Resource Group

At the top of the page, select the breadcrumb link to return to the Resource Group (`Home > Resource groups > 240900-linux-postgres`).

Note the `240900-linux-postgres-identity` User Assigned Managed Identity is listed in the Resource Group.

You can learn more about System Assigned and User Assigned managed identities in [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview#managed-identity-types).

## Add an Inbound Security Rule to the Network Security Group

Next you add an inbound security rule to allow SSH traffic from your current IP address to the Virtual Machine.

In a production scenario, you would often use [just-in-time access](/azure/defender-for-cloud/just-in-time-access-usage), [Azure Bastion](/azure/bastion/bastion-overview), or a VPN (such as Azure or a mesh VPN) to secure your Virtual Machine. These security approaches allow you to restrict access to the Virtual Machine to only when needed.

Now add an inbound security rule to the NSG to allow SSH traffic from your current IP address.

1. Select `240900-linux-postgres-nsg`.

1. Select **Settings** and then **Inbound security rules**.

1. Select **Add**.

1. Under **Source** select `My IP address`.

1. Under **Service** select `SSH`.

1. Select **Add**.

## View the Administrator for the Azure Database for PostgreSQL Flexible Server

Find the Azure Database for PostgreSQL flexible server which is named `postgres-xxxxx`, where `xxxxx` is a unique string defined by our Bicep template that remains consistent across deployments to your Subscription and Resource Group.

Select `postgres-xxxxx`.

Select **Security** and then **Authentication**.

You can see here we're using **Microsoft Entra authentication only** the `240900-linux-postgres-identity` User Assigned Managed Identity is listed under **Microsoft Entra Admins**.

This Managed identity is currently the only administrator for the server. You can optionally add your own user account as an administrator, but for this scenario we use the Managed Identity already in place.

In the upcoming section you use the identity from the Virtual Machine to administer the server via the CLI. You also use it to provide access to the server for your application.

In a production scenario, you would likely use a combination of Managed Identities, Entra ID, and fine-grained Role-Based Access Control (RBAC) to enable your application workload to access data and manage resources in Azure securely, following the principle of least privilege.

Read more about these scenarios via [Microsoft Entra authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/concepts-azure-ad-authentication) and [Use Microsoft Entra ID for authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication).

## Review the Azure Database for PostgreSQL Flexible Server Firewall Rules

Select **Settings** and then **Networking**.

If we're administering the server from our local machine, rather than the Virtual Machine, we would need to add our IP address to the firewall rules.

We can optionally create a firewall rule for our current IP address by selecting **Add current client IP address (xxx.xxx.xxx.xxx)**, and selecting **Save**. 

This rule would let us to access the test/dev server using tools on our local machine. 

However, as we're using our Virtual Machine to access the database, we won't at this time. 

In production, we would likely further isolate this server from the public internet entirely, and uncheck the **Allow public access to this resource through the internet using a public IP address** option.

Unlike the Virtual Machine, we haven't associated our Azure Database for PostgreSQL with any Virtual Network. This means we retain the option of accessing it over the public internet which is useful for test/dev scenarios. 

To provide both security and flexibility, we enable access from the Virtual Machine via its Virtual Network using a private endpoint. The private endpoint allows the Virtual Machine to access the database without exposing it to the public internet. Read more about private endpoints in [Azure Database for PostgreSQL - Flexible Server networking with Private Link](/azure/postgresql/flexible-server/concepts-private-link).

We use the Azure portal instead of Bicep to create the private endpoint for demonstration purposes.

## Create a Private Endpoint for Azure Database for PostgreSQL Flexible Server

1. Select **Settings** and then **Networking**.

1. Under **Private endpoint**, select **Add private endpoint**.

1. Under **Basics** enter **Name:** `private-endpoint-1`

1. Select **Next**

1. Under **Resource**, select **Next**.

1. Under **Virtual Network**, select **Virtual Network:** `240900-linux-postgres-vnet`. The virtual network is located in the `240900-linux-postgres` Resource Group.

1. Select **Next**

1. Under **DNS** select **Next**.

1. Under **Review + create** select **Create**.

1. You are then redirected to a page that says **Deployment is in progress**. Wait for the resources to be deployed.

1. Once it says **Your deployment is complete**, select **Go to resource**.

## Review the Virtual Machine's System assigned managed identity Role Assignments

Return to the `240900-linux-postgres` Resource Group and select `vm-1`.

On the left-hand, side select **Security** and then **Identity**.

Here you can see the **System assigned managed identity** that is attached to the Virtual Machine.

Under **System assigned**, select **Azure role assignments**. 

Here you can see the **Reader** role assigned to the **System assigned managed identity** which has been scoped to the `240900-linux-postgres` Resource Group.

This identity has permissions to list resources in the Resource Group.

This identity allows us to use the Azure CLI within our VM to list resources in the Resource Group which avoids having to hard-code specific resource details into our scripts.

At a later stage we will assign an additional role to the VM's managed identity to allow it to directly access an Azure Blob Storage account.

Next you will explore and configure the deployed infrastructure.

## Resources
- [Azure Verified Modules (AVM)](https://azure.github.io/Azure-Verified-Modules/)
- [Install Azure CLI](/cli/azure/install-azure-cli)
- [Bicep Documentation](/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [Create a resource group using Azure CLI](/cli/azure/group)
- [Azure Role-Based Access Controls (RBAC)](/azure/role-based-access-control/overview) 
- [Azure Managed Identity](/entra/identity/managed-identities-azure-resources/overview)
- [What is Bicep?](/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview#managed-identity-types)
- [Enable just-in-time access on VMs](/azure/defender-for-cloud/just-in-time-access-usage)
- [What is Azure Bastion?](/azure/bastion/bastion-overview)
- [Microsoft Entra authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/concepts-azure-ad-authentication)
- [Use Microsoft Entra ID for authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication)
- [Azure Database for PostgreSQL - Flexible Server networking with Private Link](/azure/postgresql/flexible-server/concepts-private-link)
