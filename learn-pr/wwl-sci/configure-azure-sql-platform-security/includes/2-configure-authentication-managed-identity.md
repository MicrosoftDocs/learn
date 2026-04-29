Modern cloud applications require identity-based authentication that eliminates password sprawl and enforces multifactor authentication. Contoso Financial Services discovered that their AI fraud detection service uses SQL authentication with a shared password stored in a configuration file—a security risk identified during their security review.

:::image type="content" source="../media/managed-identity-authentication-flow.png" alt-text="Before and after diagram comparing SQL password authentication to managed identity token flow via Microsoft Entra ID, with no stored credentials required." lightbox="../media/managed-identity-authentication-flow.png":::

| Configuration step | Action |
|-------------------|--------|
| Set Microsoft Entra admin | Assign a user or group as the Microsoft Entra administrator |
| Enable Entra-only auth | Disable SQL Server authentication at the server level |
| Create contained users | Map Microsoft Entra identities or managed identities to database users |
| Grant permissions | Assign roles using standard T-SQL GRANT statements |

## Set up Microsoft Entra ID–only authentication

Microsoft Entra ID–only authentication disables SQL logins and SQL Server authentication at the server level. When you enable this mode, traditional username-password authentication stops working, and all connections must authenticate using Microsoft Entra credentials.

Before enabling Entra-only authentication, you must set an Microsoft Entra admin on the logical SQL server or SQL Managed Instance. This admin has full control over the database and can create more Microsoft Entra users. In the Azure portal, navigate to your SQL server. Select **Settings** > **Microsoft Entra ID**, then choose **Set admin** to assign a user or group. You can also use Azure CLI:

```azurecli
az sql server ad-admin create \
  --resource-group ContosoFinancialRG \
  --server-name contoso-sql-server \
  --display-name "SQL Administrators" \
  --object-id <group-object-id>
```

Using a Microsoft Entra group as the admin is the recommended approach. An admin group lets you manage membership in Microsoft Entra ID without reconfiguring the SQL server when personnel changes occur. After the Microsoft Entra admin is set, you can enable Entra-only authentication through the portal or via Azure CLI. Once enabled, SQL authentication is prevented from connecting at the server level—existing SQL authentication logins and users remain in the system but can't establish connections. New SQL authentication logins can be created by Microsoft Entra accounts with proper permissions, but those accounts also can't connect while Entra-only mode is active. All successful connections must authenticate through Microsoft Entra ID.

This configuration brings three security benefits: it eliminates password sprawl by removing local SQL credentials, enables MFA enforcement through Microsoft Entra authentication policies, and allows Conditional Access policies to control access based on location, device compliance, or risk level.

> [!IMPORTANT]
> Enabling Entra-only authentication immediately disables all SQL authentication logins. Ensure you have an Microsoft Entra admin configured and tested before enabling this mode in production environments.

## Create contained database users for managed identities

Microsoft Entra users and managed identities are added to databases as contained database users, not server logins. A contained database user exists within the database itself and authenticates directly against Microsoft Entra ID. This approach simplifies permission management and aligns with modern cloud identity patterns.

For Contoso's fraud detection AI service, you create a system-assigned managed identity on the Azure Function that runs the fraud detection logic. System-assigned managed identities are automatically created and lifecycle-tied to the resource—when you delete the Function, the identity is deleted. Alternatively, user-assigned managed identities are created independently and can be assigned to multiple resources, which is useful when multiple AI services access the same database.

To grant the managed identity access, connect to the database as the Microsoft Entra admin and run T-SQL:

```sql
CREATE USER [FraudDetectionFunction] FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER [FraudDetectionFunction];
```

The first statement creates a contained database user mapped to the managed identity. The name in brackets must match the name of the Azure resource with the managed identity. The second statement grants read-only access by adding the user to the `db_datareader` role. For write access, use `db_datawriter`, or grant specific permissions using standard `GRANT` statements.

You can also create user for Microsoft Entra groups, which simplifies permission management when multiple users or services need the same access:

```sql
CREATE USER [SecurityEngineers] FROM EXTERNAL PROVIDER;
GRANT VIEW DATABASE STATE TO [SecurityEngineers];
```

After you create the database user, the application connection string uses `Authentication=Active Directory Managed Identity`. No passwords or secrets are needed—the Azure platform handles token acquisition and rotation automatically.

> [!TIP]
> Test managed identity access from the application before disabling SQL authentication. Use Azure Monitor or query diagnostics to verify successful authentication events.

## Assign Azure RBAC roles for SQL security management

Azure RBAC roles control who can manage SQL resources, but they don't grant access to data inside databases. This separation ensures that management permissions don't automatically grant data access—a principle of least privilege. As a cloud security engineer configuring platform-level security, you work primarily with management roles.

The **SQL Security Manager** role (ID: `056cd41c-7e88-42e1-933e-88ba6a50c9c3`) grants permissions to manage security policies including firewall rules, encryption settings, auditing configuration, dynamic data masking, and row-level security. This role is designed for security engineers who configure security controls but don't need to read or modify data. With this role, you configure authentication settings like the Microsoft Entra admin and enable Entra-only authentication.

In contrast, the **SQL Server Contributor** role manages SQL servers and databases but doesn't grant security policy management. The **SQL DB Contributor** role manages individual databases but also lacks security policy permissions. For Contoso's security team, the SQL Security Manager role provides the appropriate scope: they configure authentication, set firewall rules, and enable auditing, but they don't access customer transaction data.

| Role | Security policies | Database management | Data access |
|------|------------------|---------------------|-------------|
| SQL Security Manager | ✓ | – | – |
| SQL Server Contributor | – | ✓ | – |
| SQL DB Contributor | – | ✓ (database only) | – |

One key distinction: authentication controls who can connect, while network controls (like firewall rules) control where connections come from. Both must be correctly configured. Passing authentication doesn't bypass network rules, and passing network rules doesn't bypass authentication. As a security engineer, you configure both layers to create defense in depth.

For Contoso's deployment, the security team uses the SQL Security Manager role to enable Entra-only authentication across all SQL servers. This ensures consistent authentication policy enforcement without granting unnecessary data access to the security team. Application teams create contained database users and grant permissions based on least-privilege principles.

With Microsoft Entra authentication and managed identity access configured, you're ready to restrict which networks can connect to your SQL resources.

