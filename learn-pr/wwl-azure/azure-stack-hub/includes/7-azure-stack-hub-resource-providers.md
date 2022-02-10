Resource providers are web services that form the foundation for all Azure Stack Hub IaaS and PaaS services. Azure Resource Manager relies on different resource providers to provide access to services. Each resource provider helps you configure and control its respective resources. Service admins can also add new custom resource providers.

### Foundational resource providers

There are three foundational IaaS resource providers:

 -  **Compute**: The Compute Resource Provider lets Azure Stack Hub tenants to create their own virtual machines. The Compute Resource Provider includes the ability to create virtual machines and virtual machine extensions. The virtual machine extension service helps provide IaaS capabilities for Windows and Linux virtual machines. As an example, you can use the Compute Resource Provider to provision a Linux virtual machine and run Bash scripts during deployment to configure the virtual machine.
 -  **Network Resource Provider**: The Network Resource Provider delivers a series of Software Defined Networking (SDN) and Network Function Virtualization (NFV) features for the private cloud. You can use the Network Resource Provider to create resources like software load balancers, public IPs, network security groups, and virtual networks.
 -  **Storage Resource Provider**: The Storage Resource Provider delivers four Azure-consistent storage services: blob, queue, table, and Key Vault account management-providing management and auditing of secrets, such as passwords and certificates. The storage resource provider also offers a storage cloud administration service to facilitate service provider administration of Azure-consistent storage services. Azure Storage provides the flexibility to store and retrieve large amounts of unstructured data, like documents and media files with Azure Blobs, and structured NoSQL based data with Azure Tables.

### Optional resource providers

There are three optional PaaS resource providers that you can deploy and use with Azure Stack Hub:

 -  **App Service**: Azure App Service on Azure Stack Hub is a PaaS offering of Microsoft Azure available to Azure Stack Hub. The service enables your internal or external customers to create web, API, and Azure Functions apps for any platform or device.
 -  **SQL Server**: Use the SQL Server resource provider to offer SQL databases as a service of Azure Stack Hub. After you install the resource provider and connect it to one or more SQL Server instances, you and your users can create databases for cloud-native apps, websites that use SQL, and other workloads that use SQL.
 -  **MySQL Server**: Use the MySQL Server resource provider to expose MySQL databases as an Azure Stack Hub service. The MySQL resource provider runs as a service on a Windows Server 2019 Server Core virtual machine.
