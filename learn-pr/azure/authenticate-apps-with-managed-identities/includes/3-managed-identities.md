Your company has decided to move the whole system to be hosted in Azure on VMs. The application currently authenticates to Azure AD through a service principal. However, as part of the design evolution to automated authentication in Azure you decide to consider an alternative method of authentication.

Now that the machine running the app is being hosted on an Azure VM, you've realized that there's a simpler way to handle app authentication. You are going to switch to using a managed identity for the company's application.

In this unit, you'll explore managed identity within the Azure platform, what managed identity is, how it works and what services can be used.

## What are managed identities in Azure

Managed identity is a feature of Azure Active Directory (Azure AD) that enables you to authenticate any Azure service that supports it, without actual authentication credentials appearing in raw code. This is a common challenge in modern organizations where applications are written and they contain snippets of code to authenticate to different cloud services. Having the authentication details in the code means they're liable to mis-use, and are an easy place to start if an unauthorized person were attempting to compromise a system. Managed identity provides a way to solve this problem by granting an automatically managed identity that can be used to authenticate to any Azure service that supports it.

  > [!NOTE]
  > Managed identities can only be used in the context of resources hosted within Azure. For example a custom application hosted on-premises will not be able to use managed identity, in that instance a service principal is the only option.

## Overview of Azure-managed identities

Managed identities are a free feature within Azure AD for automatically managing identity. Managed identities remove the need for credential rotation or worrying about expiration dates, think back to the creation of the service principal in the previous unit. The keys generated have an expiration date plus several objects need to be stored, too successfully, call the service principal during an authentication request. When the credentials need to be refreshed, it needs someone to change any application or service storing those credentials. Using a managed identity that requirement is removed, Microsoft will handle credential rotation and expiration for you in the background, meaning once you've configured your application to use a managed identity, you keep calling the service using the provided token.

   > [!NOTE]
   > The term Managed Service Identity (MSI), which still exists in some client libraries, has been replaced by Managed identities for Azure resources

## How managed identities work

When working with managed identities, there are several terms commonly referred to that are important to remember:

- The Client ID, this is a unique ID linked to the Azure AD application and service principal created when the identity is provisioned.
- The Object ID - this ID refers to the service principal object of the managed identity.
- The Azure Instance Metadata Service is a REST API enabled when a VM is provisioned using Azure Resource Manager. The endpoint is only accessible from within the VM.

There are two different types of managed identity that can be created, that while similar, are used differently:

- **System-assigned identity** is enabled directly on the Azure service instance, for example on a VM. When that identity is enabled, Azure creates a service principal through Azure Resource Manager for that resource married to the information about the managed identity in the Azure AD tenant. The credentials are provisioned on to that instance after the identity is created. For example, if you have two VMs, managed identity has to be enabled on each VM. The status of the managed identity is directly linked to the status of the resource, if the resource is deleted the managed identity gets deleted as well.
- **User-assigned managed identity** is created as a separate standalone Azure resource. When provisioned, Azure creates an identity in same way as a system-assigned identity. However, a user-assigned identity is not tied to the status of an individual resource so can be assigned to one or more Azure services as required. For example, if you have two VMs and a backend Azure SQL Database the same identity can be assigned to each resource.

Under the hood, a managed identity is a special type of service principal, which can only be used with Azure services that support Azure AD authentication. You'll learn about the workflow for each type of managed identity in the next unit.

## Using managed identities with Azure resources

Managed identities can be used in two different scenarios, with an Azure VM (windows or linux) or through a supported service. At the present, time-managed identities only work with a select number of Azure resources. Microsoft is actively working to enable them across the platform. The services that support managed identity for Azure resources are:

- Azure Virtual Machines
- Azure Virtual Machine Scale Sets
- Azure App Service
- Azure Logic Apps
- Azure Functions
- Azure Blueprints
- Azure Data Factory V2
- Azure Container Instances

   > [!NOTE]
   > The list of services supporting managed identities including region availability and configuration options is available in the [Azure documentation](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/services-support-managed-identities).

Managed identities can be managed using the:

- **Azure portal**
- **Azure CLI**
- **Azure PowerShell**
- **Azure Resource Manager template**
- **Azure SDK** in supported development tools

When you add a managed identity to one of the resources above, you are then able to use that identity's token to access any of the following Azure resources:

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