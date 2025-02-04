There are many services available to train machine learning models. Which service you use depends on factors like:

- What type of model you need to train,
- Whether you need full control over model training,
- How much time you want to invest in model training,
- Which services are already within your organization,
- Which programming language you’re comfortable with.

Within Azure, there are several services available for training machine learning models. Some commonly used services are:

| Icon | Description|
|---|---|
|![Icon of Azure Machine Learning.](../media/03-01-machine-learning.png)|**Azure Machine Learning** gives you many different options to train and manage your machine learning models. You can choose to work with the Studio for a UI-based experience, or manage your machine learning workloads with the Python SDK, or CLI for a code-first experience. Learn more about [Azure Machine Learning](/azure/machine-learning/overview-what-is-azure-machine-learning?azure-portal=true).|
|![Icon of Azure Databricks.](../media/03-01-databricks.png)|**Azure Databricks** is a data analytics platform that you can use for data engineering and data science. Azure Databricks uses distributed Spark compute to efficiently process your data. You can choose to train and manage models with Azure Databricks or by integrating Azure Databricks with other services such as Azure Machine Learning. Learn more about [Azure Databricks](/azure/databricks/what-is-databricks?azure-portal=true).|
|![Icon of Microsoft Fabric.](../media/fabric.png)| **Microsoft Fabric** is an integrated analytics platform designed to streamline data workflows between data analysts, data engineers, and data scientists. With Microsoft Fabric, you can prepare data, train a model, use the trained model to generate predictions, and visualize the data in Power BI reports. Learn more about [Microsoft Fabric](/fabric/get-started/microsoft-fabric-overview?azure-portal=true), and specifically about [the data science features in Microsoft Fabric](/fabric/data-science/?azure-portal=true).|
|![Icon of Azure AI Services.](../media/03-01-cognitive-services.png)| **Azure AI Services** is a collection of prebuilt machine learning models you can use for common machine learning tasks such as object detection in images. The models are offered as an application programming interface (API), so you can easily integrate a model with your application. Some models can be customized with your own training data, saving time and resources to train a new model from scratch. Learn more about [Azure AI Services](/azure/cognitive-services/what-are-cognitive-services?azure-portal=true).|

## Understand the difference between services

Choosing a service to use for training your machine learning models can be challenging. Often, multiple services would fit your scenario. There are some general guidelines to help you:

- Use Azure AI Services whenever one of the customizable prebuilt models suits your requirements, to **save time and effort**.
- Use Microsoft Fabric or Azure Databricks if you want to **keep all data-related** (data analytics, data engineering, and data science) **projects within the same service**.
- Use Microsoft Fabric or Azure Databricks if you need **distributed compute** for working with large datasets (datasets are large when you experience capacity constraints with standard compute). You need to work with [PySpark](https://spark.apache.org/docs/latest/api/python?azure-portal=true) to use the distributed compute.
- Use Azure Machine Learning or Azure Databricks when you want **full control** over model training and management.
- Use Azure Machine Learning when **Python** is your preferred programming language.
- Use Azure Machine Learning when you want an **intuitive user interface** to manage your machine learning lifecycle.

> [!Important]
> There are many factors which may influence your choice of service. Ultimately, it is up to you and your organization to decide what’s the best fit. These are simply guidelines to help you understand how to differentiate between services.

## Decide between compute options

Every time you train a model, you should monitor how long it takes to train the model and how much compute is used to execute your code. By monitoring the compute utilization, you know whether to scale your compute up or down.

When you choose to work with Azure instead of training a model on a local device, you have access to scalable and cost-effective compute.

| Compute options | Considerations |
|---|---|
| **Central Processing Unit** (**CPU**) or a **Graphics Processing Unit** (**GPU**) | For smaller tabular datasets, a CPU is sufficient and cost-effective. For unstructured data like images or text, GPUs are more powerful and efficient. GPUs can also be used for larger tabular datasets, if CPU compute is proving to be insufficient.|
| **General purpose** or **memory optimized** | Use general purpose to have a balanced CPU-to-memory ratio, which is ideal for testing and development with smaller datasets. Use memory optimized to have a high memory-to-CPU ratio. Great for in-memory analytics, which is ideal when you have larger datasets or when you're working in notebooks. |
| **Spark** | A Spark cluster consists of a driver node and worker nodes. Your code initially communicates with the driver node. The work is then distributed across the worker nodes. When you use a service, like Azure Databricks, that distributes the work, parts of the workload can be executed in parallel, reducing the processing time.|

> [!Important]
> To make optimal use of a Spark cluster, your code needs to be written in a Spark-friendly language like Scala, SQL, RSpark, or PySpark in order to distribute the workload. If you write in Python, you only use the driver node and leave the worker nodes unused.

Which compute options best fit your needs is often a case of trial and error. When running code, you should monitor the compute utilization to understand how much compute resources you're using. If training your model takes too long, even with the largest compute size, you can use GPUs instead of CPUs. Alternatively, you can choose to distribute model training by using Spark compute which require you to rewrite your training scripts.
