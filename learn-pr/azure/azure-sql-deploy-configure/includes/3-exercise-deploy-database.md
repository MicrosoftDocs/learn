In this activity, you'll deploy Azure SQL Database by using the Azure portal. Throughout this exercise, you'll also explore the options that are available to you.  

## Deploy Azure SQL Database by using the Azure portal

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the top search bar, enter **Azure SQL** and wait for results so you can review what appears.  

    There are many items and categories here, but this menu gives you filters to search with. Let's break them down:
    * **Services**: With this filter you can see your existing resources all together. For example, if you selected Azure SQL, you would see all of your SQL virtual machines, databases, logical servers, managed instances, and pools.
    * **Resources**: This search is based on existing resource names. For example, if you searched for "adventureworks," any resources with "adventureworks" in the name would be returned here.
    * **Marketplace**: This filter allows you to deploy new resources from Azure Marketplace.
    * **Documentation**: This searches `learn.microsoft.com` for relevant documentation.
    * **Resource groups**: This filter allows you to search based on resource group name.

1. Select **Azure SQL** under **Marketplace**. This step will bring you to the Azure SQL create experience.

    :::image type="content" source="../media/3-azure-sql-deployment-options.gif" alt-text="Screenshot of the Azure SQL deployment options in the portal.":::

1. In **SQL databases**, select **Single database** > **Create**.

1. On the **Basics** tab, enter the following information:  

    |Parameter  |Value  |
    |---------|---------|
    |**Subscription**     |  Select your Azure subscription       |
    |**Resource group**     | Select a resource group to use, or select **Create new**        |
    |**Database name**     | AdventureWorks        |
    |**Server**     |  Select **Create new**, fill out the  **Server details** pane as follows, and select **OK**:      |
    |         |**Server name**:  Enter a unique name for the server (for example, **aw-server0406**).  |
    | | **Location**: Use a region that's close to you. |
    | | **Authentication method**: Use SQL authentication. |
    | | **Server admin login**: cloudadmin |
    | | **Password/Confirm Password**:  Use a complex password that meets [strong password requirements](/sql/relational-databases/security/strong-passwords?azure-portal=true). Note this password for later use.|
    |**Want to use SQL elastic pool?**     |   No      |
    |**Workload environment**| Leave the default of **Production** |
    |**Compute + storage**     |  Leave the default of **General Purpose**, **Gen5, 2 vCores, 32 GB storage**       |
    |**Backup storage redundancy**     |  Leave the default of **Geo-redundant backup storage**       |

1. Select **Next: Networking**.  

1. For **Connectivity method**, select **Public endpoint**. Select **Yes** for both **Allow Azure services and resources to access this server** and **Add current client IP address**.

1. For **Connection policy**, select **Default**.

1. Select **Next: Security**.

1. When you deploy Azure SQL Database in the portal, you're prompted about whether you want to **Enable Microsoft Defender for SQL** in a free trial. Select **Start free trial**.

    After the free trial, it's billed according to the Microsoft Defender for Cloud Standard Tier pricing. After you enable it, you get functionality related to identifying/mitigating potential database vulnerabilities and threat detection.

1. Leave remaining defaults and select **Next: Additional settings**.

1. On the **Additional settings** tab for Azure SQL Database, you can select the `AdventureWorksLT` database as the sample in the Azure portal. For this exercise, for **Use existing data**, select **Sample**. Select **OK** when prompted.

1. Select **Review + create**. Here, you can review your deployment selections and the Azure Marketplace terms. Review all the options to ensure that all of your selections match the exercise instructions, and then select **Create** to deploy the service.  

1. You're redirected to a pane where you can monitor the status of your deployment. You can also go to your resource group and select **Deployments** to open this same pane. It gives you the various deployments, their status, and more information. This deployment typically takes less than five minutes.  

    :::image type="content" source="../media/3-deployment-underway-2.png" alt-text="Screenshot of resources being deployed.":::

1. When your deployment is complete, select **Go to resource**.

    :::image type="content" source="../media/3-deployment-underway-3.png" alt-text="Screenshot that shows deployment is complete.":::

1. Review the **Overview** pane for the SQL database in the Azure portal and confirm that the status is **Online**.  

## Connect to Azure SQL Database

Next, let's look at the basics of connecting to your deployed SQL database and compare that experience to connecting to SQL Server.

### What does connecting to SQL Server 2019 look like?

Before you look at the SQL database that you deployed, let's review what connecting to an instance of SQL Server 2019 might look like. Typically, you'd open SQL Server Management Studio (SSMS) and connect to the local instance of SQL Server 2019. You might use Windows Authentication for the connection. The selections would be similar to the following image:

:::image type="content" source="../media/3-local-connect.png" alt-text="Screenshot that shows how to connect to SQL Server 2019 in SSMS.":::  

You'd then see a view that looks similar to the following:

:::image type="content" source="../media/3-local-server.png" alt-text="Screenshot of what a SQL Server 2019 deployment looks like in SSMS.":::  

Keep that in mind as a reference for comparison as you complete the following steps.

### Connect to your SQL Database by using SSMS

1. First, we need the logical server name. On the **Overview** pane for your database, locate the **Server name** information. This is the fully qualified domain name (FQDN) of your logical server, for example, *aw-server0406.database.windows.net*. Hover your mouse at the end of the name and select **Copy to clipboard**.

1. Let's connect to your Azure SQL Database logical server. On your local device, open SSMS if it's not open already and create a new connection. Select **Connect** > **Database Engine**.  

    :::image type="content" source="../media/3-db-engine.png" alt-text="Screenshot of how to connect to Azure SQL Database in SSMS.":::  

1. For **Server name**, paste the name of your Azure SQL Database logical server.

    Change the authentication to **SQL Server Authentication**. Then enter the corresponding server admin login and password (the one you provided during deployment in the previous exercise).  

    Select **Remember password**, and then select **Connect**.  

    > [!NOTE]
    > Depending on your local configuration (for example, VPN), your client IP address might differ from the IP address that the Azure portal used during deployment. If it does, you'll get a pop-up message that says "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign in with the account you use for Azure and add a firewall rule for your client IP address. You can complete all of these steps by using the pop-up wizard in SSMS.  

1. Expanding the databases and system databases should result in a view similar to the following: 

    :::image type="content" source="../media/3-azure-server.png" alt-text="Screenshot of the view of SQL Database folders in SSMS.":::  

    Spend a few minutes exploring the differences, at first glance, between the Azure SQL Database logical server and SQL Server. You won't deploy a managed instance as part of this exercise, but the following image shows how a managed instance would appear in SSMS:

    :::image type="content" source="../media/3-managed-instance.png" alt-text="Screenshot of the view of a managed instance in SSMS.":::  

In this exercise, you saw how to deploy and connect to Azure SQL Database, and how it compares (at first glance) to SQL Server and Azure SQL Managed Instance. In the next exercise, you'll continue this comparison, going deeper and exploring various methods to verify your deployment/installation.
