# Hybrid Computing Defined
Hybrid computing connects on-premises systems to one or more public-cloud systems, providing a single application experience along with cohesive provisioning, governance, and management. The advantages of hybrid computing are the ability to leverage current on-premises investments, placing the data close to the compute environment for the best performance, and selecting the proper security posture for applications all while using a unified billing, management, and data collection and reporting for the governance of the entire system.

# Considerations for Effective Hybrid Computing
While hybrid computing offers many benefits, there are various considerations for combining disparate computing environments including provisioning, governance, and management. 

## Provisioning
The first consideration for hybrid computing is to ensure a declarative, stateful method of deployment, ideally with the ability to check the manifest describing the desired state configuration into source-control systems. This allows for a complete DevOps optimization, along with point-in-time configuration snapshots. 

Multi-system configurations also require the ability to work with the provisioning constructs of on-premises and multi-cloud tools and processes. 

## Governance
Governance is the formal process of monitoring and controlling information technology to ensure the delivery of value to stakeholders in an organization. The first factor ineffective governance is ensuring a consistent, updated state of deployment is essential for a hybrid computing environment. Updates should be applied in a tested, automated fashion through standard DevOps practices. 

Another important factor in the governance of a hybrid computing system is ensuring security and compliance throughout the environment, with pro-active monitoring, reporting, and remediation. Regulatory statutes by government and industry require the creation of zones for the storage of data and processing of sensitive data that meet those requirements. Hybrid computing systems should have a consistent, cohesive auditing system to ensure and report compliance with all governance standards and requirements. 

## Management
Management for a hybrid computing environment should be as consistent and comprehensive as possible, using both scripted and exploratory (graphical interface) tools.  These tools should work end-to-end for the system, including all parts of the DevOps cycle. 

Hybrid computing systems may not always be connected. The management and control of the system should allow for both direct (connected) and indirect (periodically connected) aspects, without materially affecting the operation of the tools. 

# Microsoft Azure Arc and Hybrid Computing Systems
Microsoft provides several environments, examples, and mechanisms for working with hybrid computing environments, such as Azure hybrid cloud solutions, Azure hybrid benefit, Azure Defender, Azure VMWare solution, Azure Stack, Azure Sentinel, Azure VPN Gateway, Azure ExpressRoute, and Azure Arc. 

Microsoft Azure Arc uses various services and platforms that meet all of the requirements for a Hybrid computing environment, such as provisioning, governance, and management of the complete infrastructure and deployment surface for Microsoft Windows, Linux, and Kubernetes clusters combining on-premises and multi-cloud services.

## Azure Arc Enabled Servers
Azure Arc enabled servers to expand support to server-based resources that run outside of Azure. A Windows Server or Linux server that Is running in an on-premises data center can be registered with Azure Arc and use many of the resource management capabilities available on Azure. Organizations can also apply this capability to any server that's running Windows Server or Linux that is hosted by another cloud provider.

## Azure Arc Enabled Kubernetes
Using Azure Arc, organizations can connect Kubernetes clusters located anywhere to Azure and then manage the clusters in a consistent way. Azure Arc enabled Kubernetes lets you control the cluster configuration and workloads at scale using your git repositories as the source of truth for the clusters. It also lets organizations use the extensive management capabilities in Azure for common cluster management needs such as inventory, monitoring, policy compliance, security, user access, and more.

## Azure Arc enabled SQL Servers
Azure Arc enabled SQL Servers extends Azure services to SQL Server instances hosted outside of Azure in the customer’s datacenter, on the edge, or in a multi-cloud environment.

## Azure Arc Enabled Data Services
Azure Arc Enabled Data Services makes it possible to run Azure data services such as SQL Server Managed Instance and PostgreSQL Hyperscale on-premises, at the edge, and in Azure and other public clouds using Kubernetes and the infrastructure of your choice. It provides an always-current, elastically-scaled, self-provisioning deployment with a unified command-line and graphical management and monitoring system,  and both direct and indirect connected modes. Azure Arc Enabled Data Services also provides security and compliance monitoring.