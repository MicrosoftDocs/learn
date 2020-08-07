In this activity, you'll deploy Azure SQL Database deployment using the Azure portal. Throughout this exercise, you'll also get to explore the various options that are available to you.  

## Deploy Azure SQL Database using the Azure portal

1. Sign into the Azure portal using the same account you activated the sandbox with.

    > [!div class="nextstepaction"]
    > [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In the top search bar, type **Azure SQL** and review what appears.  

    There are a lot of different items and categories here, but basically this menu gives you filters for what you can search on. Let's break them down:
    * **Services**: if you select Services, then you're able to see the existing resources (i.e. already deployed) that you have all together. For example, if you clicked Azure SQL, you would see all of your SQL VMs, Databases, Logical servers, Managed Instances, and pools.
    * **Resources**: this searches based on existing resource names. For example, if you searched for "adventureworks" any resources with "adventureworks" in the name would return here.
    * **Marketplace**: this allows you to deploy new resources from the marketplace.
    * **Documentation**: this searches docs.microsoft.com for relevant documentation
    * **Resource groups**: this allows you to search based on resource group name.

1. Select **Azure SQL** under **Marketplace**. This will bring you to the Azure SQL create experience.

    :::image type="content" source="../media/3-azure-sql-deployment-options.gif" alt-text="Screenshot of the Azure SQL Deployment options in portal.":::

    Next, select **Single database** and click **Create**.

1. Next, in **SQL databases** select **Single database** and select **Create**.

1. On the **Basics** tab, enter the following information:  

    |Parameter  |Value  |
    |---------|---------|
    |**Subscription**     |  Concierge subscription       |
    |**Resource group**     | <rgn>Sandbox resource group name</rgn>        |
    |**Database name**     | AdventureWorks        |
    |**Server**     |  Select **Create new**, then fill out the  **New server** pane as follows and select **OK**:      |
    |         |**Server name**:  Enter a unique name for the server (for example, `aw-server0406`)  |
    | | **Server admin login**: cloudadmin |
    | | **Password/Confirm Password**:  A complex password that meets [strong password requirements](https://docs.microsoft.com/sql/relational-databases/security/strong-passwords?azure-portal=true). Note this password for later use.|
    || **Location**: Use a region that is close to where you are located |
    |**Want to use SQL elastic pool?**     |   No      |
    |**Compute + storage**     |  Leave the default of **General Purpose**, **Gen5, 2 vCores, 32 GB storage**       |

1. Select **Next : Networking**.  

1. For **Connectivity method**, select **Public endpoint**. Select **Yes** for both **Allow Azure services and resources to access this server** and **Add current client IP address**.

1. Select **Next: Additional settings**.

1. On the **Additional settings** tab, for Azure SQL Database you have the option to select the AdventureWorksLT database as the sample in the Azure portal. For this exercise, select **Sample**.  

1. When you deploy Azure SQL Database in the portal, you are prompted if you'd like to enable Advanced Data Security (ADS) on a free trial. Select **Start free trial**.

    After the free trial, it is billed according to the Azure Security Center Standard Tier pricing. If you choose to enable it, you get functionality related to data discovery and classification, identifying/mitigating potential database vulnerabilities, and threat detection.

    Your **Additional settings** pane should now look similar to the image below.

    :::image type="content" source="../media/3-additional-settings.png" alt-text="Screenshot of additional settings options.":::

1. Select **Review + create**. Here you can review your deployment selections and the Azure Marketplace terms. Review all the options here to ensure all of your selections match the exercise instructions and select **Create** to deploy the service.  

1. Soon after selecting Create, you will be redirected to a page that looks like the following where you can monitor the status of your deployment. You can also navigate to your resource group, and select **Deployments** to get to this same pane. This will give you the various deployments, their status, and more information. This deployment typically takes less than five minutes to deploy.  

    :::image type="content" source="../media/3-deployment-underway-2.png" alt-text="Screenshot of resources being deployed view.":::

1. Once complete, select **Go to resource**.

    :::image type="content" source="../media/3-deployment-underway-3.png" alt-text="Screenshot of deployment is complete view.":::

1. Review the **Overview** pane for the SQL database in the Azure portal and confirm that the Status is **Online**.  

## Connecting to Azure SQL Database

Next, let's look at the basics of connecting to your deployed Azure SQL Database and compare that experience to connecting to SQL Server.

### What does connecting to SQL Server 2019 look like?

Before you look at the Azure SQL Database you just deployed, let's review what connecting to an instance of SQL Server 2019 may look like. Typically, you'd open SSMS and connect, using Windows Authentication perhaps, to the local instance of SQL Server 2019, similar to the image below.  

:::image type="content" source="../media/3-local-connect.png" alt-text="Screenshot showing how to connect to SQL Server 2019 in SSMS.":::  

You would then see a view that looks similar to the following.  

:::image type="content" source="../media/3-local-server.png" alt-text="Screenshot of what a SQL Server 2019 deployment looks like in SSMS.":::  

Keep that in mind as a reference for comparison as you complete the following steps.

### Connect to your SQL Database with SSMS

1. First, we need the logical server name. On the **Overview** pane for your database, locate the **Server name**. This will be the fully qualified domain name (FQDN) of your logical server, for example, *aw-server0406.database.windows.net*. Hover your mouse at the end of the name and select **Copy to clipboard**.

1. Next, let's connect to your Azure SQL Database logical server. On your local device, open SSMS if it is not open already, and create a new connection. Select **Connect > Database Engine**.  

    :::image type="content" source="../media/3-db-engine.png" alt-text="Screenshot of how to connect to Azure SQL Database in SSMS.":::  

1. For **Server name**, paste the name of your Azure SQL Database logical server.

    Change the authentication to **SQL Server Authentication**, and input the corresponding Server Admin Login and Password (the one you provided during deployment in the previous exercise).  

    Select the **Remember password**, then select **Connect**.  

    > [!NOTE]
    > Depending on your local configuration (e.g. VPN), your client IP address may differ from the IP address the Azure portal used during deployment. If it does, you'll get a pop-up which reads "Your client IP address does not have access to the server. Sign in to an Azure account and create a new firewall rule to enable access." If you get this message, sign-in using the account you're using for the sandbox, and add a firewall rule for your client IP address. You can complete all of these steps using the pop-up wizard in SSMS.  

1. Expanding the databases and system databases should result in a view similar to the following.  

    :::image type="content" source="../media/3-azure-server.png" alt-text="Screenshot of the view of SQL Database folders in SSMS.":::  

    Spend a few minutes clicking around and exploring the differences, at first glance, between the Azure SQL Database logical server and SQL Server. You won't deploy an Azure SQL Managed Instance as part of this exercise, but the image below shows how Azure SQL Managed Instance would appear in SSMS.  

    :::image type="content" source="../media/3-managed-instance.png" alt-text="Screenshot of the view of Managed Instance in SSMS.":::  

In this exercise, you saw how to deploy and connect to Azure SQL Database, and how it compares (at first glance) to SQL Server and Azure SQL Managed Instance. In the next exercise, you will continue this comparison, going deeper and exploring various methods to verify your deployment/installation.  
