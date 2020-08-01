Once your network and identity access are configured and secure, the next topic to consider is how to protect your data, whether it is at rest, in motion, or being viewed by users and admins.

## Data encryption

Encrypted connections are forced by Azure SQL Database, with the option to additionally specify the inbound TLS minimum version (>1.0, >1.1, or >1.2) required. For Azure SQL Managed Instance, a TLS version of >1.2 is forced for outbound connections, and you have the same options for inbound TLS as with Azure SQL Database. The recommended task is to force encryption on the client to avoid server negotiation, as well as to not trust server certificate as a best practice.

Transparent Data Encryption (TDE) provides encryption for data at rest and is on by default for all new Azure SQL Databases, and can be configured for all deployment options via a switch in the Azure portal:  

:::image type="content" source="../media/6-transparent-data-encryption-enabled.png" alt-text="Confirm TDE is on":::  

At the server or instance level, you can also choose to use a Service-managed key or you can bring your own key (BYOK). The default is to let the Azure service manage your key. Azure will automatically generate a key to encrypt your databases, and manage the key rotations. You've seen how to do this with the Azure portal, but you can also use PowerShell, Azure CLI, T-SQL, or REST APIs.

:::image type="content" source="../media/6-transparent-data-encryption-key.png" alt-text="Server view of TDE options":::  

You can, alternatively, bring your own key (BYOK) leveraging Azure key vault. In this scenario, you (not Azure) are responsible for and in full control of a key lifecycle management (key creation, rotation, deletion), key usage permissions, and auditing of operations on keys.

You also have the ability to leverage column-level encryption, which is supported in Azure SQL just as it is in SQL Server. Similarly, always encrypted is supported just like in SQL Server. This process involves client-side encryption of sensitive data using keys that are never given to the database system. Additionally, the client driver transparently encrypts query parameters and decrypts the encrypted results. There is currently support on encrypted data for equality comparison, including `JOIN`, `GROUP BY`, and `DISTINCT` operators by deterministic encryption.

Always Encrypted with secure enclaves is not yet available in Azure SQL Database or Azure SQL Managed Instance.

## Dynamic Data Masking

On certain occasions, there is data that you will want to be masked or modified so unprivileged users cannot see the data, but can still perform queries including that data. This capability is supported just like in SQL Server, however there are additional capabilities and views in the Azure portal that allow you to see recommendations of fields to mask.

:::image type="content" source="../media/6-mask-recommendations.png" alt-text="DDM recommendations in Azure portal":::

Let's take a look at example where the data includes sensitive information such as social security numbers, email addresses, and salary values. You can apply a mask to those columns with the Azure portal or the following T-SQL:

```sql
ALTER TABLE [Employee] ALTER COLUMN [SocialSecurityNumber]
ADD MASKED WITH (FUNCTION = 'Partial(0,"XXX-XX-",2)')

ALTER TABLE [Employee] ALTER COLUMN [Email]
ADD MASKED WITH (FUNCTION = 'EMAIL()')

ALTER TABLE [Employee] ALTER COLUMN [Salary]
ADD MASKED WITH (FUNCTION = 'RANDOM(1,20000)')
```

From above, you see that there are multiple ways you can apply a mask via functions.

Some users, for example, if they are assigned to a role such as `DataOfficers` (just an example, not an official role), may need to be able to view the masked data. They can be given `UNMASK` privileges with the following T-SQL:

```sql
GRANT UNMASK TO DataOfficers
```

Depending on who is querying, the results would be as follows.

:::image type="content" source="../media/6-mask-example.png" alt-text="Example of users with Unmask access":::

## Tasks for data protection

In order to set up and configure data protection, you should:

- Ensure your applications force connection encryption
- Evaluate and enable TDE (default for new databases, but if you migrate you may need to enable it)
- Take advantage of Dynamic Data Masking
- For advanced protection, you can configure Always Encrypted
