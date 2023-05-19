There are many services available to train machine learning models. Which service you use depends on factors like:

- What type of model you need to train.
- Whether you need full control over model training.
- How much time you want to invest in model training.
- Which services are already within your organization.
- Which programming language you’re comfortable with.

Within Azure, there are several services available for training machine learning models. When you choose to work with Azure instead of training a model on a local device, you’ll have access to scalable and cost-effective compute. For example, you’ll be able to use compute only for the time needed to train a model, and not pay for the compute when it’s not used. 

Some commonly used services in Azure to train machine learning models are:

| Icon | Description|
|---|---|
|![Icon of Azure Machine Learning.](../media/03-01-machine-learning.png)|**Azure Machine Learning** gives you many different options to train and manage your machine learning models. You can choose to work with the Studio for a UI-based experience, or manage your machine learning workloads with the Python SDK, or CLI for a code-first experience. Learn more about [Azure Machine Learning](https://learn.microsoft.com/azure/machine-learning/overview-what-is-azure-machine-learning?azure-portal=true).|
|![Icon of Azure Databricks.](../media/03-01-databricks.png)|**Azure Databricks** is a data analytics platform that you can use for data engineering and data science. Azure Databricks uses distributed Spark compute to efficiently process your data. You can choose to train and manage models with Azure Databricks or by integrating Azure Databricks with other services such as Azure Machine Learning. Learn more about [Azure Databricks](https://learn.microsoft.com/azure/databricks/what-is-databricks?azure-portal=true).|
|![Icon of Azure Synapse Analytics.](../media/03-01-synapse.png)| **Azure Synapse Analytics** is an analytics service, which uses distributed compute for big data analytics. Azure Synapse Analytics is primarily designed to ingest and transform data at scale but also includes several machine learning capabilities. To train models with Azure Synapse Analytics, you can train models on Spark pools with MLlib or use the integrated Automated Machine Learning feature from Azure Machine Learning. Learn more about [Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/overview-what-is?azure-portal=true), and specifically about [the machine learning capabilities in Azure Synapse Analytics](/azure/synapse-analytics/machine-learning/what-is-machine-learning?azure-portal=true).|
|![Icon of Azure Cognitive Services.](../media/03-01-cognitive-services.png)| **Azure Cognitive Services** is a collection of prebuilt machine learning models you can use for common machine learning tasks such as object detection in images. The models are offered as an application programming interface (API), so you can easily integrate a model with your application. Some models can be customized with your own training data, saving time and resources to train a new model from scratch. Learn more about [Azure Cognitive Services](https://learn.microsoft.com/azure/cognitive-services/what-are-cognitive-services?azure-portal=true).|

## Understand the difference between services

Choosing a service to use for training your machine learning models may be challenging. Often, multiple services would fit your scenario. There are some general guidelines to help you:

- Use Azure Cognitive Services whenever one of the customizable prebuilt models suits your requirements, to **save time and effort**. 
- Use Azure Synapse Analytics or Azure Databricks if you want to **keep all data-related** (data engineering and data science) **projects within the same service**. 
- Use Azure Synapse Analytics or Azure Databricks if you need **distributed compute** for working with large datasets (datasets are large when you experience capacity constraints with standard compute). You'll need to work with [PySpark](https://spark.apache.org/docs/latest/api/python?azure-portal=true) to use the distributed compute.
- Use Azure Machine Learning or Azure Databricks when you want **full control** over model training and management. 
- Use Azure Machine Learning when **Python** is your preferred programming language. 
- Use Azure Machine Learning when you want an **intuitive user interface** to manage your machine learning lifecycle.

> [!Important]
> There are many factors which may influence your choice of service. Ultimately, it is up to you and your organization to decide what’s the best fit. These are simply guidelines to help you understand how to differentiate between services. 