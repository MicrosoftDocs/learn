After you've set up Azure Site Recovery, you can use protection at the lower application-level with application-aware replication. Application-level protection is an addition to restoring at the machine level.

After confirming the companies BCDR plan with key stakeholders, you now wish to investigate the workloads that Azure Site Recovery supports to ensure it fits with your organizations BCDR goals.

In this unit, you'll explore the application-level protection you can take advantage of to protect your companies different workloads.

## Azure Site Recovery supported workloads

Site Recovery can replicate any app running on a supported machine:

- **Azure VM**: Replication is available for any workload running on a supported Azure virtual machine
- **Hyper-V VM**:  Protection is available for any workload running on a Hyper-V virtual machine
- **Physical servers**: Protection is available for Windows and Linux operating systems
- **VMware VM**: Protection is available for any workload running in a VMware virtual machine

Site Recovery provides application-aware replication for many types of workloads or applications that run on top of the server operating system. Application replication is supported for many different workloads. Taking advantage of the integration with specific workloads has many benefits during normal replication, and also during failover. Some of the features offered include:

- **Near synchronous replication**: Data is written to the primary storage and the replica, almost, simultaneously to allow for low recovery times
- **App-consistent snapshots**: Snapshots taken for recovery purposes can view information in memory, and pending I/O operations, which allow for quick recovery times as the application is ready to go upon switching to the replica VM
- **Integration with SQL AlwaysOn**: AlwaysOn is an enterprise-level alternative to normal database mirroring techniques
- **Flexible recovery plans**: The ability to recover an entire application stack with a single click, both manual and scripted actions can be incorporated into the overall plan
  - **Network Management**: The automated ability to simplify the reservation of IP addresses, configure load balancers and integration with Azure Traffic Manager
  - **Automation library**: Production ready scripts that can be downloaded and integrated with the recovery plan to provide a fully automated recovery if needed

### Active Directory & DNS

Active Directory and DNS can be configured for an automated failover, they would normally be completed first in the scope of the overall recovery plan so that the Active Directory and DNS name resolution is available for when the other applications are failed over. You can have Active Directory up and running in a few minutes. Site Recovery protects the virtual machine that hosts your domain controller and DNS.

### SQL Server

Site Recovery can be used alongside SQL specific high availability technologies such as Always On availability groups. Standalone servers or clusters are supported for replication to Azure or a secondary site. Azure Site Recovery can also scale peak loads by 'bursting' them onto larger VMs in Azure. Test failovers and compliance checks can be run on demand, or scheduled, without impacting the live environment.

### SharePoint

![Diagram showing the complexity of a high-demand SharePoint farm architecture, including web servers, app servers, and database servers](../media/3-sharepointarch.svg)

Protecting SharePoint with Site Recovery allows for the all the servers that makes up the solution to be failed over at the same time. In the above example, a high-demand server farm can include Web, App, and Database server groups. The constant replication to Azure allows any updates deployed to the live environment to be automatically deployed to the replica to allow for patch consistency during a failover.

### Dynamics AX

Protecting Dynamics AX involves a similar approach as that you'd take for protecting SharePoint, because Dynamics consists of Web, App, and Databases tiers. The replica environment could also be used for test and development purposes.

### Remote Desktop Services (RDS)

Managed or unmanaged pooled virtual desktops, remote applications, and sessions can be replicated to a secondary site or Azure.

### Exchange

Small deployments of Exchange, those with a single server, can just be replicated. For larger deployments, Site Recovery integrates with Exchange DAGS (Database Availability Groups) which is a high availability feature of Exchange 2010 and can feature up to mailbox servers, and automates recovery at the database level.

### SAP

SAP NetWeaver and non-NetWeaver production application components can be replicated, the replicated environment can be used as a test bed for project upgrades and testing.

### IIS

Protecting IIS allows for full automation of the recovery plan should you need to fail over to the replicated environment. Protection for IIS servers can be easily enabled and IP addressing can be properly configured by mapping the primary and recovery networks prior to fail over. Scripts can be used during failover to update application dependencies and bindings. This enables a one-click failover for multiple web applications on the web servers, thus eliminating the scope for confusion in the event of a disaster.

### Citrix XenApp & XenDesktop

Full protection is available for Citrix using Site Recovery.  You can protect all aspects of your Citrix solution, AD, DNS, SQL, and Citrix-specific servers such as the StoreFront server. They can all be part of the same recovery plan and once replication is in the place, the replicated environment can be used as a test platform.
