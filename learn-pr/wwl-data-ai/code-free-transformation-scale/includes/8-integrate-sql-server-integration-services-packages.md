You may work in an organization where much of the transformation logic is currently held in existing SSIS packages that have been created on SQL Server. You have the ability to lift and shift SSIS packages so you can execute them within Azure Data Factory, so you can reuse existing work. To do this, you must set up an Azure-SSIS integration runtime.

## Azure-SSIS integration runtime

If you deploy packages by using the project deployment model, the Azure-SSIS integration runtime needs an SSIS catalog (SSISDB) hosted by Azure SQL Database or Azure SQL Managed Instance. If you deploy packages to the file system, Azure Files, or MSDB on Azure SQL Managed Instance (package deployment model), you don't need SSISDB. With the requirements met, the Azure-SSIS integration runtime is capable of:

- Lift and shift existing SSIS workloads

During the provisioning of the Azure-SSIS integration runtime, you specify the following options:

- The node size (including the number of cores) and the number of nodes in the cluster.
- The Azure SQL Database server or Azure SQL Managed Instance to host the SSIS Catalog Database (SSISDB), and the service tier for the database.
- The maximum parallel executions per node.

With the Azure-SSIS integration runtime enabled, you're able to manage, monitor, and schedule SSIS packages using tools such as SQL Server Management Studio (SSMS) or SQL Server Data Tools (SSDT).

## Create an Azure-SSIS integration runtime

1. In the Azure Data Factory Studio, select the **Manage** hub, and then select **Integration runtimes** under **Connections** to view existing integration runtimes in your data factory.

    [![Screenshot that shows the Integration Runtimes tab in the Azure Data Factory designer.](../media/data-flow-designer.png)](../media/data-flow-designer.png#lightbox)

1. Select **+ New** to create an Azure-SSIS IR and open the **Integration runtime setup** pane.

    ![Screenshot that shows the new Integration Runtime dialog with configuration options.](../media/new-connections-window.png)

1. In the **Integration runtime setup** pane, select the **Lift-and-shift existing SSIS packages to execute in Azure** tile, and then select **Next**.

    ![Screenshot that shows the Integration Runtime setup pane with the Lift-and-shift option highlighted.](../media/integration-runtime-setup.png)

1. On selecting this option, there are three types of settings to configure

### General settings page

1. On the **General settings** page of **Integration runtime setup** pane, complete the following steps.

    ![Screenshot that shows the General settings page of the Integration Runtime setup pane.](../media/integration-runtime-general-settings.png)

1. In **Name**, enter the name of your integration runtime.

1. For **Description**, enter the description of your integration runtime.

1. For **Location**, select the location of your integration runtime. It's recommended that you select the same location of your database server to host SSISDB.

1. For **Node Size**, select the size of node in your integration runtime cluster.

1. For **Node Number**, select the number of nodes in your integration runtime cluster.

1. For **Edition/License**, select the SQL Server edition for your integration runtime: Standard or Enterprise.

1. For **Save Money**, select the Azure Hybrid Benefit option for your integration runtime: Select **Yes** if you want to bring your own SQL Server license with Software Assurance to benefit from cost savings with hybrid use.

1. Select **Continue**.

### Deployment settings page
1. On the **Deployment settings** page of **Integration runtime setup** pane, complete the following steps.

1. Select the **Create SSIS catalog (SSISDB) hosted by Azure SQL Database server/Managed Instance to store your projects/packages/environments/execution logs** check box to deploy your packages into SSISDB (project deployment model).

    ![Screenshot that shows the Create SSIS catalog check box selected in the Deployment settings page.](../media/create-sql-server-integration-services-catalog.png)

1. For **Subscription**, select the Azure subscription that has your database server to host SSISDB.

1. For **Location**, select the location of your database server to host SSISDB. We recommend that you select the same location of your integration runtime.

1. For **Catalog Database Server Endpoint**, select the endpoint of your database server to host SSISDB.

1. To use managed identity authentication, select either the **Use Microsoft Entra authentication with the system managed identity for Data Factory** check box (for a single data factory using its system-assigned identity) or the **Use Microsoft Entra authentication with a user-assigned managed identity for Data Factory** check box (for scenarios where a specific user-assigned managed identity is required). If you skip these options, SQL authentication credentials from the following steps are used instead.

1. For **Admin Username**, enter the SQL authentication username for your database server to host SSISDB.

1. For **Admin Password**, enter the SQL authentication password for your database server to host SSISDB.

1. For **Catalog Database Service Tier**, select the service tier for your database server to host SSISDB. Select the Basic, Standard, or Premium tier, or select an elastic pool name.

Select **Test connection** when applicable and, if it's successful, select **Continue**.

Alternatively, you can create package stores:

1. Select the **Create package stores to manage your packages that are deployed into file system/Azure Files/SQL Server database (MSDB) hosted by Azure SQL Managed Instance** check box to choose whether you want to manage your packages that are deployed into MSDB, file system, or Azure Files (Package Deployment Model) with Azure-SSIS IR package stores.

    ![Screenshot that shows the Create package stores check box selected in the Deployment settings page.](../media/create-package-stores.png)

1. On the **Add package store** pane, complete the following steps.

1. For **Package store name**, enter the name of your package store.

1. For **Package store linked service**, select your existing linked service that stores the access information for file system/Azure Files/Azure SQL Managed Instance where your packages are deployed or create a new one by selecting **New**. On the **New linked service** pane, complete the following steps.

    ![Screenshot that shows the New linked service pane with configuration fields for the package store.](../media/new-linked-service-page.png)

1. For **Name**, enter the name of your linked service.

1. For **Description**, enter the description of your linked service.

1. For **Type**, select **Azure File Storage**, **Azure SQL Managed Instance**, or **File System**.

1. You can ignore **Connect via integration runtime**, since the Azure-SSIS IR is always used to fetch the access information for package stores.

1. If you select **Azure File Storage**, for **Authentication method**, select **Basic**, and then complete the following steps. The Azure-SSIS IR package store supports only the **Basic** authentication method for the Azure File Storage linked service.

1. For **Account selection method**, select **From Azure subscription** or **Enter manually**.

1. If you select **From Azure subscription**, select the relevant **Azure subscription**, **Storage account name**, and **File share**.

1. If you select **Enter manually**, enter \\\\<storage account name\>.file.core.windows.net\<file share name> for **Host**, Azure\\<storage account name\> for **Username**, and \<storage account key\> for **Password** or select your **Azure Key Vault** where it's stored as a secret.

    > [!NOTE]
    > There are different settings if you select **Azure SQL Managed Instance**, or **File System**

1. Select **Test connection** when applicable and if it's successful, select **Create**.

1. On the **Deployment settings** page, select **Continue**.
### Advanced settings page

1. On the **Advanced settings** page of **Integration runtime setup** pane, complete the following steps.

    ![Screenshot that shows the Advanced settings page of the Integration Runtime setup pane.](../media/integration-runtime-advanced-settings.png)

1. For **Maximum Parallel Executions Per Node**, select the maximum number of packages to run concurrently per node in your integration runtime cluster. 

1. Select the **Customize your Azure-SSIS Integration Runtime with additional system configurations/component installations** check box to choose whether you want to add standard/express custom setups on your Azure-SSIS IR. 

1. Select the **Select a VNet for your Azure-SSIS Integration Runtime to join, allow ADF to create certain network resources, and optionally bring your own static public IP addresses** check box to choose whether you want to join your Azure-SSIS IR to a virtual network.

1. Select the **Set up Self-Hosted Integration Runtime as a proxy for your Azure-SSIS Integration Runtime** check box to choose whether you want to configure a self-hosted IR as proxy for your Azure-SSIS IR. For more information, see [Set up a self-hosted IR as proxy](/azure/data-factory/self-hosted-integration-runtime-proxy-ssis).

1. Select **Continue**.

1. On the **Summary**, review all provisioning settings, and select **Finish** to start the creation of your integration runtime.

1. On the **Connections** pane of **Manage** hub, switch to the **Integration runtimes** page and select **Refresh**.

    ![Screenshot that shows the Integration runtimes page in the Manage hub with an Azure-SSIS integration runtime listed.](../media/linked-service-page.png)
