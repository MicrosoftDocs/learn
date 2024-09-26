The Azure managed identity is a free feature that's included with Microsoft Entra ID. You can use this feature to authenticate an identity to any Azure service that supports Microsoft Entra ID.

In this module, you explored service principals on the Azure platform. You saw how to use managed identities instead of service principals to authenticate your applications. If your code runs on a supported service, managed identities offer a more automated and secure way to manage credentials. Managed identities reduce the complexity of application authentication.

## Learn more

- [Azure services that can use managed identities to access other services](/entra/identity/managed-identities-azure-resources/managed-identities-status)
- [Getting started on integrating Microsoft Entra ID with applications](/entra/identity/enterprise-apps/plan-an-application-integration)
- [Getting started on managing service principals by using C#](/samples/azure-samples/aad-dotnet-manage-service-principals/getting-started-on-managing-service-principals-using-c/)
- [Create an Azure service principal by using the Azure CLI](/cli/azure/azure-cli-sp-tutorial-1)
- [Application and service principal objects in Microsoft Entra ID](/entra/identity-platform/app-objects-and-service-principals)
- [Service-to-service authentication to Azure Key Vault using .NET](/dotnet/api/overview/azure/service-to-service-authentication)
- [Documentation for DefaultAzureCredential](https://github.com/Azure/azure-sdk-for-net/blob/master/sdk/identity/Azure.Identity/README.md#defaultazurecredential)
