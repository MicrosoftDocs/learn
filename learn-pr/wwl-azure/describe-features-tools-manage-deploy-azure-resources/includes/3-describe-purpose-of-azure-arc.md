Managing hybrid and multicloud environments can rapidly get complicated. Azure provides a host of tools to provision, configure, and monitor Azure resources. What about the on-premises resources in a hybrid configuration or the cloud resources in a multicloud configuration?

Azure Arc works with Azure Resource Manager to extend your Azure compliance and monitoring to hybrid and multicloud configurations. Azure Arc simplifies governance and management by delivering a consistent multicloud and on-premises management platform.

:::image type="content" source="../media/azure-arc-unified-management.png" alt-text="Diagram showing Azure Arc extending unified management across Azure, on-premises, and multicloud environments.":::

Azure Arc provides a centralized, unified way to:

 -  Manage your entire environment together by projecting your existing non-Azure resources into Azure Resource Manager.
 -  Manage multicloud and hybrid virtual machines, Kubernetes clusters, and databases as if they are running in Azure.
 -  Use familiar Azure services and management capabilities, regardless of where they live.
 -  Continue using traditional ITOps while introducing DevOps practices to support new cloud and native patterns in your environment.
 -  Configure custom locations as an abstraction layer on top of Azure Arc-enabled Kubernetes clusters and cluster extensions.

## Practical scenario

Imagine your organization runs workloads in Azure, an on-premises datacenter, and another public cloud. With Azure Arc, operations teams can apply consistent governance, policy, and inventory tracking across these environments from Azure, instead of managing each environment with disconnected tools.

## What can Azure Arc do outside of Azure?

Currently, Azure Arc allows you to manage the following resource types hosted outside of Azure:

 -  Servers
 -  Kubernetes clusters
 -  Azure data services
 -  SQL Server
 -  Virtual machines (preview)

