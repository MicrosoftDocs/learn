
SAP systems moved onto Azure cloud include large multinational “single global instance” systems many times larger than the  systems deployed when the Azure platform was initially certified for SAP workloads.

Very Large Databases (VLDB) are now commonly moved to Azure. Database sizes over 20 TB require additional techniques and procedures to achieve a migration from on-premises to Azure within an acceptable downtime and a low risk.

While this lesson does not cover migration to HANA (DMO) running on Azure, many of the same concepts are applicable to HANA Migrations. 

## High-level overview

A fully optimized VLDB migration should achieve around 2 TB per hour migration throughput or more. The data transfer component of a 20-TB migration can be done in approximately 10 hours. After which, the post-processing and validation steps are then performed. In general, with sufficient time for preparation and testing, any customer system of any size can be moved to Azure.

VLDB Migrations require  considerable skill, attention to detail, and analysis. For example, the net impact of Table Splitting must be measured and analyzed. Splitting a large table into more than 50 parallel exports may  decrease the time taken to Export a table. However, too many Table Splits may result in increased Import times. Therefore, the net impact of table splitting must be calculated and tested. An expert licensed OS/DB migration consultant will be familiar with the concepts and tools. 

In this section deals with Heterogeneous OS/DB Migration to Azure with SQL Server as the target database using tools such as R3load and Migration monitor (MIGMON). The steps performed here are not intended for Homogeneous System Copies that is, a copy where the DBMS and Processor Architecture (Endian Order) - stays the same. In general, Homogeneous System Copies should have low downtime regardless of DBMS size because log shipping can be used to synchronize a copy of the database in Azure.

Further below, a diagram of a  VLDB OS/DB migration and move to Azure is summarized and include the following key points:

1. The current source OS/DB is often AIX, HPUX, Solaris. or Linux and DB2 or Oracle

2. The target OS is either Windows, Suse 12.3, Red Hat 7.x, or Oracle Linux 7.x

3. The target DB is usually either SQL Server or Oracle 12.2

4. IBM pSeries, Solaris SPARC hardware, and HP Superdome thread performance is drastically lower than low-cost modern Intel commodity servers, therefore R3load is run on separate Intel servers

5. VMWare requires special tuning and configuration to achieve good, stable, and predictable network performance. Typically, physical servers are used as R3load server and not VMs

6. Commonly four export R3load servers are used, though there is no limit on the number of export servers. A typical configuration would be:

    * Export Server #1 – dedicated to the largest 1-4 tables (depending on how skewed the data distribution is on the source database)
    
    * Export Server #2 – dedicated to tables with table splits
    
    * Export Server #3 – dedicated to tables with table splits
    
    * Export Server #4 – all remaining tables

7. Export dump files are transferred from the local disk in the Intel-based R3load server into Azure using AzCopy via public internet (typically faster than via ExpressRoute though not in all cases)

8. Control and sequencing of the Import is via the Signal File (SGN) that is automatically generated when all Export packages are completed and allows for a semi-parallel Export/Import

9. Import to SQL Server or Oracle is structured similarly to the Export, leveraging four Import servers. These servers would be separate dedicated R3load servers with Accelerated Networking. It is recommended not to use the SAP application servers for this task

10. VLDB databases would typically use E64v3, m64 or m128 VMs with Premium Storage. The Transaction Log can be placed on the local SSD disk to speed up Transaction Log writes and remove the Transaction Log IOPS and IO bandwidth from the VM quota. After the migration, the Transaction Log should be placed onto persisted disk. 

Below is a depiction of the flow of an on-premises datacenter to an Azure datacenter.

![The flow of an on-premises datacenter to an Azure datacenter.](../media/implement-large-database-migration-azure-sap-workloads.png)


