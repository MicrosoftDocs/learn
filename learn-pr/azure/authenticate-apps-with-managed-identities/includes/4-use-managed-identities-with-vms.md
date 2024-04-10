You decide to run your stock-tracking application inside a VM that has an assigned managed identity. This setup allows the app to use an Azure key vault to authenticate without having to store a username and password in code.

Now that your company has migrated your VM from on-premises to Azure, you can remove the hard-coded authentication details from the application code. You want to use the more secure managed identity token to access Azure resources.

In this unit, you'll learn how identity is managed within Azure VMs. You'll also learn how it interacts with Azure Resource Manager to form a more secure environment for applications.

## Managed identity within Azure virtual machines

In a VM, use a managed identity to access multiple Azure resources without having to specify credentials in your application's code. Managed identities allow for automatic authentication in the background. Your application remains as easy to use and as secure as possible.

You can assign a managed identity to a VM during its build creation or anytime afterwards. You can assign a managed identity to an existing VM by using the Azure portal, Azure CLI, or PowerShell.

In the previous unit, you learned about *system-assigned managed identities* and *user-assigned managed identities*. You can enable a system-assigned managed identity from the **Identity** section in a VM's settings. When you do, here's what happens:

1. The VM sends a request for a managed identity.
1. In Microsoft Entra ID, a service principal is created for the VM within the tenant that the subscription trusts.
1. Azure Resource Manager updates the Azure Instance Metadata Service identity endpoint with the service principal client ID and certificate.
1. The new service principal information is used to grant the VM access to Azure resources. To give your app access to the key vault, use role-based access control (RBAC) in Microsoft Entra ID. Assign the required role to the VM's service principal. For example, you could assign the Reader or Contributor roles.
1. A call is made to Microsoft Entra ID to request an access token by using the client ID and certificate.
1. Microsoft Entra ID returns a JSON Web Token access token.

When the configuration finishes, you don't need to create any other credentials to access other resources hosted in Azure that support Microsoft Entra authentication.

## Access control and authentication

RBAC is an authorization system that's built on Azure Resource Manager. You can use it to grant fine-grained access to resources in Azure.

Permissions are formed by role-based access. Role-based access consists of three elements: the security principal, role definition, and scope.

## Use managed identity in an application

An application that runs on an Azure resource, such as a VM or a function app, uses a managed identity to authenticate and access other resources.

The authentication and access process involves a series of requests to the Azure Instance Metadata Service:

1. The service validates the identity that's associated with your app.
1. It generates a resource access token.
1. Your app sends the token to the resource that it needs to access.
1. The token is authenticated.
1. If the token is valid, the resource verifies that the token represents an identity that has the appropriate authorization for the request.
1. When this test passes, your application can access the resource.

To avoid much of the complexity, you can use the `AzureServiceTokenProvider` API in your code. An `AzureServiceTokenProvider` object retrieves the principal ID for your app and generates a resource access token. Use the `GetAccessTokenAsync` method to specify the resource for which the access token should be generated. Provide the URI of the service that hosts the resource.

The following C# example generates a token for Azure Storage.

```C#
AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
var token = await azureServiceTokenProvider.GetAccessTokenAsync("https://storage.azure.com/");
```

Other Azure Storage APIs can use this token to authenticate and to authorize access.
