It is possible to encrypt data that is transmitted across a network between an instance of SQL Server and a client application with Transport Layer Security (TLS). The TLS encryption is performed within the protocol layer and is available to all supported SQL Server and Azure SQL database services.

## Transport Layer Security (TLS)

Transport Layer Security (TLS) is a protocol for encrypting connections, and it increases the security of data being transmitted across networks between instances of SQL Server and applications.

Once a private certificate is issued by a certificate authority, and it has been assigned to a server running a SQL Server instance, the server can then use it to securely validate client requests. Such validation requires that the computer running the client application is configured to trust the certificate used by SQL Server.

For Azure SQL Database, it is possible to enforce a minimal TLS version at the server level. The TLS versions currently supported are **1.0**, **1.1**, and **1.2**. If the client application supports encrypted connection, we recommend setting it to the latest TLS version supported after testing the application. Choosing the latest TLS version is a good practice as it provides additional fixes for vulnerabilities found in older versions.

:::image type="content" source="../media/module-33-security-final-12_1.png" alt-text="Minimal TLS version property for Azure SQL Database":::

The minimal TLS version setting for a SQL Database is accessible from the **Firewalls and virtual networks** screen, as shown in the image above.

The following table explains the options available depending on whether client applications support encrypted connections.

| Scenario | Option |
|------------|-------------|
|**TLS not supported** | Leave the minimum TLS version setting at the default. |
|**Latest TLS version supported** | Set the minimum TLS version setting to 1.2. |
|**Older TLS version supported** | Set the minimum TLS version setting to 1.0 or 1.2. Evaluate your workloads for TLS 1.2 readiness and develop a migration plan. |

Enabling TLS encryption offers privacy and data security for communications between instances of SQL Server and applications. However, when the traffic between SQL Server and a client application is encrypted with TLS, an extra network roundtrip and additional processing are required at connect time.

For Azure SQL Managed Instance, use `az sql mi update` Azure CLI command or `Set-AzSqlInstance` PowerShell cmdlet to configure the minimum TLS version.

> [!NOTE]
>By default, Azure SQL Database does not require a specific minimum TLS version. Once you enforce a version of TLS, you can no longer revert to the default.

### Certificates

You must run SQL Server Configuration Manager with a local administrator account in order to install certificates for use by SQL Server.

Furthermore, the certificate must satisfy the following conditions:

- The certificate must be located in the local computer certificate store or the current user certificate store.

- The SQL Server service account must have permission to access the certificate.

- The certificate must be within a valid period.

> [!NOTE]
>If the correct access is not provided, restarting SQL Server service will fail.

For a complete list of requirements when installing a TLS certificate, see [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine).

### Configure SQL Server instance

You can configure a SQL Server instance to use encrypted connections by following these steps:

1. On the **SQL Server Configuration Manager**, expand **SQL Server Network Configuration**, right-click **Protocols for &lt;server instance&gt;**, and then select **Properties**.

    :::image type="content" source="../media/module-33-security-final-12_3.png" alt-text="SQL Server Configuration Manager screen":::

1. From the **Protocols for &lt;server instance&gt; Properties** dialog box, select the **Certificate** tab, then select the certificate from the **Certificate** drop-down.

    :::image type="content" source="../media/module-33-security-final-12_4.png" alt-text="Protocols dialog box":::

1. On the **Flags** tab, in the **ForceEncryption** property, select **Yes**, and then click **OK**.

    :::image type="content" source="../media/module-33-security-final-12_5.png" alt-text="Protocols for SQL Server instance properties":::

1. Restart the SQL Server service.

Once the necessary configuration is in place, you can test the connection through SQL Server Management Studio:

1. In the **Connect to Server** dialog box, complete the connection information, and then click **Options**.

1. On the **Connection Properties** tab, click **Encrypt connection**, and then **Connect**.

    :::image type="content" source="../media/module-33-security-final-12_2.png" alt-text="Connect to Server encrypt connection feature on SSMS":::

All steps must have been executed correctly for you to be able to authenticate through SQL Server Management Studio using TLS.
