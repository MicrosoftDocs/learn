## DMO processing

Software Update Manager (SUM) creates the shadow repository (development components/target version for ABAP workbench) on the traditional database until the downtime phase. The target database is built up in parallel where the shadow repository is then copied and the SAP database connection is switched to the target database and the downtime process starts.

Following the migration of the application data (which includes data conversion), the upgrade is finalized and the SAP system is running on the target database. The source database retains the unmodified application data and therefore a fallback is always possible.

## Prerequisites

When migrating an existing SAP system running on anyDB to an SAP HANA database, the following steps could be required:

- Dual-Stack split
- Unicode conversion (for versions prior to SAP NetWeaver 7.5)
- Database upgrade of anyDB
- Upgrade of SAP software

## DMO for SAP BW and SAP Business Suite systems

DMO can be used for AS-ABAP systems and with SUM 1.0 SP09 or higher. DMO can also be used for SAP HANA and ASE targets. Furthermore, DMO can also be used for SQL Server, DB2, and MaxDB upon request. For more information, see the following SAP Notes:

- [SAP Note \#3106927 on Database Migration Option for SUM 1.0 SP 28](https://me.sap.com/notes/3106927)
- [SAP Note \#3296427 on Database Migration Option for SUM 2.0 SP 17](https://me.sap.com/notes/3296427)

## DMO phases

The following table provides an overview of the main DMO phases.

| Phase | Comment |
|--|--|
| Preparation | Phase that takes place prior to the SUM tool starting and covers areas such as the source pre-check/readiness, housekeeping, validating the source and target environments, verification of client 000, DDIC, and sidadm passwords. |
| Extraction | Phase that's part of the actual SUM process and where the tool checks all available software downloads for both source and target systems. The tool then unpacks SAR files, which are part of the download directory. |
| Configuration | SUM checks source and target system connectivity. |
| Checks | SUM tool checks the available space for creating the shadow repository. |
| Pre-processing | Phase where the shadow repository is created and target table structures are created in SAP HANA. This includes creating the table groups in a distributed/scale-out system. |
| Execution | This phase includes the downtime activities. The SAP source system is locked for users and actual data transfer is initiated. An SAP kernel switch is executed following the data loads. |
| Post-processing | All post-processing steps are executed, including SAP HANA content activation and cleaning up of logs in the SUM directory. |

## DMO “cutover week”

With DMO, you have a fallback option during any phase.

Beginning DMO up-processing at least one week in advance of the cutover follows published SAP best practices and allows for ample time for the shadow repository.

Backup must be performed prior to commencing the downtime activities. In the event of an issue during uptime activities, a simple fallback approach is to remove the shadow instance. This means dropping the shadow instance schema from the source database. Should errors occur during the downtime phase, it’s likely related to data problems that must be rectified before moving forward. As such, it’s important to execute multiple migration test cycles to iron out all problems in advance of the productive migration.

## DMO with system move

The option “Enable the migration with system move” is available from SUM 1.0 SP21 where the application server driving the migration can be changed as part of the process, that is, SUM started on on-premises application server and switched to an application server running in Azure. SUM is running on the source system and will stop at the execution phase. Subsequently, the complete SUM directory is copied to Azure where the import process continues on the new/target application server

The following table compares the Classical DMO versus DMO with System Move Option

| Parameter | Classical DMO | DMO with system move |
|--|--|--|
| Purpose/Use case | In place upgrade and migration | Cloud/Azure-based migrations |
| Downtime optimization flexibility | High | Medium |
| Cloud migration | Technically possible (but not currently officially supported by SAP) | Yes |
| Target servers | Same application server can be used to connect to SAP HANA after a migration | New servers need to be built in Microsoft Azure |
| Options for data transfer | Memory pipes, Filesystem dump | Filesystem dump, Can use sequential or parallel load options |
