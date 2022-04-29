This workflow illustrates how a user request flows through an SAP landscape built on high-performance Azure virtual machines and an in-memory HANA database running on HANA Large Instances for scalability and performance. This system takes advantage of OS clustering for database performance, high availability using HANA system replication, and a full disaster recovery (DR) configuration for guaranteed system availability.

:::image type="content" source="../media/hli-sample-functional-workflow-1de437d8.png" alt-text="SAP HANA on Azure (Large Instances) sample functional workflow":::


1.  In this example, an on-premises SAP user executes a sales order via Fiori interface, custom interface, or other.
2.  **Azure high-speed ExpressRoute Gateway** is used to connect to Azure virtual machines.
3.  The request flows into highly available ABAP SAP Central Services (ASCS) and then through **application servers running on Azure virtual machines in an availability set** offering a 99.95% uptime SLA.
4.  The request is sent from App Server to SAP HANA running on primary Large Instance blades.
5.  **Primary and secondary blades are clustered** at OS level for 99.99% availability, and data replication is handled through HANA System Replication in synchronous mode (HSR) from primary to secondary, enabling zero RPO.
6.  In-memory data of SAP HANA is persisted to high-performance NFS storage.
7.  Data from NFS storage is periodically backed up in seconds, using built-in storage snapshots on the local storage, without affect on database performance.
8.  Persistent data volume on secondary storage is replicated to dedicated DR system through a **dedicated backbone network for HANA storage replication**.
9.  The Large Instance on the DR side can be used for non-production to save costs, by mounting both the QA storage and DR replicated volume (read-only).
