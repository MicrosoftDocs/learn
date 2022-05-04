In this unit, you'll learn how to apply the results of the measure step in the innovation lifecycle, and the importance of data democratization.

## Data democratization

As you've learned in previous units, you can collect data from your customers by using multiple sources. These sources include micro surveys, utilization data derived by Azure Application Insights, and feature flags that customers can decide on their own to enable or disable. The more data you have, the better your decisions will be, but you need a way to handle this ever-increasing flow of data.

In 2014, [Satya Nadella talked](https://blogs.microsoft.com/blog/2014/04/15/a-data-culture-for-everyone?azure-portal=true) about the importance of the data culture in an organization. He said that decisions shouldn't be made based on feelings or subjective opinions, but by using data to validate them. He also said that data should be available to every individual who needs it, and it should be easily converted into actionable insights to facilitate data-driven decisions.

An organization can make pervasive data decisions only if those decisions are based on a solid, accessible data platform. This effort involves four areas:

- **Collect data**: The first step to data-driven decision making is always having data. Data collection can take multiple forms: migration from existing data repositories, data generation from sources like Azure Application Insights, or data ingestion from other sources.
- **Share data**: Collected data needs to be available to everybody who needs it, not only to data experts. All individuals in an organization should be able to use data to make their decisions.
- **Centralize data**: Centralized data platforms can help to simplify data sharing and governance.
- **Govern data**: Data sharing does not mean that all data needs to be available to everybody. Ensure that any sensitive data is secured, tracked, and governed before sharing it.

## Azure data platform

The Azure platform covers the whole data lifecycle, which is fundamental for data-driven decision making and data democratization. From lightweight, on-demand databases to massive data warehouses or flexible NoSQL systems, the Azure data platform allows you to cover the four data activity areas.

### Data collection

The Azure data ecosystem includes services and tools to migrate, ingest, store, and analyze data. The following list shows only a few of the mechanisms that you can use to process data and make it available for later sharing, in order to facilitate data-driven decision making:

- **Data analytics**: [Azure Synapse Analytics](/azure/synapse-analytics/overview-what-is?azure-portal=true) is an enterprise analytics service that accelerates time-to-insight across data warehouses and big-data systems. Azure Synapse Analytics brings together the best of:
   - SQL technologies used in enterprise data warehousing
   - Spark technologies used for big data
   - Pipelines for data integration and ETL (extract, transform, load) and ELT (extract, load, transform)
   - Deep integration with other Microsoft services such as Power BI, Azure Cosmos DB, and Azure Machine Learning
- **Data migration**: Data might be already stored in existing sources, but it needs to be migrated to a modern platform before it can be converted into actionable insights. [Azure Database Migration Service](/azure/dms?azure-portal=true) contains tooling that helps with data migrations from systems such as SQL Server, PostgreSQL, Oracle, and MongoDB.
- **Data processing**: Azure includes services to analyze and transform data streams with [Azure Stream Analytics](/azure/stream-analytics/stream-analytics-introduction?azure-portal=true), and to run ETL processes at large scale with [Azure Data Factory](/azure/data-factory?azure-portal=true).

### Data sharing

[Microsoft Power BI](/power-bi/fundamentals/power-bi-overview?azure-portal=true) is a set of tools that consolidate data coming from disparate sources into integrated, interactive visualizations. Users can dive into the data just by operating intuitive controls. The power of insights is available to everybody in an organization, not just to data professionals.

Area owners can create reports and dashboards that contain the relevant information around specific aspects of the application. After new functionality is introduced to validate a hypothesis, data is readily available to either validate or reject the hypothesis based on real customer usage.

Microsoft Power BI can help with data sharing from multiple perspectives. Here some examples:

- **Share data with coworkers and partners**: Power BI dashboards simplify consuming data. Visualizations allow for people who aren't data experts to drill down into data without having to be familiar with its underlying structure.
- **Quickly generate data insights**: Power BI can automatically generate visualizations of data sets with its Quick Insights functionality. You can create dashboards quickly and find data correlations that might not have been obvious at first.
- **Embed reports in a website or portal**: With Power BI, not only can visualizations be accessed in the native Power BI portal, but reports and dashboards can be embedded in other web applications too. This way, users don't need to leave their familiar corporate websites to find the data that they need for their decision-making process.

### Data centralization

The main problem of data centralization is scale at different levels. At the risk of oversimplifying, it can be reduced to the three "V's" of big data:

- **Volume**: [Azure Data Lake Storage Gen2](/azure/storage/blobs/data-lake-storage-introduction?azure-portal=true) is a cost-effective and scalable Azure platform for data storage. Based on the massive scalability provided by Azure Storage, Azure Data Lake Storage has been designed to service multiple petabytes of information while sustaining hundreds of gigabits of throughput.
- **Variety**: This term often refers to the fact that data is not always structured. You might have semi-structured and even unstructured data, too. [Azure Synapse](/azure/synapse-analytics/overview-what-is?azure-portal=true) shines in this area, because it brings together the best of SQL technologies used in enterprise data warehousing with Spark, which is often used for big data.
- **Velocity**: A problem often found in older data architectures is the interdependency between storage capacity, analysis speed, and ingestion rates. In Azure data solutions, an organization can scale different dimensions of the platform independently by decoupling them. Data can be ingested, processed, and shared through data pipelines that use the required Azure data services, as the [enterprise business intelligence architecture](/azure/architecture/reference-architectures/data/enterprise-bi-synapse?azure-portal=true) shows.

### Data governance

In today's world, data represents both a critical asset and a significant responsibility. Stored data often includes confidential information that can result in financial or personal damage if it's leaked or shared inappropriately. Storing and processing data implicitly means accepting that responsibility. Legal regulations can result in penalties for organizations that mishandle personal or confidential data.

As a consequence, data governance is critical for any organization that has a goal of data democratization. The first step toward data governance is classifying data that needs to be treated in specific ways. As an example, Microsoft uses these data categories internally for data classification:

- **Non-business**: Data from your personal life that doesn't belong to Microsoft
- **Public**: Business data that's freely available and approved for public consumption
- **General**: Business data that isn't meant for a public audience
- **Confidential**: Business data that can cause harm to Microsoft if overshared
- **Highly confidential**: Business data that would cause extensive harm to Microsoft if overshared

The next step after data classification is ensuring that each data category is protected from unauthorized access. Azure supports these technologies that enforce confidentiality:

- **Encryption of data at rest**: All Azure data is encrypted when stored in Microsoft datacenters. Some Azure services offer specific encryption features, such as [transparent data encryption](/azure/azure-sql/database/transparent-data-encryption-tde-overview?azure-portal=true) in Azure Synapse and Azure SQL Database.
- **Encryption of data in flight**: All Azure data services encrypt data with SSL or TLS before sending it through the network. Some services, such as Azure Storage, can optionally allow unencrypted traffic. Organizations should disable any unencrypted communication for any type of sensitive data.
- **Data access control**: Azure offers sophisticated authentication and authorization mechanisms both for access to the Azure platform and for access to data itself. [Azure role-based access control](/azure/role-based-access-control/overview?azure-portal=true), [Conditional Access](/azure/active-directory/conditional-access/overview?azure-portal=true), and [Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure?azure-portal=true) are three examples of essential services that can help to ensure that only authorized people have access to sensitive information.
- **Data auditing**: Many regulatory compliance standards demand evidence of data protection mechanisms by documenting who has done certain operations and accessed certain data. As described in [Auditing for Azure SQL Database and Azure Synapse Analytics](/azure/azure-sql/database/auditing-overview?azure-portal=true), data auditing in Azure contemplates three aspects of auditing:
  - *Retain* an audit trail of selected events, where you can define categories of data actions to be audited
  - *Report* on database activity, optionally with preconfigured reports and dashboards to get started quickly
  - *Analyze* reports to uncover suspicious events, unusual activity, and trends

## Growth mindset

The learn phase sometimes delivers bad news. Hypotheses that you thought were right might turn out to be wrong. Being open to alternative ideas is key for the innovation process to flow smoothly. Maybe the whole hypothesis was wrong, or maybe the problem was only the way in which the prototype was developed.

In any case, conclusions should always be backed by data. The team should move on to formulating the next hypothesis, possibly some kind of revision or iteration of the initial one.

Existing data might not allow you to unequivocally conclude whether the hypothesis was right or wrong. In this case, the data set that's helping the decision process should be enhanced. Either introduce new telemetry points in the application, or figure out new ways of getting information about the customer experience.

A growth mindset is fundamental at this stage. Think of hypotheses proven wrong or partially wrong as learning opportunities. Organizations shouldn't waste time on an innovation that doesn't generate the expected business outcomes.

## Where to look next

Many of the concepts in this unit are further discussed in the Cloud Adoption Framework documentation about [data democratization](/azure/cloud-adoption-framework/innovate/best-practices/data?azure-portal=true).