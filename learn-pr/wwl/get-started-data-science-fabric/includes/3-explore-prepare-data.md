Data is the cornerstone of data science, particularly when aiming to train a machine learning model for achieving artificial intelligence. Typically, models exhibit enhanced performance as the training dataset size increases. In addition to the quantity of data, the quality of the data is equally crucial.

To guarantee both the quality and quantity of your data, using Microsoft Fabric's robust data ingestion and processing engines is worthwhile. You have the flexibility to opt for either a low-code or code-first approach when establishing the essential data ingestion, exploration, and transformation pipelines.

## Ingest your data into Microsoft Fabric

To work with data in Microsoft Fabric, you first need to ingest data. You can ingest data from multiple sources, both local and cloud data sources. For example, you can ingest data from a CSV file stored on your local machine or in an Azure Data Lake Storage (Gen2).

> [!Tip]
> Learn more about how to [ingest and orchestrate data from various sources with Microsoft Fabric](https://learn.microsoft.com/training/paths/ingest-data-with-microsoft-fabric/?azure-portal=true).

After connecting to a data source, you can save the data into a Microsoft Fabric **lakehouse**. You can use the lakehouse as a central location to store any structured, semi-structured, and unstructured files. You can then easily connect to the lakehouse whenever you want to access your data for exploration or transformation.

## Explore and transform your data

As a data scientist, you may be most familiar with writing and executing code in **notebooks**. Microsoft Fabric offers a familiar notebook experience, powered by Spark compute.

**Apache Spark** is an open source parallel processing framework for large-scale data processing and analytics.

Notebooks are automatically attached to Spark compute. When you run a cell in a notebook for the first time, a new Spark session starts. The session persists when you run subsequent cells. The Spark session will automatically stop after some time of inactivity to save costs. You can also manually stop the session.

When you're working in a notebook, you can choose the language you want to use. For data science workloads, you're likely to work with PySpark (Python) or SparkR (R).

:::image type="content" source="../media/notebooks.png" alt-text="Screenshot of a notebook in Microsoft Fabric.":::

Within the notebook, you can explore your data using your preferred library, or with any of the built-in visualization options. If necessary, you can transform your data and save the processed data by writing it back to the lakehouse.

### Prepare your data with the Data Wrangler

To help you explore and transform your data more quickly, Microsoft Fabric offers the easy-to-use **Data Wrangler**.

After launching the Data Wrangler, you'll get a descriptive overview of the data you're working with. You can view the summary statistics of your data to find any issues like missing values.

To clean your data, you can choose any of the built-in data-cleaning operations. When you select an operation, a preview of the result and the associated code is automatically generated for you. When you have selected all necessary operations, you can export the transformations to code and execute it on your data.
