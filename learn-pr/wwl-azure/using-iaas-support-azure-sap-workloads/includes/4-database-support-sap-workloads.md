The following RDBMS platforms are supported by SAP for running workloads in Azure:

## Windows Server

* Microsoft SQL Server 2008 R2 and higher

* SAP ASE 16.0 SP02 and higher

* IBM DB2 10.5 and higher

* Oracle Database, for versions and restrictions see SAP Note 2039619

* SAP MaxDB version 7.9

* SAP liveCache as part of SAP SCM 7.0 EhP2 (or higher): Minimal version for SAP liveCache: SAP LC/LCAPPS 10.0 SP 27 including liveCache 7.9.08.32 and LCA-Build 27, released for EhP 2 for SAP SCM 7.0 and higher



## SLES and RHEL

* SAP HANA 1.0 SP12 and higher, SAP HANA 2.0

    * Running on Microsoft Azure Large Instance Types 

    * Running on Microsoft Azure VMs as listed on the SAP HANA Hardware Directory

* SAP ASE 16.0 SP02 and higher

* IBM DB2 10.5 and higher

* SAP MaxDB version 7.9.09.05 and higher

* SAP liveCache as part of SAP SCM 7.0 EhP4 (or higher)



## Oracle Linux

Oracle Database

For versions and restrictions refer to SAP Note #2039619 containing the Oracle support matrix on Azure.


> [!NOTE] 
> Oracle  supports Windows and Oracle Linux as guest OS in Azure VMs only.


> [!NOTE]
> Using Windows Failover Cluster Service with shared disk configuration for the DBMS layer is not supported in Azure VMs. Instead, to provide high availability, customers should consider using non-shared disk solutions, such as SQL Server Always On, Oracle Data Guard, or HANA System Replication.

