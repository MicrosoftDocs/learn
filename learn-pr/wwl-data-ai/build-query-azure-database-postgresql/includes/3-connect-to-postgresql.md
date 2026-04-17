Establishing secure connections to Azure Database for PostgreSQL requires understanding connection string components, authentication options, and transport layer security configuration. For AI applications that frequently read and write data, getting connection configuration right from the start prevents authentication failures and security vulnerabilities in production.

## Connection fundamentals

PostgreSQL connections require several parameters that identify the server, database, and user credentials. Azure Database for PostgreSQL uses a specific endpoint format and enforces secure transport by default.

Your server endpoint follows the pattern `<server-name>.postgres.database.azure.com`, where `<server-name>` is the unique name you specified when creating the server. The fully qualified domain name (FQDN) resolves to the server's public IP address when using public access, or a private IP address when using VNet integration.

A PostgreSQL connection requires these core parameters: the host (server FQDN), port (5432 for direct connections or 6432 for PgBouncer), database name, username (for Entra auth, use `username@servername` format), password (static or Entra token), and SSL mode. Different client libraries and tools accept these parameters in various formats, including connection strings, keyword-value pairs, or individual parameters.

## Authentication methods

Azure Database for PostgreSQL supports two authentication approaches: Microsoft Entra authentication provides stronger security through token-based access, while PostgreSQL native authentication uses traditional username and password credentials.

Microsoft Entra authentication uses OAuth 2.0 tokens instead of passwords. This approach integrates with Azure's identity platform and provides centralized identity management, eliminates password storage (tokens are short-lived), supports managed identities for Azure-hosted applications, and creates audit trails in Entra sign-in logs. To use Entra authentication, configure a Microsoft Entra administrator on your server (a user account, group, or service principal). Once configured, Entra identities connect by obtaining a token from the `https://ossrdbms-aad.database.windows.net` resource.

The connection process works as follows:

1. Your application requests an access token from Microsoft Entra ID.
1. Entra validates the identity and returns a token.
1. Your application connects to PostgreSQL using the token as the password.
1. PostgreSQL validates the token against the configured Entra administrator.

In Python, you can use the `azure-identity` library to obtain tokens:

```python
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()
token = credential.get_token("https://ossrdbms-aad.database.windows.net/.default")
# Use token.token as the password in your connection string
```

The `DefaultAzureCredential` class automatically tries multiple authentication methods in order, including managed identity (when running on Azure), Azure CLI credentials (for local development), and other options.

PostgreSQL native authentication stores usernames and encrypted passwords in the database. This approach is appropriate when applications can't use Entra authentication (legacy applications), you need to grant access to identities outside your Entra tenant, or you're running in an environment without Azure connectivity during development. When using PostgreSQL authentication, store passwords in Azure Key Vault rather than application configuration, rotate passwords regularly, use strong randomly generated passwords, and limit the permissions of each database user. The administrator username and password you specify during server creation use PostgreSQL authentication.

## TLS/SSL configuration

Azure Database for PostgreSQL encrypts all connections using Transport Layer Security (TLS). The server requires TLS by default and supports TLS 1.2 and 1.3. Connections using older TLS versions are rejected.

PostgreSQL clients use the `sslmode` parameter to control encryption and certificate validation. The available modes are:

- **disable:** No encryption. Azure rejects connections using this mode.
- **allow:** Encrypts if the server requires it, but doesn't validate certificates.
- **prefer:** Encrypts if the server supports it, but doesn't validate certificates.
- **require:** Enforces encryption but doesn't validate certificates.
- **verify-ca:** Enforces encryption and validates the server certificate against trusted certificate authorities.
- **verify-full:** Enforces encryption, validates the CA, and confirms the certificate hostname matches the server.

For production applications, use `verify-full` to ensure you're connecting to the genuine Azure PostgreSQL server. This mode validates that the server presents a certificate signed by a trusted certificate authority, and that the certificate's common name or subject alternative name matches the server hostname.

The `verify-ca` and `verify-full` modes require your client to have access to the root CA certificates that signed the server's certificate. Most operating systems and Azure hosting environments already include the DigiCert and Microsoft root CAs that Azure Database for PostgreSQL uses. If certificate validation fails, you might need to download the root certificates from Microsoft's PKI repository and configure your client to use them.

## Connection pooling with PgBouncer

Azure Database for PostgreSQL includes built-in PgBouncer, which you can enable through the server's configuration settings in the Azure portal or using the Azure CLI. Once enabled, connect on port 6432 instead of 5432.

> [!IMPORTANT]
> PgBouncer is only available on General Purpose and Memory Optimized compute tiers. If your server uses the Burstable tier, you can't enable built-in PgBouncer.

PgBouncer maintains a pool of connections to the database server and multiplexes client connections onto this pool. This reduces the overhead of connection establishment, which is valuable for applications that make many short-lived connections.

To enable PgBouncer using the Azure CLI:

```azurecli
az postgres flexible-server parameter set \
    --resource-group myResourceGroup \
    --server-name myserver \
    --name pgbouncer.enabled \
    --value true
```

After enabling, update your connection string to use port 6432:

```
postgresql://user@myserver.postgres.database.azure.com:6432/mydb?sslmode=require
```

Connection pooling optimization strategies, including pool sizing and transaction vs. session modes, are covered in the "Optimize performance, indexing, and scaling" module.

## Network access considerations

Azure Database for PostgreSQL supports two networking models: public access with firewall rules, and private access with VNet integration. Your platform or operations team typically configures these settings, but understanding them helps you troubleshoot connection issues.

With **public access**, the server has a public IP address and firewall rules control which client IPs can connect. If you can't connect from your development machine, verify that your IP address is allowed in the firewall rules.

With **private access**, the server has only a private IP address within an Azure Virtual Network. You can only connect from resources within the same VNet, peered networks, or through VPN/ExpressRoute. Private access is common in production environments where network isolation is required.

## Connection string examples

The following examples show common connection string patterns for Azure Database for PostgreSQL.

```
# Basic connection with SSL required
postgresql://myuser:mypassword@myserver.postgres.database.azure.com/mydb?sslmode=require

# Connection with certificate verification
postgresql://myuser:mypassword@myserver.postgres.database.azure.com/mydb?sslmode=verify-full&sslrootcert=/etc/ssl/certs/ca-certificates.crt

# Connection through PgBouncer (note port 6432)
postgresql://myuser:mypassword@myserver.postgres.database.azure.com:6432/mydb?sslmode=require
```

## Additional resources

- [Connect with TLS to Azure Database for PostgreSQL](/azure/postgresql/flexible-server/how-to-connect-tls-ssl)
- [Microsoft Entra authentication with PostgreSQL](/azure/postgresql/flexible-server/concepts-azure-ad-authentication)
- [Networking overview](/azure/postgresql/flexible-server/concepts-networking)
- [PgBouncer in Azure Database for PostgreSQL](/azure/postgresql/flexible-server/concepts-pgbouncer)
