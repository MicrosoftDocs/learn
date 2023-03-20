Today, companies struggle to control and govern increasingly complex environments that extend across data centers, multiple clouds, and edge. Each environment and cloud possesses its own set of management tools, and new DevOps and ITOps operational models can be hard to implement across resources.

Azure Arc simplifies governance and management by delivering a consistent multicloud and on-premises management platform.

Azure Arc provides a centralized, unified way to:

-   Manage your entire environment together by projecting your existing non-Azure and/or on-premises resources into Azure Resource Manager.
-   Manage virtual machines, Kubernetes clusters, and databases as if they are running in Azure.
-   Use familiar Azure services and management capabilities, regardless of where they live.
-   Continue using traditional ITOps while introducing DevOps practices to support new cloud native patterns in your environment.
-   Configure custom locations as an abstraction layer on top of Azure Arc-enabled Kubernetes clusters and cluster extensions.

![Azure Arc management control plane diagram](https://learn.microsoft.com/azure/azure-arc/media/overview/azure-arc-control-plane.png)

Currently, Azure Arc allows you to manage the following resource types hosted outside of Azure:

-   [Servers](https://learn.microsoft.com/azure/azure-arc/servers/overview): Manage Windows and Linux physical servers and virtual machines hosted outside of Azure.
-   [Kubernetes clusters](https://learn.microsoft.com/azure/azure-arc/kubernetes/overview): Attach and configure Kubernetes clusters running anywhere, with multiple supported distributions.
-   [Azure data services](https://learn.microsoft.com/azure/azure-arc/data/overview): Run Azure data services on-premises, at the edge, and in public clouds using Kubernetes and the infrastructure of your choice. SQL Managed Instance and PostgreSQL (preview) services are currently available.
-   [SQL Server](https://learn.microsoft.com/sql/sql-server/azure-arc/overview): Extend Azure services to SQL Server instances hosted outside of Azure.
-   Virtual machines (preview): Provision, resize, delete and manage virtual machines based on [VMware vSphere](https://learn.microsoft.com/azure/azure-arc/vmware-vsphere/overview) or [Azure Stack HCI](https://learn.microsoft.com/azure-stack/hci/manage/azure-arc-enabled-virtual-machines) and enable VM self-service through role-based access.
<!--
[](https://learn.microsoft.com/azure/azure-arc/overview#key-features-and-benefits)
-->


## Key features and benefits

Some of the key scenarios that Azure Arc supports are:

-   Implement consistent inventory, management, governance, and security for servers across your environment.
    
-   Configure [Azure VM extensions](https://learn.microsoft.com/azure/azure-arc/servers/manage-vm-extensions) to use Azure management services to monitor, secure, and update your servers.
    
-   Manage and govern Kubernetes clusters at scale.
    
-   Use GitOps to deploy configuration across one or more clusters from Git repositories.
    
-   Zero-touch compliance and configuration for Kubernetes clusters using Azure Policy.
    
-   Run [Azure data services](https://learn.microsoft.com/azure/azure-arc/kubernetes/custom-locations) on any Kubernetes environment as if it runs in Azure (specifically Azure SQL Managed Instance and Azure Database for PostgreSQL server, with benefits such as upgrades, updates, security, and monitoring). Use elastic scale and apply updates without any application downtime, even without continuous connection to Azure.
    
-   Create [custom locations](https://learn.microsoft.com/azure/azure-arc/kubernetes/custom-locations) on top of your [Azure Arc-enabled Kubernetes](https://learn.microsoft.com/azure/azure-arc/kubernetes/overview) clusters, using them as target locations for deploying Azure services instances. Deploy your Azure service cluster extensions for [Azure Arc-enabled data services](https://learn.microsoft.com/azure/azure-arc/data/create-data-controller-direct-azure-portal), [App services on Azure Arc](https://learn.microsoft.com/azure/app-service/overview-arc-integration) (including web, function, and logic apps) and [Event Grid on Kubernetes](https://learn.microsoft.com/azure/event-grid/kubernetes/overview).
    
-   Perform virtual machine lifecycle and management operations for [VMware vSphere](https://learn.microsoft.com/azure/azure-arc/vmware-vsphere/overview) and [Azure Stack HCI](https://learn.microsoft.com/azure-stack/hci/manage/azure-arc-enabled-virtual-machines) environments.
    
-   A unified experience viewing your Azure Arc-enabled resources, whether you are using the Azure portal, the Azure CLI, Azure PowerShell, or Azure REST API.

# Introduction to Azure Arc landing zone accelerator for hybrid and multicloud

Enterprises are currently building and running applications across various ecosystems on-premises, in multiple public clouds, and on the edge. When you're working in these distributed environments, it's critical that you find a way to ensure compliance and manage servers, applications, and data at scale while still maintaining agility.

[Azure landing zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/) provides: A specific architectural approach. Reference architecture. Set of reference implementations that help you prepare your landing zones for mission-critical technology platforms and supported workloads.

[![A conceptual architecture diagram of an Azure landing zone.](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/media/ns-arch-cust-expanded.svg)](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/enterprise-scale/media/ns-arch-cust-expanded.svg#lightbox)

_For more information on the design areas labeled A-I in the visual, see [environment design areas](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/design-areas#environment-design-areas)._

Azure landing zones were designed with hybrid and multicloud in mind. To support hybrid and multicloud, the reference architecture requires two additions:

-   **Hybrid and multicloud connectivity:** Understand key network design considerations and recommendations for working with Azure Arc.
-   **Unified operations:** Include Azure Arc-enabled resources to extend your governance and operations support with consistent tooling.
<!--
[](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/hybrid/enterprise-scale-landing-zone#why-hybrid)
-->

## Why hybrid?

As organizations adopt modern cloud services and the associated benefits, periods of running services parallel alongside the legacy on-premises infrastructure are inevitable. As your organization further evaluates cloud services or as business requirements dictate, your team might choose to run more than one public cloud service. Operating a distributed heterogeneous estate requires simplified, consolidated management and governance to reduce operational impact.

Use landing zone concepts introduced as part of the Cloud Adoption Framework guidance to establish patterns for building hybrid architectures and introducing standards for connectivity, governance, and monitoring. This work helps when your strategic intent is to simplify and combine the infrastructure and services following migration projects. Setting standards for management processes and tools removes the need to retrofit workloads after you move them into Azure.
<!--
[](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/hybrid/enterprise-scale-landing-zone#prerequisites)
-->

## Prerequisites

It's beneficial to have familiarity with the Azure landing zones. For more information, see the Azure landing zones [overview](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/) and Azure landing zones [implementation guidance](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/implementation-options).

[![Diagram that shows Azure Arc high-level architecture.](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/hybrid/media/single-control-plane.png)](https://learn.microsoft.com/azure/cloud-adoption-framework/scenarios/hybrid/media/single-control-plane.png#lightbox)

Azure provides various management tools to help you monitor and govern infrastructure and applications at scale. When implementing a hybrid landing zone, be sure to extend the Azure tools to control infrastructure and applications outside of Azure. This approach creates a single management plane and a single view of your entire hybrid estate, which makes monitoring and management at scale as straightforward as possible.