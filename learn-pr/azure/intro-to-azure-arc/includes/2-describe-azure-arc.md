*Azure Arc* is a service that provides a set of technologies that allow organizations such as Contoso to simplify their complex and distributed environments. Azure Arc provides a centralized, unified, and self-service approach to managing:

- Windows Server
- Linux servers
- Kubernetes clusters

You can also use Azure Arc to introduce Azure data services to hybrid environments.

## What is Azure Arc?

Azure Arc enables you to extend Azure management capabilities to hybrid environments, including on-premises datacenters and third-party cloud providers. You can use Azure Arc to manage and configure your Windows and Linux server machines and Kubernetes clusters that are hosted outside of Azure.

:::image type="content" source="../media/2-arc-overview.png" alt-text="An administrator using Azure management tools via Azure Arc to connect and manage resources in multicloud, edge, and on-premises scenarios." border="false":::

By using Azure Arc, you can manage your IT resources wherever they're hosted, using the same Azure management tools and practices you use to manage Azure hosted resources. You can manage resources with tools such as Azure Resource Manager, Azure Cloud Shell, the Azure portal, and Azure Policy regardless of where the managed resources are located.

:::image type="content" source="../media/2-arc-management.png" alt-text="Azure management tools being used to manage both Azure hosted resources, and through Azure Arc, resources located elsewhere." border="false":::

Azure Arc also extends adoption of cloud practices such as DevOps and Azure security across the on-premises, multicloud, and edge environments. In addition to extending the control plane for management, Azure Arc enables organizations to run Azure data services anywhere.

## What can I do with Azure Arc?

Azure Arc has the potential to dramatically alter the management strategy in hybrid scenarios. You can use Azure Arc in the following ways:

- Azure Policy Guest Configuration. Azure Policy supports auditing Azure Arc resources to validate such settings as configurations of the operating system, applications, and environment settings.
- Support for resource context access to Log Analytics data. Resource context enables you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because Azure Arc presents individual hybrid systems as Azure resources, you can control access to their respective logs by applying role-based access control permissions on these resources.
- Integration with Azure Monitor. You can use Azure Monitor to help monitor and manage your server resources. Azure Monitor is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises datacenters and to Microsoft and other cloud providers.
- Inventory of assets. Using Azure Arc, you can tag and query across both hybrid and Azure assets.
- Consolidate views of management services in the Azure portal. Consolidation enables you to review and configure Azure Arc resources using a consistent interface.
