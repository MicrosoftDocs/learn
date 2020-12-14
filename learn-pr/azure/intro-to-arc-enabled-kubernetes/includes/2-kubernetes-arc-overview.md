Before we focus on how Azure Arc optimizes management of Kubernetes clusters and their workloads, it is important to have clear understanding of the fundamental characteristics of each of these technologies. In this unit you'll learn about Kubernetes and Azure Arc, and their benefits. 

## What is Kubernetes?

Kubernetes is an extensible, Linux-based, open-source platform for orchestrating containerized workloads. To ensure resiliency, each Kubernetes deployment consists of multiple, clustered servers. Some of them function as control plane nodes, responsible for management of the remaining, worker nodes, hosting containerized workloads. Using Kubernetes, these workloads run as pods. 

> [!NOTE] 
> A pod corresponds roughly to a container, although it can include multiple, tightly-coupled containers running on the same cluster node.

Besides container-based isolation, Kubernetes offers the ability to isolate pods and other cluster resources, such as deployments, into namespaces. Namespaces form logical boundaries, which allow you to restrict access to create, view, or manage resources within the cluster. You can also use namespaces to provide isolation between users and external applications accessing different containerized workloads. 

### What are the key benefits of Kubernetes?

Kubernetes abstracts away the complexity of a multi-container environment that combines compute, networking, and storage components that hundreds or thousands of containers rely on. It offers a declarative management model, in which you  describe the target desired configuration and leave its implementation details for the Kubernetes control plane. 

> [!NOTE] 
> With the declaritive management model, you can use YAML-formatted manifest files to control provision, modify, and delete Kubernetes resources, such as pods or deployments. Alternatively, you can use for this purpose packaged collections of YAML files, referred to as Helm charts. Helm, currently in version 3, is a package manager for Kubernetes, which also provides the ability to deploy packaged applications to Kubernetes clusters.

In addition, the control plane delivers such benefits as:

- Self-healing of pods.
- Autoscaling of pods and, in virtualized scenarios, cluster nodes. 
- Automatic rolling updates and rollbacks of pod deployments. 
- Autodiscovery of new pod deployments. 
- Load balancing across pods running the same workloads.

Effectively, Kubernetes allows you to treat your datacenter as a unified compute resource. You don't have to worry about how and where you deploy your containers, only about deploying and scaling your apps as needed.

However, it's important to understand that Kubernetes is a highly customizable orchestration platform, which requires proper configuration, management, and maintenance:

- Aspects such as deployment, scaling, load balancing, logging, and monitoring are all optional. It is up to you to identify and implement the optimal configuration addressing your specific needs.
- Kubernetes doesn't natively provide middleware, data-processing frameworks, or databases. However, you have the option of implementing any of the corresponding functionalities by using containers.
- You're responsible for maintaining your Kubernetes environment. For example, you need to manage operating system upgrades and Kubernetes upgrades. You also manage the hardware resources available to cluster nodes, such as networking, memory, and storage.

> [!NOTE] 
> Managed Kubernetes offerings, such Azure Kubernetes Service (AKS), minimize or even eliminate some of these challenges.  

## What is Azure Arc?

Business technology landscape continuously evolves and becomes increasingly complex with multiple applications running on different hardware across on-premises datacenters, multiple public and private clouds, and the edge. Managing these disparate environments at scale, enhancing security across an entire organization so that it cannot be compromised, and enabling developer agility and innovation are critical for businesses to succeed and thrive. Microsoft provides tools and solutions that help customers like Contoso to innovate their hybrid environments in a secure manner and with a minimized management overhead. 

Azure Arc is an example of such solution. It consists of a set of technologies that you can use to simplify administration of complex, distributed, hybrid environments. It provides a centralized, scalable, and consistent multi-cloud and on-premises governance and management platform. It facilitates adoption of automation, single-pane-of-glass monitoring and comprehensive security, and promotes the cloud-first strategy, regardless of where your resources are located. At the same time, Azure Arc still allows you to continue using traditional ITOps tools and practices, as you transition to the DevOps model to fully benefit from cloud native architectural and operational patterns.

![Diagram illustrating different scenarios that leverage Azure Arc to optimize administration of SQL Server instances residing on-premises or hosted by third-party cloud providers. The first group of scenarios consists of SQL Server instances running on physical servers or virtual machines. The second group of scenarios comprises on-premises, third-party cloud hosted Kubernetes clusters, or Azure Kubernetes Service clusters running on Azure Stack HCI, with Azure Arc data controller serving as an intermediary management layer. All of these scenarios offer integration with a range of Azure services, such as Azure Monitor and Log Analytics, Azure Policy, Azure Security Center, and Azure Sentinel.](../media/2-azure-arc.png)

### What types of resources support Azure Arc?

Azure Arc supports Azure integration in several scenarios for different types of resources residing outside of Azure in the following scenarios:

- Azure Arc enabled servers - physical and virtual machines (VMs) running Windows or Linux operating system. 
- Azure Arc enabled SQL Server - SQL Server instances running on Azure Arc enabled servers.
- Azure Arc enabled Kubernetes - a wide range of Kubernetes distributions.
- Azure Stack HCI - physical clusters with virtualized workloads and containerized workloads.
- Azure Kubernetes Service on Azure Stack HCI - Azure Kubernetes Service (AKS) running on Azure Stack HCI clusters.
- Azure Arc enabled data services - Azure SQL Managed Instance and PostgreSQL Hyperscale services running on Azure Arc enabled Kubernetes or Azure Kubernetes Service on Azure Stack HCI.

> [!NOTE]
> You can use Azure Arc enabled servers to manage nodes of Kubernetes clusters.

> [!NOTE]
> Verify that the Azure Arc features you intend to use in your production environment are generally available.

In each of the Azure Arc enabled scenarios, Azure Arc relies on a locally installed agent to establish a logical connection between the local resource and Azure. By virtue of establishing this connection, a non-Azure resource automatically becomes a hybrid Azure resource, with its own identity represented by an Azure Resource Manager resource ID. Azure Resource Manager serves as the management interface that allows you to create, modify, and delete Azure resources. Once you Arc-enable a non-Azure resource, you can use Azure Resource Manager to manage and monitor its configuration and operations. 

### What are the key benefits of Azure Arc?

A number of Azure Arc benefits are independent of the resource type, since they reflect the capabilities of Azure Resource Manager. These benefits include:

- The ability to organize all organizational resources by using Azure management groups, subscriptions, resource groups, and tags.
- A single, comprehensive inventory of organizational assets across multi-clouds and on-premises, including support for searching and indexing by using Azure Resource Graph.
- A consolidated view of Azure and Azure Arc enabled resources via the Azure portal, Azure Command Line Interface (CLI), Azure PowerShell, and Representational State Transfer (REST) Application Programming Interface (API).
- Delegation of permissions on the management plane by using Azure Role Based Access Control (RBAC).
- Support for the resource context access to Log Analytics data. Resource context allows you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because each Azure Arc enabled server, cluster, or data service exists as an Azure resource, you can control access to its Log Analytics logs by relying on RBAC permissions assigned to that resource.
- Integration with Azure Monitor. You can use Azure Monitor to help monitor and manage your server resources. Azure Monitor is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises datacenters and to Microsoft and other cloud providers.

Choose the best response for each of the following questions. Then select "Check your answers".
