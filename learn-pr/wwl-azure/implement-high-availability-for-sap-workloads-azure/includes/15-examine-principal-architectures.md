The principal architectures to deploy SAP NetWeaver or S/4HANA system across Azure availability zones are:

- **Active/active**: The pair of virtual machines running ASCS/SCS and the pair of virtual machineS running the DBMS layer are distributed across two zones. The number of virtual machines running the SAP application layer are deployed to an even number across the same two zones.
- **Active/passive**: The pair of virtual machines running ASCS/SCS and the pair of virtual machineS running the DBMS layer are distributed across two zones. The number of virtual machines running the SAP application layer are deployed into one of the availability zones. You run the application layer in the same zone as the active ASCS/SCS and DBMS instance.

Before you decide how to use availability zones, you need to determine:

- The network latency among the three zones of an Azure region. This enables you to choose the zones with the least network latency in cross-zone network traffic.
- The difference between virtual machine-to-virtual machine latency within one of the zones, of your choosing, and the network latency across two zones of your choosing.
- Whether the virtual machine types that you need to deploy are available in the two zones that you selected. With some virtual machines, especially M-Series virtual machines, you might encounter situations in which some SKUs are available in only two of the three zones.

Choosing the correct Azure region for an SAP system accessed by a geographically dispersed user-base has a significant impact on high availability and performance for mission-critical workloads. Use the following evaluation criteria in devising the right strategy:

- Data Residency and Security policies
- Business Continuity requirements
- Network Connectivity including End User Network Connectivity and Azure inter-region latencies

> [!IMPORTANT]
> For a large SAP project, the region should be checked for support of all target virtual machine types, sizes, and features (like Azure NetApp for SAP HANA).
