Creating an Azure DocumentDB cluster is the first step toward using the service. The cluster is where all your databases, collections, and documents reside. You create and manage clusters through the Azure portal, Azure CLI, Bicep, or Terraform.

## Start cluster creation

To create a cluster in the Azure portal:

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. Select **Create a resource**.
1. Search for and select **Azure DocumentDB (with MongoDB compatibility)**.
1. Select **Azure DocumentDB (with MongoDB compatibility)** again.
1. Select **Create** to open the cluster configuration page.

Next, configure the cluster settings starting on the **Basics** tab.

## Configure the Basics tab

The Basics tab is where you define the cluster's identity, location, and initial compute configuration.

**Subscription and resource group**: Select the Azure subscription and resource group where the cluster is created. Use a dedicated resource group for your DocumentDB resources to simplify management and cost tracking.

**Cluster name**: Provide a globally unique name for your cluster. This name becomes part of your connection endpoint, so choose something descriptive and easy to identify. For example, `contoso-ecommerce-dev` clearly identifies the team, workload, and environment.

**Location**: To minimize network latency, select the Azure region closest to your application. The cluster and your application should be in the same region when possible.

**MongoDB version**: Select the MongoDB version for your cluster. Azure DocumentDB currently supports MongoDB version 8.0, which provides the latest query language features and compatibility improvements.

**Cluster tier**: Select **Configure** to open the Scale page, where you choose the compute tier and storage size. For a development environment, the M30 tier (2 vCores, 8-GiB RAM) with 128-GiB storage is a common starting point. You can change these settings later without downtime.

> [!TIP]
> For development and testing, burstable tiers (M10, M20, M25) provide a lower-cost option. These tiers scale CPU up on demand and are sufficient for light workloads.

**Admin username and password**: Create the administrator credentials for the cluster. The admin user has full access to all databases and collections. Passwords must be at least eight characters and include uppercase letters, lowercase letters, numbers, and nonalphanumeric characters.

> [!IMPORTANT]
> Record your admin username and password in a secure location. You need these credentials to connect to the cluster, and the password isn't retrievable from the Azure portal after creation.

## Configure the Networking tab

After completing the Basics tab, select **Next: Networking** to configure how clients connect to your cluster.

**Connectivity method**: Choose between **Public access** and **Private access**:

- **Public access** exposes the cluster endpoint to the internet. You control access through IP-based firewall rules.
- **Private access** uses Azure Private Link to create a private endpoint in your virtual network. The cluster is only accessible through private IP addresses.

For development environments, public access with firewall rules is the quickest setup. For production environments, private access provides stronger network isolation.

**Firewall rules** (public access only): 
- Select **Allow public access to this resource through the internet using a public IP address** to enable public access.
- Add your current client IP address by selecting **+ Add current client IP address**. 
- You can also enable **Allow public access from Azure services and resources within Azure to this cluster** to permit connections from other Azure services.

> [!TIP]
> In corporate environments, VPN or network settings might hide your actual IP address. If you have trouble connecting, temporarily add the `0.0.0.0` to `255.255.255.255` range for testing, then restrict it once you identify the correct IP.

## Configure the global distribution and Encryption tabs

On the **Global distribution** tab, you can enable replica clusters across multiple Azure regions to improve availability and reduce latency for global applications.

On the **Encryption** tab, you can choose between **Service-managed keys** and **Customer-managed keys** for encrypting your data at rest. Service-managed keys are the default and require no extra configuration. Customer-managed keys provide more control over encryption and key rotation.

## Review and create

Select **Review + create** to validate your settings. Azure checks that cluster name is available and all required fields are complete. Select **Create** to start provisioning.

Cluster creation takes a few minutes. Once the deployment completes, select **Go to resource** to open the cluster in the Azure portal.

## What gets created

When you create a cluster, Azure provisions:

- **Compute resources**: The vCores and RAM specified by your cluster tier, running on each physical shard in the cluster.
- **Storage**: The disk capacity you selected, with input/output operations per second (IOPS) that scale based on storage size.
- **Network endpoint**: A `mongocluster.cosmos.azure.com` endpoint that MongoDB drivers and tools use to connect.
- **Automated backups**: Backup is enabled automatically with a 35-day retention period. Backups can't be disabled.
- **Encryption**: All data is encrypted at rest using Advanced Encryption Standard (AES) 256-bit encryption with service-managed keys by default.

After the cluster is created, you can connect to it using the MongoDB connection string provided in the Azure portal. Azure DocumentDB supports two authentication approaches: native authentication using the admin username and password you created (or secondary users with specific roles), and Microsoft Entra ID authentication using managed identities for passwordless access from other Azure services. Security is discussed further in a later unit.