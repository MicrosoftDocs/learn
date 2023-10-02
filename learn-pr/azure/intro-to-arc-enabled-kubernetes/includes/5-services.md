With Arc-enabled Kubernetes, you can use Azure to deploy services to your connected clusters.

This unit provides an overview of the types of services you can deploy, and the process for doing so.

## Deploy Azure Arc-enabled data services

Azure Arc-enabled data services are a subscription service that provides hybrid data capabilities and managed services using the Kubernetes platform. 
Azure Arc-enabled data services are deployed as a set of pods based on Microsoft Container Registry (MCR) container images in Kubernetes nodes. All services use one of the key components of the Kubernetes platform, the Kubernetes API.

Before deploying data services, you first deploy the Azure Arc data controller, a series of Kubernetes pods that provide coordination and orchestration of Azure Arc enabled-data services using the Kubernetes API and Custom Resource Definitions (CRD). After a successful Azure Arc data controller deployment, you can create instances of Azure Arc-enabled data services on your connected clusters.

The following Azure Arc-enabled data services are currently available:

- Azure Arc-enabled SQL Managed Instance
- Azure Arc-enabled PostgreSQL server (preview)

The process to deploy Arc-enabled data services consists of the following high-level steps.

In the subscription where you want to deploy Arc-enabled services:

1. Install the client tools for deploying and managing Arc-enabled data services, including Azure CLI (and the arcdata Azure CLI extension) and Azure Data Studio (and its Azure Arc extension).
1. Register the Microsoft.AzureArcData provider for the subscription where the Azure Arc-enabled data services will be deployed.

These steps only need to be done once per subscription.

For each data service instance that you want to deploy in the subscription:

1. Sign in to the Azure AD tenant with an account that has permissions to manage the Azure Arc-enabled Kubernetes resource.
1. Create the Azure Arc data controller.
1. Create the instance of the data service.
1. Connect with Azure Data Studio.

After you have deployed Azure Arc-enabled data services, you can use compatible tools or client drivers to connect, query, and manage these services.

## Deploy Azure services

You can deploy Azure services to your Arc-enabled Kubernetes clusters. Many of these services are deployed by creating instances of an extension on the cluster. Cluster extensions provide an Azure Resource Manager-driven experience for installation and lifecycle management of different Azure capabilities on top of your Kubernetes cluster.

For example, by deploying the Azure Machine Learning extension, you can enable an Arc-enabled Kubernetes cluster to become a Kubernetes compute target in Azure Machine Learning, and use it to train or deploy models.

The process to deploy Azure Machine Learning to an Arc-enabled Kubernetes cluster consists of the following high-level steps.

1. Sign in to the Azure AD tenant with an account that has permissions to manage the Azure Arc-enabled Kubernetes resource.
1. Create an instance of the Azure Machine Learning extension on the cluster.
1. Deploy the Azure Machine Learning extension.
1. Attach the Kubernetes cluster to your Azure Machine Learning workspace.

You can then use the Kubernetes compute target to run training or deploy Azure Machine Learning workloads.
