
Azure SQL Database was historically limited to 4 TB of storage per database due to physical infrastructure constraints. However, the Hyperscale service tier revolutionizes this by allowing databases to exceed 100 TB. Hyperscale uses horizontal scaling techniques to add compute nodes as data sizes grow. While the cost of Hyperscale is similar to Azure SQL Database, there's an extra per terabyte storage cost. It's important to note that once a database is converted to Hyperscale, it can't be reverted to a standard Azure SQL Database.

Hyperscale is ideal for most business workloads, offering flexibility, and high performance with independently scalable compute and storage resources. It separates the query processing engine from the components providing long-term storage and durability, allowing storage capacity to scale smoothly as needed.

The Hyperscale service tier, part of the vCore-based purchasing model, is the newest and most scalable option, significantly exceeding the limits of the General Purpose and Business Critical tiers.

## Benefits

The Hyperscale service tier eliminates many of the practical limitations traditionally associated with cloud databases. The resources of a single node constrain most databases, but Hyperscale databases have no such restrictions. With its flexible storage architecture, storage expands as needed, and there's no predefined maximum size. You're billed only for the capacity you use. For read-intensive workloads, Hyperscale offers rapid scale-out by provisioning more replicas to handle read operations.

Moreover, the time required for database backups or scaling operations is no longer dependent on the data volume. Hyperscale databases can be backed up instantly, and you can scale a database with tens of terabytes up or down in minutes. This flexibility ensures that your initial configuration choices don't constrain you. Additionally, Hyperscale provides fast database restores, completing in minutes rather than hours or days.

Hyperscale provides rapid scalability based on your workload demand.

- **Scaling Up/Down –** You can increase or decrease the primary compute resources, such as CPU and memory, quickly and efficiently. Since the storage is shared, these scaling operations aren't dependent on the database's data volume.

- **Scaling In/Out –** You can create more compute replicas to handle read requests, effectively offloading the reading workload from the primary compute. These replicas also serve as hot standby, ready to take over if there's a primary compute failure.

Provisioning more compute replicas is a quick, online operation. To connect to these read-only replicas, set the *ApplicationIntent* argument in your connection string to **ReadOnly**. Connections with the **ReadOnly** application intent are automatically routed to one of the read-only compute replicas.

:::image type="content" source="../media/module-22-plan-implement-final-36.png" alt-text="Diagram showing the hyperscale architecture for Azure SQL Database.":::

## Security considerations

Security for the Hyperscale service tier offers the same robust capabilities as other Azure SQL Database tiers. It employs a layered defense-in-depth approach, providing comprehensive protection from the outermost layers inward.

:::image type="content" source="../media/module-22-plan-implement-final-37.png" alt-text="Illustration showing the Hyperscale model.":::

- **Network Security** is the first layer of defense, utilizing IP firewall rules to control access based on the originating IP address. Additionally, Virtual Network firewall rules enable communication from selected subnets within a virtual network.

- **Access Management** is provided through the following authentication methods to verify user identity:
    - SQL Authentication
    - Microsoft Entra authentication
    - Windows Authentication for Microsoft Entra principals

    Azure SQL Database Hyperscale also supports [Row-Level Security (RLS)](/sql/relational-databases/security/row-level-security?azure-portal=true), allowing customers to control access to specific rows in a database table based on user characteristics, such as group membership or execution context.

- **Threat Protection** includes robust auditing and threat detection capabilities. SQL Database and SQL Managed Instance auditing track database activities and help maintain compliance with security standards by recording events to an audit log in a customer-owned Azure storage account. Advanced Threat Protection analyzes your logs to detect unusual behavior and potential threats to your databases. It generates alerts for suspicious activities such as SQL injection, potential data infiltration, brute force attacks, and anomalies in access patterns that can indicate privilege escalations or the use of breached credentials.

- **Information Protection** is provided in the following ways:
    - Transport Layer Security (Encryption-in-transit)
    - Transparent Data Encryption (Encryption-at-rest)
    - Key management with Azure Key Vault
    - Always Encrypted (Encryption-in-use)
    - Dynamic data masking

## Performance considerations

The Hyperscale service tier is designed for customers with large on-premises SQL Server databases who want to modernize by moving to the cloud, and for those already using Azure SQL Database who need to significantly expand their database capacity. It's also ideal for customers seeking high performance and scalability.

Key performance capabilities of Hyperscale include:

- Nearly instantaneous database backups using file snapshots stored in Azure Blob storage, without affecting compute resources.
- Fast database restores based on file snapshots, completing in minutes rather than hours or days, regardless of data size.
- Enhanced overall performance due to higher transaction log throughput and faster transaction commit times, irrespective of data volumes.
- Rapid scale-out by provisioning one or more read-only replicas to offload read workloads and serve as hot standby.
- Rapid scale-up, allowing you to quickly increase compute resources to handle heavy workloads and scale them back down when not needed.

## Deploying Azure SQL Database Hyperscale

To deploy an Azure SQL Database with the Hyperscale tier, follow the same process as deploying a regular SQL database, with the following differences:

1. Under **Compute + storage**, select the **Configure database** link.

    :::image type="content" source="../media/module-22-plan-implement-final-14.png" alt-text="Screenshot showing how to configure an Azure SQL Database with the hyperscale tier." lightbox="../media/module-22-plan-implement-final-14.png":::
    
1. For **Service tier**, select **Hyperscale**.

    :::image type="content" source="../media/module-22-plan-implement-final-40_1.png" alt-text="Screenshot showing how to select the Hyperscale service tier." lightbox="../media/module-22-plan-implement-final-40_1.png":::

1. Review the hardware configurations available and select the most appropriate configuration for your database. 

1. Optionally, review the other tabs to make adjustments if needed.

1. On the **Review + create** tab, select **Create**.
