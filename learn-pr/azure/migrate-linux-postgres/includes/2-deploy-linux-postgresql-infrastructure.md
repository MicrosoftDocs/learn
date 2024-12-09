This unit guides you through the creation of the compute resources that host your application within Azure.

There are multiple methods to deploy infrastructure in Azure, including the Azure portal, the Azure CLI, and infrastructure-as-code templates (including Bicep and Terraform). In this unit, you deploy a preconfigured Bicep template that encapsulates the compute resources required for your application. The key resources are:

- A virtual machine running Linux (Ubuntu 24.04 LTS)
- Azure Database for Postgres running [Postgres 16 or later](https://www.postgresql.org/download/)
- A [managed identity](/entra/identity/managed-identities-azure-resources/overview) to enable secure access from the VM to the database
- [RBAC](/azure/role-based-access-control/overview), including roles to access the database as an administrator, and more restrictive roles for the application itself
- A virtual network for both the VM and the database

Because this example is a dev/test workload, and we want to keep things both cost-effective and performant, we chose the following configuration for you:

- The VM is a Standard D2s_v4 (two vCPUs, 8 GB of memory). It has Azure Premium SSD with 3,200 maximum I/O operations per second (IOPS) and 128 GB of storage. It has an attached P10 128-GB Premium SSD disk with 500 IOPS for the OS disk. You can upgrade the OS disk to match the VM's IOPS as required.

- The database is a General Purpose D2ds_v4 (two vCores, 8 GB of RAM) with 3,200 maximum IOPS. It has a P10 128-GB Premium SSD disk with 500 IOPS. You can upgrade this disk to match the compute IOPS as required.

At the completion of the module, you delete these resources to save costs. However, you can also turn off the VM and database when they're not in use to save compute costs and pay for only the storage that you use. You can also scale up this workload as needed.

The Bicep template in this module utilizes [Azure Verified Modules (AVM)](https://azure.github.io/Azure-Verified-Modules/). AVM is an initiative to standardize infrastructure-as-code modules. Microsoft maintains these modules, and they encapsulate many best practices for deploying resources in Azure.

## Ensure that you have an Azure subscription and the Azure CLI

If you don't have an Azure subscription, create a [free account](https://azure.microsoft.com/free/) before you begin.

This module requires Azure CLI version 2.0.30 or later. Find the version by using the following command:

```bash
az --version
```

If you need to install or upgrade, see [Install the Azure CLI](/cli/azure/install-azure-cli).

## Sign in to Azure by using the Azure CLI

To run commands in Azure by using the Azure CLI, you need to sign in first. Sign in by using the `az login` command:

```bash
az login
```

## Create a resource group

A resource group is a container for related resources. All resources must be placed in a resource group. Use the [az group create](/cli/azure/group) command to create a resource group:

```bash
az group create \
    --name 240900-linux-postgres \
    --location westus2
```

## Deploy the Bicep template by using the Azure CLI

Bicep is a domain-specific language (DSL) that uses declarative syntax to deploy Azure resources. In a Bicep file, you define the infrastructure that you want to deploy to Azure. You then use that file throughout the development life cycle to repeatedly deploy your infrastructure. Your resources are deployed in a consistent manner.

The Bicep file that you're using to deploy the compute resources for this unit is in the [deploy/vm-postgres.bicep](https://github.com/Azure-Samples/linux-postgres-migration/blob/main/deploy/vm-postgres.bicep) GitHub repo. It contains a virtual machine, a virtual network, a managed identity, and a network security group (NSG) for the VM. You can read more about Bicep in [What is Bicep?](/azure/azure-resource-manager/bicep/overview?tabs=bicep).

1. Clone the example repo to your local machine:

   ```bash
   git clone https://github.com/Azure-Samples/linux-postgres-migration.git
   ```

1. Go to the `linux-postgres-migration` directory:

   ```bash
   cd linux-postgres-migration
   ```

1. Deploy the Bicep template:

   ```bash
   az deployment group create \
       --resource-group 240900-linux-postgres \
       --template-file deploy/vm-postgres.bicep
   ```

At the completion of the deployment, JSON output confirms that the resources are deployed.

In the next sections, you'll configure and explore RBAC roles and network security rules on your deployed infrastructure by using the Azure portal. When you use the Azure portal, you can encode the roles and rules into the Bicep template. The Azure portal provides a visual interface that makes it easier to understand the relationships between resources and the permissions that are assigned to them.

## Open the resource group in the Azure portal

1. Open the [Azure portal](https://portal.azure.com).

1. On the service menu, select **Resource groups**.

1. On the **Resource groups** pane, select the resource group `240900-linux-postgres`.

In the upper-right part of the pane, the **Deployments** area shows the status of your Bicep template deployment. When deployment is successful, it shows **Succeeded**.

## View the virtual machine's network security group

1. Select the virtual machine, `vm-1`.

1. In the **Networking** section, select **Network settings**.

The network settings show that the network security group (`240900-linux-postgres-nsg`) is attached to the same subnet of the virtual network (`240900-linux-postgres-vnet`) as the virtual machine.

The NSG is also visible inside the resource group. It contains a set of inbound and outbound security rules that control the traffic to and from the virtual machine.

## Return to the resource group

At the top of the page, select the breadcrumb link to return to the resource group (`Home > Resource groups > 240900-linux-postgres`).

Note that the `240900-linux-postgres-identity` user-assigned managed identity is listed in the resource group.

You can learn more about system-assigned and user-assigned managed identities in [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview#managed-identity-types).

## Add an inbound security rule to the network security group

Add an inbound security rule to the NSG to allow SSH traffic from your current IP address to the virtual machine.

In a production scenario, you would often use [just-in-time access](/azure/defender-for-cloud/just-in-time-access-usage), [Azure Bastion](/azure/bastion/bastion-overview), or a VPN (such as Azure or a mesh VPN) to restrict access to your virtual machine.

1. Select `240900-linux-postgres-nsg`.

1. Select **Settings** > **Inbound security rules**.

1. Select **Add**.

1. Under **Source**, select **My IP address**.

1. Under **Service**, select **SSH**.

1. Select **Add**.

## View the administrator for the Azure Database for PostgreSQL flexible server

1. Find and select the Azure Database for PostgreSQL flexible server. It's named `postgres-xxxxx`, where `xxxxx` is a unique string that the Bicep template defined. The string remains consistent across deployments to your subscription and resource group.

1. Select **Security** > **Authentication**.

For this scenario, you're using **Microsoft Entra authentication only**. The `240900-linux-postgres-identity` user-assigned managed identity is listed under **Microsoft Entra Admins**.

The `240900-linux-postgres-identity` managed identity is currently the only administrator for the server. You can optionally add your own user account as an administrator. But for this scenario, you use the managed identity that's already in place.

In an upcoming section, you use the identity from the virtual machine to administer the server via the Azure CLI. You also use that identity to provide access to the server for your application.

In a production scenario, you would likely use a combination of managed identities, Microsoft Entra ID, and fine-grained RBAC to enable your application workload to access data and manage resources in Azure securely. You would follow the principle of least privilege.

Read more about these scenarios in [Microsoft Entra authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/concepts-azure-ad-authentication) and [Use Microsoft Entra ID for authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication).

## Review the Azure Database for PostgreSQL Flexible Server firewall rules

Select **Settings** > **Networking**.

If you were administering the server from your local machine, rather than the virtual machine, you would need to add your IP address to the firewall rules.

You could create a firewall rule for your current IP address by selecting **Add current client IP address (xxx.xxx.xxx.xxx)** > **Save**. This rule would let you access the dev/test server by using tools on your local machine. But because you're using a virtual machine to access the database, you won't create a firewall rule at this time.

In production, you would likely isolate this server from the public internet entirely by clearing the **Allow public access to this resource through the internet using a public IP address** option.

Unlike the virtual machine, you haven't associated Azure Database for PostgreSQL with any virtual network. You retain the option of accessing Azure Database for PostgreSQL over the public internet, which is useful for dev/test scenarios.

To provide both security and flexibility, you enable access from the virtual machine via its virtual network by using a private endpoint. The private endpoint allows the virtual machine to access the database without exposing it to the public internet. Read more about private endpoints in [Azure Database for PostgreSQL - Flexible Server networking with Private Link](/azure/postgresql/flexible-server/concepts-networking-private-link).

Here, the private endpoint has been created for you using Bicep.

## Review the role assignments for the virtual machine's system-assigned managed identity

1. Return to the `240900-linux-postgres` resource group and select `vm-1`.

1. On the service menu, select **Security** > **Identity**.

   Here, you can confirm that the system-assigned managed identity is attached to the virtual machine.

1. Under **System assigned**, select **Azure role assignments**.

   Here, you can confirm that the Reader role is assigned to the system-assigned managed identity. The role is scoped to the `240900-linux-postgres` resource group.

The permissions in this identity allow you to use the Azure CLI within the VM to list resources in the resource group. With this ability, you don't have to hard-code specific resource details into your scripts.

At a later stage, you'll assign an additional role to the VM's managed identity so that the VM can directly access an Azure Blob Storage account.

Next, you'll explore and configure the deployed infrastructure.

## Resources

- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [Install the Azure CLI](/cli/azure/install-azure-cli)
- [Create a resource group by using the Azure CLI](/cli/azure/group)
- [Azure RBAC](/azure/role-based-access-control/overview)
- [Azure managed identity](/entra/identity/managed-identities-azure-resources/overview)
- [What is Bicep?](/azure/azure-resource-manager/bicep/overview?tabs=bicep)
- [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview#managed-identity-types)
- [Enable just-in-time access on VMs](/azure/defender-for-cloud/just-in-time-access-usage)
- [What is Azure Bastion?](/azure/bastion/bastion-overview)
- [Microsoft Entra authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/concepts-azure-ad-authentication)
- [Use Microsoft Entra ID for authentication with Azure Database for PostgreSQL - Flexible Server](/azure/postgresql/flexible-server/how-to-configure-sign-in-azure-ad-authentication)
- [Azure Database for PostgreSQL - Flexible Server networking with Private Link](/azure/postgresql/flexible-server/concepts-networking-private-link)
