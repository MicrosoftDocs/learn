Authentication with Key Vault works with Microsoft Entra ID, which is responsible for authenticating the identity of any given security principal. A security principal is anything that can request access to Azure resources. This includes:

* Users – Real people with accounts in Microsoft Entra ID.
* Groups – Collections of users. Permissions given to the group apply to all its members.
* Service Principals – Represent apps or services (not people). Think of it like a user account for an app.

For applications, there are two main ways to obtain a service principal:

* Use a managed identity (recommended): Azure creates and manages the service principal for you. The app can securely access other Azure services without storing credentials. Works with services like App Service, Azure Functions, and Virtual Machines.

* Register the app manually: You register the app in Microsoft Entra ID. This creates a service principal and an app object that identifies the app across all tenants.

> [!NOTE]
> It's recommended to use a system-assigned managed identity.

## Authentication to Key Vault in application code

Key Vault SDK is using Azure Identity client library, which allows seamless authentication to Key Vault across environments with same code. The following table provides information on the Azure Identity client libraries:


| .NET | Python | Java | JavaScript |
|--|--|--|--|
| [Azure Identity SDK .NET](/dotnet/api/overview/azure/identity-readme) | [Azure Identity SDK Python](/python/api/overview/azure/identity-readme) | [Azure Identity SDK Java](/java/api/overview/azure/identity-readme) | [Azure Identity SDK JavaScript](/javascript/api/overview/azure/identity-readme) |


## Authentication to Key Vault with REST

Access tokens must be sent to the service using the HTTP Authorization header:

```http
PUT /keys/MYKEY?api-version=<api_version>  HTTP/1.1  
Authorization: Bearer <access_token>
```

When an access token isn't supplied, or when the service rejects a token, an `HTTP 401` error is returned to the client and includes the `WWW-Authenticate` header, for example:

```http
401 Not Authorized  
WWW-Authenticate: Bearer authorization="…", resource="…"
```

The parameters on the `WWW-Authenticate` header are:

* authorization: The address of the OAuth2 authorization service that might be used to obtain an access token for the request.

* resource: The name of the resource (`https://vault.azure.net`) to use in the authorization request.

## Other resources

* [Azure Key Vault developer's guide](/azure/key-vault/general/developers-guide)
* [Azure Key Vault availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance)

