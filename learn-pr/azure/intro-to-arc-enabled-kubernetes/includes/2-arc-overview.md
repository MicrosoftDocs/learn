In this unit, you learn the basics of Azure Arc and its key capabilities and benefits.

## Kubernetes basics

Kubernetes is an extensible, Linux-based, open-source platform for orchestrating containerized workloads. To ensure resiliency, each Kubernetes deployment consists of multiple, clustered server nodes. Some servers are control plane nodes that manage the other worker nodes.

The worker nodes host containerized workloads as Kubernetes pods. A pod roughly corresponds to a container, although it can include multiple tightly coupled containers that run on the same node.

Besides container-based isolation, Kubernetes can also isolate pods and other resources like deployments into namespaces. Namespaces form logical boundaries to provide isolation between users and external applications that access different containerized workloads. Namespaces also let you restrict permissions to create, view, or manage resources within a cluster.

## Kubernetes benefits

Kubernetes abstracts away the complexity of a multicontainer environment combining compute, networking, and storage components that hundreds or thousands of containers might rely on. The Kubernetes declarative management model describes the desired target configuration and leaves its implementation details to the Kubernetes control plane.

The declarative management model uses YAML-formatted manifest files to control provision, modify, and delete Kubernetes resources, such as pods or deployments. You can use the Helm package manager for Kubernetes to deploy packaged collections of YAML files, called Helm charts, to Kubernetes clusters.

Kubernetes lets you treat your datacenter as a unified compute resource. You don't have to worry about how and where you deploy your containers, only about deploying and scaling your apps as needed.

The Kubernetes control plane also delivers the following benefits:

- Self-healing of pods.
- Autoscaling of pods and, in virtualized scenarios, cluster nodes.
- Automatic rolling updates and rollbacks of pod deployments.
- Automatic discovery of new pod deployments.
- Load balancing across pods running the same workloads.

## Kubernetes challenges

It's important to understand that Kubernetes is a highly customizable orchestration platform that requires proper configuration, management, and maintenance.

Capabilities like deployment, scaling, load balancing, logging, and monitoring are all optional. It's up to you to identify and implement the optimal configuration that addresses your specific needs.

Kubernetes doesn't natively provide middleware, data-processing frameworks, or databases. You can optionally implement any of the corresponding functionalities by using containers.

You're responsible for maintaining your Kubernetes environment. For example, you need to manage operating system and Kubernetes upgrades. You must also manage the hardware resources available to cluster nodes, such as networking, memory, and storage.

Managed Kubernetes offerings, such as Azure Kubernetes Service (AKS), can minimize or eliminate some of these challenges.

## Azure Arc basics

As business technology evolves, it becomes more complex. Multiple applications might run on different hardware across on-premises datacenters, various public and private clouds, and the edge. It's important to manage these disparate environments at scale, enhance security across the entire organization, and enable developer agility. Microsoft provides tools and solutions that help organizations innovate their hybrid environments more securely, with minimal management overhead.

Azure Arc provides a set of technologies that you can use to simplify administration of complex, distributed, and hybrid environments. The centralized, scalable, and consistent Azure Arc governance and management platform spans multicloud and on-premises environments.

Azure Arc facilitates adoption of automation, single-pane-of-glass monitoring, and comprehensive security, enabling a cloud-first strategy regardless of where your resources are located. At the same time, Azure Arc lets you continue using traditional IT tools and practices as you transition to the DevOps model to fully benefit from cloud native architectural and operational patterns.

The following diagram shows how Azure Arc operates across multicloud and on-premises Kubernetes environments.

 :::image type="content" source="../media/2-azure-arc.png" alt-text="Diagram showing how Azure Arc operates across multicloud and on-premises Kubernetes environments.":::


### Azure Arc support for non-Azure resources

Azure Arc supports Azure integration for the following types of resources that reside outside of Azure:

- Azure Arc-enabled physical servers and virtual machines (VMs) running Windows or Linux operating systems.
- SQL Server instances running on Azure Arc-enabled servers.
- Azure Arc-enabled Kubernetes for a wide range of Kubernetes distributions.
- Azure Stack HCI on-premises physical clusters with virtualized workloads and containerized workloads.
- AKS running on Azure Stack HCI clusters.
- Azure Arc-enabled data services, such as Azure SQL Managed Instance, running on Azure Arc-enabled Kubernetes or AKS on Azure Stack HCI clusters.

> [!NOTE]
> For production environments, verify that the Azure Arc features you intend to use are generally available.

In Azure Arc-enabled scenarios, Azure Arc uses a locally installed agent to establish a logical connection between the local resource and Azure. Through this connection, the non-Azure resource becomes a hybrid Azure resource, with its own identity represented by an Azure resource ID. Azure serves as the management interface that allows you to create, modify, and delete Azure resources. Once a non-Azure resource is connected through Azure Arc, you can use Azure to manage and monitor its configuration and operations.

## Azure Arc benefits

The following Azure Arc benefits apply across different types of resources connected to Azure:

- The ability to organize all organizational resources by using Azure management groups, subscriptions, resource groups, and tags.
- A single, comprehensive inventory of assets across multiple clouds and on-premises, including support for searching and indexing by using Azure Resource Graph.
- A consolidated view of Azure and Azure Arc-enabled resources via the Azure portal, Azure CLI, Azure PowerShell, or REST APIs.
- Delegation of permissions on the management plane by using Azure role-based access control (Azure RBAC).
- Support for resource context access to Log Analytics data.

  Resource context lets you restrict access to Log Analytics data based on access to the corresponding Azure resource. Because each Azure Arc-enabled server, cluster, or data service exists as an Azure resource, you can control access to its Log Analytics logs by using the RBAC permissions for that resource.
  
- Integration with Azure Monitor.

  You can use Azure Monitor to help monitor and manage your server resources. Azure Monitor is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises environments and other cloud providers.

