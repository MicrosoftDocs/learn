Large Instances are physical servers based on the Intel EX E7 CPU architecture and configured in a large instance stamp — that is, a specific set of servers or blades. A compute unit equals one server or blade, and a stamp is made up of multiple servers or blades. Within a large instance stamp, servers are not shared and are dedicated to running one customer’s deployment of SAP HANA.

A variety of SKUs are available for HANA Large Instances, supporting up to 20 TB single instance (60 TB scale-out) of memory for S/4HANA or other SAP HANA workloads. Two classes of servers are offered:

* **"Type I class"** of SKUs comprising of S72, S72m, S96, S144, S144m, S192, S192m, and S192xm 

* **"Type II class"** of SKUs comprising of S384, S384m, S384xm, S384xxm, S576m, S576xm S768m, S768xm and S960m

For example, the S72 SKU comes with 768 GB RAM, 3 terabytes (TB) of storage, and 2 Intel Xeon processors (E7-8890 v3) with 36 cores. Choose a SKU that fulfills the sizing requirements you determined in your architecture and design sessions. Always ensure that your sizing applies to the correct SKU. Capabilities and deployment requirements vary by type, and availability varies by region. You can also step up from one SKU to a larger SKU.

Microsoft helps establish the large instance setup, but it is your responsibility to verify the operating system’s configuration settings. Make sure to review the most current SAP Notes for your exact Linux release.

Sizing for HANA Large Instance is no different than sizing for HANA in general. For existing and deployed systems that you want to move from other RDBMS to HANA, SAP provides several reports that run on your existing SAP systems. If the database is moved to HANA, these reports check the data and calculate memory requirements for the HANA instance. 

For green field implementations, SAP Quick Sizer is available to calculate memory requirements of the implementation of SAP software on top of HANA.

Memory requirements for HANA increase as data volume grows. Be aware of your current memory consumption to help you predict what it's going to be in the future. Based on memory requirements, you then can map your demand into one of the HANA Large Instance SKUs.

## Storage considerations
Storage layout is implemented according to the recommendation of the TDI for SAP HANA. HANA Large Instances come with a specific storage configuration for the standard TDI specifications. You can add storage to existing instances in 1-TB units. This additional storage can be added as additional volume. It also can be used to extend one or more of the existing volumes. It isn't possible to decrease the sizes of the volumes as originally deployed. It also isn't possible to change the names of the volumes or mount names. 

To support the requirements of mission-critical environments including fast recovery, NFS is used and not direct attached storage. The NFS storage server for HANA Large Instances is hosted in a multi-tenant environment, where tenants are segregated and secured using compute, network, and storage isolation. The storage volumes are attached to the HANA Large Instance units as NFS4 volumes.

To support high availability at the primary site, use different storage layouts. For example, in a multi-host scale-out, the storage is shared. Another high availability option is application-based replication such as HSR. For DR, however, a snapshot-based storage replication is used.

The HANA Large Instance of the Type I class comes with four times the memory volume as storage volume. This is not the case for the Type II class of HANA Large Instance units. The following table lists the rough capacity for the different volumes provisioned with the different HANA Large Instance units.

| HANA Large Instance SKU | hana/data | hana/log | hana/shared | hana/logbackups |
| --- | --- | --- | --- | --- |
| S72 | 1,280 GB | 512 GB | 768 GB | 512 GB |
| S72m | 3,328 GB | 768 GB | 1,280 GB | 768 GB |
| S96 | 1,280 GB | 512 GB | 768 GB | 512 GB |
| S192 | 4,608 GB | 1,024 GB | 1,536 GB | 1,024 GB |
| S192m | 11,520 GB | 1,536 GB | 1,792 GB | 1,536 GB |
| S192xm | 11,520 GB | 1,536 GB | 1,792 GB | 1,536 GB |
| S384 | 11,520 GB | 1,536 GB | 1,792 GB | 1,536 GB |
| S384m | 12,000 GB | 2,050 GB | 2,050 GB | 2,040 GB |
| S384xm | 16,000 GB | 2,050 GB | 2,050 GB | 2,040 GB |
| S384xxm | 20,000 GB | 3,100 GB | 2,050 GB | 3,100 GB |
| S576m | 20,000 GB | 3,100 GB | 2,050 GB | 3,100 GB |
| S576xm | 31,744 GB | 4,096 GB | 2,048 GB | 4,096 GB |
| S768m | 28,000 GB | 3,100 GB | 2,050 GB | 3,100 GB |
| S768xm | 40,960 GB | 6,144 GB | 4,096 GB | 6,144 GB |
| S960m | 36,000 GB | 4,100 GB | 2,050 GB | 4,100 GB |
| S896m | 33,792 GB | 512 GB | 1,024 GB | 512 GB |

It's possible to host more than one active SAP HANA instance on HANA Large Instance units. To provide the capabilities of storage snapshots and disaster recovery, such a configuration requires a volume set per instance. Currently, HANA Large Instance units can be subdivided as follows:

* S72, S72m, S96, S144, S192: In increments of 256 GB, with 256 GB the smallest starting unit. Different increments such as 256 GB and 512 GB can be combined to the maximum of the memory of the unit.

* S144m and S192m: In increments of 256 GB, with 512 GB the smallest unit. Different increments such as 512 GB and 768 GB can be combined to the maximum of the memory of the unit.

* Type II class: In increments of 512 GB, with the smallest starting unit of 2 TB. Different increments such as 512 GB, 1 TB, and 1.5 TB can be combined to the maximum of the memory of the unit.

The storage used in HANA Large Instances has a file size limitation of 16 TB. Unlike in file size limitations in the EXT3 file systems, HANA is not aware implicitly of the storage limitation enforced by the HANA Large Instances storage. As a result, HANA will not automatically create a new data file when the file size limit of 16TB is reached. As HANA attempts to grow the file beyond 16 TB, HANA will report errors and the index server will crash at the end. In order to prevent HANA trying to grow data files beyond the 16 TB file size limit of HANA Large Instance storage, you need to set the following parameters in the global.ini configuration file of HANA

* datavolume_striping=true

* datavolume_striping_size_gb = 15000

## ExpressRoute networking considerations
This architecture uses both virtual and physical networks. The virtual network is part of Azure IaaS and connects to a discrete HANA Large Instances physical network through ExpressRoute circuits. A cross-premises gateway connects your workloads in the Azure virtual network to your on-premises sites.

HANA Large Instances networks are isolated from each other for security. By default, instances residing in different regions do not communicate with each other, except for the dedicated storage replication. However, to use HSR, inter-region communications are required. ExpressRoute Global Reach, IP routing tables, or proxies can be used to enable cross-regions HSR.

All Azure virtual networks that connect to HANA Large Instances in one region can be cross connected via ExpressRoute to HANA Large Instances in a secondary region.

ExpressRoute for HANA Large Instances is included by default during provisioning. For setup, a specific network layout is needed, including required CIDR address ranges and domain routing. 

The architecture of Azure network services is a key component of the successful deployment of SAP applications on HANA Large Instance. Typically, SAP HANA on Azure (Large Instances) deployments have a larger SAP landscape with several different SAP solutions with varying sizes of databases, CPU resource consumption, and memory utilization. It's likely that not all IT systems are in Azure already. Your SAP landscape is often hybrid as well from a DBMS point and SAP application point of view using a mixture of NetWeaver, and S/4HANA, SAP HANA, and another DBMS. Azure offers different services that allow you to run the different DBMS, NetWeaver, and S/4HANA systems in Azure. Azure also offers you network technology to make Azure look like a virtual data center to your on-premises software deployments

The Azure network functionality involves the use of the following components:

* Azure virtual networks connected to the ExpressRoute circuit that, in turn, connects to your on-premises network assets.

* An ExpressRoute circuit that connects on-premises to Azure, with bandwidth of 1 Gbps or higher. The available bandwidth must allow for transfer of data between on-premises systems and systems that run on Azure VMs and must facilitate performant connectivity to Azure VMs from on-premises users. This ExpressRoute circuit is fully paid by you as a customer. 

* All SAP systems in Azure set up in virtual networks to communicate with each other.

* Active Directory and DNS hosted on-premises extended into Azure through ExpressRoute from on-premises or running entirely in Azure.

* An ExpressRoute circuit that connects SAP HANA Large Instances into the Azure data center network fabric. This circuit is deployed and handled by Microsoft. All you need to do is provide IP address ranges after the deployment of your assets in HANA Large Instance connect the ExpressRoute circuit to the virtual networks. There is no additional fee for you as a customer for the connectivity between the Azure data center network fabric and HANA Large Instance units.

* An Azure ExpressRoute gateway that connects a virtual network to ExpressRoute circuits. An Azure ExpressRoute gateway is used with ExpressRoute to an infrastructure outside of Azure or to an Azure Large Instance stamp. You can connect the Azure ExpressRoute gateway to a maximum of four different ExpressRoute circuits if those connections come from different Microsoft enterprise edge routers. 

* Networking within the HANA Large Instance stamp, which is mostly transparent for you.

The maximum throughput you can achieve with an ExpressRoute gateway is 10 Gbps. Copying files between a VM that resides in a virtual network and a system on-premises (as a single copy stream) doesn't achieve the full throughput of the different gateway SKUs. To leverage the complete bandwidth of the ExpressRoute gateway, use multiple streams.

## ExpressRoute considerations for SAP HANA on Azure (Large Instances)

There are specific networking considerations applicable to SAP HANA on Azure (Large Instances):

* The HANA Large Instance units of your customer tenant are connected through another ExpressRoute circuit into your virtual networks. To separate load conditions, the on-premises to Azure virtual network ExpressRoute circuits and the circuits between Azure virtual networks and HANA Large Instances don't share the same routers.

* The workload profile between the SAP application layer and the HANA Large Instance consists typically of small requests and burst data transfers (result sets) from SAP HANA into the application layer.

* The SAP application architecture is more sensitive to network latency than typical scenarios where data is exchanged between on-premises and Azure.

* The Azure ExpressRoute gateway has at least two ExpressRoute circuits: one circuit that is connected from on-premises and one that is connected from HANA Large Instances. This leaves only room for another two additional circuits from different MSEEs to connect to on ExpressRoute Gateway. All the connected circuits share the maximum bandwidth for incoming data of the ExpressRoute gateway.

The network latency experienced between VMs and HANA Large Instance units can be higher than a typical VM-to-VM network round-trip latency. Dependent on the Azure region, the values measured can exceed the 0.7-ms round-trip latency classified as below average in SAP Note #1100926 (FAQ: Network performance). Dependent on Azure Region and tool to measure network round-trip latency between an Azure VM and HANA Large Instance unit, the measured latency can be up to and around 2 milliseconds. Make sure you test your business processes thoroughly in Azure HANA Large Instance. 

To provide deterministic network latency between VMs and HANA Large Instance, the choice of the ExpressRoute gateway SKU is essential. Unlike the traffic patterns between on-premises and VMs, the traffic pattern between VMs and HANA Large Instance can include bursts of requests and data volumes. 

Given the overall network traffic between the SAP application and database layers, only the HighPerformance or UltraPerformance gateway SKUs are supported for connecting to SAP HANA on Azure (Large Instances). For HANA Large Instance Type II SKUs, only the UltraPerformance gateway SKU is supported as an ExpressRoute gateway. Exceptions apply when using ExpressRoute Fast Path.