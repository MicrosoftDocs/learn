To implement SAP workloads on Azure in a supported manner, customers should follow SAP certified configurations, which consist of a combination of the following four elements:

* **SAP product**

* **Operating system**

* **RDBMS** 

* **Azure offering**, including Azure VM SKU and (in case of HANA) SAP HANA on Azure (Large Instances)



## SAP NetWeaver certifications for all non-HANA RDBMS products

The following SAP NetWeaver products in combination with non-HANA RDBMS are supported on Azure VMs:

|    SAP Product    |    Guest OS    |    RDBMS    |    Virtual Machine   Types    |
|-----------------------------------|--------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    SAP Business Suite Software    |    Windows, SUSE Linux Enterprise, Red Hat Enterprise Linux,   Oracle Linux    |    SQL Server (Windows only), Oracle (Windows and Oracle   Linux only), DB2, SAP ASE    |    A5 to A11, D11 to D14, DS11 to DS14, DS11_v2 to DS15_v2,   GS1 to GS5, D2s_v3 to D64s_v3, E2s_v3 to E64s_v3, M64s, M64ms, M128s, M128ms,   M64ls, M32ls, M32ts, M208s_v2, M208ms_v2     |
|    SAP Business All-in-One    |    Windows, SUSE Linux Enterprise, Red Hat Enterprise Linux,   Oracle Linux    |    SQL Server (Windows only), Oracle (Windows and Oracle   Linux only), DB2, SAP ASE    |    A5 to A11, D11 to D14, DS11 to DS14, DS11_v2 to DS15_v2,   GS1 to GS5, D2s_v3 to D64s_v3, E2s_v3 to E64s_v3, M64s, M64ms, M128s, M128ms,   M64ls, M32ls, M32ts, M208s_v2, M208ms_v2     |
|    SAP BusinessObjects BI    |    Windows    |    N/A    |    A5 to A11, D11 to D14, DS11 to DS14, DS11_v2 to DS15_v2,   GS1 to GS5, D2s_v3 to D64s_v3, E2s_v3 to E64s_v3, M64s, M64ms, M128s, M128ms,   M64ls, M32ls, M32ts, M208s_v2, M208ms_v2     |
|    SAP NetWeaver    |    Windows, SUSE Linux Enterprise, Red Hat Enterprise Linux,   Oracle Linux    |    SQL Server (Windows only), Oracle (Windows and Oracle   Linux only), DB2, SAP ASE    |    A5 to A11, D11 to D14, DS11 to DS14, DS11_v2 to DS15_v2,   GS1 to GS5, D2s_v3 to D64s_v3, E2s_v3 to E64s_v3, M64s, M64ms, M128s, M128ms,   M64ls, M32ls, M32ts, M208s_v2, M208ms_v2    |
 

 ## SAP HANA certifications

 The following SAP HANA products are supported on Azure VMs and SAP HANA on Azure (Large Instances):

|    SAP Product    |    Supported OS    |    Azure Offerings    |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    SAP HANA   Developer Edition (including the HANA client software comprised of SQLODBC,   ODBO-Windows only, ODBC, JDBC drivers, HANA studio, and HANA database)    |    Red Hat   Enterprise Linux, SUSE Linux Enterprise    |    D-Series   VM family     |
|    Business   One on HANA    |    SUSE Linux   Enterprise    |    DS14_v2, M32ts,   M32ls, M64ls, M64s    |
|    SAP S/4   HANA    |    Red Hat   Enterprise Linux, SUSE Linux Enterprise    |    Controlled   Availability for GS5. Full support for M64s, M64ms, M128s, M128ms, M64ls,   M32ls, M32ts, M208s_v2, M208ms_v2, SAP HANA on Azure (Large instances)    |
|    Suite on   HANA, OLTP    |    Red Hat   Enterprise Linux, SUSE Linux Enterprise    |    M64s,   M64ms, M128s, M128ms, M64ls, M32ls, M32ts, M208s_v2, M208ms_v2, SAP HANA on   Azure (Large instances)    |
|    HANA   Enterprise for BW, OLAP    |    Red Hat   Enterprise Linux, SUSE Linux Enterprise    |    GS5, M64s,   M64ms, M128s, M128ms, M64ls, M32ls, M32ts, M208s_v2, M208ms_v2, SAP HANA on   Azure (Large instances)     |
|    SAP BW/4   HANA    |    Red Hat   Enterprise Linux, SUSE Linux Enterprise    |    GS5, M64s,   M64ms, M128s, M128ms, M64ls, M32ls, M32ts, M208s_v2, M208ms_v2, SAP HANA on   Azure (Large instances)    |

## Additional SAP certifications

The following non-NetWeaver (with non-HANA RDBMS) are supported on Azure VMs:

|    SAP Product    |    Guest OS    |    RDBMS    |    Virtual Machine Types    |
|--------------------------------------------------|---------------------------|----------------------------|--------------------------------------------------------------------|
|    SAP   Business One on SQL Server    |    Windows    |    SQL Server       |    All   NetWeaver certified VM types as per SAP Note #928839    |
|    SAP BPC   10.01 MS SP08    |    Windows   and Linux    |         |    All   NetWeaver Certified VM types as per SAP Note #2451795     |
|    SAP Business   Objects BI platform    |    Windows   and Linux    |         |    SAP Note   #2145537     |
|    SAP Data   Services 4.2    |         |         |    SAP Note   #2288344    |
|    SAP Hybris   Commerce Platform 5.x and 6.x    |    Windows    |    SQL   Server, Oracle    |    All   NetWeaver certified VM types as specified by the Hybris Wiki    |



