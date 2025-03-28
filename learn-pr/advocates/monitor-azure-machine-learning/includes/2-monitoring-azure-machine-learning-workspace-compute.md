Infrastructure resources in Azure Machine Learning provide the underlying layer on which data scientists run or train AI models, perform experiments, and do related tasks. As a cloud operations administrator, you're responsible for monitoring these infrastructure components.

## Workspace

A workspace is the top-level resource for Azure Machine Learning. It provides a centralized place to work with all the artifacts that you create when you use Azure Machine Learning.

A workspace:

- Keeps a history of all jobs, including logs, metrics, output, and a snapshot of your scripts.
- Stores references for compute resources.
- Holds all assets, like models, environments, components, and data.

You can monitor your workspace to get insights and errors, such as when a model deployment fails, quota utilization reaches a certain threshold, or there are unusable nodes in your environment.

## Compute

A compute is a designated resource where you run your job or host your endpoint. Azure Machine Learning supports the following types of compute:

- **Compute instance**: This type of compute is a fully configured and managed development environment in the cloud. You can use the instance as a training or inference compute for development and testing.
- **Compute cluster**: This type of compute is a managed infrastructure where you can create a cluster of CPU or GPU compute nodes.
- **Serverless compute**: When you use serverless compute, you don't need to create your own cluster. All compute life-cycle management is offloaded to Azure Machine Learning.
- **Kubernetes cluster**: This type of compute is a used to deploy trained machine learning models to Azure Kubernetes Service (AKS). You can create an AKS cluster from your Azure Machine Learning workspace or attach an existing AKS cluster.
- **Attached (Unmanaged) compute**: You can attach your own compute resources to your workspace and use them for training and inference. Virtual machines (VM) are supported, along with services such as Azure Databricks and Azure HDInsight. These are unmanaged compute resources. As such, they can require extra steps for you to maintain or improve performance for machine learning workloads.

For managed compute resources, you can get insights into the performance of the nodes, quota availability, and resilience of the environment directly from Azure Machine Learning.

Azure Monitor, Log Analytics, and Application Insights are also available for more complex analysis. When you're using an unmanaged compute resource, you need to monitor those resources apart from Azure Machine Learning.
