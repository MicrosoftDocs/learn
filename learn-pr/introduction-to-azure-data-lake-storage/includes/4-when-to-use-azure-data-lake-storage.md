<!--Paul, also a long unit, might be good to see if any trimming is possible.-->Now we'll consider whether Azure Data Lake Storage is the correct choice for your organization's big data requirements. Your organization wants to:

- Control costs.
- Remove data silos.
- Make it easier to generate business insights from any data.
- Run analytics workloads on real-time data streams.

We'll list some criteria that indicate whether Azure Data Lake Storage will meet your performance and functional goals.

- Costs
- Data access
- Data insights
- Real-time analytics

## Decision criteria

If your organization stores big data, it most likely uses a *data warehouse*. A data warehouse is a repository for data that has been processed—cleaned, structured, and filtered—in a way that enables employees to extract business intelligence by running analytics workloads.

Administrators and data engineers know that traditional data warehouses:

- Are expensive.
- Create barriers to access.
- Cannot extract business insights from external datasets.
- Don't provide real-time analysis of big data.

These issues are irrelevant if your organization deals with a single type of data or with relatively small datasets. To help you decide if Azure Data Lake Storage is a good fir for your organization, let's review the decision criteria in more detail.

### Costs

When deciding whether to move to a data lake from a traditional, on-premises data warehouse, one of the biggest factors is cost. Does a data lake solution such as Azure Data Lake Storage reduce total cost of ownership (TCO)?

Traditional data warehouses have high TCO because:

- They generally use costly, high-end hardware for reliability and performance.
- They require expensive software licenses to process and analyze the data.
- It can be expensive and complicated to make significant changes to the data warehouse configuration or data structures.
- Their overall costs grow with data volume.
- They have associated, fixed costs for items such as maintenance, administration, and backups.

In comparison, Azure Data Lake Storage provides the following benefits:

- It runs on virtual hardware on the Azure platform<!--MS style: The product descriptor is cloud platform or simply platform. Don't use Azure cloud or Azure Cloud. Don't use the Microsoft Cloud to refer to Azure.-->, so storage is scalable, fast, and reliable without incurring massive charges.
- All the software you need to ingest, process, and analyze data is available within your Azure subscription. You can use this software as needed and at a lower cost.
- Data is unprocessed and usually resides in a hierarchical namespace, so it's easier and less expensive to make changes.
- It separates storage costs from compute costs. As your data volume grows, only your storage requirements change. Paying for more cloud storage is far less expensive than adding hardware to store extra data.
- Azure takes care of many costs such as maintenance, administration, and backups.

### Data access

Does a data lake solution such as Azure Data Lake Storage make it easier for users to access data? Does it make the process of browsing, searching, and querying data easier than with a traditional data warehouse?

First, let's review some of the reasons a traditional data warehouse might create significant barriers to access, i.e. data silos:

- Data exploration is limited to what's available with the use of the data warehouse's dedicated data access frontend software.
- There's no exploratory access to raw data.
- Data exploration doesn't include data that's incompatible with or stored outside of the data warehouse.
- If different types of data are stored in separate data warehouses, there's usually no straightforward or cost-effective way to share or combine these datasets.

Azure Data Lake Storage overcomes all of the preceding data access barriers, i.e. it enables so-called *data democratization*. It does this by enabling your organization to store all your data formats, including raw data, in a single location. The elimination of data silos enables users to open a tool such as Azure Data Explorer and use it to access and work with every data item in their storage account.<!--Paul, please validate edits here.-->

### Data insights

Does Azure Data Lake Storage facilitate the extraction of useful business intelligence and other types of business analytics? Data warehouses are purpose-built for analyzing large amounts of data, but the nature of the data warehouse sets limits on the types of insights users can glean. For example:

- The incoming data is highly processed. That processing can introduce subtle biases or restrictions that can make some insights unavailable or difficult to extract.
- To control costs, the stored data is almost always a subset of the total data. This means that users might miss insights that rely on the unavailable data.
- Data warehouses are generally configured to make it easier for business professionals to mine the data for insights. However, that ease of use usually means that users who want to dive deeper into the organization's data—such as data analysts and data scientists—are out of luck because the data they need is unavailable.

> [!NOTE]
> In database parlance, a *schema* is a kind of blueprint for the organizational structure of the data. Data warehouses apply a schema to all incoming data, an approach often referred to as *schema-on-read*. Azure Data Lake Storage, by contrast, doesn't apply a schema to its data. Instead, a schema only gets applied when a tool or framework wants to use the data in a particular way; for example, for an analytics workload. This approach is known as *schema-on-write*.

Here's how the Azure Data Lake Storage solution compares to data warehouses:

- Data is not processed in any way during ingestion, so there are no biases or restrictions introduced into the data.
- Azure Data Lake Storage stores all the available data, whether it's raw, semi-structured, or structured.
- Azure Data Lake Storage can output data to tools such as Power BI that appeal to business analysts and data scientists. However, because the data is unprocessed and complete, such users can easily and quickly design prototypes, called *analytical sandboxes*. They can use these prototypes to explore, test, mash up, and in other ways dive deeply into the data.

### Real-time analytics

Is Azure Data Lake Storage a suitable choice for the ingestion and storage of real-time data to be used in machine learning, the creation of accurate prediction models, and similar real-time analytics? Data warehouses are usually not ideal for handling streaming data because:

- Most data warehouses are configured for *batch input*, where the data is ingested in discrete transactions rather than in real time.
- The schema-on-read approach used by data warehouses is expensive and slow when applied to the high velocity of incoming streaming data.
- Data warehouses work best with structured data, but streaming data is often in a semi-structured format such as JSON or XML key-value pairs.
- Data warehouses filter incoming data, but the analytics workloads for streaming data—particularly for machine learning—almost always require access to the complete dataset.
- Real-time data for a single application often comes in multiple formats; for example, JSON files, log files, and CSV files. However, data warehouses are often not configured to handle disparate data formats.

By contrast, Azure Data Lake Storage was built with real-time data in mind:

- Azure Data Lake Storage can ingest real-time data directly from an instance of HDInsight Storm, Azure IoT Hub, Azure Event Hubs, or Azure Stream Analytics.
- Azure Data Lake Storage doesn't apply a schema during ingestion, so there's no incoming bottleneck for real-time data.
- Azure Data Lake Storage works with semi-structured data.
- You can ingest all your real-time data into your storage account.
- Azure Data Lake Storage is format-agnostic and can therefore give analysts access to multiple data formats as needed.

Besides these advantages, Azure Data Lake Storage is ideal for real-time analytics, because <!--Paul, please check if these edits are OK.--> you can output the ingested streaming data to various Azure services, such as Azure Machine Learning and Azure Stream Analytics.

## Apply the criteria

To decide whether Azure Data Lake Storage is a suitable solution for your organization, review the following use cases and recommendations.

### Should you use Azure Data Lake Storage to lower costs?

Organizations might not save much money by moving from a data warehouse to a data lake if they deal with:

- Relatively small amounts of data, which might be measured in gigabytes rather than terabytes or even petabytes.
- Data that is generated or modified relatively slowly.

However, you should consider using Azure Data Lake Storage to reduce TCO if any of the following conditions apply to your organization:

- It generates massive amounts of data.
- It generates new data quickly.
- There are frequent changes to the data configuration.
- Your costs for hardware, software, and maintenance take up a significant and increasing portion of your IT budget.

### Should you use Azure Data Lake Storage to improve data access?

Organizations might not require the improved data access that comes from moving to Azure Data Lake Storage if they:

- Want to tightly control how users access data.
- Don't need to store raw and semi-structured data.

However, you should consider using Azure Data Lake Storage to enhance data democratization if any of the following conditions apply to your organization:

- You want to prevent the data silos that occur when separate datasets can't be queried or integrated.
- You want to give users access to all of your organization's data.
- You want to give users more flexibility in the tools they use to access the data.

### Should you use Azure Data Lake Storage for data insights?

Using Azure Data Lake Storage for data insights might not be suitable for organizations that:

- Have a narrow scope of what they want to study when analyzing data.
- Employ business professionals to analyze most of the data.

However, you should consider using Azure Data Lake Storage for data insights if any of the following conditions apply to your organization:

- You want to offer users a more flexible approach to exploring the data.
- You want to give analysts access to raw and semi-structured data.
- You want users to be able to build models and sandboxes that use any or even all of the available data.

### Should you use Azure Data Lake Storage for real-time analysis?

You don't need Azure Data Lake Storage to handle real-time data if:

- Your organization's streaming data has a relatively slow velocity and comes in a single data format (such as JSON files)
- Your data warehouse is configured to handle that data format by applying any processing.

However, you should consider using Azure Data Lake Storage for real-time analytics if any of the following conditions apply to your organization:

- Your streaming data comes in very fast.
- Your real-time data arrives in multiple data formats.
- You want to apply multiple types of analytics workloads to the data, such as machine learning, model prediction, and sentiment analysis.
