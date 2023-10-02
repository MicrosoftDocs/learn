

**Resources** in Azure Machine Learning refer to the infrastructure you need to run a machine learning workflow. Ideally, you want someone like an administrator to create and manage the resources. 

The resources in Azure Machine Learning include:

- The workspace
- Compute resources
- Datastores

## Create and manage the workspace

The **workspace** is the top-level resource for Azure Machine Learning. Data scientists will need access to the workspace to train and track models, and to deploy the models to endpoints.

However, you want to be careful with who has *full* access to the workspace. Next to references to compute resources and datastores, you can find all logs, metrics, outputs, models, and snapshots of your code in the workspace.

## Create and manage compute resources

One of the most important resources you need when training or deploying a model is **compute**. There are four types of compute in the Azure Machine Learning workspace:

- **Compute instance**: Similar to a virtual machine in the cloud, managed by the workspace. Ideal to use as a development environment to run (Jupyter) notebooks.
- **Compute cluster**: On-demand clusters of CPU or GPU compute nodes in the cloud, managed by the workspace. Ideal to use for production workloads as they automatically scale to your needs.
- **Inference cluster**: Allows you to create or attach an Azure Kubernetes Service (AKS) cluster. Ideal to deploy trained machine learning models in production scenarios.
- **Attached compute**: Allows you to attach other Azure compute resources to the workspace, like Azure Databricks or Synapse Spark pools.

Though compute is the most important resource when working with machine learning workloads, it can also be the most cost-intensive. Therefore, a best practice is to only allow administrators to create and manage compute resources. Data scientists shouldn't be allowed to edit compute, but only use the available compute to run their workloads.

## Create and manage datastores

The workspace doesn't store any data itself. Instead, all data is stored in **datastores**, which are references to Azure data services. The connection information to a data service that a datastore represents, is stored in the Azure Key Vault.

When a workspace is created, an Azure Storage account is created and automatically connected to the workspace. As a result, you'll have two datastores already added to your workspace:

- `workspacefilestore`: Connects to the file share of the Azure Storage account created with the workspace. Used to store files like Jupyter notebooks and Python scripts.
- `workspaceblobstore`: Connects to the Blob Storage of the Azure Storage account created with the workspace. Used to store metrics and output when tracking model training.

Additionally, you can create datastores to connect to other Azure data services. Most commonly, your datastores will connect to an Azure Storage Account or Azure Data Lake Storage (Gen2) as those data services as most often used in data science projects.
