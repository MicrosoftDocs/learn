Your company runs a significant number of databases in an Azure SQL Managed Instance environment. You’ve been asked to find a method to improve your company’s data governance framework, reinforce the overall data management strategy, increase trust in the data you use, and make your data a truly enterprise-wide asset.

Microsoft Purview uses automated data discovery to provide your company with an up-to-date map of their data landscape. You can use Microsoft Purview to register a data source and then enrich its metadata by providing descriptions, tags, or other metadata supplements. Your organization can use the overall data map for business intelligence, application development, or any task where the data matches their needs.

To fulfill the request you’ve received, you’ve decided to integrate the data source of an Azure SQL Managed Instance with your Microsoft Purview account.

## Register an Azure SQL Managed Instance in Microsoft Purview

Before you register your data source that runs in an Azure SQL Managed Instance, you need to ensure connectivity from your Microsoft Purview account. You can connect from your Microsoft Purview account to an Azure SQL Managed Instance by either:

- Using a public endpoint on the managed instance.

- Integrating the Microsoft Purview account with the virtual network used by the Azure SQL Managed Instance and then using a private endpoint to more securely access the database.

>[!Note]
>A public endpoint for a managed instance allows access from outside from the virtual network to databases that are hosted on the managed instance.

### Configure a private endpoint for a Microsoft Purview account

A private endpoint is a more secure method to connect to an Azure SQL Managed Instance because it enables network isolation. With a private endpoint enabled on the virtual network where the Azure SQL Managed Instance is deployed, you can allow connection only from within the network using a self-hosted integration runtime that’s deployed in an Azure VM. To do this, you must create a Microsoft integration runtime in your Microsoft Purview account and then download and install binaries on an Azure VM that runs any supported 64-bit version of the Windows operating system, following these steps:

1. In the Azure portal, select your **Microsoft Purview account.**

1. On the **Settings** pane, select **Networking**, and then select **Private endpoint connections**.

1. To create a new private endpoint, select **+ Private endpoint**.

1. On the **Basics** pane, select your subscription, provide a meaningful name for the private endpoint, choose the region, and then select **Resource**.

1. On the **Resource** pane, from the **Resource type** drop-down list, select **Microsoft.Purview/accounts**.

1. From the **Resource** drop-down list, select your Microsoft Purview account.

1. From the **Target sub-resource** drop-down list, select **account,** and then select **Next: Virtual Network**.

    :::image type="content" source="../media/3-create-private-endpoint.png" alt-text="Screenshot depicting how to configure a private endpoint for a Microsoft Purview account." border="true" lightbox="../media/3-create-private-endpoint.png":::

1. On the **Virtual Network** pane, select the virtual network and subnet. Optionally, select **Azure Private DNS zone** to create a new Azure DNS Zone.

1. Select **Next: Tags**.

1. On the **Tags** pane, provide the name value pair, and then select **Review + Create**.

1. To create the portal private endpoint, on the **Review + Create** pane, select **Create**.

>[!Tip]
>You can also follow these steps when you select a portal for a target subresource.

>[!Note]
>For both your Microsoft Purview Account and the Microsoft Purview Portal, you must create ingestion private endpoint connections with the virtual network that contains the Azure SQL Managed Instance. This is required, but you only need to do it once.

### Authentication for scanning an Azure SQL Managed Instance

You can use one of the following authentication methods to access the Azure SQL Managed Instance:

- SQL authentication:

  - Create a server username and password with the **db_datareader** permission on all the databases that you plan to scan. The password should be stored in Azure Key Vault as a secret.

- System- or user-assigned managed identity:

  - For user-assigned managed identity, create the user managed identity and then assign this user identity to the Microsoft Purview account.

  - For managed identity representing the Microsoft Purview account, configure permission on the Azure SQL Managed Instance. You also must create an Azure AD user account that will be mapped to the Azure AD managed identity and then assign it **db_datareader** permission. In addition, give your Microsoft Purview managed account permission to scan the Azure SQL Managed Instance either at subscription, resources group, or resource level.

  - Microsoft Purview system-assigned managed identity is automatically created.

- Service principal:

  - Use an existing service principal or create a new service principal in Azure AD by creating a new app registration.

  - The service principal needs permission on the Azure SQL Managed Instance.

  - Use the same procedure as previously described for managed identity to create an Azure AD user account. Map it to the service principal and then assign it **db_datareader** permission.

### Steps to register a data source with Microsoft Purview governance portal

Use these steps in Microsoft Purview governance portal to register a data source from an Azure SQL Managed Instance in a Microsoft Purview account:

1. In the Azure portal, select your **Microsoft Purview** account, and then select **Microsoft Purview governance portal**.

1. From the **navigation** pane, select **Data map**.

1. Select an existing collection or create a new collection, and then select **Register**.

1. Select **Azure SQL Database Managed Instance**, and then select **Continue**.

    :::image type="content" source="../media/3-register-sql-managed-instance.png" alt-text="Screenshot that represents the process of registering a data source with Microsoft Purview governance portal." border="true" lightbox="../media/3-register-sql-managed-instance.png":::

1. In the **Register sources (Azure SQL Database Managed Instance)** pane, provide the following information:

    - **Name**: Provide a meaningful name.
    - **Azure Subscription**: Select your subscription.
    - **Server name**: Select the appropriate server.
    - **Endpoint**: Provide either the public or private endpoint fully qualified domain name and port number. For example: contosopurviewmi.public.41dff15771fa.database.windows.net, 3342
    - **Select a collection**: Select the existing collection (optional).

1. To finish the registration of a data source hosted in an Azure SQL Managed Instance, select **Register**.

## Scan an Azure SQL Managed Instance

Now that you have access to an Azure SQL Managed Instance, you can create a new scan that runs with a different schedule. You can organize multiple scans with different classification rules under a scan rule set.

To create this scan, follow this procedure, which is the same as the procedure previously described to scan an Azure SQL Managed Instance:

1. To observe the collection hierarchy, in the Azure portal, select your **Microsoft Purview** account, select **Microsoft Purview governance portal**, select **Data map**, and then select **Sources**.

1. Under the **Azure SQL DB managed instance** you registered earlier, select the **New Scan** icon.

1. Provide the following information and then select **Continue**:

    - **Name**: Provide a meaningful name for your scan.

    - **Connect via integration runtime**: Select **Azure AutoResolveIntegrationRuntime**.

    - **Database selection method**: Select **From Azure subscription**.

    - **Database name**: Select your Azure SQL Database.

    - **Credential**: Select one of the following:
        - Managed Identity
        - Service Principal
        - SQL Authentication
    - **Select a collection**: Select your existing collection.

1. On the **Scope your scan** pane, select the specific folders and subfolders to selectively choose the scanning activities, and then select **Continue**.

1. On the **Select a scan rule set** pane, select either the system default scan for **AzureSQLDatabaseManagedInstance** or create a new scan rule set, and then select **Continue**.

    >[!Note] 
    >If you choose to create a new scan rule set, you can select the classification rules to include in the scan, and optionally define the patterns of the scan.

1. On the **Set a scan trigger** pane, set up a schedule or select the option to run the scan once.

1. On the **Review your scan** pane, select **Save and run**.
