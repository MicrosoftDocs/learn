Hybrid computing connects on-premises systems to one or more public-cloud systems. It provides a single application experience along with simple deployment, governance, and management. Hybrid computing gives you the ability to use current on-premises investments. This environment places data close to compute systems for the best performance. With hybrid computing, you get uniform security, a unified billing, management, data collection, and reporting system.

## Considerations for effective hybrid computing

While hybrid computing offers many benefits, there are considerations for combining multiple computing environments. 

### Deployment

Hybrid computing works best with a declarative, stateful method of deployment. A manifest describing the required state of your hybrid environment allows you to check the state of the system into source-control. This architecture gives you an optimized DevOps cycle, along with point-in-time configuration snapshots.

### Governance

Governance is the process of monitoring and controlling information technology to ensure the delivery of value to stakeholders in an organization. The first step in governance of a hybrid system is ensuring a consistent, updated state of deployment. Updates are applied in a tested, automated fashion through standard DevOps practices. Another important factor in the governance of a hybrid computing system is ensuring security and compliance. Hybrid computing systems need pro-active monitoring, reporting, and a process for correcting issues. There are also regulatory statutes required by government and industry. This level of security and compliance requires "zones" for the storage processing of sensitive data. Hybrid computing systems also need a consistent and cohesive auditing mechanism to ensure compliance.

### Management

Management for a hybrid computing environment needs to be as consistent and comprehensive as possible, using both scripted and exploratory (graphical interface) tools. These tools must work on all components in the system and completely cover the DevOps cycle. Hybrid computing systems may not always be connected. The management and control of the system must allow for both direct (connected) and indirect (periodically connected) aspects, without materially affecting the operation of the tools.

## Microsoft Azure Arc and hybrid computing systems

Microsoft provides several environments for working with hybrid computing environments, such as:

- [Azure hybrid cloud solutions](https://azure.microsoft.com/solutions/hybrid-cloud-app/#overview)
- [Azure hybrid benefit](/azure/azure-sql/azure-hybrid-benefit?tabs=azure-powershell)
- [Microsoft Defender for Cloud](/azure/security-center/azure-defender)
- [Azure VMware solution](https://azure.microsoft.com/services/azure-vmware/#product-overview)
- [Azure Stack](https://azure.microsoft.com/overview/azure-stack/)
- [Microsoft Sentinel](/azure/sentinel/overview)
- [Azure VPN Gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways)
- [Azure ExpressRoute](https://azure.microsoft.com/services/expressroute/#overview)
- [Azure Arc](https://azure.microsoft.com/services/azure-arc/#product-overview)

Microsoft Azure Arc meets the requirements for a hybrid computing environment. It provides tools for deployment, monitoring, and management of your infrastructure. Microsoft Azure Arc also gives you deployment options for Microsoft Windows, Linux, and Kubernetes clusters. Microsoft Azure Arc allows you to combine on-premises and multicloud services.

### Azure Arc-enabled servers

Azure Arc-enabled servers expand support to server-based resources that run outside of Azure. You can register a Windows or Linux server running in an on-premises data center with Azure Arc and use many of the resource management capabilities available on Azure. You can use a Windows or Linux server hosted by another cloud provider for your deployment.

### Azure Arc-enabled Kubernetes

Organizations using Azure Arc can connect Kubernetes clusters located anywhere to Azure. You can manage clusters in a consistent way. Azure Arc enabled Kubernetes lets you control the cluster configuration and workloads at scale, using git repositories for the clusters. It also lets organizations use management capabilities in Azure for cluster management needs such as inventory, monitoring, policy compliance, security, user access, and more.

### SQL Server on Azure Arc-enabled servers

SQL Server on Azure Arc-enabled servers extends Azure services to existing SQL Server instances hosted outside of Azure in the customer’s datacenter, on the edge, or in a multicloud environment.

### Azure Arc-enabled data services

Azure Arc-enabled data services make it possible to run Azure data services such as Azure Arc-enabled SQL Managed Instance. You can run these systems on-premises, at the edge, in Azure and in other public clouds. Using Kubernetes allows you to use the infrastructure of your choice. You get an always-current, elastically scaled, self-provisioning deployment. You also get a unified command-line and graphical management and monitoring system. Azure Arc-enabled data services have both direct and indirect connected modes. Azure Arc-enabled data services also provide deep security and compliance monitoring.
