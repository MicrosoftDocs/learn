Many public-sector customers considering cloud adoption need confidence that customer and personal data are kept in specific geographic areas. These boundaries might correspond to customer operations or the location of the customer's end users. Microsoft provides transparency into data location for all online services available to customers. Key principles in the safeguarding of customer data at rest, in transit, and as part of customer-initiated support requests guide all interactions with data.

## Data classifications

To provide clarity in how data is safeguarded in the cloud, Microsoft has established several [data categories and definitions](https://www.microsoft.com/trust-center/privacy/customer-data-definitions) for cloud services, including the following terms:

* **Customer data** is all data that customers provide to Microsoft to manage on customers' behalf through customers' use of Microsoft online services.
* **Customer content** is a subset of customer data and includes, for example, the content stored in a customer's Azure Storage account.
* **Personal data** means any information associated with a specific natural person, such as names and contact information of customers' end users. However, personal data could also include data that isn't customer data, such as a user ID that Azure can generate and assign to each customer administrator; such personal data is considered pseudonymous because it can't identify an individual on its own.
* **Support and consulting data** mean all data provided by customers to Microsoft to obtain Support or Professional Services.

According to the EU GDPR, [personal data is defined](https://gdpr-info.eu/art-4-gdpr/) broadly to include data that's linked or linkable to an individual person. It includes not just customer data or other obvious types of personal identifiers such as name and address, but also includes unique but pseudonymized personal identifiers such as Probably Unique Identifier (PUID) and Globally Unique Identifier (GUID). These latter types of pseudonymized personal data are often automatically generated through cloud services' operations. At Microsoft, these types of identifiers are generated automatically to track users who interact directly with Azure services, such as customers' administrators. For example, a PUID is a random string generated programmatically through a combination of characters and digits to provide a high probability of uniqueness. Pseudonymized identifiers are stored in centralized internal Azure systems in compliance with the EU GDPR requirements, including a retention period of less than 30 days for an active-deletion scenario.

While some personal data could be used on its own to identify a user (for example, user name, display name, user principal name, or even user-specific IP address), PUIDs, GUIDs, and other automatically generated personal identifiers are considered pseudonymous because they can’t identify an individual on their own. These pseudonymized identifiers do not contain any information uploaded or created by the customer.

## Data sovereignty

Data sovereignty implies data residency, but it also introduces rules and requirements that define who has control over and access to customer data stored in the cloud. In many cases, data sovereignty requires that customer data be subject to the laws and legal jurisdiction of the country/region in which data resides. These laws can have direct implications on data access, even for platform maintenance or customer-initiated support requests. Customers can use the Azure public multitenant cloud in combination with Azure Stack Hub and Azure Stack Edge for on-premises and edge solutions to meet their data sovereignty requirements. Customers can deploy these other products to put them completely in control of their data, including storage, processing, transmission, and remote access.

## Data at rest

Microsoft provides clear insight into data location for all online services available to customers from the [Where your data is located](https://www.microsoft.com/trust-center/privacy/data-location) page. Customers who want to ensure their customer data is stored only in a specific geography should select from the many regional services that make this commitment.

Azure provides [strong customer commitments](https://azure.microsoft.com/global-infrastructure/data-residency/) around data residency and transfer policies:

* **Data storage for regional services**: Most Azure services are deployed regionally and allow the customer to specify the region into which the service will be deployed. Microsoft won't store customer data outside the customer-specified geography except for a few regional services and Preview services as described on the [Azure data location](https://azure.microsoft.com/global-infrastructure/data-residency/) page. This commitment helps ensure that customer data stored in a given region will remain in the corresponding geography and won't be moved to another geography for most regional services. For service availability, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?regions=non-regional%2Cus-central%2Cus-east%2Cus-east-2%2Cus-north-central%2Cus-south-central%2Cus-west-central%2Cus-west%2Cus-west-2&products=all).
* **Data storage for non-regional services**: Certain Azure services don't allow the customer to specify the region where the services will be deployed, as described on the [data location page](https://azure.microsoft.com/global-infrastructure/data-residency/). For a complete list of non-regional services, see [Products available by region](https://azure.microsoft.com/global-infrastructure/services/?regions=non-regional&products=all).

Customer data in an Azure Storage account is [always replicated](/azure/storage/common/storage-redundancy) to help ensure durability and high availability. Azure Storage copies customer data to protect it from transient hardware failures, network or power outages, and even massive natural disasters. Customers can usually choose to replicate their data within the same datacenter, across availability zones within the same region, or across geographically separated regions.

As described on the [data location page](https://azure.microsoft.com/explore/global-infrastructure/data-residency/), most Azure **regional** services honor the data at rest commitment to make sure that customer data remains within the geographic boundary where the corresponding service is deployed. A handful of exceptions to this rule are noted on the data location page. Customers should review these exceptions to decide if the type of data stored outside their chosen deployment geography meets their needs.

**Non-regional** Azure services don't allow customers to specify the region where the services will be deployed. Some non-regional services don't store customer data at all, but merely provide global routing functions such as Azure Traffic Manager or Azure DNS. Other non-regional services are intended for data caching at edge locations around the globe, such as the Content Delivery Network. Such services are optional, and customers shouldn't use them for sensitive customer content they want to keep in Geo. One non-regional service that deserves more discussion is **Azure Active Directory**, which we discuss in a later section.

## Data in transit

While customers can't control the precise network path for data in transit, data encryption in transit helps protect data from interception.

Data in transit applies to the following scenarios involving data moving between:

* Customers' end users and Azure service.
* Customers' on-premises datacenter and Azure region.
* Microsoft datacenters as part of expected Azure service operation.

While data in transit between two points within the geography will usually remain in Geo, it's not possible to guarantee this 100% of the time because of the way that networks automatically reroute traffic to avoid congestion or bypass other interruptions. That said, data in transit can be protected through encryption.

## Customer data in Azure Active Directory

Azure Active Directory (Azure AD) is a non-regional service that might store Active Directory (AD) data globally, except for Azure AD deployments in:

* The United States, where identity data is stored solely in the United States.
* Europe, where Azure AD keeps most of the identity data within European datacenters except as noted in [Customer data storage and processing for European customers in Azure Active Directory](/azure/active-directory/fundamentals/active-directory-data-storage-eu).
* Australia and New Zealand, where identity data is stored in Australia except as noted in [Customer Data storage for Australian and New Zealand customers in Azure Active Directory](/azure/active-directory/fundamentals/active-directory-data-storage-australia-newzealand).

Azure AD provides a [dashboard](https://go.microsoft.com/fwlink/?linkid=2092972) with clear insight into data location for every Azure AD component service. Among other features, Azure AD is an identity-management service that stores directory data for customer's Azure administrators, including user **personal data** such as names, email addresses, and other personal information.

Azure AD implements extensive **data-protection features**, including tenant isolation and access control, data encryption in transit, secrets encryption and management, disk-level encryption, advanced cryptographic algorithms used by various Azure AD components, data operational considerations for insider access, and more. Detailed information is available from the [Active Directory Data Security Considerations](https://aka.ms/AADDataWhitePaper) whitepaper.

## Data residency and compliance

Established privacy regulations such as the EU GDPR are silent on data residency and data location, and allow data transfers with approved mechanisms such as the EU Standard Contractual Clauses (also known as EU Model Clauses). Microsoft commits contractually in the Online Services Terms [Data Protection Addendum](https://aka.ms/DPA) (DPA) that all potential transfers of customer data out of the EU, European Economic Area (EEA), and Switzerland shall be governed by the EU Model Clauses. Microsoft will abide by the requirements of the EEA and Swiss data-protection law covering the collection, use, transfer, retention, and other processing of personal data from the EEA and Switzerland. All transfers of personal data are subject to appropriate safeguards and documentation requirements as described in the EU GDPR.

Next, we'll look at how Azure uses encryption to protect data across its lifecycle.
