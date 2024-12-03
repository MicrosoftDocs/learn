Azure Database for PostgreSQL automatically encrypts data both in transit, and at rest. You don't need to do anything, encryption is enabled by default.

## Data at rest

Azure Database for PostgreSQL flexible server supports encryption for data at rest by using Azure storage encryption. Encryption's always on and uses Microsoft's managed keys. The encryption uses FIPS (Federal Information Processing Standard) 140-2 validated cryptographic module and an AES (Advanced Encryption Standard) 256-bit cipher.

## Data in transit

Azure Database for PostgreSQL secures data in transit with Transport Layer Security (TLS) and Secure Sockets Layer (SSL) by default.

Flexible server supports TLS 1.2 and 1.3 and can't be disabled.

In the Azure portal, navigate to your Azure Database for PostgreSQL server. Under **Settings**, select **Server Parameters**. In the Search bar, enter **TLS**.

- **ssl_min_protocol_version** - allows you to set the minimus SSL/TLS version to use. This parameter is set to TLS V1.2 by default.
- **ssl_max_protocol_version** - allows you to set the maximum SSL/TLS version to use.
