Managed identities can be added to virtual machines on Azure. Running your stock-tracking application inside a VM with an assigned managed identity allows the app to authenticate with an Azure key vault without having to store a username and password in code.

Knowing that your company has migrated your VM from on-premises to Azure, you can now remove the hard-coded authentication details from the application code. You can use the more secure managed Identity token to access resources in Azure.

In this unit, you'll learn about the management of identity within Azure VMs and how it interacts with the Azure Resource Manager to form a more secure environment for applications.

## Managed identity with Azure Windows Virtual Machines

You use managed identity in a VM to access multiple Azure resources without having to specify additional credentials. Rather than specifying actual credentials in the source code, managed identities allow an automatic authentication to happen in the background. You'll keep your application as easy to use and secure as possible.

You can assign a managed identity to a VM either during its build time, or to an existing VM using the portal, Azure CLI, or PowerShell script.

In the previous unit, you learned about a **system-assigned managed identity** and a **user-assigned managed identity**, both of which can be created with an Azure VM. The identities are configured using Azure Resource Manager in both scenarios. The process flow is:

- The VM sends a request for a managed identity from the Azure Resource Manager.
- A service principal is created in Azure AD for the VM within the tenant that's trusted by the subscription.
- Azure Resource Manager updates the Azure Instance Metadata Service identity endpoint with the service principal client ID and certificate.
- The new service principal information is used to grant the VM access to Azure resources. For your app, to give it access to the key vault, use role-based access control (RBAC) in Azure AD to assign the required role to the VM's service principal. For example, read or contribute.
- A call is made to Azure AD to request an access token by using the client ID and certificate. Azure AD returns a JSON Web Token access token.

When configuration is complete, you don't need to create any additional credentials to access those resources.

## Access control and authentication

Use RBAC to handle access control within Azure. RBAC is an authorization system built on Azure Resource Manager, and allows you to assign fine grained management of access to resources.

Role-based access is how permissions are formed and consist of three elements: the security principal, role definition, and scope.

## Using managed identity in an application

An application that runs inside an environment, such as a VM or function app using a managed identity, uses this identity to authenticate and access other resources.

This process involves a series of requests to the Azure Instance Metadata Service, which validates the identity associated with your app, and generates a resource access token. Your app then sends this token to the resource to which it requires access. The token is then authenticated. If the token is valid, the resource verifies that it represents an identity with the appropriate authorization rights to meet the request. When this test passes, your application can access the resource.

To avoid much of the complexity, you can use the `AzureServiceTokenProvider` API in your code. An `AzureServiceTokenProvider` object retrieves the principal ID for your app and generates a resource access token. You specify the resource for which the access token should be generated using the `GetAccessTokenAsync` method. You provide the URI of the service hosting the resource. The C# example below generates a token for Azure Storage:

```C#
AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
var token = await azureServiceTokenProvider.GetAccessTokenAsync("https://storage.azure.com/");
```

Other Azure Storage APIs can take this token and use it to authenticate and authorize access.
