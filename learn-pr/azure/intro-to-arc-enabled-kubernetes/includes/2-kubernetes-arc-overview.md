Before we focus on how Azure Arc optimizes management of Kubernetes clusters and their workloads, it's important to understand more about these technologies. In this unit, you'll learn about Kubernetes and Azure Arc and the key benefits that they provide.

## What is Kubernetes?

Kubernetes is an extensible, Linux-based, open-source platform for orchestrating containerized workloads. To ensure resiliency, each Kubernetes deployment consists of multiple, clustered servers. Some of them function as control plane nodes, responsible for management of the remaining worker nodes, which host containerized workloads. Using Kubernetes, these workloads run as pods.

> [!NOTE]
> A pod corresponds roughly to a container, although it can include multiple tightly-coupled containers running on the same cluster node.

Besides container-based isolation, Kubernetes offers the ability to isolate pods and other cluster resources, such as deployments, into namespaces. Namespaces form logical boundaries, which allow you to restrict access to create, view, or manage resources within the cluster. You can also use namespaces to provide isolation between users and external applications accessing different containerized workloads.

### What are the key benefits of Kubernetes?

Kubernetes abstracts away the complexity of a multi-container environment that combines compute, networking, and storage components that hundreds or thousands of containers may rely on. It offers a declarative management model, in which you describe the target desired configuration and leave its implementation details for the Kubernetes control plane.

> [!NOTE]
> With the declarative management model, you can use YAML-formatted manifest files to control provision, modify, and delete Kubernetes resources, such as pods or deployments. Alternatively, you can use packaged collections of YAML files, referred to as Helm charts. Helm is a package manager for Kubernetes, which also provides the ability to deploy packaged applications to Kubernetes clusters.

In addition, the control plane delivers benefits such as:

- Self-healing of pods.
- Autoscaling of pods and, in virtualized scenarios, cluster nodes.
- Automatic rolling updates and rollbacks of pod deployments.
- Automatic discovery of new pod deployments.
- Load balancing across pods running the same workloads.

Effectively, Kubernetes allows you to treat your datacenter as a unified compute resource. You don't have to worry about how and where you deploy your containers, only about deploying and scaling your apps as needed.

However, it's important to understand that Kubernetes is a highly customizable orchestration platform, requiring proper configuration, management, and maintenance:

- Aspects such as deployment, scaling, load balancing, logging, and monitoring are all optional. It is up to you to identify and implement the optimal configuration addressing your specific needs.
- Kubernetes doesn't natively provide middleware, data-processing frameworks, or databases. However, you have the option of implementing any of the corresponding functionalities by using containers.
- You're responsible for maintaining your Kubernetes environment. For example, you need to manage operating system upgrades and Kubernetes upgrades. You also manage the hardware resources available to cluster nodes, such as networking, memory, and storage.

> [!NOTE]
> Managed Kubernetes offerings, such Azure Kubernetes Service (AKS), minimize or even eliminate some of these challenges.  

## What is Azure Arc?

As the business technology landscape evolves, it can become increasingly complex. Multiple applications might run on different hardware across on-premises datacenters, various public and private clouds, and the edge. Managing these disparate environments at scale, enhancing security across an entire organization, and enabling developer agility are critical functions to help businesses to succeed and thrive. Microsoft provides tools and solutions that help customers like Contoso to innovate their hybrid environments in a more secure manner, with minimal management overhead.

Azure Arc is one of these solutions. It provides a set of technologies that you can use to simplify administration of complex, distributed, and hybrid environments. Azure Arc provides a centralized, scalable, and consistent governance and management platform spanning multicloud and on-premises. It facilitates adoption of automation, single-pane-of-glass monitoring and comprehensive security, enabling a cloud-first strategy regardless of where your resources are located. At the same time, Azure Arc lets you continue using traditional ITOps tools and practices as you transition to the DevOps model to fully benefit from cloud native architectural and operational patterns.

:::image type="content" source="../media/2-azure-arc.png" alt-text="Diagram showing the GitOps workflow for Azure Arc-enabled Kubernetes, including an application update.":::

### What types of resources work with Azure Arc?

Azure Arc supports Azure integration for different types of resources residing outside of Azure, including:

- Azure Arc-enabled servers - physical and virtual machines (VMs) running Windows or Linux operating system.
- SQL Server on Azure Arc-enabled servers - SQL Server instances running on Azure Arc-enabled servers.
- Azure Arc-enabled Kubernetes - a wide range of Kubernetes distributions.
- Azure Stack HCI - physical clusters with virtualized workloads and containerized workloads.
- Azure Kubernetes Service on Azure Stack HCI - Azure Kubernetes Service (AKS) running on Azure Stack HCI clusters.
- Azure Arc-enabled data services - Azure SQL Managed Instance running on Azure Arc-enabled Kubernetes or AKS on Azure Stack HCI

> [!NOTE]
> For production environments, verify that the Azure Arc features you intend to use are generally available.

In each of these Azure Arc-enabled scenarios, Azure Arc relies on a locally installed agent to establish a logical connection between the local resource and Azure. By establishing this connection, a non-Azure resource becomes a hybrid Azure resource, with its own identity represented by an Azure Resource Manager resource ID. Azure Resource Manager serves as the management interface that allows you to create, modify, and delete Azure resources. Once a non-Azure resource is connected through Azure Arc, you can use Azure Resource Manager to manage and monitor its configuration and operations.

### What are the key benefits of Azure Arc?

Many Azure Arc benefits apply across different types of resources connected to Azure. These benefits include:

- The ability to organize all organizational resources by using Azure management groups, subscriptions, resource groups, and tags.
- A single, comprehensive inventory of assets across multiple clouds and on-premises, including support for searching and indexing by using Azure Resource Graph.
- A consolidated view of Azure and Azure Arc-enabled resources via the Azure portal, Azure Command Line Interface (CLI), Azure PowerShell, and Representational State Transfer (REST) Application Programming Interface (API).
- Delegation of permissions on the management plane by using Azure role-based access control (RBAC).
- Support for the resource context access to Log Analytics data. Resource context allows you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because each Azure Arc-enabled server, cluster, or data service exists as an Azure resource, you can control access to its Log Analytics logs by relying on RBAC permissions assigned to that resource.
- Integration with Azure Monitor. You can use Azure Monitor to help monitor and manage your server resources. Azure Monitor is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises environments and other cloud providers.

Choose the best response for each of the following questions. Then select "Check your answers".
