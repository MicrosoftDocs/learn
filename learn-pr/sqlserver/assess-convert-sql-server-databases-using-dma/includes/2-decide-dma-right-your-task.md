In your law firm, you've compiled a list of the SQL Server databases in your organization. You've identified those databases that require upgrading to SQL Server 2019. All the databases are hosted on-premises. However, the CTO asks you to move a selection of databases to the cloud, to prepare for some infrastructure changes. The CTO also wants a report detailing the changes required, so they can allocate the resources needed to do the upgrades.

You realize it will be impossible to do the necessary checks and create a report in time for the CTO's deadline. After searching for a solution, you think the **Azure Migrate** and **Microsoft Data Migration Assistant (DMA)** tools might help. You now need to decide if the DMA is the most appropriate tool for your task.

## Using backup and restore to upgrade/migrate SQL Server

Using database backups and restoring them on the target instance is an option for migrating older versions of SQL Server to SQL Server 2019. However, if you need to migrate a large number of databases, this process is likely to be lengthy. If you manually migrate databases, you'll need to migrate user logins separately.

## What is Azure Migrate?

Azure Migrate provides a dashboard for a suite of migration tools. From the portal you can find documentation and download links to **Assess and migrate servers**, **Assess and migrate databases**, and **Explore more scenarios**.

:::image type="content" source="../media/2-azure-migrate.png" alt-text="Azure Migrate" lightbox="../media/2-azure-migrate.png":::

### Assess and migrate servers

To assess and migrate servers, you should first discover machines in your on-premises or cloud environment. To perform the discovery, you must install the Azure Migrate appliance to a machine in the same domain as the machines that you wish to discover.

:::image type="content" source="../media/2-discover-machines.png" alt-text="Discover machines":::

The machine that runs the Azure Migrate appliance has the following requirements:

- Windows Server 2016
- 32 GB RAM
- 8 vCPUs
- 80 GB of free disk space

### Assess and migrate databases

To assess and migrate databases, a link is provided to install Data Migration Assistant.

### Explore more scenarios

**Explore more** includes links to tools to assess and migrate WebApps, Virtual Desktop Infrastructure, and data using Data Box. Azure Data Box is a ruggedized physical storage device with 100 TB capacity. The device is sent to a customer, the customer backs up their data to the device, and then the customer returns the Data Box device to Microsoft. When transferring many terabytes of data, physically sending the data is the most reliable and least expensive method.

:::image type="content" source="../media/2-explore-more.png" alt-text="Explore more" lightbox="../media/2-explore-more.png":::

## What is the Microsoft Data Migration Assistant?

![Data Migration Assistant start page](../media/2-dma-start.png "Data Migration Assistant start page")

The DMA is a standalone application that runs a set of tasks to assist in upgrading your SQL Server databases. It removes the time-consuming process of checking your databases for compatibility issues before a migration. DMA connects to the _source_ and _target_ servers, and discovers breaking changes, behavior changes, and deprecated features. If you're migrating to an on-premises SQL Server host, you can also run a **new features** assessment to find features in the target version that can enhance the performance of your database. For migrations to Azure SQL Database, DMA checks feature parity to uncover partially or unsupported features in Azure.

The time that DMA needs to assess your database will depend on the size of the source database. For large databases, you can run the compatibility and new feature recommendation assessments individually to reduce the assessment time.

After assessing your database, you can use DMA to migrate to the target server. The migration process can include the following elements:

- Database schema: all objects in the database, including tables, indexes, stored procedures, views, and functions
- Data
- Windows and SQL logins
- Database users
- Server roles

By default, DMA doesn't move the **sa** login, but will move all other qualified logins. You can select which logins to migrate, but you'll need to ensure these logins are correctly mapped to the migrated databases.

## Supported source and target versions

You use the DMA to assess and migrate on-premises and Azure SQL Databases. It supports these source databases:

- SQL Server 2005
- SQL Server 2008
- SQL Server 2008 R2
- SQL Server 2012
- SQL Server 2014
- SQL Server 2016
- SQL Server 2017 on Windows

Allowing you to migrate to:

- SQL Server 2012
- SQL Server 2014
- SQL Server 2016
- SQL Server 2017 on Windows or Linux
- SQL Server 2019
- Azure SQL Database

When you upgrade a database to an on-premises target, you can choose to assess compatibility issues and new feature recommendations. For SQL Azure Database upgrades, DMA highlights compatibility issues and provides a SQL Server feature parity category. DMA also includes recommendations and alternative approaches for Azure.

## Export report

After running a compatibility or upgrade assessment, you can export the results to CSV or JSON for future reference. You can combine assessment reports from multiple servers to create a report in Power BI. You need PowerShell, Power BI Desktop, and a template provided by Microsoft to produce this report.

Doing database upgrades can be a time-consuming task for administrators who manage many databases. The compatibility and new features assessments, and the upgrade, should always be done out of hours or when there's the least activity on the server. In practice, there might only be a small window of opportunity to do these tasks. The DMA ensures each operation is completed consistently. By default, it ensures that no logins or users are overlooked during a migration, which enables a swift transition to the new server.

### Prepare for the exercises

You'll be using a virtual machine in later exercises. Run these commands to set up the machine so you can connect to it.

1. In the Cloud Shell, create a VM. 

    ```azurecli
    PASSWORD=$(openssl rand -base64 32)
    az vm create \
        --name SQL2019Server \
        --image "MicrosoftSQLServer:sql2019-ws2019:sqldev:latest" \
        --size Standard_D2s_v3 \
        --admin-username azureadmin \
        --admin-password $PASSWORD \
        --nsg-rule RDP \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    echo $PASSWORD
    ```
    
1. Make a note of this password as you'll need it to connect to the VM in the exercises.
1. Open the RDP port to allow you to connect with a Remote Desktop Connection.

    ```azurecli
    az vm open-port \
        --port 3389 \
        --name SQL2019Server \
        --resource-group <rgn>[Sandbox resource group]</rgn>
    ```

> [!WARNING]
> Do not deactivate the sandbox. This sandbox will continue to be used in following units.
