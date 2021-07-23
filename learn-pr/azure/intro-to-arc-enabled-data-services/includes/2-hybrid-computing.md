# Hybrid Computing Defined
Hybrid computing connects on-premises systems to one or more public-cloud systems. It provides a single application experience along with simple deploymnet, governance, and management. Hybrid computing gives you the ability to use current on-premises investments. It places data close to the compute environment for the best performance. With hybrid computing you get uniform security, a unified billing, management, data collection, and reporting system for the entire system.

# Considerations for Effective Hybrid Computing
While hybrid computing offers many benefits, there are various considerations for combining computing environments including deployment, governance, and management. 

## Provisioning
The first consideration for hybrid computing is to ensure a declarative, stateful method of deployment, ideally with the ability to check the manifest describing the desired state configuration into source-control systems. This declarative state allows for a complete DevOps optimization, along with point-in-time configuration snapshots. 

Multi-system configurations also require the ability to work with the provisioning constructs of on-premises and multi-cloud tools and processes. 

## Governance
Governance is the formal process of monitoring and controlling information technology to ensure the delivery of value to stakeholders in an organization. The first factor ineffective governance is ensuring a consistent, updated state of deployment is essential for a hybrid computing environment. Updates should be applied in a tested, automated fashion through standard DevOps practices. 

Another important factor in the governance of a hybrid computing system is ensuring security and compliance throughout the environment. You also want to ensure pro-active monitoring, reporting, and remediation of any issues. There are also regulatory statutes required by government and industry, which means you need to create "zones" for the storage processing of sensitive data that meet those requirements. Hybrid computing systems should have a consistent, cohesive auditing system to ensure and report compliance with all standards and requirements. 

## Management
Management for a hybrid computing environment should be as consistent and comprehensive as possible, using both scripted and exploratory (graphical interface) tools.  These tools should work end-to-end for the system, including all parts of the DevOps cycle. 

Hybrid computing systems may not always be connected. The management and control of the system should allow for both direct (connected) and indirect (periodically connected) aspects, without materially affecting the operation of the tools. 

# Microsoft Azure Arc and Hybrid Computing Systems
Microsoft provides several environments for working with hybrid computing environments, such as:

 - Azure hybrid cloud solutions
 - Azure hybrid benefit
 - Azure Defender
 - Azure VMware solution
 - Azure Stack
 - Azure Sentinel
 - Azure VPN Gateway
 - Azure ExpressRoute
 - Azure Arc

Microsoft Azure Arc uses various services and platforms that meet all of the requirements for a Hybrid computing environment. It provides deployment, governance, and management of the complete infrastructure. It also give you deployment options for Microsoft Windows, Linux, and Kubernetes clusters. This allows you to combine on-premises and multi-cloud services.

## Azure Arc Enabled Servers
Azure Arc enabled servers to expand support to server-based resources that run outside of Azure. A Windows Server or Linux server that Is running in an on-premises data center can be registered with Azure Arc. It uses many of the resource management capabilities available on Azure. Organizations can also use any server that's running Windows Server or Linux that is hosted by another cloud provider for the deployment.

## Azure Arc Enabled Kubernetes
Using Azure Arc, organizations can connect Kubernetes clusters located anywhere to Azure. You can manage clusters in a consistent way. Azure Arc enabled Kubernetes lets you control the cluster configuration and workloads at scale, using git repositories for the clusters. It also lets organizations use the extensive management capabilities in Azure for common cluster management needs such as inventory, monitoring, policy compliance, security, user access, and more.

## Azure Arc enabled SQL Servers
Azure Arc enabled SQL Servers extends Azure services to SQL Server instances hosted outside of Azure in the customer’s datacenter, on the edge, or in a multi-cloud environment.

## Azure Arc Enabled Data Services
Azure Arc Enabled Data Services makes it possible to run Azure data services such as SQL Server-Managed Instance and PostgreSQL Hyperscale on-premises, at the edge, and in Azure and other public clouds. Using Kubernetes allows you to use the infrastructure of your choice. You get always-current, elastically scaled, self-provisioning deployment. You also get a unified command-line and graphical management and monitoring system,  and both direct and indirect connected modes. Azure Arc Enabled Data Services also provides deep security and compliance monitoring.