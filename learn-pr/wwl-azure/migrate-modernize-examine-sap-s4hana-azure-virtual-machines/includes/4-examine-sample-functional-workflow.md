This workflow illustrates how a user request flows through an SAP landscape built using high-performance Azure VMs and in-memory SAP HANA databases running on Azure VMs for the maximum scalability and performance. This system takes advantage of Linux OS clustering for high availability, premium storage for performance, data replication for high availability via HANA System Replication (HSR), and a full disaster recovery (DR) configuration for guaranteed 99.95 percent system availability with asynchronous HSR.

:::image type="content" source="../media/sap-netweaver-workflow-example-0cfef8e1.gif" alt-text="Diagram of S A P, S 4 HANA on Azure virtual machines sample functional workflow.":::

1. In this example, an on-premises SAP user executes a sales order request via SAP’s S/4HANA Fiori interface, custom application interface, or others.
2. **Azure high-speed express route gateway** is used to connect securely from On-premises network to Azure Virtual Machines and other Azure resources.
3. Request flows into highly available SAP ABAP SAP Central Services (ASCS) and then through **SAP application servers running on Azure Virtual Machines in an Azure VM Availability Set** offering a 99.95 percent uptime SLA.
4. Request is sent from app server to SAP HANA running on an Azure Virtual Machine optimized for large memory SAP HANA workloads.
5. **Primary (active) and secondary (standby) running on SAP certified M-series virtual machines with Write Accelerator are clustered** at OS level for 99.95 percent availability, and data replication is handled through HSR in synchronous mode from primary to secondary enabling zero RPO.
6. In-memory data of SAP HANA is persisted to high-performance **Azure Premium Storage**.
7. In-memory HANA data is replicated to a DR region virtual machine through an Azure high-speed backbone network and HSR in asynchronous mode. The disaster recovery VM can be smaller than the production VM to save costs.
8. VMs on the DR region can be used for nonproduction to save costs by mounting both the non-production storage and DR replicated volume (read-only).
9. SAP App Server with ASCS on the DR side can be in standby shutdown mode and can be started when needed to save costs.
