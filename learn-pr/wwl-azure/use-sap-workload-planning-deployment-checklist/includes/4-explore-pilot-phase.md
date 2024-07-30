The pilot can run in parallel to project planning and preparation. This phase can also be used to test options identified in the planning and preparation phase. As part of the pilot, it's recommended to set up and validate a full HA/DR solution as well as security design. In some cases, it might be also possible to use this phase to perform scalability tests or deploy SAP sandbox systems. To run a pilot, customers should start by identifying a non-critical system that they want to migrate into Azure and continue by carrying out the following tasks:

## 1. Optimize data transfer into Azure

The approach and outcome are highly dependent on a customer’s connectivity to Azure. Depending on the amount of data, it might be possible to use for this purpose ExpressRoute, Site-to-Site VPN, or offline data transfer services such as Azure Data Box or the Azure Import/Export Service.

## 2. SAP heterogeneous platform migration

In case of an SAP heterogeneous platform migration that involves an export and import of the database data, test and optimize export and import phases. For large heterogeneous migrations targeting SQL Server, refer to [SAP OS/DB Migration to SQL Server–FAQ](https://techcommunity.microsoft.com/t5/Running-SAP-Applications-on-the/SAP-OS-DB-Migration-to-SQL-Server-8211-FAQ-v6-2-April-2017/ba-p/368070). You can use Migration Monitor/SWPM in case you don't need to combine the migration with a release upgrade or SAP Database Migration Option (DMO) otherwise. For details, refer to [Database Migration Option (DMO) of SUM – Introduction](https://blogs.sap.com/2013/11/29/database-migration-option-dmo-of-sum-introduction/). In either case, use the following steps:

- Measure time to export from source, upload exported content to Azure, and perform import. Maximize overlap between export and import.
- Use the comparison between the source and target databases to properly size the target infrastructure.
- Validate and optimize timing.

## 3. Perform technical validation

### Virtual machine types

- Reference SAP support notes, SAP HANA hardware directory, and SAP Product Availability Matrix (PAM) to ensure accuracy of the information regarding supported Azure Virtual Machine SKUs, supported OS releases for these Azure Virtual Machine SKUs, and supported SAP and DBMS releases.
- Validate sizing of the infrastructure and the application components that you deploy in Azure. When migrating existing applications, you should be able to obtain the necessary SAPS based on existing telemetry. Retrieve the SAP benchmark and compare it to the SAPS numbers listed in [SAP Note \#1928533](https://me.sap.com/notes/1928533). In addition, reference the information provided in [SAPS ratings on Azure Virtual Machines – where to look and where you can get confused](https://techcommunity.microsoft.com/t5/Running-SAP-Applications-on-the/SAPS-ratings-on-Azure-virtual machines-8211-where-to-look-and-where-you-can/ba-p/368208).
- Evaluate and test the sizing of your Azure Virtual Machines regarding maximum storage throughput and network throughput of the different virtual machine types you chose in the planning phase. This data can be found in [Sizes for virtual machines in Azure](/azure/virtual-machines/sizes). When the Azure Virtual Machine guest operating system is Windows, it's important to consider the max uncached disk throughput for sizing. In the case of Linux, it's also important to consider the max uncached disk throughput for sizing.

### Storage

- Use Azure Standard SSD storage as the minimum for virtual machines representing SAP application layers and for non-performance sensitive DBMS deployment and use Azure Premium Storage for any DBMS virtual machines that are performance sensitive.
- Avoid using Azure Standard HDD disks.
- Use Azure managed disks.
- Enable Azure Write Accelerator for DBMS log drives with M-Series Azure Virtual Machines. Be aware of documented Write Accelerator limits and usage restrictions.
- For DBMS-related storage information, refer to [Considerations for Azure Virtual Machines DBMS deployment for SAP workload](/azure/virtual-machines/workloads/sap/dbms_guide_general) as well as DBMS specific documentation referenced in that document.
- For SAP HANA deployments, refer to [SAP HANA infrastructure configurations and operations on Azure](/azure/virtual-machines/workloads/sap/hana-vm-operations).
- Never mount Azure data disks to an Azure Linux virtual machine by using the device ID. Instead, use the universally unique identifier (UUID). Be careful when you use graphical tools to mount an Azure data disk. Double-check the entries in /etc/fstab to make sure that the disks are mounted using the UUID. For more information, refer to [Connect to the Linux virtual machine to mount the new disk](/azure/virtual-machines/linux/attach-disk-portal).

### Networking

Test and evaluate your virtual network infrastructure and the distribution of your SAP applications across or within the Azure virtual networks.

1. Evaluate the approach of hub and spoke virtual network architecture or micro segmentation within a single Azure virtual network based on the following criteria:

     - Costs due to data exchange between peered Azure virtual networks (for details, refer to [Azure virtual network pricing](https://azure.microsoft.com/pricing/details/virtual-network/).
     - Comparison between the ability to terminate peering between Azure virtual networks and the use of NSGs to isolate subnets within a virtual network in cases where applications or virtual machines hosted in a subnet of the virtual network become a security risk.
     - Central logging and auditing of network traffic between on-premises, the Internet, and the Azure virtual datacenter.
2. Evaluate and test data path between the SAP application layer and SAP DBMS layer. As part of your evaluation, consider the following:

     - Placing Network Virtual Appliances in the communication path between the SAP application and the DBMS layer of an SAP NetWeaver, Hybris, or S/4HANA based SAP systems isn't supported.
     - Placing SAP application layer and SAP DBMS in different Azure virtual networks that aren't peered isn't supported.
     - It's supported to use Azure Application Security Groups (ASGs) and Network Security Groups (NSGs) to control traffic flow between the SAP application layer and SAP DBMS layer.
3. Make sure that Azure Accelerated Networking is enabled on the virtual machines used on the SAP application layer and the SAP DBMS layer. Keep in mind the OS requirements for support of Accelerated Networking in Azure:

     - Windows Server 2012 R2 or newer releases
     - SUSE Linux 12 SP3 or newer releases
     - RHEL 7.4 or newer releases
     - Oracle Linux 7.5. The RHCKL kernel requires the release 3.10.0-862.13.1.el7. The Oracle UEK kernel requires release 5.
4. Test and evaluate the network latency between SAP application layer virtual machine and DBMS virtual machine according to [SAP Note \#500235](https://me.sap.com/notes/500235) and [SAP Note \#1100926](https://me.sap.com/notes/1100926). Evaluate the results against network latency guidance of [SAP Note \#1100926](https://me.sap.com/notes/1100926). The network latency should be within the moderate to good range.
5. Make sure that Azure internal load balancer (ILB) deployments are set up to use Direct Server Return. This setting will reduce latency in cases where ILBs are used for high availability configurations on the DBMS layer.
6. If you're using Azure load balancer in conjunction with Linux guest operating systems check that the Linux network parameter **net.ipv4.tcp\_timestamps** is set to 0. Note that this contradicts the general recommendations of [SAP Note \#2382421](https://me.sap.com/notes/2382421). The SAP Note has been updated to reflect the fact that the parameter needs to be set to 0 to work in conjunction with Azure load balancers.

### High Availability and disaster recovery deployments

- If you deploy the SAP application layer without targeting specific Azure availability zones, make sure that all virtual machines running SAP dialog instance or middleware instances of the same SAP system are deployed in the same Availability Set.

  - In case you don't require high availability for the SAP Central Services and DBMS, these virtual machines can be deployed into the same Availability Set as the SAP application layer.
- If you need to protect the SAP Central Services and the DBMS layer for high availability with passive replicas, deploy the two nodes for SAP Central Services in one Availability Set and the two DBMS nodes in another Availability Set.
- If you deploy into Azure availability zones, you cannot use Availability Sets. Instead, you should make sure that you deploy the active and passive Central Services nodes into two different availability zones, which provide the smallest latency between zones.
- Keep in mind that you need to use Azure Standard load balancer when creating Windows Server or Pacemaker-based Failover Clusters for the DBMS and SAP Central Services layer across availability zones. Basic load balancer doesn't support zonal deployments.

### Timeout settings

- Check SAP NetWeaver developer traces of SAP instances and make sure there are no connection breaks between enqueue server and the SAP work processes. These connection breaks can be avoided by setting these two registry parameters.

  - **HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\KeepAliveTime = 120000**. For details, refer to [KeepAliveTime](/previous-versions/windows/it-pro/windows-2000-server/cc957549%28v=technet.10%29).
  - **HKLM\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\KeepAliveInterval = 120000**. For details, refer to [KeepAliveInterval](/previous-versions/windows/it-pro/windows-2000-server/cc957548%28v=technet.10%29).
- To avoid GUI timeouts between on-premises SAP GUI interfaces and SAP application layers deployed in Azure, set the following parameters in the default.pfl or the instance profile:

  - **rdisp/keepalive\_timeout** = 3600
  - **rdisp/keepalive** = 20
- If you use a Windows Failover Clustering, make sure that the parameters determining failover triggered by non-responsive nodes are set correctly. The Microsoft TechCommunity article [Tuning Failover Cluster Network Thresholds](https://techcommunity.microsoft.com/t5/Failover-Clustering/Tuning-Failover-Cluster-Network-Thresholds/ba-p/371834) lists parameters and their impact on failover behavior. For example, assuming the cluster nodes are in the same subnet, make sure to configure failover parameters in the following manner:

  - **SameSubNetDelay** = 2000
  - **SameSubNetThreshold** = 15
  - **RoutingHistorylength** = 30
  - Test high availability and disaster recovery procedures:

    - Simulate failover by shutting down Azure Virtual Machines (Windows guest OS) or putting operating systems in panic mode (Linux guest OS).
    - Measure the times it takes to complete failovers. If the times are too long, consider:

      - For SUSE Linux, use SBD devices instead of the Azure Fencing Agent to speed up failover.
      - For SAP HANA, if the reload of data takes too long consider improving storage performance.
    - Test backup/restore sequence and timing and tune if necessary. Make sure that not only backup times are enough. Also, test restore and take the timing on restore activities. make sure that the restore times are within your RTO SLAs where your RTO relies on a database or virtual machine restore process.
    - Test DR functionality and architecture.

## 4. Perform security checks

- Test the validity of the Azure role-based access (RBAC) approach you implemented. The goal is to separate and limit access and permissions delegated to different teams. As an example, SAP Basis team members should be able to deploy Azure Virtual Machines into a given Azure virtual network and assign disks to these Azure Virtual Machines. However, the SAP Basis team shouldn't be able to create new virtual networks or change the settings of existing virtual networks. Conversely, members of the network team shouldn't be able to deploy Azure Virtual Machines into virtual networks where SAP application and DBMS virtual machines are running. Nor should members of the network team be able to change attributes of virtual machines or delete virtual machines and their disks.
- Verify that NSG rules are working as expected and shield the protected resources.
- Verify encryption at rest and in transit. Define and implement processes to back up, store, and access certificates as well as validate the restore process of encrypted entities.
- Use Azure Disk Encryption for OS disks.
- Consider a pragmatic approach when deciding whether to implement an encryption mechanism. For example, evaluate whether it's necessary to apply both Azure Disk encryption and the DBMS Transparent Database Encryption.

## 5. Test performance

In migration scenarios, use SAP tracing and measurements to compare the pilot with the current implementation based on:

- Top 10 online reports
- Top 10 batch jobs
- Data transfers through interfaces into the SAP system, focusing on cross-premises traffic
