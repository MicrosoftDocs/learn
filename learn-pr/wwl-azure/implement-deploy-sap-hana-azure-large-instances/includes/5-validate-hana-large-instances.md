You must validate the following before you begin the HANA installation:

 -  HLI unit(s)
 -  Operating system configuration
 -  Network configuration
 -  Storage configuration

1.  The first step after you receive the HANA Large Instance and establish access and connectivity to the instances is to register the OS of the instance with your OS provider. Depending on whether you use SUSE or Red Hat, this step involves registering your instance with SUSE SMT (Subscription Management Tool) or Red Hat Subscription Manager installed on an Azure VM within the Azure VM subnet of the virtual network accessible from the HANA Large Instance. This step is necessary for patching the OS, which is the responsibility of the customer.
2.  The second step is to check for new patches and fixes of the specific OS release/version. Verify that the patch level of the HANA Large Instance is in the latest state. There might be cases where the latest patches aren't included. After taking over a HANA Large Instance unit, it's mandatory to check whether patches need to be applied.
3.  The third step is to check out the relevant SAP Notes for installing and configuring SAP HANA on the specific OS release/version. Due to changing recommendations or changes to SAP Notes or configurations that are dependent on individual installation scenarios, Microsoft won't always be able to configure a HANA Large Instance unit perfectly. Therefore, it's mandatory for you as a customer to read the SAP Notes related to SAP HANA for your exact Linux release. Also, check the configurations of the OS release/version and apply the configuration settings if you haven't already. Specifically, check the following parameters and eventually adjust to:
    
     -  net.core.rmem\_max = 16777216
     -  net.core.wmem\_max = 16777216
     -  net.core.rmem\_default = 16777216
     -  net.core.wmem\_default = 16777216
     -  net.core.optmem\_max = 16777216
     -  net.ipv4.tcp\_rmem = 65536 16777216 16777216
     -  net.ipv4.tcp\_wmem = 65536 16777216 16777216
    
    Starting with SLES12 SP1 and RHEL 7.2, these parameters must be set in a configuration file in the /etc/sysctl.d directory. For example, a configuration file with the name 91-NetApp-HANA.conf must be created. For older SLES and RHEL releases, these parameters must be set in/etc/sysctl.conf. For all RHEL releases starting with RHEL 6.3, keep in mind that the sunrpc.tcp\_slot\_table\_entries = 128 parameter must be set in/etc/modprobe.d/sunrpc-local.conf. If the file does not exist, you need to create it first and then add the entry options sunrpc tcp\_max\_slot\_table\_entries=128
4.  The fourth step is to check the system time of your HANA Large Instance unit. The instances are deployed with a system time zone. This time zone represents the location of the Azure region in which the HANA Large Instance stamp is located. You can change the system time or time zone of the instances you own. If you order more instances into your tenant, you need to adapt the time zone of the newly delivered instances. Microsoft has no insight into the system time zone you set up with the instances after the handover. Thus, newly deployed instances might not be set in the same time zone as the one you changed to. It's your responsibility as the customer to adapt the time zone of the instance(s) that were handed over, if necessary.
5.  The fifth step is to check etc/hosts. As the blades get handed over, they have different IP addresses that are assigned for different purposes. Check the etc/hosts file. When units are added into an existing tenant, don't expect to have etc/hosts of the newly deployed systems maintained correctly with the IP addresses of systems that were delivered earlier. It's your responsibility as the customer to makes sure that a newly deployed instance can interact and resolve the names of the units that you deployed earlier in your tenant.

## Operating system

> [!IMPORTANT]
> For Type II units, only the SLES 12 SP2 OS version is currently supported.

The swap space of the delivered OS image is set to 2 GB according to the [SAP Note \#1999997 - FAQ: SAP HANA memory](https://launchpad.support.sap.com/#/notes/1999997). As a customer, if you want a different setting, you must set it yourself.

SUSE Linux Enterprise Server 12 SP1 for SAP applications is the distribution of Linux that's installed for SAP HANA on Azure (Large Instances). This particular distribution provides SAP-specific capabilities "out of the box" (including pre-set parameters for running SAP on SLES effectively).

The following SAP support notes are applicable to implementing SAP HANA on SLES 12:

 -  [SAP Note \#1944799 - SAP HANA guidelines for SLES operating system installation](https://launchpad.support.sap.com/#/notes/1944799)
 -  [SAP Note \#2205917 - SAP HANA DB recommended OS settings for SLES 12 for SAP applications](https://launchpad.support.sap.com/#/notes/2205917)
 -  [SAP Note \#1984787 - SUSE Linux Enterprise Server 12: installation notes](https://launchpad.support.sap.com/#/notes/1984787)
 -  [SAP Note \#171356 - SAP software on Linux: General information](https://launchpad.support.sap.com/#/notes/171356)
 -  [SAP Note \#1391070 - Linux UUID solutions](https://launchpad.support.sap.com/#/notes/1391070)

Alternatively, you have the option of running Red Hat Enterprise Linux for SAP HANA (releases 6.7 and 7.2) on HANA Large Instances.

The following SAP support notes are applicable to implementing SAP HANA on Red Hat:

 -  [SAP Note \#2292690 - SAP HANA DB: Recommended OS settings for RHEL 7](https://launchpad.support.sap.com/#/notes/2292690)
 -  [SAP Note \#2247020 - SAP HANA DB: Recommended OS settings for RHEL 6.7](https://launchpad.support.sap.com/#/notes/2247020)
 -  [SAP Note \#1391070 - Linux UUID solutions](https://launchpad.support.sap.com/#/notes/1391070)
 -  [SAP Note \#2228351 - Linux: SAP HANA Database SPS 11 revision 110 (or higher) on RHEL 6 or SLES 11](https://launchpad.support.sap.com/#/notes/2228351)
 -  [SAP Note \#2397039 - FAQ: SAP on RHEL](https://launchpad.support.sap.com/#/notes/2397039)
 -  [SAP Note \#1496410 - Red Hat Enterprise Linux 6.x: Installation and upgrade](https://launchpad.support.sap.com/#/notes/1496410)
 -  [SAP Note \#2002167 - Red Hat Enterprise Linux 7.x: Installation and upgrade](https://launchpad.support.sap.com/#/notes/2002167)

## Time synchronization

SAP applications that are built on the SAP NetWeaver architecture are sensitive to time differences for the various components that comprise the SAP system. Such differences are indicated by SAP ABAP short dumps with the error title of ZDATE\_LARGE\_TIME\_DIFF.

For SAP HANA on Azure (Large Instances), time synchronization that's done in Azure doesn't apply to the compute units in the Large Instance stamps. This synchronization is not applicable for running SAP applications in native Azure VMs, because Azure ensures that a system's time is properly synchronized.

As a result, you must set up a separate time server that can be used by SAP application servers that are running on Azure VMs and by the SAP HANA database instances that are running on HANA Large Instances. The storage infrastructure in Large Instance stamps is time-synchronized with NTP servers.

## Networking

Every HANA Large Instance unit comes with two or three IP addresses that are assigned to two or three NIC ports. Three IP addresses are used in HANA scale-out configurations and the HANA system replication scenario.

The distribution for units with two IP addresses assigned should look like:

 -  Ethernet “A” should have an IP address assigned that is out of the Server IP Pool address range that you submitted to Microsoft. This IP address shall be used for maintaining in /etc/hosts of the OS.
 -  Ethernet “C” should have an IP address assigned that is used for communication to NFS. Therefore, these addresses do NOT need to be maintained in etc/hosts in order to allow instanc-to-instance traffic within the tenant.

For deployment cases of HANA System Replication or HANA scale-out, a blade configuration with two IP addresses assigned is not suitable. If having two IP addresses assigned only and wanting to deploy such a configuration, contact SAP HANA on Azure Service Management to get a third IP address in a third VLAN assigned. For HANA Large Instance units having three IP addresses assigned on three NIC ports, the following usage rules apply:

 -  Ethernet “A” should have an IP address assigned that is out of the Server IP Pool address range that you submitted to Microsoft. As such, this IP address shall not be used for maintaining in /etc/hosts of the OS.
 -  Ethernet “B” should be exclusively used to be maintained in etc/hosts for communication between the different instances. These addresses would also be the IP addresses that need to be maintained in scale-out HANA configurations as IP addresses HANA uses for the inter-node configuration.
 -  Ethernet “C” should have an IP address assigned that is used for communication to NFS storage. Hence this type of address should not be maintained in etc/hosts.
 -  Ethernet “D” should be exclusively used for access STONITH device for pacemaker. This interface is required when you configure HANA System Replication (HSR) and want to achieve auto failover at the operating system using an SBD based device.

## Storage

The storage layout for SAP HANA on Azure (Large Instances) is configured by SAP HANA on Azure Service Management through SAP recommended guidelines. The naming conventions of the storage volumes are listed in the following table (where SID is the HANA instance System ID and Tenant is an internal enumeration of operations when deploying a tenant):

:::row:::
  :::column:::
    **Storage usage**
  :::column-end:::
  :::column:::
    **Mount name**
  :::column-end:::
  :::column:::
    **Volume**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA data
  :::column-end:::
  :::column:::
    `/hana/data/SID/mnt0000<m>`
  :::column-end:::
  :::column:::
    Storage IP:/hana\_data\_SID\_mnt00001\_tenant\_vol
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA log
  :::column-end:::
  :::column:::
    `/hana/log/SID/mnt0000<m>`
  :::column-end:::
  :::column:::
    Storage IP:/hana\_log\_SID\_mnt00001\_tenant\_vol
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA log backup
  :::column-end:::
  :::column:::
    `/hana/log/backups`
  :::column-end:::
  :::column:::
    Storage IP:/hana\_log\_backups\_SID\_mnt00001\_tenant\_vol
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    HANA shared
  :::column-end:::
  :::column:::
    `/hana/shared/SID`
  :::column-end:::
  :::column:::
    Storage IP:/hana\_shared\_SID\_mnt00001\_tenant\_vol/shared
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    usr/sap
  :::column-end:::
  :::column:::
    `/usr/sap/SID`
  :::column-end:::
  :::column:::
    Storage IP:/hana\_shared\_SID\_mnt00001\_tenant\_vol/usr\_sap
  :::column-end:::
:::row-end:::


HANA **usr/sap** share the same volume. The nomenclature of the mountpoints includes the system ID of the HANA instances as well as the mount number. In scale-up deployments, there is only one mount, such as mnt00001. In scale-out deployments, on the other hand, you see as many mounts as you have worker and leading nodes.

For scale-out environments, data, log, and log backup volumes are shared and attached to each node in the scale-out configuration. For configurations that are multiple SAP instances, a different set of volumes is created and attached to the HANA Large Instance unit.

When you look at a HANA Large Instance unit, you realize that the units come with generous disk volume for HANA/data and that there is a volume HANA/log/backup. The reason that the HANA/data so large is that the storage snapshots offered to customers are using the same disk volume. The more storage snapshots you perform, the more space is consumed by snapshots in your assigned storage volumes.

The HANA/log/backup volume is not supposed to be the volume for database backups. It is sized to be used as the backup volume for the HANA transaction log backups. For more information, see SAP HANA (Large Instances) high availability and disaster recovery on Azure.

In addition to the storage that's provided, you can purchase additional storage capacity in 1 TB increments. This additional storage can be added as new volumes to a HANA Large Instance.

During onboarding with SAP HANA on Azure Service Management, the customer specifies a user ID (UID) and group ID (GID) for the sidadm user and sapsys group (for example: 1000,500). During installation of the SAP HANA system, you must use these same values. Because you want to deploy multiple HANA instances on a unit, you get multiple sets of volumes (one set for each instance). As a result, at deployment time you need to define the following:

 -  The SID of the different HANA instances (sidadm is derived from it).
 -  The memory sizes of the different HANA instances. The memory size per instance defines the size of the volumes in each individual volume set.

Based on storage provider recommendations, the following mount options are configured for all mounted volumes (excludes boot LUN):

`nfs rw, vers=4, hard, timeo=600, rsize=1048576, wsize=1048576, intr, noatime, lock 0 0`

These mount points are configured in /etc/fstab

The storage controller and nodes in the Large Instance stamps are synchronized to NTP servers. When you synchronize the SAP HANA on Azure (Large Instances) units and Azure VMs against an NTP server, there should be no significant time drift between the infrastructure and the compute units in Azure or Large Instance stamps.

To optimize SAP HANA to the storage used underneath, set the following SAP HANA configuration parameters:

 -  max\_parallel\_io\_requests 128
 -  async\_read\_submit on
 -  async\_write\_submit\_active on
 -  async\_write\_submit\_blocks all

For SAP HANA 1.0 versions up to SPS12, these parameters can be set during the installation of the SAP HANA database, as described in [SAP Note \#2267798](https://launchpad.support.sap.com/#/notes/2267798). You can also configure the parameters after the SAP HANA database installation by using the hdbparam framework.

The storage used in HANA Large Instances has a file size limitation. The size limitation is 16 TB per file. Unlike in file size limitations in the EXT3 file systems, HANA is not aware implicitly of the storage limitation enforced by the HANA Large Instances storage. As a result, HANA will not automatically create a new data file when the file size limit of 16TB is reached. As HANA attempts to grow the file beyond 16 TB, HANA will report errors and the index server will crash at the end.

To prevent HANA from trying to grow data files beyond the 16 TB file size limit of HANA Large Instance storage, you need to set the following parameters in the SAP HANA global.ini configuration file

 -  datavolume\_striping=true
 -  datavolume\_striping\_size\_gb = 15000
 -  See also [SAP Note \#2400005](https://launchpad.support.sap.com/#/notes/2400005)
 -  Be aware of [SAP Note \#2631285](https://launchpad.support.sap.com/#/notes/2631285)

With SAP HANA 2.0, the hdbparam framework has been deprecated. As a result, the parameters must be set by using SQL commands. For more information, see [SAP Note \#2399079](https://launchpad.support.sap.com/#/notes/2399079).

> [!NOTE]
> When deploying SAP HANA on Azure (Large Instances), take into account the exceptions documented at [SAP HANA (Large Instances) network architecture](https://docs.microsoft.com/azure/virtual-machines/workloads/sap/hana-network-architecture#networking-architecture-for-hana-large-instance)
