Another authentication mechanism offered by Azure AD is Managed identities.

Imagine that you need to connect from an Azure Data Factory (ADF) to an Azure SQL Database. What identity should ADF present to the database?

:::image type="content" source="../media/azure-data-factory-sql-identity-43931848.png" alt-text="ADF SQL Identity.":::


The traditional answer would have been to use SQL Authentication with a username and password. It leaves yet another credential that needs to be managed on an ongoing basis.

## Identity of the service

Many Azure services expose their own identity. It isn't an identity that you need to manage. For example, you don't need to worry about password policies and so on.

You can assign permissions to that identity, as with any other Azure AD identity.

In the ADF example, you can add the ADF MSI as an Azure SQL Database user and add it to roles within the database.

## Managed identity types

There are two types of managed identities:

 -  System-assigned - It's the types of identities described above. Many, but not all, services expose these identities.
 -  User-assigned - you can create a managed identity as an Azure resource. It can then be assigned to one or more instances of a service.

For more information, see: [What are managed identities for Azure resources?](/azure/active-directory/managed-identities-azure-resources/overview)
