
*Azure Arc* is a service that provides a set of technologies for organizations such as Contoso that want to simplify their complex and distributed environments. Azure Arc provides a centralized, unified, and self-service approach to managing:

- Windows Server
- Linux servers
- Kubernetes clusters

> [!NOTE]
> You can also Azure Arc to introduce Azure data services to on-premises environments.

## What is Azure Arc?

Azure Arc enables you to extend Azure management capabilities to potentially anywhere, including on-premises datacenters, and third-party cloud providers. You can use Azure Arc to manage and configure your Windows and Linux server machines and Kubernetes clusters that are hosted outside of Azure. 

:::image type="content" source="../media/arc-overview.png" alt-text="A graphic that displays an administrator using Azure management tools via Azure Arc to connect and manage resources in multi-cloud, edge, and on-premises scenarios." border="false":::

By using Azure Arc, you can manage your IT resources, wherever they are hosted, by using the same Azure management tools and practices you use to manage Azure hosted resources. This means you can manage resources with tools such as Azure Resource Manager, Microsoft Azure Cloud Shell, the Azure portal, and Azure Policy regardless of where the managed resources are located. 

:::image type="content" source="../media/arc-management.png" alt-text="A graphic that displays Azure management tools being used to manage both Azure hosted resources, and through Azure Arc, resources located elsewhere." border="false":::

Azure Arc also extends adoption of cloud practices such as DevOps and Azure security across the on-premises, multiple-cloud, and edge environments. In addition to extending the control plane for management, Azure Arc enables organizations to run Azure data services anywhere.

Continuous improvements have been made to the Azure fabric controller (the Azure *control plane*). This control plane is responsible for managing the lifecycle of resources such as VMs, database instances, Kubernetes clusters, and Apache Hadoop clusters.

For example, every time Contoso provisions, scales, stops, or terminates a resource, such as an Azure VM, the Azure fabric controller processes this operation. In between the fabric controller and the resources is the *Azure Resource Manager*, which is another layer that automates the resource lifecycle. Azure has resource providers for each of the resource types that Azure hosts.

> [!NOTE]
> Resource Manager provides a management layer that enables you to create, update, and delete Azure resources.

## What can I do with Azure Arc?

Azure Arc has the potential to dramatically alter the management strategy in hybrid scenarios. You can use Azure Arc in the following ways: 

- Azure Policy guest configuration. Azure Policy supports auditing Azure Arc resources to validate such settings as configurations of the operating system, applications, and environment settings. 

> [!NOTE] 
> Currently, you cannot configure the time zone on the Windows operating system using Azure Policy via Azure Arc.

- Support for resource context access Log Analytics data. Resource context enables you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because Azure Arc presents individual on-premises Windows computers as Azure resources, you can control access to their respective logs by applying role-based access control permissions on these resources.
- Integration with Azure monitor. You can use Azure Monitor to help monitor and manage your server resources. *Azure Monitor* is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises datacenters and to Microsoft and other cloud providers.
- Inventory of assets. Using Azure Arc, you can tag and query across both hybrid and Azure assets. 
- Unify the Azure portal. Enables you to review and configure Azure Arc resources using a consistent interface. 



