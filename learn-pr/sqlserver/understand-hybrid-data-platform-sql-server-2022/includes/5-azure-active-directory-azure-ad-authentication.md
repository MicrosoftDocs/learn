---
ms.custom:
  - build-2023
---
Managing database security can become complex as the size and complexity of the database environment grows, making it challenging to maintain a consistent security posture across all databases and systems. 

Microsoft Entra ID provides a cloud-based centralized authentication authority that employs advanced authentication methods. SQL Server 2022 has introduced support for logins and users that are based on Microsoft Entra accounts. 

## Architecture

Let's review how Microsoft Entra authentication works for SQL Server 2022:

:::image type="content" source="../media/module-2-azure-ad-03.png" alt-text="Diagram how Microsoft Entra ID works for SQL Server.":::

1. The Azure extension for SQL Server retrieves data from Microsoft Entra ID and stores it in the Windows registry.
1. The user logs in to SQL Server 2022 using Microsoft Entra ID.
1. SQL Server searches the registry for the metadata containing the necessary information to connect to Microsoft Entra ID and establish a connection.

Like Azure SQL Managed Instance and Azure SQL Database, SQL Server 2022 supports a new syntax for `CREATE LOGIN` and `CREATE USER` to support `EXTERNAL PROVIDER`. Use the `CREATE USER` T-SQL statement with a Microsoft Entra account to provide authentication to users in a database without the need for a login.

As we can see, SQL Server 2022 uses Microsoft Entra ID to provide secure and simplified access management for users.

To see the Microsoft Entra authentication methods available on SQL Server 2022, see [Microsoft Entra authentication for SQL Server](/sql/relational-databases/security/authentication-access/azure-ad-authentication-sql-server-overview)

<a name='exercise-configure-azure-active-directory-authentication-for-sql-server-2022'></a>

## Exercise: Configure Microsoft Entra authentication for SQL Server 2022

To run this exercise, make sure you meet these requirements before you start:

* SQL Server 2022 (16.x) or later is installed.
* SQL Server is [connected to Azure](/sql/sql-server/azure-arc/connect?tabs=windows).
* Azure Key Vault. The user setting up Microsoft Entra admin should have the **Contributor** role on Azure Key Vault.
* *SQL Server – Azure Arc* resource should have the **Contributor** role for the server.

<a name='configure-azure-ad-admin-for-sql-server-using-the-azure-portal'></a>

### Configure Microsoft Entra admin for SQL Server using the Azure portal

1. Navigate to **SQL Server – Azure Arc** on Azure portal, and select the instance for your SQL Server host. Make sure it's connected by going to the **Properties** menu.

1. Select **Microsoft Entra ID** on the left-hand column, and then select **Set Admin**. Select an account to be added as an admin for SQL Server.

1. Select **Service-managed cert**, then select **Change key vault** and select your existing Azure Key vault resource.

1. Select **Service-managed app registration**, then **Save**.

   > [!NOTE]
   > Wait until the process completes before proceeding to the next step.

<a name='grant-permission-to-the-azure-ad-application'></a>

### Grant permission to the Microsoft Entra application

1. Navigate to **Microsoft Entra ID** on Azure portal.

1. Select **App registrations**.

    :::image type="content" source="../media/module-2-azure-ad-02.png" alt-text="Screenshot showing App registrations menu in the Azure portal.":::

1. Select the newly created application. The application should have a name in the format of `<hostname>-<instanceName><uniqueNumber>`.

1. Select the **API permissions** menu, then select **Grant admin consent**.

<a name='connect-to-sql-server-using-azure-ad-authentication'></a>

### Connect to SQL Server using Microsoft Entra authentication

You can now connect to SQL Server using Microsoft Entra authentication:

:::image type="content" source="../media/module-2-azure-ad-01.png" alt-text="Screenshot showing SQL Server Management Studio with authentication dialog.":::

As we've seen SQL Server 2022 provides simplified access management for SQL Server users authenticating using Microsoft Entra ID.
