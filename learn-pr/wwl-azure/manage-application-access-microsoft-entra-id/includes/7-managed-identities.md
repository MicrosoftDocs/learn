A common challenge for developers is the management of secrets, credentials, certificates, and keys used to secure communication between services. Managed identities eliminate the need for developers to manage these credentials.

While developers can securely store the secrets in Azure Key Vault, services need a way to access Azure Key Vault. Managed identities provide an automatically managed identity in Microsoft Entra ID for applications to use when connecting to resources that support Microsoft Entra authentication. Applications can use managed identities to obtain Microsoft Entra tokens without having to manage any credentials.

## Here are some of the benefits of using managed identities

 -  You don't need to manage credentials. Credentials aren’t even accessible to you.<br>
 -  You can use managed identities to authenticate to any resource that supports Microsoft Entra authentication, including your own applications.
 -  Managed identities can be used at no extra cost.

## Managed identity types

There are two types of managed identities:

1.  System-assigned. Some Azure resources, such as virtual machines allow you to enable a managed identity directly on the resource. When you enable a system-assigned managed identity:

 -  A service principal of a special type is created in Microsoft Entra ID for the identity. The service principal is tied to the lifecycle of that Azure resource. When the Azure resource is deleted, Azure automatically deletes the service principal for you.
 -  By design, only that Azure resource can use this identity to request tokens from Microsoft Entra ID.
 -  You authorize the managed identity to have access to one or more services.
 -  The name of the system-assigned service principal is always the same as the name of the Azure resource it is created for. For a deployment slot, the name of its system-assigned identity is `<app-name>/slots/<slot-name>`.

2.  User-assigned. You may also create a managed identity as a standalone Azure resource. You can create a user-assigned managed identity and assign it to one or more Azure Resources. When you enable a user-assigned managed identity:<br>

 -  A service principal of a special type is created in Microsoft Entra ID for the identity. The service principal is managed separately from the resources that use it.<br>
 -  User-assigned identities can be used by multiple resources.
 -  You authorize the managed identity to have access to one or more services.

The following table shows the differences between the two types of managed identities:

| **Property**                   | **System-assigned managed identity**                                                                                                                                   | **User-assigned managed identity**                                                                                                                                                                                                                                                                                                                                |
| ------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Creation                       | Created as part of an Azure resource (for example, Azure Virtual Machines or Azure App Service).                                                                       | Created as a stand-alone Azure resource.                                                                                                                                                                                                                                                                                                                          |
| Life cycle                     | Shared life cycle with the Azure resource that the managed identity is created with.<br>When the parent resource is deleted, the managed identity is deleted as well.  | Independent life cycle.<br>Must be explicitly deleted.                                                                                                                                                                                                                                                                                                            |
| Sharing across Azure resources | Can’t be shared.<br>It can only be associated with a single Azure resource.                                                                                            | Can be shared.<br>The same user-assigned managed identity can be associated with more than one Azure resource.                                                                                                                                                                                                                                                    |
| Common use cases               | Workloads contained within a single Azure resource.<br>Workloads needing independent identities.<br>For example, an application that runs on a single virtual machine. | Workloads that run on multiple resources and can share a single identity.<br>Workloads needing pre-authorization to a secure resource, as part of a provisioning flow.<br>Workloads where resources are recycled frequently, but permissions should stay consistent.<br>For example, a workload where multiple virtual machines need to access the same resource. |

## How can I use managed identities for Azure resources?

You can use managed identities by following the steps below:

1.  Create a managed identity in Azure. You can choose between system-assigned managed identity or user-assigned managed identity.

 -  When using a user-assigned managed identity, you assign the managed identity to the "source" Azure Resource, such as a Virtual Machine, Azure Logic App or an Azure Web App.

2.  Authorize the managed identity to have access to the "target" service.
3.  Use the managed identity to access a resource. In this step, you can use the Azure SDK with the Azure.Identity library. Some "source" resources offer connectors that know how to use Managed identities for the connections. In that case, you use the identity as a feature of that "source" resource.

## What Azure services support the feature?

Managed identities for Azure resources can be used to authenticate to services that support Microsoft Entra authentication.

## Which operations can I perform on managed identities?

Resources that support system assigned managed identities allow you to:

 -  Enable or disable managed identities at the resource level.<br>
 -  Use role-based access control (RBAC) to grant permissions.
 -  View the create, read, update, and delete (CRUD) operations in Azure Activity logs.
 -  View sign in activity in Microsoft Entra ID sign in logs.

If you choose a user assigned managed identity instead:

 -  You can create, read, update, and delete the identities.<br>
 -  You can use RBAC role assignments to grant permissions.
 -  User assigned managed identities can be used on more than one resource.
 -  CRUD operations are available for review in Azure Activity logs.
 -  View sign in activity in Microsoft Entra ID sign in logs.

Operations on managed identities can be performed by using an Azure Resource Manager template, the Azure portal, Azure CLI, PowerShell, and REST APIs.
