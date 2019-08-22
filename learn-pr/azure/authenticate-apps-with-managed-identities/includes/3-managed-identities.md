Your company is moving all the organization applications from their on-premises servers to Azure, hosted on a VM. The application currently authenticates to the Azure AD through a service principal. However, as part of the design evolution to automated authentication in Azure you decide to consider an alternative method of authentication.

With your applications hosted on an Azure VM, you've realized there is a better, more secure, and simpler mechanism for managing application authentication: managed identities.

In this unit, you'll:

- explore managed identity within the Azure platform,
- what managed identity is,
- how it works and what services can be used.

## What are managed identities in Azure

Managed identity is a feature of Azure Active Directory (Azure AD) that enables you to authenticate any Azure service that supports it, without actual authentication credentials appearing in raw code. This is a common challenge in modern organizations where applications are written and they contain snippets of code to authenticate to different cloud services. Having the authentication details in the code means they're liable to mis-use, and are an easy place to start if an unauthorized person were attempting to compromise a system.

Managed identity provides a way to solve this problem by granting an automatically managed identity that can be used to authenticate to any Azure service that supports it.

Managed identities can only be used in the context of resources hosted within Azure.

Managed identities remove the need for credential rotation or worrying about expiration dates. Azure will handle credential rotation and expiration for you in the background, meaning once you've configured your application to use a managed identity, you keep calling the service using the provided token.

The term-Managed Service Identity (MSI), which still exists in some client libraries, has been replaced by Managed identities for Azure resources

## How managed identities work

When working with managed identities, there are several terms commonly referred to that are important to remember:

- The Client ID - is a unique ID linked to the Azure AD application and service principal created when the identity is provisioned.
- The Object ID - refers to the service principal object of the managed identity.
- The Azure Instance Metadata Service - is a REST API, which is enabled when a VM is provisioned using Azure Resource Manager. The endpoint is only accessible from within the VM.

There are two different types of managed identity that can be created, that while similar, are used differently:

### System-assigned identity

System-assigned identity is enabled directly on the Azure service instance, for example on a VM. When that identity is enabled, Azure creates a service principal through Azure Resource Manager for that resource married to the information about the managed identity in the Azure AD tenant. The credentials are provisioned on to that instance after the identity is created. For example, if you have two VMs, managed identity has to be enabled on each VM. The status of the managed identity is directly linked to the status of the resource, if the resource is deleted the managed identity gets deleted as well.

### User-assigned managed identity

User-assigned managed identity is created as a separate standalone Azure resource. When provisioned, Azure creates an identity in same way as a system-assigned identity. However, a user-assigned identity is not tied to the status of an individual resource so can be assigned to one or more Azure services as required. For example, if you have two VMs and a backend Azure SQL Database the same identity can be assigned to each resource.

## Using managed identities with Azure resources

Presently, there are two forms of managed identity:

- System-assigned - these identities are enabled against a specific Azure service instance.  Once the identity is created against an Azure AD tenant, it is then trusted by any subscriptions against that instance.   The provisioned credentials exist for the life of the Azure instance they were assigned to.
- user-assigned - these identities are standalone Azure resources assigned to an Azure AD tenant. The identity is then trusted by all subscriptions linked to that tenant.   The identity can be assigned to more than one Azure service instance. The provisioned identity exists separately to the Azure instances it has been assigned to.

Microsoft is actively working to enable them across the platform. The services that support managed identity for Azure resources are:

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

Managed identities can be administered using the:

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