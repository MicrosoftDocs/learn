
In this unit, you will learn how to apply the results of the Measure step in the innovation lifecycle process, and how important data democratization is.

## Data Democratization

As you have learnt in previous units, you can collect data from your customers using multiple sources, such as micro surveys, utilization data derived by Azure Application Insights, or feature flags that customers can decide on their own to enable or disable. The more data you have, the better your decisions will be. However, you need to have a way of handling this ever increasing flow of data.

Already in 2014 [Satya Nadella talked](https://blogs.microsoft.com/blog/2014/04/15/a-data-culture-for-everyone?azure-portal=true) about the importance of the data culture in an organization. Decisions should not be made based on feelings or subjective opinions, but using data to validate them. Data should be available to every individual that needs it, and it should be easily converted into actionable insights to facilitate data-driven decisions.

Pervasive data decisions can only be taken if they are based on a solid, accessible data platform. This involves four different areas:

- **Collect data**: The first step to data-driven decision making is always having data. Data collection can take multiple forms: migration from existing data repositories, data generation using new sources as Azure Application Insights or data ingestion out of other sources.
- **Share data**: This collected data needs to be available to everybody that needs it, not only to data experts. All individuals in an organization should be able to use data to take their decisions.
- **Govern data**: Data sharing does not mean that all data needs to be available to everybody: Ensure that any sensitive data is secured, tracked, and governed before sharing it.
- **Centralize data**: centralized data platforms can help to simplify data sharing and governance.

## Azure Data Platform

Azure offers a rich platform covering the whole data lifecycle, fundamental for data-driven decision making and data democratization. From lightweight, on-demand databases to massive data warehouses or flexible NoSQL systems, Microsoft Azure data platform allows you to cover the four data activity areas:

### Data Collection

Azure data ecosystem includes services and tools to migrate, ingest, store, and analyze data. The following list is not exhaustive by any means, it just gives a glimpse of some of the mechanisms that can be used to process data and make it available for later sharing, in order to facilitate data-driven decision taking:

- Data Analytics: [Azure Synapse](https://docs.microsoft.com/azure/synapse-analytics/overview-what-is?azure-portal=true) is an enterprise analytics service that accelerates time-to-insight across data warehouses and big data systems. Azure Synapse brings together the best of SQL technologies used in enterprise data warehousing, Spark technologies used for big data, pipelines for data integration and ETL/ELT (Extract-Transform-Load/Extract-Load-Transform), and deep integration with other Azure services such as Power BI, Azure CosmosDB, and Azure Machine Learning.
- Data Migration: data might be already stored in existing sources, but it needs to be migrated to a modern platform before it can be converted into actionable insights. [Azure Database Migration Service](https://docs.microsoft.com/azure/dms?azure-portal=true) contains tooling that helps with data migrations from systems such as SQL Server, PostgreSQL, Oracle, or MongoDB.
- Data Processing: Azure includes services to analyze and transform data streams with [Azure Stream Analytics](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-introduction?azure-portal=true), and to execute ETL (Extract-Transform-Load) processes at large scale with [Azure Data Factory](https://docs.microsoft.com/azure/data-factory?azure-portal=true).

### Data Sharing

[Microsoft Power BI](https://docs.microsoft.com/power-bi/fundamentals/power-bi-overview?azure-portal=true) is a set of tools that consolidate data coming from disparate sources into integrated, interactive visualizations. Users can dive in the data just by operating intuitive controls, so that the power of insights is available to everybody in an organization, and not only to data professionals.

Area owners can create reports and dashboards that contain the relevant information around specific aspects of the application, so that after introducing new functionality to validate a hypothesis, data is readily available to either validate or reject the hypothesis based on real customer usage.

Microsoft Power BI can help with data sharing from multiple perspectives. Here some examples:

- **Sharing data with coworkers and partners**: Power BI Dashboards simplify consuming data, since the visualizations allow for non-data experts to drill down into data without having to be familiar with its underlying structure.
- **Quickly generate data insights**: Power BI can automatically generate visualizations of data sets with its "Quick Insights" functionality, so that you can create dashboards quickly, and find out data correlations that might not have been obvious at first sight.
- **Embed reports in a web site or portal**: with Power BI not only can visualizations be accessed in the native Power BI portal, but reports and dashboards can be embedded in other web applications too. This way, users do not need to navigate away of their familiar corporate web sites to find the data they need for their decision-making process.

### Data Centralization

The main problem of data centralization is scale at different levels: at the risk of oversimplifying, it can be reduced down to the three "V's" of Big Data (Volume, Variety, and Velocity):

- **Volume**: [Azure Data Lake Storage Gen2](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-introduction?azure-portal=true) is the most cost-effective and scalable Azure platform for data storage. Based on the massive scalability provided by Azure Storage, Azure Data Lake Storage has been designed from the start to service multiple petabytes of information while sustaining hundreds of gigabits of throughput.
- **Variety**: this term often refers to the fact that data is not always structured, but you might have semi-structured and even unstructured data too. [Azure Synapse](https://docs.microsoft.com/azure/synapse-analytics/overview-what-is?azure-portal=true) shines in this area, since it brings together the best of SQL technologies used in enterprise data warehousing with Spark, often used for big data.
- **Velocity**: a problem often found in legacy data architectures is the interdependency between storage capacity, analysis speed and ingestion rates. In Azure data solutions, different dimensions of the platform can be scaled independently from each other, by decoupling them. Data can be ingested, processed, and shared using data pipelines that use the required Azure data services, as the [Enterprise Business Intelligence Architecture](https://docs.microsoft.com/azure/architecture/reference-architectures/data/enterprise-bi-synapse?azure-portal=true) shows.

### Data Governance

In today's world, data represents both a critical asset and a significant responsibility: stored data often includes some level of confidential information that could result in financial or personal damage if leaked or shared inappropriately. Not only storing and processing data implicitly means accepting that responsibility, but existing legal regulations can result in penalties for organization that mishandle personal or confidential data.

As a consequence, data governance is critical for any organization with a data democratization goal. The first step towards data governance is classifying data that needs to be treated in specific ways. As an example, these are the data categories that Microsoft uses internally for data classification:

- Non-business: Data from your personal life that doesn't belong to Microsoft.
- Public: Business data that is freely available and approved for public consumption.
- General: Business data that isn't meant for a public audience.
- Confidential: Business data that can cause harm to Microsoft if overshared.
- Highly confidential: Business data that would cause extensive harm to Microsoft if overshared.

The next step after data classification is ensuring that each data category is protected from unauthorized access. Azure supports different technologies that enforce confidentiality:

- **Encryption of data at rest**: all Azure data is encrypted when stored in Microsoft data centers. Some Azure services offer specific encryption features, such as [Transparent Data Encryption](https://docs.microsoft.com/azure/azure-sql/database/transparent-data-encryption-tde-overview?azure-portal=true) in Azure Synapse and Azure SQL Database.
- **Encryption of data in flight**: similarly, all Azure data services encrypt data with SSL/TLS before sending it through the network. Some services such as Azure Storage can optionally allow unencrypted traffic as well. Organizations should disable any unencrypted communication for any type of sensitive data.
- **Data access control**: Azure offers sophisticated authentication and authorization mechanisms both for access to the Azure platform and for access to data itself. [Azure Role-Based Access Control](https://docs.microsoft.com/azure/role-based-access-control/overview?azure-portal=true), [Conditional Access](https://docs.microsoft.com/azure/active-directory/conditional-access/overview?azure-portal=true) and [Privileged Identity Management](https://docs.microsoft.com/azure/active-directory/privileged-identity-management/pim-configure?azure-portal=true) are three examples of essential services that can help to ensure that only authorized individuals have access to sensitive information.
- **Data auditing**: many regulatory compliance standards demand evidence of the data protection mechanisms, by documenting who has done what operation and accessed which data. As described in [Auditing for Azure SQL Database and Azure Synapse Analytics](https://docs.microsoft.com/azure/azure-sql/database/auditing-overview?azure-portal=true), data auditing in Azure contemplates three aspects of auditing:
  - **Retain** an audit trail of selected events, where you can define categories of data actions to be audited.
  - **Report** on database activity, optionally with pre-configured reports and dashboards to get started quickly.
  - **Analyze** reports, to uncover suspicious events, unusual activity, and trends.

## Growth Mindset

The learn phase sometimes delivers bad news. Hypothesis that you thought to be right might turn out not to be correct. Being open for alternative ideas is key for the innovation process to flow smoothly. Maybe they whole hypothesis was wrong, or maybe only the way in which the prototype was developed. In any case, conclusions should always be backed by data, and the team should move on to formulating the next hypothesis, possibly some kind of revision or iteration of the initial one.

A possibility is that existing data does not allow to unequivocally conclude whether the hypothesis was right or wrong. In this case, the data set helping to the decision process should be enhanced, either introducing new telemetry points in the application, or figuring out new ways of getting information about the customer experience. A growth mindset is fundamental at this stage, so that hypothesis proven wrong or partially wrong are considered as learn opportunities, and organizations do not waste time on innovation that does not generate the expected business outcomes.

## Where to look next

Many of the concepts exposed in this unit are further articulated in the Cloud Adoption Framework sections for [Data Democratization](https://docs.microsoft.com/azure/cloud-adoption-framework/innovate/best-practices/data?azure-portal=true).
