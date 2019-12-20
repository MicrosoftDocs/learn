Given the wide variety of Azure infrastructure options, nearly all existing SAP NetWeaver and S/4HANA systems can be hosted in Azure. Azure supports VM SKUs with terabytes of memory and more than 200 CPUs. For even more demanding workloads, Azure offers HANA Large Instances (HLI), which allow for HANA deployments that can scale up to 24TB and scale-out to 120TB.

To successfully deploy SAP systems into Azure IaaS (or IaaS in general), it is important to understand the differences between the offerings of traditional outsourcers or hosters and IaaS offerings. While the traditional hoster or outsourcer adapts infrastructure (network, storage and server type) to the workload a customer wants to host, it is the customer's or partner's responsibility to identify the workload’s requirement and choose the correct Azure components of VMs, storage and network for IaaS deployments.

It is important to verify the following items:

* The SAP supported VM and HLI types of Azure

* The SAP supported products/releases on Azure

* The supported OS and DBMS releases for the specific SAP releases in Azure

* SAPS throughput provided by different Azure VM and HLI SKUs

Additionally, it's necessary to understand how the Azure IaaS resource and bandwidth limitations stand in comparison to the actual resource consumption of on-premises systems. Therefore, you need to be familiar with the different capabilities of the Azure VMs and HLI supported with SAP in:

* CPU and memory resources

* Storage IOPS and throughput

* Network bandwidth and latency

## Learning objectives 

In this module you will:

* Understand how the SAPS metric serves as a major criteria for determining whether a VM size offers throughput requirement necessary for a given SAP workload. It also represents one the primary factors considered by Microsoft and SAP when certifying Azure VMs for SAP NetWeaver and SAP HANA.

* Learn how high availability of SAP workloads on Azure VMs can be analyzed in two different contexts:

    * High availability of SAP workloads

    * High availability capabilities of Azure infrastructure

* See how VMs hosting SAP Application can be backed up using Azure Backup

* Understand how the solution to enable SAP Monitoring using Azure VM Agent and its extensions and how to enable it

* Review security considerations using SQL Server Transparent Data Encryption (TDE) when deploying  SAP SQL Server databases in Azure

* Review the compute considerations for planning SAP HANA on Azure Large Instances

