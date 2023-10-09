Azure Arc-enabled data services are a subscription service that provides hybrid data capabilities and managed services using the Kubernetes platform. The following Azure Arc-enabled data services are available:

- Azure Arc-enabled SQL Managed Instance
- Azure Arc-enabled PostgreSQL server (preview)

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

You should carefully plan your resource requirements for your infrastructure and Kubernetes before you deploy Azure Arc-enabled data services. You can find planning guidance on the [planning page](/azure/azure-arc/data/plan-azure-arc-data-services) in the Microsoft documentation.

Microsoft has worked with several industry partners to validate specific infrastructure and Kubernetes solutions. Learn more at the Azure Arc-enabled data services [validation program](/azure/azure-arc/data/validation-program).

Azure arc-enabled data services are deployed as a set of pods based on Microsoft Container Registry (MCR) container images in Kubernetes nodes. All services use one of the key components of the Kubernetes platform, the Kubernetes API.

## Connected modes

Before you deploy Azure Arc-enabled data services components, you should decide which you would like to use. You can choose between the following connected modes:

### Direct connected mode

With direct connected mode (currently in preview), users can use the Azure Resource Manager with the Azure portal to deploy and manage Azure Arc-enabled data services. Azure Role-Based Access Control (RBAC) can be used for security  authentication and control. Also, inventory, logs, metrics, and billing information is automatically sent to Azure.

### Indirect connected mode

With indirect connected mode, all deployment and management operations for Azure Arc-enabled data services are done with the Azure command-line interface (CLI) using the [arcdata extension](/Azure/azure-arc/data/install-arcdata-extension). Or, with tools like kubectl or Azure Data Studio. These tools interact directly with the Kubernetes API to manage Azure Arc-enabled data services. You aren't always required to be connected to Azure when you use indirect connected mode. Inventory and billing can be manually exported and uploaded to Azure using the Azure CLI. Logs and metrics can be optionally uploaded to Azure Monitor.

After deployment, Azure CLI, kubectl, and Azure Data Studio can interact with the Kubernetes API to manage Azure Arc-enabled data services in both direct and indirect connected mode.

You can learn more about connected modes in the Microsoft documentation on [connectivity](/azure/azure-arc/data/connectivity).

## Azure Arc data controller

Once you've deployed the Kubernetes platform of your choice, you first deploy an Azure Arc data controller. The Azure Arc data controller is a series of Kubernetes pods that provide coordination and orchestration of Azure Arc enabled-data services using the Kubernetes API and Custom Resource Definitions (CRD).

The Azure Arc data controller can be deployed in direct connected mode using the Azure portal. To deploy with direct connected mode, you must first connect your Kubernetes cluster using Azure Arc-enabled Kubernetes. This connection deploys Azure Arc agents on your Kubernetes cluster and connects it to Azure. Azure Arc agents are used in direct connected mode to coordinate Azure Resource Manager requests in the Kubernetes cluster and upload inventory, billing, logs, and metrics collected by the Azure Arc data controller. You can learn more about how to connect your Kubernetes cluster in the Microsoft documentation on how to [connect](/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli) to Azure Arc.

The data controller can be deployed in indirect connected mode using the az CLI (using the arcdata extension), kubectl, or Azure Data Studio.

## Azure Arc-enabled data services

With a successful Azure Arc data controller deployment, you can now deploy an Azure Arc-enabled SQL Managed Instance or Azure Arc-enabled PostgreSQL server (preview).

Azure Arc-enabled data services are based on Kubernetes Custom Resource Definitions (CRD). CRD allows the Arc data controller to recognize Kubernetes API requests to deploy and configure Azure Arc-enabled data services.

### Azure Arc-enabled SQL Managed Instance

Azure Arc-enabled SQL Managed Instance is a Kubernetes stateful-set pod, giving it built-in basic high availability. The pod includes containers for the SQL Server instance, metrics, and log collection. The SQL Server instance container includes the SQL Server engine and agents to assist with management capabilities.

In direct connected mode, you can deploy and manage an Azure Arc-enabled SQL Managed Instance using the Azure portal. In indirect connected mode, you can use the Azure CLI (using the arcdata extension), kubectl, or Azure Data Studio.

## Unified Azure experience

When you use direct connected mode, you can manage Azure Arc-enabled data services with the Azure Resource Manager through the Azure portal. For example, you can deploy an Azure Arc-enabled SQL Managed Instance in the Azure portal. Azure Arc resource providers coordinate the request with Azure Arc agents and the Azure Arc data controller in the Kubernetes cluster to complete the deployment. Also, Azure Arc agents automatically consume inventory, metrics, logs, and billing collected by the Azure Arc data controller to upload to Azure.

When you use indirect connected mode, you can manually use the Azure CLI to export and upload inventory, metrics, logs, and billing collected by the Azure Arc data controller. The Azure portal can be used to view deployed Azure Arc-enabled data services and corresponding usage, billing, metrics, and logs.

## Connecting and managing data services

After you have deployed Azure Arc-enabled data services, you can use compatible tools or [client drivers](/sql/connect/sql-connection-libraries) to connect, query, and manage these services. SQL Server Management Studio (SSMS) and Azure Data Studio (ADS) are examples of tools to query and manage Azure Arc-enabled SQL Managed Instance.
