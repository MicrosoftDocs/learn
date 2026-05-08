SQL Server Management Studio (SSMS) is a free tool for managing and querying SQL-based databases. If you don't have it installed, you can [download SSMS](/sql/ssms/download-sql-server-management-studio-ssms?azure-portal=true). You can use it to connect to and query a data warehouse in Microsoft Fabric.

## Connect to your data warehouse

Follow these steps to connect to a data warehouse in Fabric from SSMS:

1. Navigate to your Microsoft Fabric workspace.
1. Select the **...** (ellipsis) to the right of your warehouse name, then select **Copy SQL connection string**.

    :::image type="content" border="false" source="../media/5-connection-string.png" alt-text="Screenshot showing the More options menu on a warehouse with Copy SQL connection string highlighted.":::

    A dialog appears displaying the connection string. Select **Copy**.

    :::image type="content" border="false" source="../media/5-connection-string-box.png" alt-text="Screenshot showing the SQL connection string dialog with a Copy button.":::

1. Open SSMS. In the **Connect to Server** dialog, paste the connection string into the **Server name** field.
1. In the **Database Name** field, enter the exact name of your warehouse (for example, `sample-dw`). This step is required — if the field is left blank, the connection may fail even if authentication succeeds.
1. In the **Authentication** dropdown, select the appropriate Microsoft Entra authentication method for your organization, then select **Connect**.

    :::image type="content" border="false" source="../media/5-ssms-authentication.png" alt-text="Screenshot showing the SSMS Connection Properties tab with server name, Microsoft Entra MFA authentication, and database name filled in.":::

1. After establishing a connection, SSMS shows the connected warehouse, along with its corresponding tables and views, all ready for querying.

    :::image type="content" border="false" source="../media/5-ssms-warehouse.png" alt-text="Screenshot showing the connected sample-dw warehouse in the SSMS Object Explorer with tables and views visible.":::

## Authentication options

Microsoft Fabric supports Microsoft Entra ID authentication only — SQL authentication isn't supported. In the **Authentication** dropdown, select the appropriate Microsoft Entra option for your organization.

For more information, see [Connect to Server (Login page) - Database Engine](/ssms/f1-help/connect-to-server-login-page-database-engine?azure-portal=true) and [Microsoft Entra authentication as an alternative to SQL authentication in Microsoft Fabric](/fabric/data-warehouse/entra-id-authentication?azure-portal=true).

## Other tools

Any third-party tool can use the SQL connection string via ODBC or OLE DB drivers to connect to a Microsoft Fabric Warehouse or SQL analytics endpoint, using Microsoft Entra ID authentication.

> [!NOTE]
> TCP **port 1433** must be open in your network firewall. For more information, see [Warehouse connectivity](/fabric/data-warehouse/connectivity?azure-portal=true).
