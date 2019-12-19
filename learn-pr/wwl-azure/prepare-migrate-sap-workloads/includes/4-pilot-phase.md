The pilot can run in parallel to project planning and preparation. This phase can also be used to test options identified in the planning and preparation phase. As part of the pilot, it is recommended to set up and validate a full HA/DR solution as well as security design. In some cases, it might be also possible to use this phase to perform scalability tests or deploy SAP sandbox systems. To run a pilot, customers should start by identifying a non-critical system that they want to migrate into Azure and continue by carrying out the following tasks:

**1. Optimize data transfer into Azure.** The approach and outcome are highly dependent on customer’s connectivity to Azure. Depending on the amount of data, it might be possible to use for this purpose ExpressRoute, Site-to-Site VPN, or offline data transfer services such as Azure Data Box or the Azure Import/Export Service. 

**2. In case of an SAP heterogeneous platform migration that involves an export and import of the database data, test and optimize export and import phases.**  You can use Migration Monitor/SWPM in case you do not need to combine the migration with a release upgrade or SAP Database Migration Option (DMO) otherwise.  In either case, use the following steps: 

* Measure time to export from source, upload exported content to Azure and perform import. Maximize overlap between export and import. 

* Use the comparison between the source and target databases to properly size the target infrastructure. 

* Validate and optimize timing

**3. Perform technical validation** 

**VM Types**

* Reference SAP support notes, SAP HANA hardware directory, and SAP Product Availability Matrix (PAM) to ensure accuracy of the information regarding supported Azure VM SKUs, supported OS releases for these Azure VM SKUs, and supported SAP and DBMS releases.

* Validate sizing of the infrastructure and the application components that you deploy in Azure. When migrating existing applications, you should be able to obtain the necessary SAPS based on existing telemetry. Retrieve the SAP benchmark and compare it to the SAPS numbers listed in SAP support note #1928533. 

* Evaluate and test the sizing of your Azure VMs regarding maximum storage throughput and network throughput of the different VM types you chose in the planning phase. 

**Storage**

* Use Azure Standard SSD storage as minimum for VMs representing SAP application layers and for non-performance sensitive DBMS deployment and use Azure Premium Storage for any DBMS VMs that are performance sensitive.

* Avoid using Azure Standard HDD disks.

* Use Azure managed disk

* Enable Azure Write Accelerator for DBMS log drives with M-Series Azure VMs. Be aware of documented Write accelerator limits and usage restrictions (as described in the previous module)

* For DBMS-related storage information, refer to Microsoft doc Considerations for Azure Virtual Machines DBMS deployment for SAP workload at [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/dbms_guide_general](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/dbms_guide_general).

* For SAP HANA deployments, refer to the Microsoft doc SAP HANA infrastructure configurations and operations on Azure at [https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-vm-operations](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-vm-operations).

* Never mount Azure data disks to an Azure Linux VM by using the device ID. Instead, use the universally unique identifier (UUID). Be careful when you use graphical tools to mount Azure data disk. Double-check the entries in /etc/fstab to make sure that the disks are mounted using the UUID. 

**Networking**

Test and evaluate your virtual network infrastructure and the distribution of your SAP applications across or within the Azure virtual networks 

1. Evaluate the approach of hub and spoke virtual network architecture or micro segmentation within a single Azure virtual network based on the following criteria:

    * Costs due to data exchange between peered Azure VNets. 

    * Comparison between the ability to terminate peering between Azure virtual networks and the use of NSGs to isolate subnets within a virtual network in cases where applications or VMs hosted in a subnet of the virtual network become a security risk

    * Central logging and auditing of network traffic between on-premises, the Internet, and the Azure virtual datacenter

2. Evaluate and test data path between SAP application layer and SAP DBMS layer. As part of your evaluation, consider the following:

    * Placing Network Virtual Appliances in the communication path between the SAP application and the DBMS layer of an SAP NetWeaver, Hybris, or S/4HANA based SAP systems is not supported

    * Placing SAP application layer and SAP DBMS in different Azure virtual networks that are not peered is not supported.

    * It is supported to use Azure Application Security Groups (ASG) and Network Security Groups (NSG) to control traffic flow between the SAP application layer and SAP DBMS layer

3. Make sure that Azure Accelerated Networking is enabled on the VMs used on the SAP application layer and the SAP DBMS layer. Keep in mind the OS requirements for support of Accelerated Networking in Azure: 

    * Windows Server 2012 R2 or newer releases

    * SUSE Linux 12 SP3 or newer releases

    * RHEL 7.4 or newer releases

    * Oracle Linux 7.5. The RHCKL kernel requires the release 3.10.0-862.13.1.el7. The Oracle UEK kernel requires release 5.

4. Test and evaluate the network latency between SAP application layer VM and DBMS VM according to SAP Note #500235 (Network Diagnosis with NIPING) and SAP Note #1100926 (FAQ: Network performance). Evaluate the results against network latency guidance of SAP support note #1100926. The network latency should be within the moderate to good range. Exceptions apply to traffic between VMs and HANA Large Instance units.

5. Make sure that Azure internal load balancer (ILB) deployments are set up to use Direct Server Return. This setting will reduce latency in cases where ILBs are used for high availability configurations on the DBMS layer

6. If you are using Azure Load Balancer in conjunction with Linux guest operating systems check that the Linux network parameter net.ipv4.tcp_timestamps is set to 0. 

**High Availability and disaster recovery deployments**

* If you deploy the SAP application layer without targeting specific Azure Availability Zones, make sure that all VMs running SAP dialog instance or middleware instances of the same SAP system are deployed in the same Availability Set. 

    * In case you do not require high availability for the SAP Central Services and DBMS, these VMs can be deployed into the same Availability Set as the SAP application layer.

* If you need to protect the SAP Central Services and the DBMS layer for high availability with passive replicas, deploy the two nodes for SAP Central Services in one Availability Set and the two DBMS node in another Availability Set.

* If you deploy into Azure Availability Zones, you cannot leverage Availability Sets. Instead you should make sure that you deploy the active and passive Central Services nodes into two different Availability Zones, which provide the smallest latency between zones. 

* Keep in mind that you need to use Azure Standard Load Balancer when creating Windows Server or Pacemaker-based Failover Clusters for the DBMS and SAP Central Services layer across Availability Zones. Basic Load Balancer does not support zonal deployments

**Timeout settings** 

* Check SAP NetWeaver developer traces of SAP instances and make sure there are no connection breaks between enqueue server, and the SAP work processes. These connection breaks can be avoided by setting these two registry parameters

    * HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\KeepAliveTime = 120000. 

    * HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\KeepAliveInterval = 120000. 
* To avoid GUI timeouts between on-premises SAP GUI interfaces and SAP application layers deployed in Azure, set the following parameters in the default.pfl or the instance profile: 

    * rdisp/keepalive_timeout = 3600

    * rdisp/keepalive = 20

* If you use a Windows Failover Clustering, make sure that the parameters determining failover triggered by non-responsive nodes are set correctly. For example, assuming the cluster nodes are in the same subnet, make sure to configure failover parameters in the following manner: 

    * SameSubNetDelay = 2000

    * SameSubNetThreshold = 15

    * RoutingHistorylength = 30

**4. Test high availability and disaster recovery procedures**

* Simulate failover by shutting down Azure VMs (Windows guest OS) or putting operating systems in panic mode (Linux guest OS).

* Measure times it takes to complete a failover. If the times are too long, consider: 

    * For SUSE Linux, use SBD devices instead of the Azure Fencing Agent to speed up failover

    * For SAP HANA, if the reload of data takes too long consider improving storage performance

* Test backup/restore sequence and timing and tune if necessary. Make sure that not only backup times are enough. Also test restore and take the timing on restore activities. make sure that the restore times are within your RTO SLAs where your RTO relies on a database or VM restore process

* Test DR functionality and architecture

**5. Perform security checks** 

* Test the validity of the Azure role-based access (RBAC) approach you implemented. The goal is to separate, and limit access and permissions delegated to different teams. As an example, SAP Basis team members should be able to deploy Azure VMs into a given Azure virtual network and assign disks to these Azure VMs. However, the SAP Basis team should not be able to create new virtual networks or change the settings of existing virtual networks. Conversely, members of the network team should not be able to deploy Azure VMs into virtual networks where SAP application and DBMS VMs are running. Nor should members of the network team be able to change attributes of VMs or delete VMs and their disks.

* Verify that NSG rules are working as expected and shield the protected resources

* Verify encryption at rest and in transit. Define and implement processes to back up, store, and access certificates as well as validate the restore process of encrypted entities.

* Use Azure Disk Encryption for OS disks 

* Consider a pragmatic approach when deciding whether to implement an encryption mechanism. For example, evaluate whether it is necessary to apply both Azure Disk encryption and the DBMS Transparent Database Encryption.

**6. Test performance** 

In migration scenarios, leverage SAP tracing and measurements to compare the pilot with the current implementation based upon the following:

* top 10 online reports

* top 10 batch jobs 

* data transfers through interfaces into the SAP system, focusing on cross-premises traffic.