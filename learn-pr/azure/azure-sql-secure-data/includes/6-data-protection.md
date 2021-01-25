Now that your network and identity access are configured and secure, let's consider how to protect your data, whether it's at rest, in motion, or being viewed by users and admins. 

## Data encryption

Encrypted connections are forced by Azure SQL Database and Azure SQL Managed Instance, with the option to additionally specify the inbound Transport Layer Security (TLS) required minimum version (>1.0, >1.1, or >1.2). The recommended task is to force encryption on the client to avoid server negotiation, as well as to not trust the server certificate as a best practice.

Transparent Data Encryption (TDE) provides encryption for data at rest and is on by default for all new Azure SQL Database instances. It can be configured for all deployment options via a switch in the Azure portal, as shown here:  

:::image type="content" source="../media/6-transparent-data-encryption-enabled.png" alt-text="Screenshot of confirming TDE is on.":::  

At the server or instance level, you can also choose to use a service-managed key or use Bring Your Own Key (BYOK). The default is to let the Azure service manage your key. Azure will automatically generate a key to encrypt your databases, and it will manage the key rotations. You've seen how to do this with the Azure portal, but you can also use Azure PowerShell, the Azure CLI, Transact-SQL (T-SQL), or REST APIs.

:::image type="content" source="../media/6-transparent-data-encryption-key.png" alt-text="Server view of TDE options":::  

You can, alternately, use BYOK and take advantage of an Azure key vault. In this scenario, you are responsible for and in full control of a key lifecycle management (key creation, rotation, and deletion), key usage permissions, and auditing of operations on keys.

You can also take advantage of column-level encryption, which is supported in Azure SQL just as it is in SQL Server. Similarly, the Always Encrypted feature is supported just as it is in SQL Server. This process involves using client-side encryption of sensitive data, which uses keys that are never given to the database system. Additionally, the client driver transparently encrypts query parameters and decrypts the encrypted results. There is currently support on encrypted data for equality comparison, including `JOIN`, `GROUP BY`, and `DISTINCT` operators by deterministic encryption.

The Always Encrypted feature with secure enclaves is now avaialable in preview for Azure SQL Database but not yet supported for Azure SQL Managed Instance.

## Dynamic Data Masking

On occasion, you'll want to mask or modify certain data so that nonprivileged users can't see it, but they can still perform queries that include that data. This capability is supported just as it is in SQL Server. However, there are additional capabilities and views in the Azure portal that allow you to see recommendations of fields to mask.

:::image type="content" source="../media/6-mask-recommendations.png" alt-text="Screenshot of Dynamic Data Masking recommendations in the Azure portal.":::

Let's take a look at an example where the data includes sensitive information, such as social security numbers, email addresses, and salaries. You can apply a mask to those columns with the Azure portal or the following T-SQL commands:

```sql
ALTER TABLE [Employee] ALTER COLUMN [SocialSecurityNumber]
ADD MASKED WITH (FUNCTION = 'Partial(0,"XXX-XX-",2)')

ALTER TABLE [Employee] ALTER COLUMN [Email]
ADD MASKED WITH (FUNCTION = 'EMAIL()')

ALTER TABLE [Employee] ALTER COLUMN [Salary]
ADD MASKED WITH (FUNCTION = 'RANDOM(1,20000)')
```

From the preceding commands, you can see that there are multiple ways to apply a mask via functions.

For example, if they're assigned to a role such as *DataOfficers* (this is an example, not an official role), some users might need to be able to view the masked data. They can be given `UNMASK` privileges with the following T-SQL command:

```sql
GRANT UNMASK TO DataOfficers
```

Depending on who is querying, the results would be as shown here:

:::image type="content" source="../media/6-mask-example.png" alt-text="Screenshot of an example of users with unmask access.":::

## Tasks for data protection

To set up and configure data protection, you should:

- Ensure that your applications force connection encryption.
- Evaluate and enable TDE. This is the default setting for new databases but, if you migrate, you might need to enable it.
- Take advantage of Dynamic Data Masking.
- For advanced protection, you can configure the Always Encrypted feature.
