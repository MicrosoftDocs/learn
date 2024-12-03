In this phase, you should use all the knowledge and experience you accumulated in the prior phases and apply them in preparation for the production deployments. In addition, in migration scenarios, you should prepare for data transfer between your current hosting location and Azure.

1. Work through necessary SAP release upgrades of your production systems before moving into Azure.
2. Agree with the business owners on the functional and business tests that need to be conducted after the migration of the production system. Make sure that all these tests are executed with the source systems in the current hosting location. You want to avoid tests being conducted for the first time once the system is moved into Azure.
3. Test production migration process into Azure. In cases where you're not moving all production systems to Azure within the same timeframe, identify groups of production systems that need to reside in the same hosting location. Test data migration. Common migration methods include:

     - Using DBMS methods like backup/restore in combination with SQL Server Always On, HANA System Replication, or Log shipping to seed and synchronize database content into Azure.
     - Use Backup/restore for smaller databases.
     - Use SAP Migration Monitor implemented into SAP SWPM tool to perform heterogeneous migrations.
     - Use the SAP DMO process (described at [Database Migration Option (DMO) of SUM – Introduction](https://blogs.sap.com/2013/11/29/database-migration-option-dmo-of-sum-introduction/)) if you need to combine with an SAP release upgrade. Keep in mind that not all combinations between source and target DBMS are supported. More information can be found in the DMO release-specific SAP Notes. For example, Database Migration Option (DMO) of SUM 2.0 SP04 is documented in [SAP Note \#3126581](https://me.sap.com/notes/3126581).
     - Compare throughput of data transfer via Internet and ExpressRoute in case you need to upload backups or SAP export files to Azure. To facilitate Internet-based transfers, you might need to adjust NSG/ASG configuration.
4. Before moving systems from the old platform into Azure, collect resource consumption data, such as CPU usage, storage throughput, and IOPS data. This is important regarding the DBMS layer units but is also helpful in the case of the application layer units. In addition, you should measure network and storage latency.
5. Reference SAP support notes, SAP HANA hardware directory, and SAP Product Availability Matrix (PAM) to ensure accuracy of the information regarding supported Azure Virtual Machine SKUs, supported OS releases for these Azure Virtual Machine SKUs, and supported SAP and DBMS releases.
6. Adapt your deployment scripts to use new Azure Virtual Machine SKUs types and incorporate new features from which you can benefit.
7. After deployment of infrastructure and application, step through the extra checks to validate the deployment:

     - The deployment provisioned the appropriate Azure Virtual Machine SKUs with the intended storage configuration.
     - Guest operating systems of Azure Virtual Machines are hardened in the intended and uniform manner.
     - Guest operating systems of Azure Virtual Machines are at the intended version and patch level.
     - The intended application releases and patches are installed.
     - Guest operating systems of Azure Virtual Machines are at the intended version and patch level.
     - Azure Premium Storage is being used for the latency-sensitive disks or where the single virtual machine availability SLA of 99.9% is required.
     - Guest operating systems of Azure Virtual Machines are at the intended version and patch level.
     - Whenever applicable, Azure Write Accelerator is enabled.
     - Guest operating systems of Azure Virtual Machines are at the intended version and patch level.
     - Make sure that within the virtual machine, storage spaces, or stripe sets are created across disks that need Azure Write Accelerator support. For relevant information regarding Linux volume managers, refer to:

         - MDADM: [Configure Software RAID on Linux](/azure/virtual-machines/linux/configure-raid)
         - LVM: [Configure LVM on a Linux virtual machine in Azure](/azure/virtual-machines/linux/configure-lvm)
     - Azure Virtual Machines are configured exclusively with managed disks.
     - Whenever applicable, Azure Virtual Machines are deployed into the intended Availability Sets and availability zones.
     - Azure Accelerated Networking is enabled on the Azure Virtual Machines used on the SAP application layer and the SAP DBMS layer.
     - There are no Azure Network Virtual Appliances in the communication path between the SAP application and the DBMS layer of an SAP NetWeaver, Hybris, or S/4HANA based SAP systems.
     - ASG and NSG rules control the connectivity in the intended manner.
     - Timeout settings identified in the pilot phase are implemented.
     - Network latency between SAP application layer virtual machine and DBMS layer complies with the guidelines provided in [SAP Note \#500235](https://me.sap.com/notes/500235) and [SAP Note \#1100926](https://me.sap.com/notes/1100926). When deploying SAP HANA on Azure (Large Instances), take into account the exceptions documented in [SAP HANA (Large Instances) network architecture](/azure/virtual-machines/workloads/sap/hana-network-architecture).
     - Encryption is implemented in the intended manner.
     - Interfaces and applications are available in the newly deployed infrastructure.
8. Create a playbook that facilitates Azure planned maintenance events. The playbook should define the order in which the systems and Azure Virtual Machines should be taken offline and brought back online for planned maintenance.
