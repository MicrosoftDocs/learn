::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=7d16abfd-3c24-4d01-a6c5-779b7d479452]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

## Integration runtime

In Data Factory, an activity defines the action to be performed. A linked service defines a target data store or a compute service. An integration runtime (IR) provides the bridge between the activity and linked services.

## Azure-SSIS integration runtime

To lift and shift existing SSIS workloads, you can create an Azure-SSIS IR to natively execute SSIS packages. Selecting the right location for your Azure-SSIS IR is essential to achieve high performance in your extract-transform-load (ETL) workflows.

- The location of your Azure-SSIS IR doesn't need to be the same as the location of your data factory, but it should be the same as the location of your own Azure SQL Database or Azure SQL Managed Instance server where SSISDB is to be hosted. This way, your Azure-SSIS Integration Runtime can easily access SSISDB without incurring excessive traffic between different locations.

- If you don't have an existing Azure SQL Database or Azure SQL Managed Instance server to host SSISDB, but you have on-premises data sources/destinations, you should create a new Azure SQL Database or Azure SQL Managed Instance server in the same location as the virtual network connected to your on-premises network. This way, you can create your Azure-SSIS IR using the new Azure SQL Database or Azure SQL Managed Instance server and joining that virtual network, all in the same location, effectively minimizing data movements across different locations.

- If the location of your existing Azure SQL Database or Azure SQL Managed Instance server where SSISDB is hosted isn't the same as the location of the virtual network connected to your on-premises network, first create your Azure-SSIS IR using an existing Azure SQL Database or Azure SQL Managed Instance server and joining another virtual network in the same location, and then configure a virtual network to virtual network connection between different locations.

An Azure-SSIS IR runs packages that are deployed into an SSIS catalog (SSISDB) hosted by Azure SQL Database or Azure SQL Managed Instance (Project Deployment Model). It also runs packages that are deployed into the file system, Azure Files, or the SQL Server database (MSDB) hosted by Azure SQL Managed Instance (Package Deployment Model). If you use SSISDB, Azure Data Factory creates it on a database server that you provide when it provisions the Azure-SSIS IR.

During the provisioning of the Azure-SSIS integration runtime, you specify the following options:

- The node size (including the number of cores) and the number of nodes in the cluster.
- The existing Azure SQL Database server or Azure SQL Managed Instance to host the SSIS catalog database (SSISDB), and, for Azure SQL Database, the service tier for the database.
- The maximum parallel executions per node.

With the Azure-SSIS integration runtime enabled, you can deploy, run, manage, monitor, and schedule SSIS packages using tools such as SQL Server Management Studio (SSMS) or SQL Server Data Tools (SSDT).

::: zone-end