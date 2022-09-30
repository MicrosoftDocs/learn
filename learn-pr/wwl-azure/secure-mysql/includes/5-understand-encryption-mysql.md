## Data in Transit

Azure Database for MySQL supports encrypted connections using TLS 1.2. This protocol is enabled by default and is managed by the **tls_version** server parameter. This parameter allows you to enforce the minimum TLS version the server permits. You can select more than one version, for example if you want to allow TLS 1.2 and 1.3. When you change this parameter, you must restart the server to apply the change.

:::image type="content" source="../media/tls-versions.png" alt-text="Screenshot showing the server parameter tls_version page." lightbox="../media/tls-versions.png":::

If your client application doesn't support encrypted connections, you'll need to disable encrypted connections in Azure Database for MySQL. In the Azure portal, navigate to your MySQL server, and under **Settings** select **Server parameters**. In the search box, enter **require_secure_transport**. This parameter defines whether client connections must use a secure connection, that is, SSL over TCP/IP or connections that use a socket file on Unix, or shared memory on Windows. If your client application doesn't support encrypted connections, set **require_secure_transport** to **OFF**.

> [!NOTE]
> If you set **require_secure_transport** to **OFF**, but a client connects with an encrypted connection, it will still be accepted.

To use encrypted connections with your client applications, download the public SSL certificate in the Azure portal. Navigate to your MySQL server and from the left menu select **Networking**. From the top menu, select **Download SSL Certificate**. To allow applications to connect securely to the database over SSL, save the certificate file to your local environment or the client environment where your application is hosted.

## Data at rest

Data at rest encryption is supported in the InnoDB storage engine. Encryption is set at the tablespace level and InnoDB supports encryption for the following tablespaces: file-per-table, general, and system. For MySQL version 8.0, ensure the server parameter **default_table_encryption** is set to **ON** (it's **OFF** by default). For a table that is encrypted, you can also encrypt the redo log. This is disabled by default.

To encrypt a table in a file per table tablespace:

```sql
CREATE TABLE myEncryptedTable (myID INT) ENCRYPTION = 'Y';
```

If you then alter a table, the encryption clause must be specified:

```sql
ALTER TABLE myEncryptedTable ENCRYPTION = 'Y';
```

Azure Database for MySQL supports data at rest encryption by default, using Microsoft's managed keys. Data and backups are always encrypted on disk, and this can't be disabled.
