A common challenge for developers is the management of secrets, credentials, certificates, and keys used to secure communication between services. Managed identities eliminate the need for developers to manage these credentials.

While developers can securely store the secrets in Azure Key Vault, services need a way to access Azure Key Vault. Managed identities provide an automatically managed identity in Microsoft Entra ID for applications to use when connecting to resources that support Microsoft Entra authentication. Applications can use managed identities to obtain Microsoft Entra tokens without having to manage any credentials.

## Types of managed identities

There are two types of managed identities:

* A **system-assigned managed identity** is enabled directly on an Azure service instance. When the identity is enabled, Azure creates an identity for the instance in the Microsoft Entra tenant trusted by the subscription of the instance. After the identity is created, the credentials are provisioned onto the instance. The lifecycle of a system-assigned identity is directly tied to the Azure service instance that it's enabled on. If the instance is deleted, Azure automatically cleans up the credentials and the identity in Microsoft Entra ID.
* A **user-assigned managed identity** is created as a standalone Azure resource. Through a create process, Azure creates an identity in the Microsoft Entra tenant that's trusted by the subscription in use. After the identity is created, the identity can be assigned to one or more Azure service instances. The lifecycle of a user-assigned identity is managed separately from the lifecycle of the Azure service instances to which it's assigned.

Internally, managed identities are service principals of a special type, which are locked to only be used with Azure resources. When the managed identity is deleted, the corresponding service principal is automatically removed.

## Characteristics of managed identities

The following table highlights some of the key differences between the two types of managed identities.

| Characteristic | System-assigned managed identity | User-assigned managed identity |
|--|--|--|
| Creation | Created as part of an Azure resource (for example, an Azure virtual machine or Azure App Service) | Created as a stand-alone Azure resource |
| Lifecycle | Shared lifecycle with the Azure resource that the managed identity is created with. When the parent resource is deleted, the managed identity is deleted as well. | Independent life-cycle. Must be explicitly deleted. |
| Sharing across Azure resources | Can't be shared, it can only be associated with a single Azure resource. | Can be shared, the same user-assigned managed identity can be associated with more than one Azure resource. |

## When to use managed identities

The following image gives an overview of the scenarios that support using managed identities. For example, you can use managed identities if you want to build an app using Azure App Services that accesses Azure Storage without having to manage any credentials. 

:::image type="content" source="../media/managed-identities-use-case.png" alt-text="Image showing a list of sources that gain access to targets through Microsoft Entra ID.":::

## What Azure services support managed identities?

Managed identities for Azure resources can be used to authenticate to services that support Microsoft Entra authentication. For a list of Azure services that support the managed identities for Azure resources feature, visit [Services that support managed identities for Azure resources](/azure/active-directory/managed-identities-azure-resources/services-support-msi).

The rest of this module uses Azure virtual machines in the examples, but the same concepts and similar actions can be applied to any resource in Azure that supports Microsoft Entra authentication.
