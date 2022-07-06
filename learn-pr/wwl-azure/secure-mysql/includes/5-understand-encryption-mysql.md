## Data in Transit

Azure Database for MySQL Flexible server supports encrypted connections using TLS 1.2. This is enabled by default and is managed by the **tls_version** server parameter. This parameter allows you to enforce the minimum TLS version the server permits. You can select more than one version, for example if you want to allow TLS 1.2 and 1.3. When you change this parameter, you must restart the server to apply the change.

:::image type="content" source="../media/tls-versions.png" alt-text="Screenshot showing the Server parameter tls_version page." lightbox="../media/tls-versions.png":::

If your client application doesn't support encrypted connections, you'll need to disable encrypted connections in Azure Database for MySQL flexible server. In the Azure portal, navigate to your flexible server, and under **Settings** select **Server parameters**. In the search box, enter **require_secure_transport**. This parameter defines whether client connections must use a secure connection, that is, SSL over TCP/IP or connections that use a socket file on Unix, or shared memory on Windows. If your client application doesn't support encrypted connections, set **require_secure_transport** to OFF.

> [!NOTE]
> If you set **require_secure_transport** to OFF on flexible server, but a client connects with an encrypted connection, it will still be accepted.

To use encrypted connections with your client applications, download the public SSL certificate in the Azure portal. Navigate to your flexible server and from the left menu select **Networking**. From the top menu, select **Download SSL Certificate**. To allow applications to connect securely to the database over SSL, save the certificate file to your local environment or the client environment where your application is hosted.

Azure Database for MySQL single server allows you to select whether or not to enforce an SSL connection. You can also set the minimum TLS version that the server will permit. In the Azure portal, navigate to your single server and from the left menu under **Settings**, select **Connection security**. Select **Save** to save any changes. Single server doesn't require you to restart the server.

:::image type="content" source="../media/single-server-ssl.png" alt-text="Screenshot showing the Connection security page." lightbox="../media/single-server-ssl.png":::

## Data at rest

Data at rest encryption is supported in the InnoDB storage engine. Encryption is set at the tablespace level and InnoDB supports encryption for the following tablespaces: file per table, general, and system. For MySQL version 8.0, ensure the server parameter **default_table_encryption** is set to ON (it's OFF by default). For a table that is encrypted, you can also encrypt the redo log. This is disabled by default.

To encrypt a table in a file per table tablespace:

```sql
CREATE TABLE myEncryptedTable (myID INT) ENCRYPTION = 'Y';
```

If you then alter a table, the encryption clause must be specified:

```sql
ALTER TABLE myEncryptedTable ENCRYPTION = 'Y';
```

Azure Database for MySQL flexible server supports data at rest encryption by default, using Microsoft's managed keys. Data and backups are always encrypted on disk, and this can't be disabled. Azure Database for MySQL single server supports data at rest using customer managed keys.

## Infrastructure double encryption

Optionally, you can add a second layer of encryption for data at rest. This also uses service-managed keys but isn't enabled by default because this additional encryption can have an impact on performance. This second layer of encryption also uses FIPS 140-2 validated cryptographic module, but with a different encryption algorithm. Infrastructure Layer encryption has the benefit of being implemented at the layer closest to the storage device or network wires, and close to hardware that stores data at rest.

You must enable infrastructure double encryption is made when the server is created. When a new Azure Database for MySQL single server is being created, select the **Additional Settings** tab. Select **Infrastructure double encryption enabled**.

:::image type="content" source="../media/single-server-double-encryption.png" alt-text="Screenshot showing the Create MySQL server page." lightbox="../media/single-server-double-encryption.png":::

> [!NOTE]
> Infrastructure double encryption is only supported on Single Server General purpose v2 and Memory Optimized pricing tiers. This is the same for data at rest encryption.

Infrastructure double encryption provides the following benefits:

- **Diversity of crypto implementation** - over time hardware-based encryption will provide addition protection over and above software-based encryption.
- **Implementation errors** - two layers of encryption protect against any errors in caching or memory management that might expose plaintext data. Two layers also provide additional protection against errors in the encryption implementation.

> [!NOTE]
> Data at rest encryption is also supported on single server with customer managed keys (BYOK).
