You can use Azure Monitor, including Log Analytics. to monitor Azure VMs hosting SAP workloads and any components of your SAP environment in Azure. You might want to also consider using third-party SAP monitoring solutions available from Azure Marketplace that integrate with Azure Monitor, such as Blue Medora’s SAP Monitoring.    

For full support, users must enable built-in SAP monitors to retrieve information about configuration and resource utilization from the underlying Azure infrastructure. Therefore, every Azure instance that hosts SAP software and related DBMS systems such that:

* The Azure Monitoring Extension for SAP is deployed and correctly configured.

* Data from the Azure Monitoring Extension for SAP is visible in the SAP NetWeaver system.

Make sure that the following technical requirements for use of the Azure Monitoring Extension for SAP are given:

* The Azure Virtual Machine instance requires an active route to the internet to access the Azure Extension Pool. This requirement might require setting Internet proxies for the Virtual Machine Instance before deploying the Azure Virtual Machine Extension for SAP.

* The SAP Enhanced Monitoring is deployed. To include Azure performance counters in the SAP enhanced monitoring, SAP has enhanced the SAP Host Agent and its monitoring transaction ST06. Check the configuration, the required versions, and minimum support package levels as described in the following SAP Notes:

    * **Windows**: SAP Note 1409604 (Virtualization on Windows: Enhanced monitoring)

    * **Linux**: SAP Note 1102124 (SAPOSCOL on Linux: Enhanced function)”

In the case of SAP HANA on Azure (Large Instances), Microsoft offers monitoring support for CPU, memory, network bandwidth, and disks space. For the Type II SKUs of the HANA Large Instances, the server comes with the preloaded system diagnostic tools. Users can use these diagnostic tools to perform the system health check. 

