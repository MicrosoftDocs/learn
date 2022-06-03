
Data sovereignty implies data residency; however, it also introduces rules and requirements that define who has control over and access to customer data stored in the cloud. In many cases, data sovereignty mandates that customer data be subject to the laws and legal jurisdiction of the country or region in which data resides. These laws can have direct implications on data access even for platform maintenance or customer-initiated support requests. 

When it comes to compliance, data residency regulations govern the physical locations where data can be stored and how and when it can be transferred, processed, or accessed internationally. These regulations can differ significantly depending on jurisdiction. 

For regulatory compliance considerations, data residency considerations may support or even mandate the physical locations where data can be stored, and how and when it can be transferred internationally. These regulations can differ significantly depending on jurisdiction. Azure's regions and service features provide customers with different avenues so they can select and limit data residency and data access. This enables customers in regulated industries to successfully run mission-critical workloads in the cloud and leverage all the advantages of the Microsoft hyperscale cloud. 


### Data Sovereignty

When designing your data residency solution, one common requirement is regarding data sovereignty. While it implies data residency; it also introduces rules and requirements that define who has control over and access the data stored in the cloud. In many cases, data sovereignty mandates that customer data be subject to the laws and legal jurisdiction of the country or region in which data resides. These laws can have direct implications on data access even for platform maintenance or customer-initiated support requests. You can use Azure public multi-tenant cloud in combination with Azure Stack products for on-premises and edge solutions to meet your data sovereignty requirements, as described later in this article. These other products can be deployed to put you solely in control of your data, including storage, processing, transmission, and remote access.

### Personal Data

As a customer, you retain all rights, titles, and interest in and to customer data---personal data and other content---that you provide for storing and hosting in Azure services. Microsoft will not store or process customer data outside the geography you specify, except for certain services and scenarios. You are also in control of any additional geographies where you decide to deploy your solutions or replicate your data. In addition, you and your users may move, copy, or access your customer data from any location globally. Most Azure services are deployed regionally and enable you to specify where your customer data will be stored and processed. Examples of such regional services include VMs, storage, and SQL Database. To maintain resiliency, Microsoft uses variable network paths that sometimes cross geo boundaries; however, replication of customer data between regions is always transmitted over encrypted network connections.

### Consider Azure Policy

When designing your data resident solution, take into consideration the use of Azure Policy. You can use Azure Policy to implement governance over cloud infrastructure and data, including but not limited to regions in which resources can be deployed, which services can be deployed, and resource monitoring requirements. To restrict the data and resources to certain Azure regions, such as for data residency, customers can use the *Allowed Locations* policy. Once policies are established, not only will new resources that are deployed be checked against the policies, but all resources will be periodically scanned to help ensure ongoing compliance.

### Consider Azure Blueprints

Another option to take into consideration is the use of Azure Blueprints. Blueprints can be used to help manage data residency for specific compliance needs by specifying both allowed locations and allowed locations for resource groups. The typical scenario to use Azure Blueprints is when you need to create scale deployments by supplying templates to create, deploy, and update fully governed cloud environments to consistent standards, which helps customers comply with regulatory requirements. It differs from Azure Resource Manager (ARM) and Azure Policy in that Blueprints is a package that contains different types of artifacts---including ARM templates, resource groups, policy assignments, and role assignments---all in one container, so you can quickly and easily deploy all these components in a repeatable configuration. Blueprints help to simplify large-scale Azure deployments by packaging policies in a single blueprint definition.

If you want to ensure your data is stored only in your chosen Geography, you should select from the options below:

- Data storage for regional services: Most Azure services are deployed regionally and enable you to specify the region into which the service will be deployed. Microsoft won't store your data outside the Geography you specified except for a few regional services and Preview services as described on the Azure data location page. This commitment helps ensure that your data stored in a given region will remain in the corresponding Geography, and won't be moved to another Geography for most regional services. For service availability, see Products available by region.
- Data storage for non-regional services: Certain Azure services don't enable you to specify the region where the services will be deployed as described on the data location page. For a complete list of non-regional services, see Products available by region.

Your data in an Azure Storage account is always replicated to help ensure durability and high availability. Azure Storage copies your data to protect it from transient hardware failures, network or power outages, and even massive natural disasters. You can typically choose to replicate your data within the same data center, across availability zones within the same region, or across geographically separated regions.

One example of a non-regional service is Azure Active Directory (Azure AD). In other words, Azure AD may store identity data globally, except for Azure AD deployments in:

- The United States, where identity data is stored solely in the United States.
- Europe, where Azure AD keeps most of the identity data within European datacenters except as noted in Identity data storage for European customers in Azure Active Directory.
- Australia and New Zealand, where identity data is stored in Australia except as noted in Customer data storage for Australian and New Zealand customers in Azure Active Directory.

Customers can configure certain Azure services, tiers, or plans to store customer data only in a single region, with certain exceptions. These include Azure Backup, Azure Data Factory, Azure Site Recovery, Azure Stream Analytics, and locally redundant storage (LRS).
