[Microsoft Entra ID](/entra/fundamentals/whatis?azure-portal=true) provides a cloud-based centralized authentication authority that employs advanced authentication methods. SQL Server 2025 introduces security enhancements for hybrid environments, including improved performance, enhanced [managed identity](/entra/identity/managed-identities-azure-resources/overview?azure-portal=true) integration, streamlined security management, and new encryption capabilities. 

## Enhanced security capabilities in SQL Server 2025

SQL Server 2025 introduces several security improvements for hybrid environments:

### Managed identity support

SQL Server 2025 expands managed identity capabilities for [Azure Arc-enabled SQL Server](/sql/sql-server/azure-arc/overview?azure-portal=true) instances. With managed identity support, you can:

- **Authenticate to Azure resources**: Use the Arc-enabled server managed identity for outbound connections to communicate with Azure resources like [Azure Key Vault](/azure/key-vault/general/overview?azure-portal=true), [Azure Storage](/azure/storage/common/storage-introduction?azure-portal=true), and other Azure services without storing credentials.
- **Enable inbound connections**: Allow external users to connect to SQL Server using Microsoft Entra authentication through managed identity.
- **Backup and restore to URL**: Back up to or restore from Azure Blob Storage using managed identity authentication, eliminating the need to manage shared access signatures or storage account keys.
- **Extensible Key Management (EKM) with Azure Key Vault**: Use managed identity for [EKM](/sql/relational-databases/security/encryption/extensible-key-management-ekm?azure-portal=true) with Azure Key Vault and Managed Hardware Security Modules (HSM), providing a secure way to manage encryption keys.

All managed identity features require SQL Server to be enabled by Azure Arc, emphasizing the importance of hybrid cloud connectivity.

### Advanced encryption capabilities

SQL Server 2025 enhances encryption with new capabilities:

- **OAEP padding mode for RSA encryption**: Support for Optimal Asymmetric Encryption Padding (OAEP) with certificates and asymmetric keys, adding security layers to encryption and decryption processes and aligning with modern cryptographic standards.

- **TLS 1.3 with TDS 8.0 support**: Configure [TLS 1.3](/sql/relational-databases/security/networking/tls-1-3?azure-portal=true) encryption for various SQL Server components including [Always On availability groups](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server?azure-portal=true), failover cluster instances, linked servers, replication topologies, and client tools like sqlcmd and bcp. This provides stronger encryption for data in transit across your hybrid infrastructure.

### Improved password security

SQL Server 2025 enables password-based key derivation function for password hashes by default. This enhancement strengthens password security and helps organizations comply with NIST SP 800-63b standards, providing better protection against brute-force attacks.

### Security cache optimization

SQL Server 2025 optimizes security cache invalidation by affecting only specific login entries rather than the entire cache. When security cache entries are invalidated, only those entries belonging to the affected login are cleared, minimizing the performance impact on other users.

### Support for nonunique display names

SQL Server 2025 introduces support for creating Microsoft Entra logins and users with nonunique display names using the new `WITH OBJECT_ID` syntax in [CREATE LOGIN](/sql/t-sql/statements/create-login-transact-sql?azure-portal=true) and [CREATE USER](/sql/t-sql/statements/create-user-transact-sql?azure-portal=true) statements. This enhancement provides flexibility when working with Microsoft Entra ID accounts that may have duplicate display names across different organizational units.

SQL Server 2025 uses Microsoft Entra ID to provide secure and simplified access management for users, with enhanced monitoring and auditing capabilities that integrate with [Microsoft Purview](/purview/purview?azure-portal=true) and [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction?azure-portal=true).

To see the Microsoft Entra authentication methods available on SQL Server 2025, see [Microsoft Entra authentication for SQL Server](/sql/relational-databases/security/authentication-access/azure-ad-authentication-sql-server-overview)

> [!TIP]
> SQL Server 2025's security features work together to provide protection for hybrid environments. Combine Microsoft Entra authentication with managed identity support, TLS 1.3 encryption, and Azure Arc integration for a security architecture that spans on-premises and cloud resources.

## Exercise: Configure Microsoft Entra authentication

To run this exercise, make sure you meet these requirements before you start:

* SQL Server 2025 (17.x) is installed.
* SQL Server is [connected to Azure](/sql/sql-server/azure-arc/connect?tabs=windows) via Azure Arc.
* [Azure Key Vault](/azure/key-vault/general/overview?azure-portal=true). The user setting up Microsoft Entra admin should have the **Contributor** role on Azure Key Vault.
* *SQL Server – Azure Arc* resource should have the **Contributor** role for the server.

> [!NOTE]
> SQL Server 2025 requires Azure Arc connectivity to enable managed identity support and security features like backup to URL with managed identity and Extensible Key Management with Azure Key Vault.

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

SQL Server 2025 provides simplified access management for SQL Server users authenticating using Microsoft Entra ID, with enhanced performance, improved managed identity support, and better integration with Azure security services. The authentication process benefits from optimized token caching and reduced latency, making it suitable for hybrid environments where users need secure access to both on-premises and cloud resources.
