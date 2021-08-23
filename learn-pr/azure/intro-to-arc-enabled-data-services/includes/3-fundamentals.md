Azure Arc-enabled data services is a set of software to provide hybrid data capabilities and managed services using the Kubernetes platform. The following Azure Arc-enabled data services are available:

- Azure Arc-enabled SQL Managed Instance
- Azure Arc-enabled PostgreSQL Hyperscale (Preview)

One of the ways to learn about the various components that make up Azure Arc-enabled data services is to examine the architecture.

:::image type="content" source="../media/azure-arc-data-services-arch.svg" alt-text="Azure Arc-enabled data services architecture" border="false":::  

## Kubernetes and infrastructure

The Azure Arc-enabled data services architecture all starts with the infrastructure and Kubernetes platform of your choice. Several different Kubernetes distributions are supported including:

- Azure Kubernetes Service (AKS)
- Azure Kubernetes Service on Azure Stack (HCI)
- Azure RedHat OpenShift (ARO)
- OpenShift Container Platform (OCP)
- AWS Elastic Kubernetes Service (EKS)
- Google Cloud Kubernetes Engine (GKE)
- Open source, upstream Kubernetes

You should carefully [plan](https://docs.microsoft.com/azure/azure-arc/data/plan-azure-arc-data-services) your resource requirements for your infrastructure and Kubernetes before you deploy Azure Arc-enabled data services.

Microsoft has worked with several industry partners to validate specific infrastructure and Kubernetes solutions. Learn more at the Azure Arc-enabled data services [validation program](https://docs.microsoft.com/azure/azure-arc/data/validation-program).

Azure arc-enabled data services are deployed as a set of pods based on Microsoft Container Registry (MCR) container images running on Kubernetes nodes. All services utilize one of the key components of the Kubernetes platform, the Kubernetes API.

## Connected modes

Before you deploy Azure Arc-enabled data services components, you should decide which connected mode you would like to use. You can choose between the following connected modes:

### Direct connected mode

With direct connected mode, users can use the Azure Resource Manager through the az CLI and Azure Portal to deploy and manage Azure Arc-enabled data services. Azure Active Directory and Azure Role-Based Access Control (RBAC) can be used for security authentication and control. Also, inventory, logs, metrics, and billing information is automatically sent to Azure.

### Indirect connected mode

With indirect connected mode, all deployment and management operations for Azure Arc-enabled data services are done using the az CLI (using the arcdata extension) or tools like kubectl or Azure Data Studio. These tools interact directly with the Kubernetes API to manage Azure Arc-enabled data services. You are not required to be always connected to Azure when you use indirect connected mode. Inventory, logs, metrics, and billing can be manually exported and uploaded to Azure using the az CLI.

## Azure Arc data controller

Once you have deployed the Kubernetes platform of your choice, you will first deploy an Azure Arc data controller. The Azure Arc data controller is a series of Kubernetes pods that provide coordination and orchestration of Azure Arc enabled-data services using the Kubernetes API including a concept called custom resource definitions.

The Azure Arc data controller can be deployed in direct connected mode using the Azure portal. In order to deploy with direct connected mode, you must first [connect](https://docs.microsoft.com/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli) your Kubernetes cluster using Azure Arc-enabled Kubernetes. This connection will deploy Azure Arc agents on your Kubernetes cluster and connect it to Azure.

The data controller can be deployed in indirect connected mode using the az CLI (using the arcdata extension), kubectl, or Azure Data Studio.

## Azure Arc-enabled data services

With a successful Azure Arc data controller deployment, you can now deploy an Azure Arc-enabled SQL Managed Instance or Azure Arc-enabled PostgreSQL Hyperscale.

Azure Arc-enabled data services are based on Kubernetes Custom Resource Definitions (CRD). This allows the Arc data controller to recognize Kubernetes API requests to deploy and configure Azure Arc-enabled data services.

### Azure Arc-enabled SQL Managed Instance

In direct connected mode, you can deploy an Azure Arc-enabled SQL Managed Instance using the Azure portal. In either connected mode, you can use the az CLI, kubectl, or Azure Data Studio.

Azure Arc-enabled SQL Managed Instance is a Kubernetes stateful-set pod, giving it built-in basic high availability. The pod includes containers for the SQL Server instance, metrics, and log collection. The SQL Server instance container includes the SQL Server engine and agents to assist with management capabilities.

### Azure Arc-enabled PostgreSQL Hyperscale

You can deploy an Azure Arc-enabled PostgreSQL Hyperscale through the Azure portal if you use direct connected mode. In either connected mode, you can use the az CLI, kubectl, or Azure Data Studio.

An Azure Arc-enabled PostgreSQL server group is a series of Kubernetes stateful-set pods (the number depends on how many worker nodes you deploy), giving it built-in basic high availability. Each pod includes containers for the PostgreSQL engine, metrics, and log collection.

## Azure integration

## Connecting and managing data services