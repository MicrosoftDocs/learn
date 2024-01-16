Now that your network and identity access are configured and secure, let's consider how to protect your data, whether it's at rest, in motion, or being viewed by users and admins.

## Data encryption

Encrypted connections are forced by Azure SQL Database, with the option to additionally specify the inbound Transport Layer Security (TLS) required minimum version (>1.0, >1.1, or >1.2). We recommend forcing encryption on the client to avoid server negotiation, and not trusting the server certificate as a best practice.

## Transparent data encryption

Transparent Data Encryption (TDE) provides encryption for data at rest and is on by default for all new databases in Azure SQL Database. You can configure it for all deployment options with a switch in the Azure portal, as shown here:  

:::image type="content" source="../media/6-transparent-data-encryption-enabled.png" alt-text="Screenshot of confirming TDE is on in the Azure portal.":::  

At the server level, you can also choose to use a **Service-managed key** or use [Bring Your Own Key (BYOK)](/azure/azure-sql/database/transparent-data-encryption-byok-overview) using the **Customer-managed key** option. The default is to let the Azure service manage your key. Azure automatically generates a key to encrypt your databases, and it manages the key rotations. You've learned how to do this with the Azure portal, but you can also use Azure PowerShell, the Azure CLI, Transact-SQL (T-SQL), or REST APIs.

:::image type="content" source="../media/6-transparent-data-encryption-key.png" alt-text="Screenshot of the TDE options server view.":::  

### Customer-managed keys with TDE

You can alternately use BYOK and take advantage of an Azure key vault. The advantages of using customer-managed keys are:

- Full and granular control over usage and management of the TDE protector
- Transparency of the TDE protector usage
- Ability to implement separation of duties in the management of keys and data within the organization
- The key vault administrator can revoke key access permissions to make encrypted database inaccessible
- Central management of keys in AKV
- Greater trust from your end customers because AKV is designed so that Microsoft can't see or extract encryption keys

You can also take advantage of using a [user-assigned managed identity (UMI)](/azure/azure-sql/database/authentication-azure-ad-user-assigned-managed-identity) with customer-managed keys for TDE, which:

- Enables the ability to pre-authorize key vault access for Azure SQL logical servers by creating a user-assigned managed identity and granting it access to key vault, even before the server or database has been created.
- Allows creation of an Azure SQL logical server with TDE and CMK enabled.
- Enables the same user-assigned managed identity to be assigned to multiple servers, eliminating the need to individually turn on system-assigned managed identity for each Azure SQL logical server and providing it access to key vault.
- Provides the capability to enforce CMK at server creation time with an available built-in Azure policy.

[Automatic key rotation](/azure/azure-sql/database/transparent-data-encryption-byok-key-rotation#automatic-key-rotation) has been introduced for customer-managed keys using TDE. When enabled, the server continuously checks the key vault for any new versions of the key being used as the TDE protector. If a new version of the key is detected, the TDE protector on the server is automatically rotated to the latest key version within 60 minutes.

## Always Encrypted

You can also take advantage of column-level encryption, which is supported in Azure SQL just as it is in SQL Server. This process involves using client-side encryption of sensitive data, which uses keys that are never given to the database system. Additionally, the client driver transparently encrypts query parameters and decrypts the encrypted results. There's currently support on encrypted data for equality comparison, including `JOIN`, `GROUP BY`, and `DISTINCT` operators by deterministic encryption.

[Always Encrypted with secure enclaves](/sql/relational-databases/security/encryption/always-encrypted-enclaves) expands confidential computing capabilities of Always Encrypted by enabling in-place encryption and richer confidential queries. The Always Encrypted feature with secure enclaves is now available for Azure SQL Database, but not yet supported for Azure SQL Managed Instance.

## Dynamic Data Masking

On occasion, you'll want to mask or modify certain data so that nonprivileged users can't see it, but they can still perform queries that include that data. This capability is supported just as it is in SQL Server. However, there are additional capabilities and views in the Azure portal that allow you to see recommendations of fields to mask.

:::image type="content" source="../media/6-mask-recommendations.png" alt-text="Screenshot of Dynamic Data Masking recommendations in the Azure portal.":::

Let's take a look at an example where the data includes sensitive information, such as names and email addresses. You can apply a mask to those columns in the Azure portal by selecting the **Dynamic Data Masking** menu under **Security** in your **SQL database** configuration pane, or by using the following T-SQL commands:

```sql
ALTER TABLE Data.Membership ALTER COLUMN FirstName
ADD MASKED WITH (FUNCTION = 'partial(1, "xxxxx", 1)')

ALTER TABLE Data.Membership ALTER COLUMN Email
ADD MASKED WITH (FUNCTION = 'email()')

ALTER TABLE Data.Membership ALTER COLUMN DiscountCode 
ADD MASKED WITH (FUNCTION = 'random(1, 100)')
 
GRANT UNMASK to DataOfficers
```

From the preceding commands, you can see that there are multiple ways to apply a mask via functions.

For example, if they're assigned to a role such as *DataOfficers* (this is an example, not an official role), some users might need to be able to view the masked data. You can give them `UNMASK` privileges with the following T-SQL command:

```sql
GRANT UNMASK TO DataOfficers
```

Depending on who is querying, the results would be as shown here:

:::image type="content" source="../media/6-mask-example.png" alt-text="Screenshot of an example of users with unmask access.":::

With the introduction to granular dynamic data-masking permissions, you can grant or revoke `UNMASK` permission at the database level, schema level, table level, or at the column level to a database user, Microsoft Entra identity, Microsoft Entra group, or database role.

## Tasks for data protection

To set up and configure data protection, you should:

- Ensure that your applications force connection encryption, and use the highest TLS version that is compatible with your application, clients, and drivers.
- Evaluate and enable [TDE](/azure/azure-sql/database/transparent-data-encryption-tde-overview). This is the default setting for new databases but, if you migrate, you might need to enable it.
- Take advantage of [Dynamic Data Masking](/azure/azure-sql/database/dynamic-data-masking-overview).
- For advanced protection, you can configure the [Always Encrypted with secure enclaves](/azure/azure-sql/database/always-encrypted-enclaves-enable) feature.
