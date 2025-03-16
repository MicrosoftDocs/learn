Infrastructure resources in Azure Machine Learning provide the underlying layer on which data scientists run or train AI models, perform experiments, etc. As a cloud operations administrator, it's your responsibility to monitor these infrastructure components.

## Workspace

The workspace is the top-level resource for Azure Machine Learning, providing a centralized place to work with all the artifacts you create when you use Azure Machine Learning. The workspace keeps a history of all jobs, including logs, metrics, output, and a snapshot of your scripts. The workspace stores references for compute resources. It also holds all assets like models, environments, components, and data assets.

You can monitor the Workspace to get insights and errors such as when a model deployment fails, when quota utilization reaches a certain threshold, or when there are unusable nodes in your environment.

## Compute

A compute is a designated compute resource where you run your job or host your endpoint. Azure Machine Learning supports the following types of compute:

- **Compute instance** - a fully configured and managed development environment in the cloud. You can use the instance as a training or inference compute for development and testing.
- **Compute cluster** - a managed-compute infrastructure that allows you to create a cluster of CPU or GPU compute nodes.
- **Serverless compute** - When you use serverless compute you don't need to create your own cluster. All compute lifecycle management is offloaded to Azure Machine Learning.
- **Kubernetes cluster** - used to deploy trained machine learning models to Azure Kubernetes Service (AKS). You can create an AKS cluster from your Azure Machine Learning workspace or attach an existing AKS cluster.
- **Attached (Unmanaged) compute** - You can attach your own compute resources to your workspace and use them for training and inference. Virtual Machines (VM) are supported along with other services, such as Azure Databricks, HDInsight, and more. These are unmanaged compute resources and as such they can require extra steps for you to maintain or improve performance for machine learning workloads.

For managed compute resources you can get insights into the performance of the nodes, quota availability, and resiliency of the environment directly from Azure Machine Learning. Azure Monitor, Log Analytics, and App Insights are also available for more complex analysis. When using an unmanaged compute resource, you need to monitor those resources apart from Azure Machine Learning.
