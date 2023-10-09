Here are some of the tasks of an Azure data engineer:

- Design and develop data storage and data processing solutions for the enterprise. 
- Set up and deploy cloud-based data services such as blob services, databases, and analytics.
- Secure the platform and the stored data. Make sure only the necessary users can access the data. 
- Ensure business continuity in uncommon conditions by using techniques for high availability and disaster recovery.
- Monitor to ensure that the systems run properly and are cost-effective. 

> [!div class="alert is-success"]
> **How a data engineer differs from a database administrator**
>
> The data engineer's role overlaps with the role of the database administrator (DBA) in terms of broad tasks. The differences are in scope and focus. Data engineers work with more than just databases, and they focus on _cloud implementations_ rather than on-premises servers.

## Move data around

As a data engineer, you can transfer and move data in several ways. One way is to start an *Extract, Transform, and Load (ETL)* process.

Extraction sources can include databases, files, and streams. Each source has unique data formats that can be structured, semistructured, or unstructured. In Azure, data sources include Azure Cosmos DB, Azure Data Lake, files, and Azure Blob storage.

### Extract

During the extraction process, data engineers define the data and its source:

- **Define the data source**: Identify source details such as the resource group, subscription, and identity information such as a key or secret.

- **Define the data**: Identify the data to be extracted. Define data by using a database query, a set of files, or an Azure Blob storage name for blob storage.

### Transform

**Define the data transformation**: Data transformation operations can include splitting, combining, deriving, adding, removing, or pivoting columns. Map fields between the data source and the data destination. You might also need to aggregate or merge data.

### Load

**Define the destination**: During a load, many Azure destinations can accept data formatted as a JavaScript Object Notation (JSON), file, or blob. You might need to write code to interact with application APIs.

Azure Data Factory offers built-in support for Azure Functions. It has support for many programming languages, including Node.js, .NET, Python, and Java. Although Extensible Markup Language (XML) was common in the past, most systems have migrated to JSON because of its flexibility as a semistructured data type.

**Start the job**: Test the ETL job in a development or test environment. Then migrate the job to a production environment to load the production system.

**Monitor the job**: ETL operations can involve many complex processes. Set up a proactive and reactive monitoring system to provide information when things go wrong. Set up logging according to the technology that uses it.

## ETL tools

As a data engineer, you use several tools for ETL. The most common tool is Azure Data Factory, which provides robust resources and nearly 100 enterprise connectors. Data Factory also allows you to transform data by using a wide variety of languages.

You might find that you also need a repository to maintain information about your organization's data sources and dictionaries. Azure Data Catalog can store this information centrally.

## Evolution from ETL

Azure has opened the way for technologies that can handle unstructured data at an unlimited scale. This change has shifted the paradigm for loading and transforming data from ETL to extract, load, and transform (ELT).

The benefit of ELT is that you can store data in its original format, be it JSON, XML, PDF, or images. In ELT, you define the data's structure during the transformation phase, so you can use the source data in multiple downstream systems.

In an ELT process, data is extracted and loaded in its native format. This change reduces the time required to load the data into a destination system. The change also limits resource contention on the data sources. 

The steps for the ELT process are the same as for the ETL process. They just follow a different order.

Another process like ELT is called extract, load, transform, and load (ELTL). The difference with ELTL is that it has a final load into a destination system.

## Holistic data engineering

Organizations are changing their analysis types to incorporate predictive and preemptive analytics. Because of these changes, as a data engineer you should look at data projects holistically. Data professionals used to focus on ETL, but developments in data platform technologies lend themselves to an ELT approach. 

Design data projects in phases that reflect the ELT approach:

- **Source**: Identify the source systems to extract from. 
- **Ingest**: Identify the technology and method to load the data.
- **Prepare**: Identify the technology and method to transform or prepare the data.

Consider the technologies that are needed to analyze and consume the data within the project:

- **Analyze**: Identify the technology and method to analyze the data.
- **Consume**: Identify the technology and method to consume and present the data.

In traditional descriptive analytics projects, you might have transformed data in Azure Analysis Services and then used Power BI to consume the analyzed data. New AI technologies such as Azure Machine Learning services and Azure Synapse Analytics provide a wider range of technologies to automate some of the required analysis.

These project phases don't necessarily have to flow linearly. For example, because machine learning experimentation is iterative, the Analyze phase sometimes reveals issues such as missing source data or transformation steps. To get the results you need, you might need to repeat earlier phases.

<!-- TODO: this would be a good spot for an image -->

To fully appreciate this process, let's examine it by using an example of high-level architecture.
