The Azure managed identity is a free feature included with Azure Active Directory. This feature offers the functionality to authenticate an identity to any Azure service that supports Azure AD.

In this module, you explored service principals in the Azure platform. You saw how to use managed identities instead of service principals to authenticate your applications. If your code runs on a supported service, managed identities offer a more automated and secure method to do credential management. The complexity of application authentication is reduced.

## Learn more

- The list of services supporting managed identities, including region availability and configuration options, is available in the [Azure documentation](https://docs.microsoft.com/azure/active-directory/managed-identities-azure-resources/services-support-managed-identities)
- [Integrating Azure Active Directory with the application getting started guide](https://docs.microsoft.com/azure/active-directory/manage-apps/plan-an-application-integration)
- [Getting started on managing service principals using C#](https://azure.microsoft.com/resources/samples/aad-dotnet-manage-service-principals/)
- [Create an Azure service principal with Azure CLI](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest)
- [Application and service principal objects in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/develop/app-objects-and-service-principals)
- [Service-to-service authentication to Azure Key Vault using .NET](https://docs.microsoft.com/azure/key-vault/service-to-service-authentication)