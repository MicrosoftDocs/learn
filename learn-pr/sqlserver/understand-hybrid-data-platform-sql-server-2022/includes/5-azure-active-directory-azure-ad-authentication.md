---
ms.custom:
  - build-2023
---
Managing database security can become complex as the size and complexity of the database environment grows, making it challenging to maintain a consistent security posture across all databases and systems. 

Azure AD provides a cloud-based centralized authentication authority that employs advanced authentication methods. SQL Server 2022 has introduced support for logins and users that are based on Azure AD accounts. 

## Architecture

Let's review how Azure Active Directory authentication works for SQL Server 2022:

:::image type="content" source="../media/module-2-azure-ad-03.png" alt-text="Diagram how Azure AD works for SQL Server.":::

1. The Azure extension for SQL Server retrieves data from Azure AD and stores it in the Windows registry.
1. The user logs in to SQL Server 2022 using Azure AD.
1. SQL Server searches the registry for the metadata containing the necessary information to connect to Azure AD and establish a connection.

Like Azure SQL Managed Instance and Azure SQL Database, SQL Server 2022 supports a new syntax for `CREATE LOGIN` and `CREATE USER` to support `EXTERNAL PROVIDER`. Use the `CREATE USER` T-SQL statement with an Azure AD account to provide authentication to users in a database without the need for a login.

As we can see, SQL Server 2022 uses Azure AD to provide secure and simplified access management for users.

To see the Azure AD authentication methods available on SQL Server 2022, see [Azure Active Directory authentication for SQL Server](/sql/relational-databases/security/authentication-access/azure-ad-authentication-sql-server-overview)

## Exercise: Configure Azure Active Directory authentication for SQL Server 2022

To run this exercise, make sure you meet these requirements before you start:

* SQL Server 2022 (16.x) or later is installed.
* SQL Server is [connected to Azure](/sql/sql-server/azure-arc/connect?tabs=windows).
* Azure Key Vault. The user setting up Azure AD admin should have the **Contributor** role on Azure Key Vault.
* *SQL Server – Azure Arc* resource should have the **Contributor** role for the server.

### Configure Azure AD admin for SQL Server using the Azure portal

1. Navigate to **SQL Server – Azure Arc** on Azure portal, and select the instance for your SQL Server host. Make sure it's connected by going to the **Properties** menu.

1. Select **Azure Active Directory** on the left-hand column, and then select **Set Admin**. Select an account to be added as an admin for SQL Server.

1. Select **Service-managed cert**, then select **Change key vault** and select your existing Azure Key vault resource.

1. Select **Service-managed app registration**, then **Save**.

   > [!NOTE]
   > Wait until the process completes before proceeding to the next step.

### Grant permission to the Azure AD application

1. Navigate to **Azure Active Directory** on Azure portal.

1. Select **App registrations**.

    :::image type="content" source="../media/module-2-azure-ad-02.png" alt-text="Screenshot showing App registrations menu in the Azure portal.":::

1. Select the newly created application. The application should have a name in the format of `<hostname>-<instanceName><uniqueNumber>`.

1. Select the **API permissions** menu, then select **Grant admin consent**.

### Connect to SQL Server using Azure AD authentication

You can now connect to SQL Server using Azure AD authentication:

:::image type="content" source="../media/module-2-azure-ad-01.png" alt-text="Screenshot showing SQL Server Management Studio with authentication dialog.":::

As we've seen SQL Server 2022 provides simplified access management for SQL Server users authenticating using Azure AD.
