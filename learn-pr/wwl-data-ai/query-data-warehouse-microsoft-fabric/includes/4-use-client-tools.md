Using SQL Server Management Studio (SSMS) to connect to a data warehouse in Fabric can facilitate your workflow, especially if you’re already familiar with the tool.

## Connect to your data warehouse

SQL Server Management Studio provides a familiar interface for those who regularly work with SQL Server.

:::image type="content" border="false" source="../media/4-connection-string.gif" alt-text="Animated GIF showing how to generate the connection string for a data warehouse in Microsoft Fabric.":::

Follow these steps to connect to data warehouse in Fabric from SSMS:

1. Navigate to your Microsoft Fabric workspace. 
1. On your warehouse asset, select more options, then select **Copy SQL connection string**.
1. Launch SQL Server Management Studio, and paste the SQL connection string copied into the **Server** name box, and provide the appropriate credentials for authentication.

    :::image type="content" border="false" source="../media/4-ssms.png" alt-text="Screenshot showing how to connect to a warehouse using SQL Server Management Studio.":::

1. After establishing a connection, SSMS shows the connected warehouse, along with its corresponding tables and views, all ready for querying.

    :::image type="content" border="false" source="../media/4-ssms-warehouse.png" alt-text="Screenshot showing the connected warehouse in SQL Server Management Studio.":::

## Authentication options

In Microsoft Fabric, two types of authenticated users are supported through the SQL connection string:

- Microsoft Entra ID (formerly Azure Active Directory) user principals, or user identities
- Microsoft Entra ID (formerly Azure Active Directory) service principals

> [!NOTE] 
> SQL authentication is not supported.

## Other tools

Any third-party tool can use the SQL connection string via ODBC or OLE DB drivers to connect to a Microsoft Fabric Warehouse or SQL analytics endpoint, using Microsoft Entra ID (formerly Azure Active Directory) authentication.
