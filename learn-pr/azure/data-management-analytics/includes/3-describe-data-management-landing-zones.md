
The data-management landing zone is classified as a management function, and it's central to the data management and analytics scenario. It's responsible for platform governance and enables communication to ingest data sources from Azure, third-party clouds, and on-premises data sources. It's the heart of the data-governance flow.

## Significance

The data-management zone allows for centralized data governance and control space for any centralized data estates. It provides placeholders for implementing several common components of enterprise data-centric architecture including Data Catalog, Data Discovery, Data Classification, Data Lineage, Data Quality Management, Data Models Repositories, Master Data Management, API Catalog, Data Sharing contracts, Container Registry, and several more. Lets study a few of them in the following sections.

### Data Catalog and discovery

Data Catalog is an organized service that allows users to centralize metadata and learn more about their data sources that help organizations achieve more value from their assets.

Here are some advantages to centralizing metadata:

- Promotes consistency and accuracy across the department
- Enables better data congruency, quality, and structure
- Makes data easily accessible
- Allows users to self-serve

In an enterprise scenario, we'd like to minimize the number of data silos, get a faster access to what matters most, and function as a single source (during the data lifecycle).

Data-driven culture empowers users to get access to their data source. The growing number of cloud applications, privacy regulations, and security rules are making it more difficult to effectively secure and govern data. Therefore, a Data Catalog is needed to:

- Spend less time searching for data and more time using it to gain insight.
- Have better and safer access to data through governance, minimizing the scenario of departments having a hard time finding data and controlling who has access to it.
- Reduce the cost of data redundancy and hoarding.
- Provide better linkage between the technical value and the business value of metadata.

### Data Discovery

Data discovery describes processes in understanding data sets on hand for data integration and/or data analysis. This step occurs in design, and should combine technical research with subject-matter expertise. During data discovery, a high-level view is taken in assessing data preparation, or data quality needs.

### Data Classification

In the field of data management, data classification as a part of the Information Lifecycle Management (ILM) process can be defined as a tool for categorization of data to help organizations to effectively answer the following questions:

- What data types are available?
- Where is certain data located?
- What access levels are implemented?
- What protection level is implemented, and does it adhere to compliance regulations?

When implemented, data classification provides a bridge between IT professionals or processes and application owners. IT staffs are informed about the data value, and management (usually application owners) understands better which part of the datacenter needs to be invested in to keep operations running effectively. This can be of particular importance in risk management, legal discovery, and compliance with government regulations. Data classification is typically a manual process; however, there are many tools from different vendors that can help gather information about the data.

Data classification needs to take into account the following:

- Regulatory requirements
- Strategic or proprietary worth
- Organization-specific policies
- Ethical and privacy considerations
- Contractual agreements

### Data Lineage

Data lineage includes the data origin, what happens to it, and where it moves over time. It also enables replaying specific portions or inputs of the data flow for step-wise debugging or regenerating lost output.

Data lineage can be represented visually to discover the data flow/movement from its source to destination via various changes and hops on its way in the enterprise environment, how the data gets transformed along the way, how the representation and parameters change, and how the data splits or converges after each hop. Representation broadly depends on the scope of the metadata management and reference point of interest. Data lineage provides sources of the data and intermediate data flow hops from the reference point with backward data lineage, and leads to the final destination's data points and its intermediate data flows with forward data lineage.

Data lineage provides the audit trail of the data points at the highest granular level, but presentation of the lineage can happen at various zoom levels to simplify the vast information, similar to analytic web maps. Data Lineage can be visualized at various levels based on the granularity of the view. At a high level, data lineage provides what systems the data interacts with before it reaches its destination. As the granularity increases, data lineage goes up to the data-point level, where it can provide the details of the data point and its historical behavior, attribute properties, and trends and data quality passed through that specific data point in the data lineage.

### Data Quality Management

Defining data quality in a sentence is difficult due to the many contexts data are used in, and the varying perspectives among end users, producers, and custodians of data.

From a consumer perspective, data quality is:

- Data fit for use by data consumers
- Data meeting or exceeding consumer expectations

Here's a typical data management landing zone architecture:

:::image type="content" source="../media/high-level-design-multiple-landing-zones.png" alt-text="Diagram of multiple data landing zones." lightbox="../media/high-level-design-multiple-landing-zones.png":::

### Microsoft Purview context

Microsoft Purview is a unified data-governance service that helps you manage and govern your on-premises, multicloud, and software-as-a-service (SaaS) data. Microsoft Purview helps you create a holistic, up-to-date map of your data landscape with automated data discovery, sensitive data classification, and end-to-end data lineage. It also enables data curators to manage and secure your data estate and empowers data consumers to find valuable, trustworthy data.

Microsoft Purview automates data discovery by providing data scanning and classification as a service for assets across your data estate. Metadata and descriptions of discovered data assets are integrated into a holistic map of your data estate. Atop this map, there are purpose-built apps that create environments for data discovery, access management, and insights about your data landscape.

The following diagram is a high-level architecture of Microsoft Purview, showing multicloud and on-premises sources flowing into Microsoft Purview, and Microsoft Purview's apps (Data Catalog, Map, and Insights) allowing data consumers and data curators to view and manage metadata. This metadata is also being ported to external analytics services from Microsoft Purview for more processing.

:::image type="content" source="../media/high-level-overview-purview.png" alt-text="Diagram of a high-level Microsoft Purview Overview." lightbox="../media/high-level-overview-purview.png":::
