Managed identities can be added to Virtual Machines on Azure. Running your stock-tracking application inside a VM with an assigned managed identity will allow the app to authenticate with the required Azure Key Vault without having to store a username and password in code.

Knowing that your company has migrated your VM from on-premises to Azure, it's now possible to remove the hard-coded authentication details from the applications code and change it to using the more secure **Managed Identities** token to gain access to resources in Azure.

In this unit, you will learn about the management of identity within Azure virtual machines and how it interacts with the Azure Resource Manager to form a more secure working environment for applications and their authentication.

## Managed identity with Azure Windows Virtual Machines

Managed identity in a VM allows the easy accessing of multiple Azure resources automatically without the need to specify any additional credentials. Rather than specifying actual credentials in the source code, managed identities allow an automatic authentication to happen in the background thus keeping your application as easy to use and secure as possible.

You can assign a managed identity to a VM either during its build time, or to an existing VM using the portal, Azure CLI, or Powershell script.

In the previous unit you learned about the two types of managed identity, a **system-assigned managed identity** and a **user-assigned managed identity**, both of them can be created with an Azure VM. In both scenarios, the identities are configured using Azure Resource Manager. The process flow is:

- The VM sends a request for a managed identity from the Azure Resource Manager
- A service principal is created in Azure AD for the VM within the tenant trusted by the subscription
- Azure Resource Manager updates the Azure Instance Metadata Service identity endpoint with the service principal client ID and certificate
- The new service principal information is used to grant the VM access to Azure resources. For your app, to give it access to the Key Vault, use RBAC (Role-Based Access Control) in Azure AD to assign the required role (for example, read or contribute) to the VM's service principal
- A call is made to Azure AD to request an access token by using the Client ID and certificate. Azure AD returns a JSON Web Token access token

Once the configuration is done, accessing those resources is automatic without the need to create any additional credentials.

## Access control and authentication

Access control within Azure is handled using Role-Based Access Control (RBAC). RBAC is an authorization system built upon Azure Resource Manager and allows you to assign fine grained management of access to resources.

Role-based access is how permissions are formed and consist of three elements: the security principal, role definition, and scope.

## Using managed identity in an application

An application running inside an environment such as a VM or Function App using a managed identity can use this identity to authenticate and access other resources.

This process involves a series of requests to the Azure Instance Metadata Service, which validates the identity associated with your app and generates a resource access token. Your app then sends this token to the resource to which it requires access, which authenticates the token. If the token is valid, the resource then verifies the token represents an identity that has the appropriate authorization rights to meet the request. When this test passes, your application can access the resource.

To avoid much of the complexity, it can be hidden using the `AzureServiceTokenProvider` API in your code. An `AzureServiceTokenProvider` object retrieves the principal ID for your app and generates a resource access token. You specify the resource for which the access token should be generated using the `GetAccessTokenAsync` method, and provide the URI of the service hosting the resource. The C# example below generates a token for Azure storage.

```C#
AzureServiceTokenProvider azureServiceTokenProvider = new AzureServiceTokenProvider();
var token = await azureServiceTokenProvider.GetAccessTokenAsync("https://storage.azure.com/");
```

Other Azure Storage APIs can take this token and use it to authenticate and authorize access.
