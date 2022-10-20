To access data when training machine learning models, you'll want to serve the data by storing it in a cloud data service. By storing data separately from your compute, you’ll *minimize costs* and *be more flexible*.

## Separate compute from storage
One of the benefits of the cloud is the ability to scale compute up or down according to your demands. In addition, you can shut down compute when you don’t need it and restart it when you want to use it again. 

Especially when training machine learning models, you’ll have periods of time during which you'll need a lot of compute power, and times when you don’t. When shutting down the compute you use for training machine learning models, you want to ensure your data isn't lost, and can still be accessed for other purposes (like reporting). 

Therefore, it’s a best practice to store your data in a service, which is separate from the service, which provides you with compute for training your models. Which service is best to store your data depends on the data you have and the service you use for model training.

## Store data for model training workloads
When you use **Azure Machine Learning**, **Azure Databricks**, or **Azure Synapse Analytics** for *model training*, there are three common options for storing data, which are easily connected to all three services:

- **Azure Blob Storage**: Cheapest option for storing data as *unstructured* data. Ideal for storing files like images, text, and JSON. Often also used to store data as CSVs as files, as data scientists prefer working with CSV files.
- **Azure Data Lake Storage (Gen 2)**: Stores data as *unstructured* data while also implementing a hierarchical namespace, which means it’s easier to give someone access to a specific file or folder. Storage capacity is virtually limitless so ideal for storing large data. 
- **Azure SQL Database**: Stores data as *structured* data. Data will be read like a table and schema is defined when a table in the database is created. Ideal for data that doesn’t change over time.

> [!Note]
> There are other Azure services for storing and serving data to services such as Azure Machine Learning, Azure Databricks, and Azure Synapse Analytics. The three storage options listed here are the most commonly used data storage solutions, especially for new projects. To learn about when to use which option, [explore this guide on Azure data stores](/azure/architecture/guide/technology-choices/data-store-decision-tree).

By storing your data in one of these Azure storage solutions, you can easily serve the data to whichever Azure service you use for machine learning workloads. To load the data into one of these storage solutions, you can set up a pipeline to extract, transform, and load the data. 