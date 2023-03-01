Azure SQL Database is one of Microsoft's SQL Server Platform-as-a-Service (PaaS) offerings. It's fully managed and gives organizations a highly performing, reliable, and secure, general purpose relational database engine in the cloud.

In your bicycle manufacturing company, you've already identified and profiled the databases that you want to migrate to Azure SQL Database. Now, you want to plan the migration, considering data recoverability, disaster recovery, security, and other implementation details. You'd like to know if Microsoft provides tools to help with this process.

In this module, the focus is on single databases and elastic pools. A single database has its own resources and is deployed to a logical SQL Database server where it's managed. Elastic pool databases are deployed onto a single SQL Database server where resources are shared between all databases.

### Benefits of Azure SQL Database (single and elastic pools)

The following sections categorize and summarize the benefits of deploying single and elastic pool databases:

#### Backup and recovery

- Automatic backup
- Point-in-time restore
- Backup retention 7 days+
- Long-term backup retention stores backups for up to 10 years

#### High availability

- 99.99% availability guarantee
- Built-in availability with three secondary replicas
- Zone redundancy via Azure availability zones

#### Disaster recovery

- Geo-restore of database backups
- Active-geo replication between Azure regions

#### Service scalability

- Dynamic scale-up and scale-down
- Scale out with multiple shards
- Share compute resources between databases using elastic pools

#### Security

- Support for Azure Active Directory authentication
- Cloud-only security features such as Advanced Threat Protection
- Transparent data encryption (TDE) enabled by default
- Support for dynamic and static data masking, row-level security, and Always Encrypted
- Firewall allowlist

#### Licensing

- DTU purchasing model for predictive costing
- vCore purchasing model, enabling storage to be scaled independently of compute
- Combine the vCore purchasing model with Azure Hybrid Benefit for SQL Server to realize cost savings of up to 30 percent

## Tools to support your migration planning to Azure SQL Database

The following tools should be used in the discovery, planning, and assessment stage of your migration to Azure SQL Database:

1. **Microsoft Planning and Assessment**. Use this tool in the discovery stage to confirm the source environment that you're migrating from.

2. **Azure Database Migrate Service**. The Azure Database Migrate Service enables you to do large-scale database migration from within the Azure portal.

3. **Data Migration Assistant**. Use the Data Migration Assistant in the planning and assessment stage of a Data Platform Modernization project to check for compatibility issues that affect database functionality in Azure SQL Database.

4. **Database Experimentation Assistant**. If you're concerned about workloads that operate on the target server, use the Database Experimentation Assistant to assess if your target server can handle it.

## Migration planning for Azure SQL Database

When you migrate to an Azure SQL database, it's important to recognize that this product, although similar to SQL Server, is a distinctly separate application. There are considerations that need to be planned for before migration.

### SQL agent jobs

Azure SQL Database doesn't provide functionality to host SQL Server agent jobs that must be migrated to complementary technologies such as:

- Azure automation
- Elastic jobs

### Security settings

Authentication with security principals in Azure SQL Database supports two types:

- SQL authentication
- Azure Active Directory authentication

### Read scale-out

Read scale-out allows for read-only SQL workloads to be serviced by a secondary replica.

### Retry application connections

When you access any cloud service, it's important to understand the requirements for retry logic so an application can recover from temporary issues and problems.

[Retry Service Specific](/azure/architecture/best-practices/retry-service-specific)

## Create an Azure SQL database

To create an Azure SQL database using the Azure portal, complete the following steps:

1. Sign in to the [Azure portal](https://portal.azure.com) with your subscription.
1. Select **Create a resource** in the upper-left corner of the Azure portal.
1. Locate the managed instance, and then select **SQL Database**.
1. Select **Create**.
1. On the **Basics** tab, in the **Project Details** section, type or select the following values:

    | Property | Value |
    | --- | --- |
    | Subscription | Select the correct subscription |
    | Resource group | Select **Create new**, type **cto**, and select **OK** |

1. In the **Database Details** section, type or select the following values:

    | Property | Value |
    | --- | --- |
    | Database name | mySampleDatabase |
    | Server | Select **Create new** |
    | Server name | **mysqlserver**, along with some numbers for uniqueness. |
    | Server admin login | `azureuser` |
    | Password | Type a complex password that meets password requirements. |
    | Location | Choose a location from the drop-down, such as West US 2. |

1. In the **"Want to use SQL elastic pool"** section, select the **No** option.
1. In **Compute + storage**, select **Configure database** and, for this quick start, select **vCore-based** purchasing options.
1. Select **Serverless**.
   - Review the settings for **Max vCores, Min vCores, Autopause delay**, and **Data max size**, and change them if necessary
   - Accept the preview terms and select **OK**
   - Select **Apply**
1. Select the **Additional settings** tab.
1. In the **Data source** section, under **Use existing data**, select **None**.
1. Leave the rest of the values as default and select **Review + Create** at the bottom of the form.
1. Review the final settings and select **Create**.
1. On the **SQL Database** form, select **Create** to deploy and configure the resource group, server, and database.
