One of the keys to manageable, performant solutions with large data is good model design. We'll discuss model scalability, why it's important, and what tools exist in Power BI to help you and your team accomplish your goals.

## What is enterprise or large-scale data?

Before we talk through scalability, let's define what we're talking about. You'll see throughout the module that we refer to *enterprise-scale* or *large-scale* data rather than big data. In this module, enterprise-scale or large-scale data refers to tables with a large number of records or rows. Power BI, used with tools like Azure Synapse Analytics, can analyze massive datasets, in the range of trillions of rows or petabytes of data.

If you're familiar with working with enterprise data, it may be helpful to understand that Power BI is the next generation of Analysis Services. It's the same technology under the hood of Analysis Services and Power BI datasets, the [VertiPaq engine](/analysis-services/analysis-services-overview).

> [!TIP]
> Take a look at the [Model, query, and explore data in Azure Synapse](/training/paths/model-query-explore-data-for-azure-synapse/) learning path for more information on data analytics in Azure.

## What is scalability and why is it important?
Scalability in this context refers to building data models that can handle growth in the volume of data. A data model that ingests thousands of rows of data may grow to millions of rows over time, and the model must be designed to accommodate such growth. It's important to consider that your data will grow and/or change, which increases complexity. 

Scalability must be at the forefront in enterprise solutions to ensure:
- Flexibility - models need to be able to accommodate change
- Data growth - models must be able to handle an increase in data volume with acceptable report performance
- Reduced complexity - models built with scalability in mind will be less complex and easier to manage

## How do I design for scalability?

The best approach to building scalable Power BI data models will always be building with data modeling best practices in mind. 

Beyond the data model, [Power BI Premium](/power-bi/enterprise/service-premium-what-is) was designed specifically for enterprise deployments. Premium capacity offers greater storage capacity and allows for larger individual datasets depending on the [SKU](/power-bi/enterprise/service-premium-what-is#size-considerations). Implementing the premium only [large dataset storage feature](/power-bi/enterprise/service-premium-large-models) enables data to grow beyond the Power BI desktop (.pbix) file size limitations.

> [!TIP]
> Are you planning a Power BI enterprise deployment? Read the [Power BI enterprise deployment whitepaper](https://aka.ms/PBIEnterpriseDeploymentWP) for a full list of enterprise deployment considerations.

Another important consideration in designing for scalability using Power BI Premium is [choosing the right capacity](/power-bi/enterprise/service-premium-what-is#capacity-nodes). You'll need to work with your Power BI administrator to determine which Power BI Premium licensing SKU is available to you. If you're having performance issues in Premium capacity, work first to optimize your model, and then work with your Power BI administrator to [monitor Power BI Premium capacities](/power-bi/enterprise/service-admin-premium-monitor-capacity).

At the most basic level, it's important to understand that Premium capacities require sufficient memory for processing. You'll need to double the amount of RAM to process your data model refresh. For example, if you have a 40-GB dataset, you'll need *at least* 80-GB of memory available. A 40-GB dataset would be best supported by a P3/A6 capacity, which contains 100-GB of memory.

> [!TIP]
> Review [Power BI license types and capabilities](/power-bi/enterprise/service-admin-licensing-organization#license-types-and-capabilities). If you're not sure which license type your organization has, check with the Power BI administrator.




