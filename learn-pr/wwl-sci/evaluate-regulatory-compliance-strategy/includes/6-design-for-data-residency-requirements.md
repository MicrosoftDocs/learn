
Data sovereignty implies data residency; however, it also introduces rules and requirements that define who has control over and access to customer data stored in the cloud. In many cases, data sovereignty mandates that customer data be subject to the laws and legal jurisdiction of the country or region in which data resides. These laws can have direct implications on data access even for platform maintenance or customer-initiated support requests. 

When it comes to compliance, data residency regulations govern the physical locations where data can be stored and how and when it can be transferred, processed, or accessed internationally. These regulations can differ significantly depending on jurisdiction.

For regulatory compliance considerations, data residency considerations may support or even mandate the physical locations where data can be stored, and how and when it can be transferred internationally. These regulations can differ significantly depending on jurisdiction. Azure's regions and service features provide customers with different avenues so they can select and limit data residency and data access. This flexibility with data residency requirements enables customers in regulated industries to successfully run mission-critical workloads in the cloud and use all the advantages of the Microsoft hyperscale cloud. 

## Data Sovereignty

When you design a data residency solution, you will also likely address data sovereignty requirements. While data sovereignty implies data residency, it also introduces rules and requirements that define who has control over and access to the data stored in the cloud. In many cases, data sovereignty mandates that customer data is subject to the laws and legal jurisdiction of the country or region in which data resides. These laws can have direct implications on data access even for platform maintenance or customer-initiated support requests. You can use Azure public multi-tenant cloud in combination with Azure Stack products for on-premises and edge solutions to meet your data sovereignty requirements, as described later in this article. These other products can be deployed to put you solely in control of your data, including storage, processing, transmission, and remote access.

## Personal Data

As a customer, you retain all rights, titles, and interest in and to customer data - personal data and other content - that you provide for storing and hosting in Azure services. Microsoft will not store or process customer data outside the geography you specify, except for certain services and scenarios. You are also in control of any other geographies where you decide to deploy your solutions or replicate your data. In addition, you and your users may move, copy, or access your customer data from any location globally. Most Azure services are deployed regionally and enable you to specify where your customer data will be stored and processed. Examples of such regional services include VMs, storage, and SQL Database. To maintain resiliency, Microsoft uses variable network paths that sometimes cross geo boundaries; however, replication of customer data between regions is always transmitted over encrypted network connections.

## Consider Azure Policy

When designing your data resident solution, take into consideration the use of Azure Policy. You can use Azure Policy to implement governance over cloud infrastructure and data. Governance includes the regions in which resources can be deployed, which services can be deployed, and resource monitoring requirements. To restrict the data and resources to certain Azure regions, such as for data residency, customers can use the *Allowed Locations* policy. Once policies are established, newly deployed resources will be checked against the policies, and older resources will be periodically scanned to help ensure ongoing compliance.

## Consider Azure Blueprints

Another option to take into consideration is the use of Azure Blueprints. Blueprints can be used to help manage data residency for specific compliance needs by specifying both allowed locations and allowed locations for resource groups. Azure Blueprints can be helpful when you need templates to create, deploy, and update fully governed cloud environments to consistent standards that meet regulatory requirements. Azure Blueprints are different than Azure Resource Manager (ARM) and Azure Policy because Blueprints package many different types of artifacts - including ARM templates, resource groups, policy assignments, and role assignments - all in one container. This packaging allows you to quickly and easily deploy all these components in a repeatable configuration. Blueprints help to simplify large-scale Azure deployments by packaging policies in a single blueprint definition.

If you want to ensure your data is stored only in your chosen region, you should select from the options below:

- Data storage for regional services: most Azure services are deployed regionally and enable you to specify the region into which the service will be deployed. Microsoft won't store your data outside the region you specified except for a few regional services and Preview services as described on the Azure data location page. This commitment helps ensure that your data which is stored in a given region will remain in that region.
- Data storage for non-regional services: certain Azure services don't enable you to specify the region where the services will be deployed as described on the data location page.

Your data in an Azure Storage account is always replicated to help ensure durability and high availability. Azure Storage copies your data to protect it from transient hardware failures, network or power outages, and even massive natural disasters. You can typically choose to replicate your data within the same data center, across availability zones within the same region, or across geographically separated regions.

One example of a non-regional service is Azure Active Directory (Azure AD). In other words, Azure AD may store identity data globally, except for Azure AD deployments in:

- The United States, where identity data is stored solely in the United States.
- Europe, where Azure AD keeps most of the identity data within European datacenters except as noted in the article [Identity data storage for European customers in Azure Active Directory](/azure/active-directory/fundamentals/active-directory-data-storage-eu).
- Australia and New Zealand, where identity data is stored in Australia except as noted in the article [Customer data storage for Australian and New Zealand customers in Azure Active Directory](/azure/active-directory/fundamentals/active-directory-data-storage-australia-newzealand).

Customers can configure certain Azure services, tiers, or plans to store customer data only in a single region, with certain exceptions. These include Azure Backup, Azure Data Factory, Azure Site Recovery, Azure Stream Analytics, and locally redundant storage (LRS).