# Hybrid Computing Defined
Hybrid computing connects on-premises systems to one or more public-cloud systems. It provides a single application experience along with simple deployment, governance, and management. Hybrid computing gives you the ability to use current on-premises investments. It places data close to the compute environment for the best performance. With hybrid computing you get uniform security, a unified billing, management, data collection, and reporting system.
# Considerations for Effective Hybrid Computing
While hybrid computing offers many benefits, there are considerations for combining multiple computing environments. 
## Deployment
You should use a declarative, stateful method of deployment for hybrid computing.  You also need the ability to check the manifest describing the desired state configuration into source-control systems. This declarative state allows for optimized DevOps, along with point-in-time configuration snapshots. 
Multi-system configurations in hybrid computing require the ability to work with the tools and processes in on-premises and multi-cloud environments. 
## Governance
Governance is the formal process of monitoring and controlling information technology to ensure the delivery of value to stakeholders in an organization. The first factor in effective governance of a hybrid system is ensuring a consistent, updated state of deployment. Updates should be applied in a tested, automated fashion through standard DevOps practices. 
Another important factor in the governance of a hybrid computing system is ensuring security and compliance. You need pro-active monitoring, reporting, and a system for correcting issues. There are also regulatory statutes required by government and industry. This means you need to create "zones" for the storage processing of sensitive data so that you can meet those requirements. Hybrid computing systems should have a consistent and cohesive auditing system to ensure compliance with all standards and requirements. 
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
Microsoft Azure Arc meets the requirements for a Hybrid computing environment. It provides tools for deployment, monitoring and management of your infrastructure. It also gives you deployment options for Microsoft Windows, Linux, and Kubernetes clusters. This allows you to combine on-premises and multi-cloud services.
## Azure Arc Enabled Servers
Azure Arc enabled servers to expand support to server-based resources that run outside of Azure. A Windows Server or Linux server that is running in an on-premises data center can be registered with Azure Arc, which can then use many of the resource management capabilities available on Azure. Organizations can also use any server that's running Windows Server or Linux that is hosted by another cloud provider for the deployment.
## Azure Arc Enabled Kubernetes
Using Azure Arc, organizations can connect Kubernetes clusters located anywhere to Azure. You can manage clusters in a consistent way. Azure Arc enabled Kubernetes lets you control the cluster configuration and workloads at scale, using git repositories for the clusters. It also lets organizations use the extensive management capabilities in Azure for common cluster management needs such as inventory, monitoring, policy compliance, security, user access, and more.
## Azure Arc enabled SQL Servers
Azure Arc enabled SQL Servers extends Azure services to SQL Server instances hosted outside of Azure in the customer’s datacenter, on the edge, or in a multi-cloud environment.
## Azure Arc Enabled Data Services
Azure Arc Enabled Data Services makes it possible to run Azure data services such as SQL Server-Managed Instance and PostgreSQL Hyperscale. You can run these systems on-premises, at the edge, in Azure and in other public clouds. 
Using Kubernetes allows you to use the infrastructure of your choice. You get an always-current, elastically scaled, self-provisioning deployment. You also get a unified command-line and graphical management and monitoring system. Azure Arc Enabled Data Services has both direct and indirect connected modes. 
Azure Arc Enabled Data Services also provides deep security and compliance monitoring.
