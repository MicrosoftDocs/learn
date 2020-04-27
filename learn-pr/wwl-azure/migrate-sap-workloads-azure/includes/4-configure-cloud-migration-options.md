This unit outlines the prerequisites and benefits of migrating to Microsoft Azure in one-step via Data Migration Option (DMO) with System Move compared to the two-step option of “lift and shift” and then Data Migration Option (DMO).

## Steps for Data Migration Option (DMO) with System Move to Microsoft Azure:

* Ensure connectivity to Azure is available via Express Route (highly recommended and with higher-speed connectivity) or Virtual Private Network (VPN) into Azure

* Provision the target infrastructure in Azure that includes SAP NetWeaver and SAP HANA database servers. The Azure infrastructure can be rapidly deployed using predefined Azure Resource Manager (ARM) templates.

* SUM is started on the on-premises source SAP application server.

* Uptime activities are executed from the on-premises SAP application server and the shadow repository is created.

* As part of the downtime phase, export files are generated on the source system and these files are then transferred to Azure via Express Route or VPN.

* File transfers can occur in “Sequential Data Transfer” or “Parallel Data Transfer” mode

## Sequential Data Transfer Mode:

* In Sequential Data Transfer mode, all tables are exported to the file system of the on-premises server

* Once the export is finalized, the complete SUM directory is transferred to the target application server in Azure

* The SUM directory is re-synchronized during the HOSTCHANGE phase of Data Migration Option (DMO)

* SUM is initiated on the target Azure application server and the import is started

* Post-processing is completed

## Parallel Data Transfer Mode:

* In Parallel Data Transfer mode, data is immediately transferred to the Azure target after the export is completed for each file via the dmotocloud.sh script

* This mode can be used to minimize migration downtime.

Consider the following for the two-step migration:

* Ensure connectivity to Azure is available via Express Route (recommended) or VPN .

* Provision the target infrastructure on Azure which includes the cloned system and target SAP NetWeaver and SAP HANA database servers. The Azure infrastructure can be deployed using predefined Azure Resource Manager (ARM) templates.

* The cloned system can be built with a homogeneous system copy (backup/restore) or via DBMS replication tools (For example, Oracle Data Guard, or SQL Always-On).

* Business and technical testing should be initiated (with functional, integration and acceptance testing to ensure the move of data has been successful).

* Following business and technical validation, the traditional Data Migration Option (DMO) process can be followed to migrate and upgrade to SAP HANA.

* Data Migration Option (DMO) can be leveraged with the memory pipe method (i.e. export/import occurs within the same application server and memory segment for accelerated migrations).

* Following the migration to SAP HANA, business and technical validation should again be initiated.

* In this approach, two downtimes and two testing cycles are required.

## Data Migration Option (DMO) optimization options

There are many factors that influence the downtime associated with an SAP database migration and include (amongst others):

|    Scope                                |    Software changes, Unicode conversion, data center   relocation    |
|-----------------------------------------|----------------------------------------------------------------------|
|    Source System Performance            |    CPU, I/O, memory, DBMS performance, SAP NetWeaver release         |
|    Source System Database Size          |    Database size, largest tables, status of housekeeping             |
|    Target System Performance            |    CPU, I/O, memory, DBMS performance, SAP NetWeaver release         |
|    Network                              |    Network speed, bandwidth, latency                                 |
|    Toolset                              |    SWPM, SUM, Data Migration Option (DMO) of SUM, version of the toolset                     |
|    Migration Approach                   |    Standard vs Minimize Downtime                                     |
|    Ramp-up / Ramp-down                  |    Activities Interface management, batch job management             |
|    Pre and Post Migration Validation    |    Functional, integration and acceptance Testing.                   |


Broadly speaking, the potential for performance optimizations can be seen in the following three areas:

* Export

* File Transfer

* Import

## Infrastructure/hardware

The infrastructure/hardware reduction lever consists of the following:

* **On-premises**

    - Deploy a dedicated migration server (PAS / AAS) with extensive compute capability to execute SUM
    
    - Deploy Solid State Disks (SSD) on the source database and migration servers. 
    
    - (PAS / AAS)

* **Microsoft Azure**

- **Express Route connectivity** is recommended with the maximum bandwidth available (currently available up to 10 Gbps)

- Leverage the dmotocloud.sh script (RSYNC) to move files from an on-premise source to an Azure target for the Data Migration Option (DMO) System Move Option with Parallel Transfer.    

- **Implement storage snapshots** for time-efficient backups during the cutover period.    

## Key considerations for downtime optimization for Data Migration Option (DMO)

* Source database optimization (index rebuild, DB statistics, DB parameters, and DB file system). A useful reference can be found in the table below.

|    Database      |    Reference                                                                                                          |
|------------------|-----------------------------------------------------------------------------------------------------------------------|
|    Oracle        |    SAP Note 936441 - Oracle settings for R3load based system   copy                                                   |
|    DB2           |    http://www.redbooks.ibm.com/abstracts/sg247774.html                                                                |



* Use the latest version of migration tool (For example, R3* and kernel).

* Network parameterization (For example, MTU settings, reset counters).

* OS-related parameterization (For example, Q depth).

* SAP HANA database parameters (Related to save points, log mode, and timeouts).

* Data Migration Option (DMO) Migration parameters (For example, duration files, manual table splits, manual table sequencing order, and fast load for BLOB).

## Data Migration Option (DMO) benchmarking:

* Used to capture export and import phases for a subset of data. It can be configured to run on specific tables.

## Repeat multiple runs of downtime phase:

* Running the execution phase multiple times is possible by reworking the table splitting activity (thus optimizing table splitting that will reduce the downtime of the Data Migration Option (DMO) procedure).

## Downtime optimized Data Migration Option (DMO)

Downtime Optimized Data Migration Option (DMO) is a migration option where large tables are migrated as part of the uptime phase. Triggers will capture the changes that can be replayed back as part of the downtime process. 

In the table below, see the comparison between Classic Data Migration Option (DMO) and Downtime Optimized DMO. 

|    Classic DMO                                          |    Downtime Optimized DMO                                                                                                                                                                                                                                                                                                                                        |
|---------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    Data Migration Option (DMO) can be performed by any resource                 |    A SAP employee needs to execute the project and is a SAP Services-based   project only                                                                                                                                                                                                                                                                        |
|    All tables are replicated as part of the downtime    |    Large tables are replicated as part of the uptime using   SLT                                                                                                                                                                                                                                                                                                 |
|    Longer downtime duration                             |    Reduced downtime duration                                                                                                                                                                                                                                                                                                                                     |
|    All scenarios are supported                          |    Scenario "DMO without Software Update" can be   combined with "downtime-optimized DMO" Scenario "DMO with   System Move" does not support "downtime-optimized DMO"                                                                                                                                                                                            |
|    No need to add the DMIS in stack.xml generation      |    Manually add DMIS in Maintenance Optimizer (MOPZ) to   create the stack configuration file (stack.xml)                                                                                                                                                                                                                                                        |
|    No Restrictions                                      |    Products supported: SAP ECC 6.0 and higher SAP CRM 7.0 and   higher                                                                                                                                                                                                                                                                                           |
|    No Restrictions                                      |    Restrictions on Tables which cannot be replicated in   uptime: Basis tables containing deep components (For example, STRG) Pool tables   Application exchange tables (transferred in uptime anyhow) Tables to be   converted Tables without primary key Tables which start with /BI in the name   Tables from Transport Management System (TMS) starting with E07*    |


## Near-Zero Downtime (NZDT)

NZDT uses clone-based methodology and following the cloning of the production system, Data Migration Option (DMO) executes on the clone. Transaction activities are captured from the production system and replayed back to the clone system. For details, refer to the SAP Note #693168 - Minimized Downtime Service (MDS).
