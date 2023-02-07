
Authentication with Key Vault works in conjunction with Azure Active Directory, which is responsible for authenticating the identity of any given security principal.

For applications, there are two ways to obtain a service principal:

* Enable a system-assigned **managed identity** for the application. With managed identity, Azure internally manages the application's service principal and automatically authenticates the application with other Azure services. Managed identity is available for applications deployed to a variety of services.

* If you cannot use managed identity, you instead register the application with your Azure AD tenant. Registration also creates a second application object that identifies the app across all tenants.

> [!NOTE]
> It is recommended to use a system-assigned managed identity.

Below is information on authenticating to Key Vault without using a managed identity.

## Authentication to Key Vault in application code

Key Vault SDK is using Azure Identity client library, which allows seamless authentication to Key Vault across environments with same code. The table below provides information on the Azure Identity client libraries:


| .NET | Python | Java | JavaScript |
|--|--|--|--|
| [Azure Identity SDK .NET](/dotnet/api/overview/azure/identity-readme) | [Azure Identity SDK Python](/python/api/overview/azure/identity-readme) | [Azure Identity SDK Java](/java/api/overview/azure/identity-readme) | [Azure Identity SDK JavaScript](/javascript/api/overview/azure/identity-readme) |


## Authentication to Key Vault with REST

Access tokens must be sent to the service using the HTTP Authorization header:

```http
PUT /keys/MYKEY?api-version=<api_version>  HTTP/1.1  
Authorization: Bearer <access_token>
```

When an access token is not supplied, or when a token is not accepted by the service, an HTTP 401 error will be returned to the client and will include the `WWW-Authenticate` header, for example:

```http
401 Not Authorized  
WWW-Authenticate: Bearer authorization="…", resource="…"
```

The parameters on the `WWW-Authenticate` header are:

* authorization: The address of the OAuth2 authorization service that may be used to obtain an access token for the request.

* resource: The name of the resource (`https://vault.azure.net`) to use in the authorization request.

## Additional resources

* [Azure Key Vault developer's guide](/azure/key-vault/general/developers-guide)
* [Azure Key Vault availability and redundancy](/azure/key-vault/general/disaster-recovery-guidance)
