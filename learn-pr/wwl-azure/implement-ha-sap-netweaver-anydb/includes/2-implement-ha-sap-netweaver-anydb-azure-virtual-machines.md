We'll cover implementation details of one of the SAP NetWeaver deployment scenarios with AnyDB on Azure Virtual Machines. In particular, we'll describe the steps to prepare Azure infrastructure for installing a high-availability SAP system on a Windows failover cluster (with a shared disk) to host an SAP ASCS instance. Azure Resource Manager templates for SAP are used to simplify deployment of required resources.

This procedure is DBMS-independent. The process of installing non-HANA DBMS products is outside of the scope of this course. For more information regarding these installations, see:

- [SQL Server Azure Virtual Machines DBMS deployment for SAP NetWeaver](/azure/virtual-machines/workloads/sap/dbms_guide_sqlserver)
- [Oracle Azure Virtual Machines DBMS deployment for SAP workload](/azure/virtual-machines/workloads/sap/dbms_guide_oracle)
- [IBM Db2 Azure Virtual Machines DBMS deployment for SAP workload](/azure/virtual-machines/workloads/sap/dbms_guide_ibm)
- [SAP ASE Azure Virtual Machines DBMS deployment for SAP workload](/azure/virtual-machines/workloads/sap/dbms_guide_sapase)
- [SAP MaxDB, liveCache, and Content Server deployment on Azure Virtual Machines](/azure/virtual-machines/workloads/sap/dbms_guide_maxdb)
