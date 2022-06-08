Azure Database for PostgreSQL automatically encrypts data both in transit, and at rest. You don't need to do anything to enable this, it is enabled by default.

## Data at rest

Azure Database for PostgreSQL flexible server supports encryption for data at rest by leveraging Azure storage encryption. This is always on and uses Microsoft's managed keys. The encryption uses FIPS 140-2 validated cryptographic module and an AES 256-bit cipher.

Single server also supports customer managed encryption keys (BYOK) using Azure Key Vault and customer-managed keys. The key must have the following properties enabled:

- Soft delete
- Enable purge protection

The key must also have the following attributes:

- No expiration date
- Not disabled
- Able to perform get, wrap key, and unwrap key operations

Your Azure Database for PostgreSQL single server must also be registered in Azure Key Vault. You will be prompted to register your server principal when you attempt to set up data encryption for the first time.

> [!NOTE]
> Azure Database for PostgreSQL does not support customer managed encryption keys on flexible server.

## Data in transit

Azure Database for PostgreSQL secures data in transit with Transport Layer Security (TLS) and SSL by default.

- Single server supports TLS 1.2 and gives you the option to disable SSL if your client application does not support it.
- Flexible server supports TLS 1.2 and 1.3 and cannot be disabled.

In the Azure portal, navigate to your Azure Database for PostgreSQL server. Under **Settings**, select **Server Parameters**. In the Search bar, enter TLS.

- **ssl_min_protocol_version** - allows you to set the minimus SSL/TLS version to use. This is set to TLS V1.2 by default.
- **ssl_max_protocol_version** - allows you to set the maximum SSL/TLS version to use.

## Infrastructure double encryption enabled

You can also add a second layer of encryption for data at rest. This uses service-managed keys but is not enabled by default because of the performance impact of additional encryption. This second layer of encryption also uses FIPS 140-2 validated cryptographic module, but with a different encryption algorithm. Infrastructure Layer encryption has the benefit of being implemented at the layer closest to the storage device or network wires, and close to hardware that stores data at rest. 

You must enable infrastructure double encryption when the server is created. When a new Azure Database for PostgreSQL single server is being created, select the **Additional Settings** tab. Select **Infrastructure double encryption enabled**.

> [!NOTE]
> Infrastructure double encryption is only supported on General Purpose and Memory Optimized compute tiers.
