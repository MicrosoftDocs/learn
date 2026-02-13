::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=e7684170-b332-4cfd-bc95-f908653b39c4]

::: zone-end

::: zone pivot="text"

**Microsoft Azure** is one of the world's leading cloud platforms. A **cloud platform** is a collection of services you can use over the internet instead of running everything on your own computer or server. Today, most modern applications run in the cloud, in internet-based data centers that let you store data, run code, and scale without worrying about physical hardware. Instead of buying and maintaining your own infrastructure, you use services provided by trusted platforms. 

Azure's trusted by organizations globally to build secure, reliable applications. With Azure, you can develop AI applications and agents that take advantage of advanced AI services and deploy them at global scale. 

Azure provides four core categories of services:

- **Compute**: The ability to run applications, programs, and workloads in the cloud. You can think of compute as renting computers in the cloud that you can scale up or down whenever you need.

- **Storage**: Services that let you save and manage data in the cloud. Storage can include files, databases, images, backups—anything you want safely stored and accessible from anywhere.

- **Networking**: Tools that connect your cloud resources to each other, to the internet, or to your organization.  
Networking makes sure your apps can talk to each other securely and efficiently.

- **App Services**: Ready‑made platforms for building, hosting, and running applications without managing the underlying servers. 

## Azure's organizational structure

When a user gets started with Azure, their access needs to be organized and managed. Azure organizes access and management by **tenants**, **subscriptions**, **resource groups**, and **resources**. 

![Screenshot of diagram of Azure's organizational structure.](../media/azure-tenant-structure.png)

An **Azure tenant** is an organization's home base and identity in Microsoft's cloud. Having a tenant is like having an apartment unit in a large building, where the building is Microsoft cloud. Each tenant is separate and secured from others—your organization has its own locks, rooms, and controls.

When a company signs up for Azure or Microsoft 365, Microsoft creates a *tenant* for them. This tenant is a dedicated and secure space where all the organization’s cloud resources live. The tenant includes users, groups, identities, and policies for managing secure access.

An **Azure subscription** is a billing container for your cloud resources. One tenant can contain one or many Azure subscriptions. A subscription ties your Azure usage to a payment method (or credits for free/trial accounts) and sets boundaries for cost, quotas, and access control.

**Resource groups (RGs)** are folders that hold related Azure resources so you can manage them together. One subscription can have multiple resource groups. Each resource group can have custom permissions and policies at the resource-group level.

An **Azure resource** is *any individual service or object you create in Azure* such as a storage account, a database, or a Foundry resource. Each resource has a resource type, configuration settings, unique resource name and ID, and optional access controls. The resource type (for example: `Microsoft.Storage/storageAccounts`) defines the resource's behavior, capabilities, and settings.

When you *configure* a resource, you choose its settings, such as: 

- Region (where the resource is deployed)
- Performance tier (associated with cost)
- Permissions and security 

Azure's organizational structure helps ensure clarity, security, and scalability in cloud environments. Tenants and subscriptions allow for clear separation of concerns across departments or projects. Resource groups simplify management by grouping related assets, making it easier to apply policies, monitor usage, and automate deployments. Understanding this hierarchy is essential for efficient cloud governance and cost control in Azure.

## Azure portal 

**Azure portal**, accessible at [https://portal.azure.com](https://portal.azure.com?portal=true), is a centralized, web-based management user interface (UI) for all Azure services. It can be used to: 

- Create and manage cloud resources 
- Deploy and configure services
- Monitor usage, performance, and health
- Manage identities, roles, and access policies
- View billing, costs, and spending patterns
- Access specialized services like Microsoft Foundry

![Screenshot of the Azure portal experience.](../media/azure-portal-example.png)

You can create and manage individual resources in Azure portal. Each resource has information which is accessible through the *All resources* pane.        

![Screenshot of a resource in the Azure portal.](../media/example-foundry-resource.png) 

> [!NOTE]
> You can also create Azure resources **programmatically**, which means using code or scripts *instead* of clicking through the Azure portal interface. This approach is useful when you want to repeat the same setup across environments, automate deployments, or reduce manual errors. For example, instead of going into the Azure portal to create a storage account, you could run a single command in the Azure CLI or use a script that creates it the same way every time. This makes your deployments faster, more reliable, and easier to maintain—especially for larger AI applications that require many resources.

Next, learn how Azure gives you everything you need to build scalable, secure AI applications.    

::: zone-end