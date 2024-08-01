Now we'll explore how to protect the SQL Server back end of an application using a combination of SQL Server business continuity and disaster recovery (BCDR) technologies and Azure Site Recovery.

SQL Server can be deployed in many ways:

- **Standalone SQL Server**: SQL Server and all databases are hosted on a single machine (physical or a virtual). When virtualized, host clustering is used for local high availability. Guest-level high availability isn't implemented.
- **SQL Server Failover Clustering Instances (Always On FCI)**: Two or more nodes running SQL Server instanced with shared disks are configured in a Windows Failover cluster. If a node is down, the cluster can fail SQL Server over to another instance. This setup is typically used to implement high availability at a primary site. This deployment doesn't protect against failure or outage in the shared storage layer. A shared disk can be implemented using iSCSI, fiber channel or shared vhdx.
- **SQL Always On Availability Groups**: Two or more nodes are set up in a shared nothing cluster, with SQL Server databases configured in an availability group, with synchronous replication and automatic failover.

This process uses the following native SQL disaster recovery technologies for recovering databases to a remote site:

- **SQL Always On Availability Groups**, to provide for disaster recovery for SQL Server 2012 Enterprise editions or newer (including SQL Server 2017 Standard Edition)
- **SQL database mirroring in high safety mode**, for other SQL Server deployments.

## Supported scenarios

Site Recovery can protect SQL Server as summarized in the table.

| **Scenario** | **To a secondary site** | **To Azure** |
|---|---|---|
| Hyper-V | Yes | Yes |
| VMware | Yes | Yes |
| Physical server | Yes | Yes |
| Azure | NA | Yes |

## Supported SQL Server versions

The following SQL Server versions are supported, for the supported scenarios:

- SQL Server 2017 Enterprise and Standard
- SQL Server 2016 Enterprise and Standard
- SQL Server 2014 Enterprise and Standard
- SQL Server 2012 Enterprise and Standard
- SQL Server 2008 R2 Enterprise and Standard

## Supported SQL Server integration

Site Recovery can be integrated with native SQL Server BCDR technologies summarized in the table, to provide a disaster recovery solution.

| **Feature** | **Feature Details** | **SQL Server** |
|---|---|---|
| Always On availability group | Multiple standalone instances of SQL Server each run in a failover cluster that has multiple nodes. Databases can be grouped into failover groups that can be copied (mirrored) on SQL Server instances so that no shared storage is needed. Provides disaster recovery between a primary site and one or more secondary sites. Two nodes can be set up in a shared nothing cluster with SQL Server databases configured in an availability group with synchronous replication and automatic failover. | SQL Server (all supported versions) |
| Failover clustering (Always On FCI) | SQL Server uses Windows failover clustering for high availability of on-premises SQL Server workloads. Nodes running instances of SQL Server with shared disks are configured in a failover cluster. If an instance is down the cluster fails over to a different one. The cluster doesn't protect against failure or outages in shared storage. The shared disk can be implemented with iSCSI, fiber channel, or shared VHDXs. | SQL Server (all supported versions) |
| Database mirroring (high safety mode) | Protects a single database to a single secondary copy. Available in both high safety (synchronous) and high performance (asynchronous) replication modes. Doesn’t require a failover cluster. | SQL Server (all supported versions) |
| Standalone SQL Server | The SQL Server and database are hosted on a single server (physical or virtual). Host clustering is used for high availability if the server is virtual. No guest-level high availability. | Enterprise or Standard edition |

## Deployment prerequisites

- An on-premises SQL Server deployment, running a supported SQL Server version. Typically, you also need Active Directory for your SQL server.
- The requirements for the scenario you want to deploy.

## Set up Active Directory

Set up Active Directory, in the secondary recovery site, for SQL Server to run properly.

- Small enterprise: With a small number of applications, and a single domain controller for the on-premises site, if you want to fail over the entire site, we recommend you use Site Recovery replication to replicate the domain controller to the secondary datacenter or to Azure.
- Medium to large enterprise: If you have a large number of applications, an Active Directory forest, and you want to fail over by application or workload, we recommend you set up an extra domain controller in the secondary datacenter or in Azure. If you're using Always On availability groups to recover to a remote site, we recommend you set up another extra domain controller on the secondary site or in Azure, to use for the recovered SQL Server instance.

These instructions presume that a domain controller is available in the secondary location.

## Integrate with SQL Server Always On for replication to Azure

Here's what you need to do:

1. Import scripts available at [https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/asr-automation-recovery/scripts/ASR-SQL-FailoverAG.ps1](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/demos/asr-automation-recovery/scripts/ASR-SQL-FailoverAG.ps1) into your Azure Automation account. This repository contains the scripts to fail over SQL Availability Group.
2. Add the ASR-SQL-FailoverAG script as a pre-action of the first group of the recovery plan.
3. Follow the instructions available in the script to create an automation variable to provide the name of the availability groups.

SQL Always On doesn’t natively support test failover. To perform a test failover, use the following procedure:

1. Configure Azure Virtual Machine Backup on the virtual machine that hosts the availability group replica in Azure.
2. Before triggering test failover of the recovery plan, recover the virtual machine from the backup taken in the previous step into the test virtual network.
3. Force a quorum in the virtual machine restored from backup.
4. Update IP of the listener to an IP available in the test failover network.
5. Bring listener online.
6. Create a load balancer with one IP created under the frontend IP pool corresponding to each availability group listener and with the SQL virtual machine added in the backend pool.
7. Perform a test failover of the recovery plan.

Once you have added the script in the recovery plan and validated the recovery plan by performing a test failover, you can perform a planned failover.
