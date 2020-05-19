Software Update Manager (SUM) creates the shadow repository on the existing database ahead of the downtime phase. A target database is built in parallel while the shadow repository is subsequently copied and the SAP database connection is switched to the target database.

Following the migration of the application data, that includes data conversion, the upgrade is then finalized and the SAP system begins to run on the target database. The source database retains the unmodified application data and is used as a possible fallback if needed.

## Prerequisites

When migrating an existing SAP system running on anyDB to an SAP HANA database, the following steps are required:

* Dual-Stack split

* Unicode conversion (for versions prior to SAP NetWeaver 7.5)

* Database upgrade of anyDB

* Upgrade SAP software

## DMO for SAP BW and SAP Business Suite Systems

DMO can be used for AS-ABAP systems and with SUM 1.0 SP09 or higher. DMO can also be used for SAP HANA and ASE targets. Furthermore, DMO can also be used for SQL Server, DB2, and MaxDB. For more information, see the following SAP Notes:

* SAP Note 2426315: Database Migration Option for SUM 1.0 SP 21

* SAP Note 2472850: Database Migration Option for SUM 2.0 SP 01

## DMO phases

The following diagram provides an overview of the main DMO phases.

|    Phase             |    Comment                                                                                                                                                                                                                                       |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    Preparation       |    Occurs prior to the SUM tool starting and   covers areas such as the source pre-check/readiness, housekeeping, validating   the source and target environments, verification of client 000, DDIC, and   sidadm passwords.     |
|    Extraction        |    Phase that is part of the actual SUM process and where the   tool checks all available software downloads for both source and target   systems. The tool then unpacks SAR files, which are part of the download   directory.                   |
|    Configuration     |    SUM checks source and target system connectivity.                                                                                                                                                                                             |
|    Checks            |    SUM tool checks the available space for creating the   shadow repository.                                                                                                                                                                     |
|    Pre-Processing    |    Phase where the shadow repository is created, and target   table structures are created in SAP HANA. This phase includes creating the table   groups in a distributed/scale-out system.                                                              |
|    Execution         |    This phase includes the downtime activities. The SAP   source system is locked for users and actual data transfer is initiated. An   SAP kernel switch is executed following the data loads.                                                  |
|    Post-Processing    |    All post processing steps are executed, including SAP HANA   content activation and cleaning up of logs in the SUM directory.                                                                                                                 |


## DMO cut-over Week

DMO provides a fallback option during any phase.

Beginning DMO up-processing at least one week in advance of the cut-over follows published SAP best practices and allows for ample time for the shadow repository.
In the event of an issue during up-tim
Backup must be performed prior to commencing the downtime activities. If there is an event during up-time activities, a simple fallback approach is to remove the shadow instance. If so, this means dropping the shadow instance schema from the source database. Should errors occur during the downtime phase and are likely related to data problems, which must be rectified before moving forward. It is important to execute multiple migration test cycles to resolve problems in advance of the  migration.

## DMO with System Move

The option “Enable the migration with system move” is available from SUM 1.0 SP21 where the application server driving the migration can be changed as part of the process. For example, SUM started on on-premises application server and switched to an application server running in Azure. SUM is running on the source system and will stop at the execution phase. Subsequently, the complete SUM directory is copied to Azure where the import process continues on the new/target application server

The following table compares the Classical DMO versus DMO with System Move Option

|    Parameter                            |    Classical DMO                                                                     |    DMO with system Move                                                                 |
|-----------------------------------------|--------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------|
|    Purpose/Use Case                     |    In place upgrade and migration                                                    |    Cloud/Azure-based migrations                                                         |
|    Downtime Optimization Flexibility    |    High                                                                              |    Medium                                                                               |
|    Cloud Migration                      |    Technically possible (but not currently officially   supported by SAP)            |    Yes                                                                                  |
|    Target servers                       |    Same application server can be used to connect to SAP HANA   after a migration    |    New servers need to be created and deployed in Microsoft Azure                                      |
|    Options for Data Transfer            |    <ul><li>Memory pipes</li>   <li>Filesystem dump</li></ul>                                |    <ul><li>Filesystem dump</li>   <li>Can use sequential or parallel load options</li></ul>    |

