

*Azure Arc* is a service that provides a set of technologies for organizations such as Contoso that want to simplify their complex and distributed environments. It provides a centralized, unified, and self-service approach to managing:

- Windows Server
- Linux servers
- Kubernetes clusters
- Azure Data Services

Azure Arc also extends adoption of cloud practices such as DevOps and Azure security across the on-premises, multiple-cloud, and edge environments. In addition to extending the control plane for management, Azure Arc enables companies to run Azure data services anywhere.

Continuous improvements have been made to the Azure fabric controller (the Azure control plane). This control plane is responsible for managing the lifecycle of resources such as VMs, database instances, Apache Hadoop clusters, and Kubernetes clusters.

For example, every time Contoso provisions, scales, stops, or terminates a resource—such as an Azure VM—the Azure fabric controller processes this operation. In between the fabric controller and the resources is another layer called the *Azure Resource Manager* that automates the resource lifecycle. Azure has resource providers for each of these resource types hosted in Azure.

> [!NOTE]  
> Azure Resource Manager provides a management layer that enables you to create, update, and delete your Azure resources.

## Azure Arc capabilities

While Azure Arc has the potential to dramatically alter the management strategy in hybrid scenarios, it's currently limited to two features available to registered systems, as described in the following table.

|Feature|Description|
|------------------------------------------------------ | ------------------------------------------------------------ |
|Azure Policy guest configuration|Azure Policy supports auditing Azure Arc resources to validate such settings as configurations of the operating system (OS), applications, and environment settings. The only exception to this is the ability to configure the time zone on the Windows operating system. When auditing target computers, you have the option of reviewing logs locally or remotely via the **Azure VM Run** command, available from the Azure portal.|
|Support for resource-context–access Log Analytics data|Resource context enables you to restrict the scope of access to Log Analytics data based on the permissions to the corresponding Azure resource. Because Azure Arc presents individual on-premises Windows computers as Azure resources, you can control access to their respective logs by applying RBAC permissions on these resources.|

## Additional reading

You can learn more by reviewing the following documents.

- [What is Azure Resource Manager?](https://aka.ms/azure-resource-manager-management-overview?azure-portal=true)
- [What is Azure Arc for servers (preview)?](https://aka.ms/azure-arc-servers?azure-portal=true)
