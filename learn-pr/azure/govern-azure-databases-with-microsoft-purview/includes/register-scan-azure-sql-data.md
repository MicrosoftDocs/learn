You’ve received a request to prepare a complete and comprehensive overview of all your data flows, sources, transformations, and dependencies so you can manage your data assets.

You’ve decided to use a Microsoft Purview account to connect to data sources that are stored in Azure SQL databases.

## Register an Azure SQL Database source with a Microsoft Purview account

Prepare your Microsoft Purview account making sure you have Data Source Administrator permissions and Data Reader permissions on the collection where you're going to register your data source.

Before you can register an Azure SQL database source, you need to ensure that the Microsoft Purview account has connectivity to the database and has the correct credentials to access it.

### Configure the firewall settings for an Azure SQL Database

It’s important that you provide connectivity to your Azure SQL Database before you scan the data source. The firewall settings on the Azure SQL Database specify which IP addresses are allowed to connect to the SQL databases. You can configure the firewall to allow connections to an Azure SQL Database from your Microsoft Purview account using one of the following methods:

- Allow Azure Connections. To configure this setting, in the Azure SQL Database in the **Security** section, on the **Firewall and virtual networks** page, select **Allow Azure services and resources to access this server**.

- Install a self-hosted integration runtime and give it access through the firewall. To use this configuration, you must integrate your Azure SQL Database with your virtual network by using a private endpoint. Deploy a virtual machine (VM) in that virtual network and then install a self-hosted integration runtime that runs a scan in the Azure SQL Database. Additionally, ensure that the configuration of the VM’s IP address allows it to bypass the SQL Database firewall.

### Authentication for scanning the Azure SQL Database

To access an Azure SQL Database from your Microsoft Purview account, use one of the following three authentication methods:

1. SQL Authentication. If your database is already configured for SQL Authentication, you can use the same method to authenticate and run scans. Use the existing name and password to sign in, or you can create new credentials that have the **db_datareader** permission for the dataset that you plan to scan.

    You must store the password for the account used for scanning the SQL Database in Azure Key Vault as a secret. Your Microsoft Purview Account must be authorized to access that secret. You can also use this method if you’re configuring a self-hosted integration account.

    >[!Note]
    >Microsoft Purview supports lineage from Azure SQL Database. To sign in, the account requires **db_owner** permission for the dataset.

1. Managed identity. Use manage identity as the preferred method if you’ve configured Azure Active Directory (Azure AD) authentication with your Azure SQL database. You can use either a system- or a user-assigned managed identity to authenticate and scan the Azure SQL Database. The managed identity needs permission to get metadata for the database, schemas, and tables.

    Assign the **db_datareader** permission to the managed identity so it’s authorized to query the tables to sample for classification. You should also give your Microsoft Purview managed account permission to scan the Azure SQL Database either at subscription, resources group, or resource level.

1. Service principal. The service principal is created in Azure AD as a new app registration. Add the **client secret** to the newly registered app. Preferably, store the secret in Azure Key Vault.

    The service principal needs permission to get metadata for the database, schemas, and tables. You can provide the correct level of permission by creating an Azure AD user in the SQL Database using the previously created service principal.

### Register an Azure SQL Database

Use the following steps to register an Azure SQL Database source in Microsoft Purview:

1. In the Microsoft Azure portal, select your **Microsoft Purview** account, select **Microsoft Purview governance portal**, and then select **Data map**.

1. On the **Data map** pane, select **Collections**, and then either create a new collection or select an existing collection.

1. On the **Sources** pane, select the appropriate collection, and then select the **Register** icon.

1. On the **Register sources** pane, select the **Azure SQL Database** source tile, and then select **Continue.**

    :::image type="content" source="../media/2-register-azure-sql-database.png" alt-text="Screenshot that describes the process of registering an Azure SQL Database data source in Microsoft Purview."  border="true" lightbox="../media/2-register-azure-sql-database.png":::

1. On the **Register sources (Azure SQL Database)** pane, provide a **Name** for the data source, select the relevant **Azure subscription**, select the **Server name** for the SQL Server, enter the public **endpoint**, select the **collection**, and then select **Register.**

1. The Azure SQL Database is now listed under the selected collection.

    :::image type="content" source="../media/2-provide-name-sql.png" alt-text="Screenshot that depicts the Register sources (Azure SQL Database) pane." border="true" lightbox="../media/2-provide-name-sql.png":::

## Scan an Azure SQL Database

The scan configuration method for an Azure SQL Database source differs depending on which of the following authentication scenarios you choose for your Azure SQL Database:

- Managed identities

- A service principal

- SQL authentication

### Scan an Azure SQL Database configured with managed identities for authentication

To scan your Azure SQL database with system-managed or user-managed identities, you must:

- Provide at least **db_datareader** permission for the managed identity.

- Create an Azure AD user in the Azure SQL Database that has the same name as the Microsoft Purview managed identity. You must use the same spelling for both.

- Grant the Microsoft Purview account managed identity the **Reader** role at the **Subscription** or **Resource group** where your Azure SQL Database is created.

    :::image type="content" source="../media/2-managed-identities.png" alt-text="Screenshot depicting how to scan an Azure SQL Database with system-managed or user-managed identities." border="true" lightbox="../media/2-managed-identities.png":::

To scan an Azure SQL Database that’s been configured using managed identities, follow these steps:

1. In the Azure portal, select your **Microsoft Purview** account, and then select **Microsoft Purview governance portal**.

1. To observe the collection hierarchy, select **Data map**, and then select **Sources**.

1. Under the **Azure SQL DB** you registered earlier, select the **New Scan** icon.

    :::image type="content" source="../media/2-scan-azuresqldatabase.png" alt-text="Screenshot depicting the steps to scan an Azure SQL Database that's been configured using managed identities." border="true" lightbox="../media/2-scan-azuresqldatabase.png":::

1. Provide the following information and then select **Continue**:

    - **Name**: Provide a meaningful name for your scan.
    - **Connect via integration runtime**: Select **Azure AutoResolveIntegrationRuntime**.
    - **Database selection method**: Select **From Azure subscription**.
    - **Database name**: Select your Azure SQL Database.
    - **Credential**: Select **Microsoft Purview MSI (system)**.
    - **Lineage extraction**: Optionally select **On** or **Off** for lineage extraction.
    - **Select a collection**: Select your existing collection.

    >[!Note]
    >Lineage is represented visually to display data moving from source to destination including how the data was transformed.

1. On the **Scope your scan** pane, select the specific tables to selectively choose the scanning activities, and then select **Continue**.

1. On the **Select a scan rule set** pane, select either the **system default scan** for the AzureSQLDatabase or create a new scan rule set, and then select **Continue**.

    >[!Note]
    >If you choose to create a new scan rule set, you can select the classification rules to include in the scan, and optionally define the patterns of the scan.

1. On the **Set a scan trigger** pane, either set up a schedule or select the option to run the scan once.

1. On the **Review your scan** pane, select **Save and run**.

### Scan an Azure SQL Database configured with service principal for authentication

The service principal created in Azure AD must be granted the necessary permission to get metadata from your Azure SQL Database. To grant this permission, configure the Azure SQL Database with Azure AD authentication. Additionally, create an Azure AD user in the Azure SQL Database for your service principal.

>[!Tip]
>Microsoft provides a PowerShell script that simplifies the process to [Create an Azure AD user in SQL Database using an Azure AD service principal](/azure/azure-sql/database/authentication-aad-service-principal-tutorial#create-an-azure-ad-user-in-sql-database-using-an-azure-ad-service-principal).

The credentials for the service principal must be stored in Azure Key Vault. Use the same procedure described earlier to connect Azure Key Vault with your Microsoft Purview account. The secret that you create in Azure Key Vault will be used for your service principal and must contain the **Client credentials** value. You can retrieve this value from the app registration page representing your service principal.

To scan an Azure SQL Database that’s been configured using a service principal as the credentials, use the steps described earlier for scanning an Azure SQL Database that’s been configured using managed identities.

### Scan an Azure SQL Database configured with SQL authentication

To configure a scan of a database configured with SQL authentication, you need to connect your Microsoft Purview Account with the Azure Key Vault service. This service stores the passwords for the account used to scan the SQL database. Use Microsoft Purview governance portal to integrate the Key Vault service and your Microsoft Purview account:

1. In Microsoft Purview governance portal, select the **Management** page, select **Credentials**, and then, in the toolbar, select **Manage Key Vault connections**.

1. On the **Manage Key Vault connections** pane, select **New**, provide a name for the connection, and then select the existing Key Vault.

:::image type="content" source="../media/2-register-key-vault-connection.png" alt-text="Screenshot depicting the steps to scan an Azure SQL Database configured with SQL authentication by connecting your Microsoft Purview Account with the Azure Key Vault service." border="true" lightbox="../media/2-register-key-vault-connection.png":::

>[!Note]
>Be sure to configure the access policy for Azure Key Vault to grant **Get** and **List** secret permission for your Microsoft Purview account.

:::image type="content" source="../media/2-add-access-policy.png" alt-text="Screenshot depicting how to configure the access policy for Azure Key Vault to grant Get and List secret permission for Microsoft Purview." border="true" lightbox="../media/2-add-access-policy.png":::

After you establish a connection with Azure Key Vault, create credentials that use **SQL** **authentication** for your Azure SQL database.

When you create the scan for Azure SQL Database, follow the same procedure described for creating a scan configured with service principal for authentication, but select **SQL Authentication** for **Credentials**.

### Manage the scan

To check the status of the scan after the data scan finishes, navigate to the Microsoft Purview collection that contains your data source, and then select **View Details**.

:::image type="content" source="../media/2-view-the-scan.png" alt-text="Screenshot depicting the status of the scan." border="true" lightbox="../media/2-view-the-scan.png":::

>[!Tip]
>When you select an existing scan, you can also trigger a manual scan or edit the scan to configure a different schedule.
