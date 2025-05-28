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

## Features and capabilities of Azure Machine Learning

Let's focus on **Azure Machine Learning**. Microsoft Azure Machine Learning is a cloud service for training, deploying, and managing machine learning models. It's designed to be used by data scientists, software engineers, devops professionals, and others to manage the end-to-end lifecycle of machine learning projects. 

Azure Machine Learning supports tasks including:

- Exploring data and preparing it for modeling.
- Training and evaluating machine learning models.
- Registering and managing trained models.
- Deploying trained models for use by applications and services.
- Reviewing and applying responsible AI principles and practices.

Azure Machine Learning provides the following features and capabilities to support machine learning workloads:

- Centralized storage and management of datasets for model training and evaluation.
- On-demand compute resources on which you can run machine learning jobs, such as training a model.
- Automated machine learning (AutoML), which makes it easy to run multiple training jobs with different algorithms and parameters to find the best model for your data.
- Visual tools to define orchestrated *pipelines* for processes such as model training or inferencing.
- Integration with common machine learning frameworks such as MLflow, which make it easier to manage model training, evaluation, and deployment at scale.
- Built-in support for visualizing and evaluating metrics for responsible AI, including model explainability, fairness assessment, and others.


