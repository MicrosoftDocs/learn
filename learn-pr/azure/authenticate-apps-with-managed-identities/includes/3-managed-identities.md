Your company has migrated its' stock tracking application to an Azure VM. The application currently authenticates to Azure AD through a service principle. However, as part of the design evolution to automated authentication in Azure you decide to consider an alternative method of authentication.

Your manager has asked you to look at a change in the authentication method for the application and switch to using the managed identity service.

In this unit, you'll explore managed identity within the Azure platform, what managed identity is, how it works and what services can be used.

## What are managed identities in Azure

Managed identity in Azure is a feature of Azure Active Directory (Azure AD) that gives the ability to authenticate to any Azure service that supports it without actual authentication credentials appearing in raw code. This is a common challenge in modern organizations where applications are written and they contain snippets of code to authenticate to different cloud services. Having the authentication details in the code means they're liable to mis-use, and are an easy place to start if an unauthorized person were attempting to compromise a system. Managed identity provides a way to solve this problem by granting an automatically managed identity that can be used to authenticate to any Azure service that supports it.

  > [!NOTE]
  > Managed identities can only be used in the context of resources hosted within Azure. For example a custom application hosted on-premises will not be able to use managed identity, in that instance a service principal must be used.

## Overview of Azure-managed identities

Managed identities are a free feature within Azure AD for automatically managing identity. Managed identities remove the need for credential rotation or worrying about expiration dates, think back to the creation of the service principal in the previous unit. The keys generated have an expiration date plus several objects need to be stored, too successfully, call the service principal during an authentication request. When the credentials need to be refreshed, this requires a change to any application or service storing those credentials to ensure the authentication request is accepted. With managed identity that requirement is removed, Microsoft will handle credential rotation and expiration for you in the background, meaning once you've configured your application to use managed identity, you keep calling the service using the same token.

   > [!NOTE]
   > Managed identities for Azure resources is the new name for the service formerly known as Managed Service Identity (MSI)which still exists in some client libraries.

## How managed identities work

When working with managed identities, there are several terms commonly referred to that are important to remember:

- The Client ID, the client ID is a unique ID linked to the Azure AD application and service principal created when the identity is provisioned.
- The Object ID - the object ID refers to the service principal object of the managed identity.
- The Azure Instance Metadata Service (IMDS), IMDS is a REST API enabled when a VM is provisioned using Azure Resource Manager. The endpoint is only accessible from within the VM.

There are two different types of managed identity that can be created, that while similar, are used differently. The two types are a **system-assigned managed identity** and a **user-assigned managed identity**:

- A **system-assigned identity** is enabled directly on the Azure service instance that is, a per resource basis. When that identity is enabled, Azure creates a service principal through Azure Resource Manager for that instance married to the information about the managed identity in the Azure AD tenant. After the identity is created the credentials are provisioned on to that instance. For example, if you have 2 VMs managed identity has to be enabled in isolation on each VM. The status of the managed identity is then directly linked to the status of the resource, if the resource gets deleted the managed identity is with it.
- A **user-assigned managed identity** is created as a separate standalone Azure resource. When provisioned, Azure creates an identity in same way as a system-assigned identity. However, a user-assigned identity is not tied to the status of an individual resource so can be assigned easily one or more Azure services as required. For example, if you have 2 VMs and a backend Azure SQL Database the same identity can be assigned to each resource.

Under the hood, a managed identity is a special type of service principal, which can only be used with Azure services that support Azure AD authentication.

![Screenshot showing managed identity workflow](../media/3-service-identities-azure.png)

You'll learn about the workflow for each type of managed identity in the next unit.

## Using managed identities with Azure resources

Managed identities can be used in a two different scenarios, with an Azure VM (windows or linux) or through a supported service. At the present time-managed identities only work with a select number of Azure resources. Microsoft is actively working to enable them across the platform. The services that support managed identity for Azure resources are Azure Virtual Machines, Azure Virtual Machine Scale Sets, Azure App Service, Azure Logic Apps, Azure Functions, Azure Blueprints, Azure Data Factory V2, and Azure Container Instances.

   > [!NOTE]
   > The list of services supporting managed identities including region availability and configuration options is available in the Azure documentation [here](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/services-support-managed-identities).

Where a service doesn't yet support managed identity integration can still be achieved with any service that supports Azure AD authentication including:

- [Azure Resource Manager](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-arm)
- [Azure Key Vault](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-nonaad)
- [Azure Data Lake](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-datalake)
- [Azure SQL](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-sql)
- [Azure Event Hubs](https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-managed-service-identity)
- [Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-use-managed-service-identity)
- [Azure Service Bus](https://docs.microsoft.com/en-us/azure/service-bus-messaging/service-bus-managed-service-identity)
- [Azure Storage Blobs and Queues](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-vm-windows-access-storage)
- [Azure Cosmos DB](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-cosmos-db)
- [Azure AD Graph API](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/tutorial-windows-vm-access-azure-ad-graph)

You can work with managed identity using different pathways. It can be configured using the **Azure portal**, the **Azure CLI**, in **Azure PowerShell**, an **Azure Resource Manager template, or the **Azure SDK** in supported development tools.
