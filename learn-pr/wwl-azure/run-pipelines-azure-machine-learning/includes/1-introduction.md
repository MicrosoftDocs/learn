

In Azure Machine Learning, you can experiment in notebooks and train (and retrain) machine learning models by running scripts as jobs. 

In an enterprise data science process, you'll want to separate the overall process into individual tasks. You can group tasks together as **pipelines**. Pipelines are key to implementing an effective **Machine Learning Operations** (**MLOps**) solution in Azure. 

You'll learn how to create **components** of individual tasks, making it easier to reuse and share code. You'll then combine components into an Azure Machine Learning pipeline, which you'll run as a **pipeline job**.

> [!NOTE]
> The term *pipeline* is used extensively across various domains, including machine learning and software engineering. In Azure Machine Learning, a pipeline contains steps related to the training of a machine learning model. In Azure DevOps or GitHub, a pipeline can refer to a build or release pipelines, which perform the build and configuration tasks required to deliver software. In Azure Synapse Analytics, a pipeline is used to define the data ingestion and transformation process. The focus of this module is on Azure Machine Learning pipelines. However, bear in mind that it's possible to have pipelines across services interact with each other. For example, an Azure DevOps or Azure Synapse Analytics pipeline can trigger an Azure Machine Learning pipeline. 

> [!Tip]
> Learn more about MLOps in relation to Azure Machine Learning with [an introduction to machine learning operations](/training/paths/introduction-machine-learn-operations?azure-portal=true)

## Learning objectives

In this module, you'll learn how to:

- Create components.
- Build an Azure Machine Learning pipeline.
- Run an Azure Machine Learning pipeline.
