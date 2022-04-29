As per [SAP Note \#1928533](https://launchpad.support.sap.com/#/notes/1928533), the following RDBMS platforms are supported on Azure:

## Windows Server:

 -  Microsoft SQL Server 2008 R2 and higher
 -  SAP ASE 16.0 SP02 and higher
 -  IBM DB2 10.5 and higher
 -  Oracle Database, for versions and restrictions see [SAP Note \#2039619](https://launchpad.support.sap.com/#/notes/2039619)
 -  SAP MaxDB version 7.9
 -  SAP liveCache as part of SAP SCM 7.0 EhP2 (or higher): Minimal version for SAP liveCache: SAP LC/LCAPPS 10.0 SP 27 including liveCache 7.9.08.32 and LCA-Build 27, released for EhP 2 for SAP SCM 7.0 and higher
    
     -  SAP liveCache based on SAP MaxDB technology must run on an Azure VM solely dedicated to SAP liveCache, that is, without any other application software running on the same VM).

## SLES and RHEL:

 -  SAP HANA 1.0 SP12 and higher, SAP HANA 2.0
    
     -  on Microsoft Azure Large Instance Types as described in [SAP Note \#2316233](https://launchpad.support.sap.com/#/notes/2316233).
     -  on Microsoft Azure VMs as listed on the SAP HANA Hardware Directory.
 -  SAP ASE 16.0 SP02 and higher
 -  IBM DB2 10.5 and higher
 -  SAP MaxDB version 7.9.09.05 and higher
 -  SAP liveCache as part of SAP SCM 7.0 EhP4 (or higher):
    
     -  Minimal version for SAP liveCache: SAP LC/LCAPPS 10.0 SP 34 including liveCache 7.9.09.05 and LCA-Build 34, released for EhP 4 for SAP SCM 7.0 and higher.
     -  SAP liveCache based on SAP MaxDB technology must run on an Azure VM solely dedicated to SAP liveCache (that is, without any other application software running on this VM).

## Oracle Linux:

 -  Oracle Database

For versions and restrictions refer to [SAP Note \#2039619](https://launchpad.support.sap.com/#/notes/2039619) containing the Oracle support matrix on Azure.

 -  As per [SAP Note \#2039619](https://launchpad.support.sap.com/#/notes/2039619) (and the information provided above), Oracle only supports Windows and Oracle Linux as guest OS in Azure VMs.
 -  Using Windows Failover Cluster Service with shared disk configuration for the DBMS layer is NOT supported in Azure VMs. Instead, to provide high availability, customers should consider using non-shared disk solutions, such as SQL Server Always On, Oracle Data Guard, or HANA System Replication.

For more information, see the following SAP Notes:

 -  [2303398 - SAP on SQL Server in Microsoft Azure Virtual Machines](https://launchpad.support.sap.com/#/notes/2303398)
 -  [555223 - FAQ - Microsoft SQL Server in NetWeaver based systems](https://launchpad.support.sap.com/#/notes/555223)
 -  [2134316 - Can SAP ASE run in a cloud environment? - SAP ASE](https://launchpad.support.sap.com/#/notes/2134316)
 -  [2039619 - SAP Applications on Microsoft Azure using the Oracle Database](https://launchpad.support.sap.com/#/notes/2039619)
 -  [1928533 - Supported Products and Azure VM types](https://launchpad.support.sap.com/#/notes/1928533)
    
     -  SAP products supported on Windows
     -  RDBMS platforms supported on Windows
     -  SAP products supported on Linux
     -  RDBMS platforms supported on Linux (SLES, RHEL, Oracle Linux)
