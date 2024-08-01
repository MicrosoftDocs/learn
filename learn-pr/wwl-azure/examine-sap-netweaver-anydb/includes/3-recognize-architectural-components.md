The architecture consists of the following infrastructure and key software components:

## Virtual network

The Azure Virtual Network service securely connects Azure resources to each other. The virtual network also connects to an on-premises environment via virtual gateway provisioned as part of ExpressRoute or Site-to-Site connection. In a typical VDC design, this virtual gateway resides in the virtual network that serves as the hub of a hub-spoke hierarchy consisting of multiple, peered virtual networks. The spokes represent individual virtual networks hosting the SAP applications and database tiers.

## Subnets

Each virtual network is typically divided into separate subnets hosting application (SAP NetWeaver) and database tiers. There might be also extra subnets hosting infrastructure services (such as Active Directory domain controllers) and serving the role of network perimeter (containing jumpbox Azure Virtual Machines) – although these commonly reside in the hub virtual network.

## Virtual machines

Azure Virtual Machines host the application tier and database tier components, grouped as follows:

- **SAP NetWeaver**. The application tier runs SAP Central Services and SAP application servers.
- **AnyDB**. The database tier runs AnyDB as the source database, such as Microsoft SQL Server, Oracle, or IBM DB2.
- **Jumpbox**. Also called a *bastion host*. This Azure Virtual Machine runs a hardened operating system instance that administrators use to connect to the other virtual machines. It can run Windows or Linux. Use a Windows jumpbox to run tools such as HANA Cockpit or HANA Studio.
- **Active Directory domain controllers**. Active Directory domain controllers provide authentication and authorization services for Windows and Linux operating system.

## Load balancers

Azure load balancer instances are used to distribute traffic to Azure Virtual Machines in the application and database tiers.

## Availability sets

In highly available configurations, Azure Virtual Machines serving the same role can be grouped into distinct availability sets, with at least two virtual machines per availability set. Alternatively, in multi-zone deployments, individual virtual machines serving the same role can be deployed into distinct availability zones.

## Network interface cards (NICs)

Network interface cards attach virtual machines to a virtual network.

## Network security groups (NSGs)

NSGs restrict incoming, outgoing, and intra-subnet traffic in a virtual network.

## Virtual gateway

A virtual gateway facilitates extending your on-premises network to the Azure virtual network. ExpressRoute is the recommended service for cross-premises connectivity of SAP deployments in Azure, but a Site-to-Site VPN or Virtual WAN can serve as alternatives.

## Disks

Azure Virtual Machine disks provide persistent storage for SAP workloads.

## Azure Storage

Azure Storage provides a range of storage services. It's also used by Cloud Witness to implement quorum for Windows Server Failover Clustering.

## SAP Web Dispatcher pool

The Web Dispatcher component is used as a load balancer for SAP traffic among the SAP application servers. To achieve high availability for the Web Dispatcher component, Azure load balancer is used to implement the parallel Web Dispatcher setup. The available Web Dispatchers in the load balanced backend pool are accessed in a round-robin configuration for HTTP(S) traffic distribution from the load balancer.

For traffic from SAP GUI clients via DIAG protocol or Remote Function Calls (RFC), the Central Services message server balances the load through SAP application server logon groups, so no other load balancer is needed.

## SAP Central Services cluster

The Central Services is a potential single point of failure (SPOF) when deployed to a single virtual machine — a typical deployment when high availability isn't a requirement. To implement a high availability solution, deploy multiple Central Services instances and configure them as members of a failover cluster with a shared disk or a file share providing highly available storage accessible by all cluster nodes.

Azure doesn't support natively shared disks, but you can use third-party solutions (such as SIOS DataKeeper Cluster Edition, which replicates synchronously independent disks owned by individual cluster nodes) to implement this functionality on Azure Virtual Machines running Linux or Windows Server.

SAP has recently modified the Central Services deployment process to allow the use of **/sapmnt** global directories via a UNC path. This change removes the requirement for SIOS or other shared disk solutions on the Central Services virtual machines. It's still recommended to ensure that the **/sapmnt** UNC share is highly available. This can be done on the Central Services instance by using Windows Server Failover Cluster with Scale Out File Server (SOFS) and the Storage Spaces Direct (S2D) feature in Windows Server 2016. For Linux accessible shares, you can use highly available NFS deployment of Azure Virtual Machines.

When using Windows Server Failover Clustering, Cloud Witness is the recommended quorum model.

## Database servers

The database tier is another potential single point of failure (SPOF) when deployed to a single virtual machine — a typical deployment when high availability isn't a requirement. High availability and disaster recovery for database servers might be achieved using built-in SAP load balancers, Azure load balancer, or other mechanisms, depending on the DBMS.

## Application servers pool

To provide high availability of application servers, deploy the primary application server and one or more other application servers. To manage logon groups for ABAP application servers, the SMLG transaction is used. It uses the load balancing function within the message server of the Central Services to distribute workload among SAP application servers pool for SAPGUIs and RFC traffic. The application server connection to the highly available Central Services is through the cluster virtual network name.
