Azure Arc enables you to extend Azure management capabilities to hybrid environments, including on-premises datacenters and third-party cloud providers. You can use Azure Arc to manage and configure your Windows and Linux server machines and Kubernetes clusters that are hosted outside of Azure. You can also use Azure Arc to introduce Azure data services to hybrid environments. These capabilities allow organizations such as Contoso to simplify their complex and distributed environments.

:::image type="content" source="../media/2-azure-arc-control-plane.png" alt-text="Diagram of the Azure Arc management control plane.":::

By using Azure Arc, you can manage your distributed IT resources, using the same Azure management tools and practices you use to manage resources hosted in Azure. You can use tools like Azure Resource Manager, Azure Cloud Shell, the Azure portal, and Azure Policy regardless of where the resources are located.

:::image type="content" source="../media/2-arc-management.png" alt-text="Diagram showing Azure management tools being used to manage both Azure hosted resources, and through Azure Arc, resources located elsewhere." border="false" lightbox="../media/2-arc-management.png":::

Azure Arc also extends adoption of cloud practices such as DevOps and Azure security across the on-premises, multicloud, and edge environments. In addition to extending the control plane for management, Azure Arc enables organizations to run Azure data services anywhere.

## What can I do with Azure Arc?

Azure Arc supports a range of hybrid scenarios. You can use Azure Arc in the following ways:

- Inventory of assets. Using Azure Arc, you can tag and query across both hybrid and Azure assets.
- Consolidate views of management services in the Azure portal. Consolidation enables you to review and configure Azure Arc resources using a consistent interface.
- Use Azure Monitor to help monitor and manage your server resources. Azure Monitor is a core component of the Microsoft strategy to extend comprehensive, cloud-based monitoring functionality beyond Azure to on-premises datacenters and to Microsoft and other cloud providers.
- Use Azure Policy to audit Azure Arc resources, validating configurations of the operating system, applications, and environment settings.

Now we'll take a look at some of the specific ways you can work with Azure Arc.
