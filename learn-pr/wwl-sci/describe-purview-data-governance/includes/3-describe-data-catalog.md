
The goal of Microsoft Purview Data Catalog is to provide a platform for data governance and to drive business value creation in your organization. It does this through a rich set of features that align to data governance principles. The sections that follow describe some of the key features of the Microsoft Purview Data Catalog.

### Governance domains

Governance domains: Governance domains are a new way of organizing your data estate through business concepts, like Marketing or Finance, providing context for your data assets. A governance domain is a boundary that enables the common governance, ownership, and discovery of data products and business concepts like glossary terms, OKRs, or critical data. You can establish many kinds of boundaries such as:

- Fundamental business areas - human resources, sales, finance, supply chain, etc.
- Overarching subject areas - product, parties, etc.
- Boundaries based on organizational functions - customer experience, cloud supply chain, business intelligence, etc.

Business domains are connected to several other business concepts that are incorporated as features of the Data Catalog.

#### Data products

Related to business domains are data products. A data product is a business construct with a name, description, owners, and most importantly a list of associated data assets. The data product provides context for the assets that are included within it, and provides a use case for data consumers.

A governance domain can house many data products but a data product is managed by a single governance domain and can be discovered across many domains.

A successful data product makes it easy for data consumers to recognize valuable data using their day-to-day language, and at the same time streamlines ownership responsibilities for those data assets.

Consider the example where a data scientist has created a set of data assets to be used by a data model and to be used by others. Although the data scientist can use the data catalog to add a glossary term to all the relevant data assets and can add a description to each asset to make it more relevant in search for similar information, it doesn't guarantee that a data consumer would know what glossary term to use or that the data consumer will find all the data assets. This is where a data product fits nicely. The data scientist creates a data product that lists all the assets used to create their data model. The description provides a full use case, with examples or suggestions on how to use the data. The data scientist is now a data product owner and they've improved their data consumer's search experience by helping them get everything they need in this one data product.

#### Glossary terms

Glossary terms provide critical business context to your data assets and also apply policies that determine how your data should be managed, governed, and made discoverable for use.

Glossary terms are individual concepts that define the business, processes, and systems used in an organization. They can be applied across a data estate, relating to data assets and data products to provide business context to your users.

Terms are created under governance domains to create context that is specific to each part of your organization. For example, both sales and marketing might use the same term to mean different things, and your governance domains help your team to differentiate between those meanings. Once created, terms map to data products, to provide context for those data products, and to provide specific data governance based on business context.

Glossary terms provide data governance based on the business context, because they now contain policies. Policies in a business term apply specific business health goals, data governance requirements, and terms of use to any data product that a term is applied to.

#### Critical data elements

Not all data elements have the same importance or sensitivity, and dedicating resources to manage the quality of all data indiscriminately can be impractical and costly. Critical data elements (CDEs) are a logical grouping of important pieces of information across your data estate. These groupings can make data easier to understand and promote standardization. Data quality rules and access policies can be attached to these elements to further secure sensitive information across your data estate.

For example: A "Customer ID" critical data element can map "CustID" from one table and "CID" from another table into the same logical container. Users can match this value across data assets to make connections, and when data producers create a new asset they can use this element as a blueprint to provide quality information in the correct format.

Critical data elements are created within governance domains and can have policies set to manage these important pieces of information.

By creating CDEs, organizations can allocate resources strategically, focusing governance effort on areas that have the most significant impact on the business.

#### OKRs

OKRs (objectives and key results) in Microsoft Purview are trackable business objectives tied to governance domains and data products to emphasize the value of business data.

OKRs link data products directly to real business objectives to cross the gap between the business and the data estate. Data governance isn't just an IT task or engineering best practice, it's a critical part of value generation.

#### Data access policies

Data catalog access policies allow you to manage access to your data products and set up a system to provide access to users who request it. Promote innovation and flexibility in your data estate by creating self-service access opportunities, while upholding security and right-use standards.

#### Search and browse

Data discovery can be time consuming because you might not know where to find the data that you want. Search enables data consumers need to easily find the data needed for their analytics or governance workloads. Searching is great if you know what you're looking for, but there are times where data consumers wish to explore the data available to them. The Microsoft Purview Data Catalog offers a browse experience that enables users to explore what data is available to them either by collection or through traversing the hierarchy of each data source in the catalog.

#### Health management

Health management has features to enhance your data governance strategy and management.

***Health controls***: Data health controls allow your team to analyze and track your journey to complete data governance by monitoring your governance health, and using the provided health controls to track your progress. Data Health Controls are specific measures, processes, and tools implemented to monitor, maintain, and improve the quality, security, and overall health of an organization's data.

The benefits of data health controls include:
- Improved Data Quality: Ensures that data remains accurate, consistent, and reliable for decision-making.
- Enhanced Security: Protects sensitive data from breaches, unauthorized access, and corruption.
- Regulatory Compliance: Helps organizations adhere to legal and industry standards for data management.
- Operational Efficiency: Reduces the time and resources spent on correcting data issues and ensures that data is readily available and usable.
- Risk Mitigation: Prevents costly errors and data-related risks that can arise from poor data management.

In summary, data health controls are essential components of a comprehensive data governance strategy, helping organizations maintain the integrity, security, and usability of their data assets.

***Health actions***: Health management actions give you and your users steps to take to improve data health and governance across your data estate. These actions correspond to the checks made to calculate a data product's data governance health control score. Addressing these actions raises your health score and promotes an overall more useable and discoverable data catalog.


#### Data quality

Microsoft Purview Data Quality is a comprehensive solution that empowers governance domain and data owners to assess and oversee the quality of their data ecosystem, facilitating targeted actions for improvement.

Data Quality offers users the ability to evaluate data quality using no-code/low-code rules, including out-of-the-box (OOB) rules and AI-generated rules. These rules are aggregated to provide scores at the levels of data assets, data products, and governance domains, ensuring end-to-end visibility of data quality within each domain. Microsoft Purview Data Quality also incorporates AI-powered data profiling capabilities

By applying Microsoft Purview Data Quality, organizations can effectively measure, monitor, and enhance the quality of their data assets.