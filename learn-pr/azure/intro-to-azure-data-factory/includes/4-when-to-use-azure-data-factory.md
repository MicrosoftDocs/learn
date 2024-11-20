In this unit, we discuss how to determine if Azure Data Factory is a suitable data-integration solution for your organization. We evaluate Azure Data Factory against the following criteria:

- Requirements for data integration
- Coding resources
- Support for multiple data sources
- Serverless infrastructure

## Decision criteria

To determine whether to use Azure Data Factory, use the criteria described in the following table.

| Criteria                          | Analysis                                                     |
| --------------------------------- | ------------------------------------------------------------ |
| Do you need data integration at all? | If your organization works with big data, or is a traditional relational data warehousing organization, you might be interested in a data-integration solution. |
| Do you have the coding resources needed? | Not everybody that works with data is experienced in coding. Some might prefer to work with graphical tools that provide visualizations to help create the tasks that work with source data. |
| Do you need to work with multiple data sources? | Some organizations might have their raw data stored in a range of disparate systems, both on-premises and cloud-based. A data-analytics solution must be able to easily connect to many data sources. |
| Can you create, manage, and maintain separate data integration components? | Without a managed service for data analytics, enterprises must build custom data movement components. Alternatively, they might create custom services to integrate their data sources and processing. Integrating and maintaining such systems can be expensive and difficult. In addition, not all such systems have the monitoring, alerting, and controls that a fully managed service offers. |

## Apply the criteria

Review the following questions when considering Azure Data Factory as your data-integration solution.

### Do you need data integration at all?

If your organization is small, and works with limited data sources, then you might not require a data-integration service at all. If, however, your organization works with big data, or is a traditional relational data warehousing organization, you might benefit from a data-integration solution. Consider the following points:

- Big data organizations rely on technologies for handling large amounts of diverse data. For them, Azure Data Factory provides a means to create and run pipelines in the cloud. These pipelines can access both cloud and on-premises data services. These pipelines typically work with technologies such as Azure Synapse Analytics, Azure Blobs, and Azure Data Lake. Also, Azure HDInsight, Azure Databricks, and Azure Machine Learning.
- Relational data warehousing organizations typically rely on technologies such as SQL Server. SQL Server Integration Services (SSIS) is often used to create SSIS packages. For such organizations, Azure Data Factory gives them the ability to run SSIS packages on Azure, letting them access both cloud and on-premises data services.

### Do you have the coding resources needed?

If your organization lacks the necessary coding resources to create the required activities, consider Azure Data Factory. Azure Data Factory provides a low code/no code process for working with data sources and the related activities. For example, the Azure Data Factory authoring and monitoring tool lets you create pipelines graphically by dragging and dropping activities onto a design surface. The following screenshot depicts the interface where a data engineer is creating a pipeline with several activities:

:::image type="content" source="../media/visual.png" alt-text="Screenshot that displays the Azure Data Factory authoring and monitoring tool.":::

### Do you need to work with multiple data sources?

If your organization has a requirement to access data in multiple locations and from multiple sources, you need to consider a data-integration solution that provides this support. Azure Data Factory uses connectors to integrate with disparate data sources. There are currently more than 90 data sources supported. In addition, Azure Data Factory supports extensible options to reach other data sources.

### Can you create, manage, and maintain separate data integration components?

It can be complex and time-consuming to create and manage your own server-based data-integration solution. However, if running such a solution within your organization's datacenter works for you, then you don't need to consider Azure Data Factory. However, there are advantages in using a fully managed, serverless solution for data integration. Key benefits include:

- The ability to scale as needed to support more workloads.
- No need to deploy, configure, and maintain servers to host your data integration workloads.

## Summary

In summary, consider Azure Data Factory when you meet one or more of the following criteria:

- Your data engineers lack the necessary time to create code to perform data analytics tasks.
- You have multiple data sources in disparate locations.
- You want to take advantage of a fully managed, cloud-based solution.
