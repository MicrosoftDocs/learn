*Azure Arc* is a service that provides a set of technologies for organizations such as Contoso that want to simplify their complex and distributed environments.

*Azure Arc* is a set of technologies that brings Azure security and cloud-native services to hybrid and multicloud environments. It provides a centralized, unified, and self-service approach to managing, securing, and monitoring:

 -  Windows Server
 -  Linux servers
 -  Kubernetes clusters
 -  SQL servers
 -  Azure Data Services

Azure Arc also extends adoption of cloud native services and DevOps across hybrid, multicloud, and edge environments. In addition to extending the control plane for managing infrastructure, Azure Arc enables companies to run Azure data services, and Azure Machine Learning on containerized infrastructure anywhere.

Continuous improvements have been made to the Azure control plane. This control plane is responsible for managing the lifecycle of resources such as VMs, database instances, Apache Hadoop clusters, and Kubernetes clusters.

For example, every time Contoso provisions, scales, stops, or terminates a resource—such as an Azure VM—the Azure fabric controller processes this operation. In between the fabric controller and the resources is another layer called the *Azure Resource Manager* that automates the resource lifecycle. Azure has resource providers for each of these resource types hosted in Azure.

> [!NOTE]
> Azure Resource Manager provides a management layer that enables you to create, update, and delete your Azure resources.

## Azure Arc capabilities

Azure Arc enables you to deploy and configure the following cloud based technologies to secure, manage, and monitor Arc-enabled servers:

:::row:::
  :::column:::
    **Feature**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Policy guest configuration
  :::column-end:::
  :::column:::
    Audit Azure Arc resources to validate such settings as configurations of the operating system (OS), applications, and environment settings
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support for resource-context–access Log Analytics data
  :::column-end:::
  :::column:::
    Restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Microsoft Defender for Cloud
  :::column-end:::
  :::column:::
    Microsoft Defender for Endpoint provides threat detection and vulnerability management.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Microsoft Sentinel
  :::column-end:::
  :::column:::
    Collect security-related events and correlate them with other data sources.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Monitor
  :::column-end:::
  :::column:::
    Monitor and store data related system performance and events. Discover application components and processes to determine dependencies.
  :::column-end:::
:::row-end:::


## Additional reading

You can learn more by reviewing the following documents.

 -  [What is Azure Resource Manager?](https://aka.ms/azure-resource-manager-management-overview?azure-portal=true)
 -  [What is Azure Arc for servers?](https://aka.ms/azure-arc-servers?azure-portal=true)