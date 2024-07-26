For on-premises development, you can use either HANA System Replication or use shared storage to establish high availability for SAP HANA. On Azure Virtual Machines, HANA System Replication on Azure is currently the only supported high availability function. SAP HANA Replication consists of one primary node and at least one secondary node. Changes to the data on the primary node are replicated to the secondary node synchronously or asynchronously.

:::image border="false" type="content" source="../media/sap-hana-high-availability-overview-c1c1ac0b.png" alt-text="Diagram showing an overview of S A P HANA high availability.":::

The following steps describe how to deploy and configure Azure Virtual Machines running SUSE Linux Enterprise Server, install the cluster framework, and install and configure SAP HANA System Replication. In the example configurations, installation commands, instance number 03, and HANA System ID HN1 are used. Consult the article [SAP HANA scale-out with HSR and Pacemaker on SLES](/azure/sap/workloads/sap-hana-high-availability-scale-out-hsr-suse) for the latest detailed steps.

For instructions regarding the equivalent procedure for Azure Virtual Machines running Red Hat Enterprise Linux, refer to [High availability of SAP HANA on Azure Virtual Machines on Red Hat Enterprise Linux](/azure/virtual-machines/workloads/sap/sap-hana-high-availability-rhel)

To achieve high availability, SAP HANA is installed on two virtual machines. The data is replicated by using HANA System Replication.

SAP HANA System Replication setup uses a dedicated virtual hostname and virtual IP addresses. On Azure, a load balancer is required to use a virtual IP address. The following list shows the configuration of the load balancer:

- Front-end configuration: IP address 10.0.0.13 for hn1-db
- Back-end configuration: Connected to primary network interfaces of all virtual machines that should be part of HANA System Replication
- Probe Port: Port 62503
- Load-balancing rules: 30313 TCP, 30315 TCP, 30317 TCP

## Deploy Azure resources

The resource agent for SAP HANA is included in SUSE Linux Enterprise Server for SAP Applications. The Azure Marketplace contains an image for SUSE Linux Enterprise Server for SAP Applications 12 that you can use to deploy new virtual machines.

## Deploy with a template

You can use one of the quickstart templates that are on GitHub to deploy all the required resources. To deploy the template, follow these steps:

1. Open the database template or the converged template on the Azure portal. The database template creates the load-balancing rules for a database only. The converged template also creates the load-balancing rules for an ASCS/SCS and ERS (Linux only) instance. If you plan to install an SAP NetWeaver-based system and you want to install the ASCS/SCS instance on the same machines, use the converged template.
2. Enter the following parameters:

     - **Sap System ID**: Enter the SAP system ID of the SAP system you want to install. The ID is used as a prefix for the resources that are deployed.
     - **Stack Type**: (This parameter is applicable only if you use the converged template.) Select the SAP NetWeaver stack type.
     - **Os Type**: Select one of the Linux distributions. For this example, select **SLES 12**.
     - **Db Type**: Select **HANA**.
     - **Sap System Size**: Enter the number of SAPS that the new system is going to provide. If you're not sure how many SAPS the system requires, ask your SAP Technology Partner or System Integrator.
     - **System Availability**: Select **HA**.
     - **Admin Username and Admin Password**: A new administrative user account that can be used to sign in to the operating system.
     - **New Or Existing Subnet**: Determines whether a new virtual network and subnet should be created or an existing subnet used. If you already have a virtual network connected to your on-premises network, select Existing.
     - **Subnet ID**: If you want to deploy the virtual machine into an existing virtual network where you have a subnet defined the virtual machine should be assigned to, name the ID of that specific subnet. The ID usually looks like: `/subscriptions/subscription ID/resourceGroups/resource group name/providers/Microsoft.Network/virtualNetworks/virtual network name/subnets/subnet name`

## Manual deployment (via the Azure portal)

1. **Create a resource group**.
2. **Create a virtual network**.
3. **Create an availability set**.

     - Set the max update domains.
4. **Create a load balancer (internal)**.

     - Select the virtual network created in step 2.
5. **Create virtual machine 1**.

     - Use a SLES4SAP image in the Azure gallery supported for SAP HANA on the virtual machine type you selected.
     - Select the availability set created in step 3.
6. **Create virtual machine 2**.

     - Use a SLES4SAP image in the Azure gallery supported for SAP HANA on the virtual machine type you selected.
     - Select the availability set created in step 3.
7. **Add data disks**.
8. **Configure the load balancer. First, create a front-end IP pool**:

     - Open the load balancer in the Azure portal, select frontend IP pool, and select Add.
     - Enter the name of the new front-end IP pool (for example, hana-frontend).
     - Set the Assignment to Static and enter the IP address (for example, 10.0.0.13).
     - After the new front-end IP pool is created, note the pool IP address.
9. **Next, create a back-end pool**:

     - Open the load balancer, select backend pools, and select Add.
     - Enter the name of the new back-end pool (for example, hana-backend).
     - Select Add a virtual machine.
     - Select the availability set created in step 3.
     - Select the virtual machines of the SAP HANA cluster.
10. **Next, create a health probe**:

     - Open the load balancer, select health probes, and select **Add**
     - Enter the name of the new health probe (for example, hana-hp).
     - Select TCP as the protocol and port 62503. Keep the Interval value set to 5, and the Unhealthy threshold value set to 2.
     - Select **OK**.
11. **For SAP HANA 1.0, create the load-balancing rules**:

     - Open the load balancer, select load balancing rules, and select **Add**
     - Enter the name of the new load balancer rule (for example, hana-lb-30315).
     - Select the front-end IP address, the back-end pool, and the health probe that you created earlier (for example, hana-frontend).
     - Keep the Protocol set to TCP, and enter port 30315.
     - Increase the idle timeout to 30 minutes.
     - Make sure to enable Floating IP.
     - Repeat these steps for port 30317.
12. **For SAP HANA 2.0, create the load-balancing rules for the system database**:

     - Open the load balancer, select load balancing rules, and select Add
     - Enter the name of the new load balancer rule (for example, hana-lb-30313).
     - Select the front-end IP address, the back-end pool, and the health probe that you created earlier (for example, hana-frontend).
     - Keep the Protocol set to TCP, and enter port 30313.
     - Increase the idle timeout to 30 minutes.
     - Make sure to enable Floating IP.
     - Repeat these steps for port 30314.
13. **For SAP HANA 2.0, first create the load-balancing rules for the tenant database**:

     - Open the load balancer, select load balancing rules, and select Add
     - Enter the name of the new load balancer rule (for example, hana-lb-30340).
     - Select the frontend IP address, backend pool, and health probe you created earlier (for example, HANA-frontend).
     - Keep the Protocol set to TCP, and enter port 30340.
     - Increase the idle timeout to 30 minutes.
     - Make sure to enable Floating IP.
     - Repeat these steps for ports 30341 and 30342.

For more information about the required ports for SAP HANA, see [SAP Note \#2388694](https://me.sap.com/notes/2388694).

> [!IMPORTANT]
> Don't enable TCP timestamps on Azure Virtual Machines placed behind Azure load balancer. Enabling TCP timestamps will cause the health probes to fail. Set parameter net.ipv4.tcp\_timestamps to 0.

## Create a Pacemaker cluster

Follow the steps in [Setting up Pacemaker on Red Hat Enterprise Linux in Azure](/azure/virtual-machines/workloads/sap/high-availability-guide-rhel-pacemaker) to create a basic Pacemaker cluster for this HANA server. You can use the same Pacemaker cluster for SAP HANA and SAP NetWeaver (A)SCS.

## Install SAP HANA

**The steps in this section use the following prefixes:** 

- **\[A\]**: The step applies to all nodes.
- **\[1\]**: The step applies to node 1 only.
- **\[2\]**: The step applies to node 2 of the Pacemaker cluster only.



1. **\[A\]** Set up the disk layout by using Logical Volume Manager (LVM). We recommend that you use LVM for volumes that store data and log files. The following example assumes that the Azure Virtual Machines has four data disks attached that are used to create two volumes.

     - List all of the available disks

   ```bash
    ls /dev/disk/azure/scsi1/lun*
    ```

     - Create physical volumes for all of the disks that you want to use

   ```bash
    sudo pvcreate /dev/disk/azure/scsi1/lun0
    sudo pvcreate /dev/disk/azure/scsi1/lun1
    sudo pvcreate /dev/disk/azure/scsi1/lun2
    sudo pvcreate /dev/disk/azure/scsi1/lun3
    ```

     - Create a volume group for the data files. Use one volume group for the log files and one for the shared directory of `SAP HANA:\`

   ```bash
    sudo vgcreate vg_hana_data_HN1 /dev/disk/azure/scsi1/lun0 /dev/disk/azure/scsi1/lun1
    sudo vgcreate vg_hana_log_HN1 /dev/disk/azure/scsi1/lun2
    ```

     - Create the logical volumes.

    A linear volume is created when you use `lvcreate` without the `-i` switch. We suggest that you create a striped volume for better I/O performance, and align the stripe sizes to the values documented in [SAP HANA VM storage configurations](./hana-vm-operations-storage.md). The `-i` argument should be the number of the underlying physical volumes and the `-I` argument is the stripe size. In this document, two physical volumes are used for the data volume, so the `-i` switch argument is set to **2**. The stripe size for the data volume is **256 KiB**. One physical volume is used for the log volume, so no `-i` or `-I` switches are explicitly used for the log volume commands.  

    > [!IMPORTANT]
    > Use the `-i` switch and set it to the number of the underlying physical volume when you use more than one physical volume for each data or log volumes. Use the `-I` switch to specify the stripe size, when creating a striped volume.  
    > See [SAP HANA VM storage configurations](./hana-vm-operations-storage.md) for recommended storage configurations, including stripe sizes and number of disks.  

    ```bash
    sudo lvcreate -i 2 -I 256 -l 100%FREE -n hana_data vg_hana_data_HN1
    sudo lvcreate -l 100%FREE -n hana_log vg_hana_log_HN1
    sudo mkfs.xfs /dev/vg_hana_data_HN1/hana_data
    sudo mkfs.xfs /dev/vg_hana_log_HN1/hana_log
    ```

     - Create the mount directories and copy the UUID of all of the logical volumes

    ```bash
    sudo mkdir -p /hana/data/HN1
    sudo mkdir -p /hana/log/HN1
    sudo mkdir -p /hana/shared/HN1
    # Write down the ID of /dev/vg_hana_data_HN1/hana_data, /dev/vg_hana_log_HN1/hana_log, and /dev/vg_hana_shared_HN1/hana_shared
    sudo blkid
    ```

     - Create fstab entries for the three logical volumes

    ```bash
    sudo vi /etc/fstab
    ```

     - Insert the following line in the **/etc/fstab** file:

    ```bash
    /dev/disk/by-uuid/UUID of /dev/mapper/vg_hana_data_HN1-hana_data /hana/data/HN1 xfs  defaults,nofail  0  2
    /dev/disk/by-uuid/UUID of /dev/mapper/vg_hana_log_HN1-hana_log /hana/log/HN1 xfs  defaults,nofail  0  2
    ```

     - Mount the new volumes:

    ```bash
    sudo mount -a
    ```

2. **\[A\]** Set up the disk layout:

     - For demo systems, you can place your HANA data and log files on one disk. Create a partition on /dev/disk/azure/scsi1/lun0 and format it with xfs:

    ```bash
    sudo sh -c 'echo -e "n\n\n\n\n\nw\n" | fdisk /dev/disk/azure/scsi1/lun0'
    sudo mkfs.xfs /dev/disk/azure/scsi1/lun0-part1
    # Write down the ID of /dev/disk/azure/scsi1/lun0-part1
    sudo /sbin/blkid
    sudo vi /etc/fstab
    ```

     - Insert this line in the **/etc/fstab** file:

    ```bash
    /dev/disk/by-uuid/[UUID] /hana xfs defaults,nofail 0 2
    ```

     - Create the target directory and mount the disk:

    ```bash
    sudo mkdir /hana
    sudo mount -a
    ```

3. **\[A\]** Setup host name resolution for all hosts. You can either use a DNS server or modify the /etc/hosts file on all nodes.
4. **\[A\]** Install the SAP HANA high availability packages

    ```bash
    sudo zypper install SAPHanaSR
    ```

5. **\[A\]** Run the hdblcm program from the HANA installation media. Enter the following values at the prompt:

     - Choose installation: Enter 1.
     - Elect other components for installation: Enter 1.
     - Enter Installation Path \[/hana/shared\]: Select Enter.
     - Enter Local Host Name \[..\]: Select Enter.
     - Do you want to add extra hosts to the system? (y/n) \[n\]: Select Enter.
     - Enter SAP HANA System ID: Enter the SID of HANA, for example: HN1.
     - Enter Instance Number \[00\]: Enter the HANA Instance number. Enter 03 if you used the Azure template or followed the manual deployment section of this article.
     - Select Database Mode / Enter Index **\[1\]**: Select Enter.
     - Select System Usage / Enter Index \[4\]: Select the system usage value.
     - Enter Location of Data Volumes \[/hana/data/HN1\]: Select Enter.
     - Enter Location of Log Volumes \[/hana/log/HN1\]: Select Enter.
     - Restrict maximum memory allocation? \[n\]: Select Enter.
     - Enter Certificate Host Name For Host '...' \[...\]: Select Enter.
     - Enter SAP Host Agent User (sapadm) Password: Enter the host agent user password.
     - Confirm SAP Host Agent User (sapadm) Password: Enter the host agent user password again to confirm.
     - Enter System Administrator (hdbadm) Password: Enter the system administrator password.
     - Confirm System Administrator (hdbadm) Password: Enter the system administrator password again to confirm.
     - Enter System Administrator Home Directory \[/usr/sap/HN1/home\]: Select Enter.
     - Enter System Administrator sign in Shell \[/bin/sh\]: Select Enter.
     - Enter System Administrator User ID \[1001\]: Select Enter.
     - Enter ID of User Group (sapsys) \[79\]: Select Enter.
     - Enter Database User (SYSTEM) Password: Enter the database user password.
     - Confirm Database User (SYSTEM) Password: Enter the database user password again to confirm.
     - Restart system after machine reboot? \[n\]: Select Enter.
     - Do you want to continue? (y/n): Validate the summary. Enter y to continue.
6. **\[A\]** Upgrade the SAP Host Agent. Download the latest SAP Host Agent archive from the SAP Software Center and run the following command to upgrade the agent. Replace the path to the archive to point to the file that you downloaded:

    ```bash
    sudo /usr/sap/hostctrl/exe/saphostexec -upgrade -archive [path to SAP Host Agent SAR]
    ```

## Configure SAP HANA 2.0 System Replication

1. **\[1\]** Create the tenant database. If you're using SAP HANA 2.0 or MDC, create a tenant database for your SAP NetWeaver system. Replace NW1 with the SID of your SAP system. Execute the following command as `hanasidadm`:

    ```bash
    hdbsql -u SYSTEM -p "passwd" -i 03 -d SYSTEMDB 'CREATE DATABASE NW1 SYSTEM USER PASSWORD "passwd"'
    ```

2. **\[1\]** Configure System Replication on the first node:

     - Back up the databases as `hanasidadm`:

    ```bash
    hdbsql -d SYSTEMDB -u SYSTEM -p "passwd" -i 03 "BACKUP DATA USING FILE ('initialbackupSYS')"
    hdbsql -d HN1 -u SYSTEM -p "passwd" -i 03 "BACKUP DATA USING FILE ('initialbackupHN1')"
    hdbsql -d NW1 -u SYSTEM -p "passwd" -i 03 "BACKUP DATA USING FILE ('initialbackupNW1')"
    ```

     - Copy the system PKI files to the secondary site:

    ```bash
    scp /usr/sap/HN1/SYS/global/security/rsecssfs/data/SSFS_HN1.DAT hn1-db-1:/usr/sap/HN1/SYS/global/security/rsecssfs/data/
    scp /usr/sap/HN1/SYS/global/security/rsecssfs/key/SSFS_HN1.KEY hn1-db-1:/usr/sap/HN1/SYS/global/security/rsecssfs/key/
    ```

     - Create the primary site:

    ```bash
    hdbnsutil -sr_enable --name=SITE1
    ```

3. **\[2\]** Configure System Replication on the second node. Register the second node to start the system replication. Run the following commands as `hanasidadm`administrator:

   ```bash
    sapcontrol -nr 03 -function StopWait 600 10
    hdbnsutil -sr_register --remoteHost=hn1-db-0 --remoteInstance=03 --replicationMode=sync --name=SITE2
    ```

## Configure SAP HANA 1.0 System Replication

1. **\[1\]** Create the required users. Run the following command as root:

   ```bash
    PATH="$PATH:/usr/sap/HN1/HDB03/exe"
    hdbsql -u system -i 03 'CREATE USER hdbhasync PASSWORD "passwd"'
    hdbsql -u system -i 03 'GRANT DATA ADMIN TO hdbhasync'
    hdbsql -u system -i 03 'ALTER USER hdbhasync DISABLE PASSWORD LIFETIME'
    ```

2. **\[A\]** Create the keystore entry. Run the following command as root to create a new keystore entry:

   ```bash
    PATH="$PATH:/usr/sap/HN1/HDB03/exe"
    hdbuserstore SET hdbhaloc localhost:30315 hdbhasync passwd
    ```

3. **\[1\]** Back up the database.

     - Back up the databases as root:

   ```bash
    PATH="$PATH:/usr/sap/HN1/HDB03/exe"
    hdbsql -d SYSTEMDB -u system -i 03 "BACKUP DATA USING FILE ('initialbackup')"
    ```

     - If you use a multitenant installation, also back up the tenant database:

   ```bash
    hdbsql -d HN1 -u system -i 03 "BACKUP DATA USING FILE ('initialbackup')"
    ```

4. **\[1\]** Configure System Replication on the first node. Create the primary site as `hanasidadm` :

   ```bash
    su - hdbadm
    hdbnsutil -sr_enable –-name=SITE1
    ```

5. **\[2\]** Configure System Replication on the secondary node. Register the secondary site as `hanasidadm`:

   ```bash
    sapcontrol -nr 03 -function StopWait 600 10
    hdbnsutil -sr_register --remoteHost=hn1-db-0 --remoteInstance=03 --replicationMode=sync --name=SITE2
    ```

## Create SAP HANA cluster resources

1. First, create the HANA topology. Run the following commands on one of the Pacemaker cluster nodes:

   ```bash
    sudo crm configure property maintenance-mode=true
    # Replace the bold string with your instance number and HANA system ID
    sudo crm configure primitive rsc_SAPHanaTopology_HN1_HDB03 ocf:suse:SAPHanaTopology \
    operations \$id="rsc_sap2_HN1_HDB03-operations" \
    op monitor interval="10" timeout="600" \
    op start interval="0" timeout="600" \
    op stop interval="0" timeout="300" \
    params SID="HN1" InstanceNumber="03"
    sudo crm configure clone cln_SAPHanaTopology_HN1_HDB03 rsc_SAPHanaTopology_HN1_HDB03 \
    meta is-managed="true" clone-node-max="1" target-role="Started" interleave="true"
    ```

2. Next, create the HANA resources.

   > [!NOTE]
   > This article contains references to the term *slave*, a term that Microsoft no longer uses. When the term is removed from the software, we'll remove it from this article.

   ```bash
    # Replace the bold string with your instance number, HANA system ID, and the front-end IP address of the Azure load balancer.
    
    sudo crm configure primitive rsc_SAPHana_HN1_HDB03 ocf:suse:SAPHana \
    operations \$id="rsc_sap_HN1_HDB03-operations" \
    op start interval="0" timeout="3600" \
    op stop interval="0" timeout="3600" \
    op promote interval="0" timeout="3600" \
    op monitor interval="60" role="Master" timeout="700" \
    op monitor interval="61" role="Slave" timeout="700" \
    params SID="HN1" InstanceNumber="03" PREFER_SITE_TAKEOVER="true" \
    DUPLICATE_PRIMARY_TIMEOUT="7200" AUTOMATED_REGISTER="false"
    sudo crm configure ms msl_SAPHana_HN1_HDB03 rsc_SAPHana_HN1_HDB03 \
    meta is-managed="true" notify="true" clone-max="2" clone-node-max="1" \
    target-role="Started" interleave="true"
    sudo crm configure primitive rsc_ip_HN1_HDB03 ocf:heartbeat:IPaddr2 \
    meta target-role="Started" is-managed="true" \
    operations \$id="rsc_ip_HN1_HDB03-operations" \
    op monitor interval="10s" timeout="20s" \
    params ip="10.0.0.13"
    sudo crm configure primitive rsc_nc_HN1_HDB03 anything \
    params binfile="/usr/bin/nc" cmdline_options="-l -k 62503" \
    op monitor timeout=20s interval=10 depth=0
    sudo crm configure group g_ip_HN1_HDB03 rsc_ip_HN1_HDB03 rsc_nc_HN1_HDB03
    sudo crm configure colocation col_saphana_ip_HN1_HDB03 4000: g_ip_HN1_HDB03:Started \
    msl_SAPHana_HN1_HDB03:Master
    sudo crm configure order ord_SAPHana_HN1_HDB03 Optional: cln_SAPHanaTopology_HN1_HDB03 \
    msl_SAPHana_HN1_HDB03
    # Clean up the HANA resources. The HANA resources might have failed because of a known issue.
    sudo crm resource cleanup rsc_SAPHana_HN1_HDB03
    sudo crm configure property maintenance-mode=false
    sudo crm configure rsc_defaults resource-stickiness=1000
    sudo crm configure rsc_defaults migration-threshold=5000
    ```

3. Make sure that the cluster status is ok and that all of the resources are started. It isn't important on which node the resources are running.

   ```bash
    sudo crm_mon -r
    # Online: [ hn1-db-0 hn1-db-1 ]
    #
    # Full list of resources:
    #
    # stonith-sbd (stonith:external/sbd): Started hn1-db-0
    # rsc_st_azure (stonith:fence_azure_arm): Started hn1-db-1
    # Clone Set: cln_SAPHanaTopology_HN1_HDB03 [rsc_SAPHanaTopology_HN1_HDB03]
    # Started: [ hn1-db-0 hn1-db-1 ]
    # Master/Slave Set: msl_SAPHana_HN1_HDB03 [rsc_SAPHana_HN1_HDB03]
    # Masters: [ hn1-db-0 ]
    # Slaves: [ hn1-db-1 ]
    # Resource Group: g_ip_HN1_HDB03
    # rsc_ip_HN1_HDB03 (ocf::heartbeat:IPaddr2): Started hn1-db-0
    # rsc_nc_HN1_HDB03 (ocf::heartbeat:anything): Started hn1-db-0
    ```

## Add an HSR third site to a HANA Pacemaker cluster

SAP HANA supports system replication (HSR) with more than two sites connected. You can add a third site to an existing HSR pair, managed by Pacemaker in a highly available setup. You can [add an HSR third site to a HANA Pacemaker cluster](/sap/workloads/disaster-recovery-sap-hana) in a second Azure region for disaster recovery (DR) purposes. Both SUSE Linux Enterprise Server (SLES) and RedHat Enterprise Linux (RHEL) specifics are covered.

Pacemaker and the HANA cluster resource agent manage the first two sites. The Pacemaker cluster doesn't control the third site.

SAP HANA supports a third system replication site in two modes:

- [Multitarget](https://help.sap.com/docs/SAP_HANA_PLATFORM/6b94445c94ae495c83a19646e7c3fd56/ba457510958241889a459e606bbcf3d3.html) replicates data changes from primary to more than one target system. The third site is connected to primary replication in a star topology.
- [Multitier](https://help.sap.com/docs/SAP_HANA_PLATFORM/6b94445c94ae495c83a19646e7c3fd56/f730f308fede4040bcb5ccea6751e74d.html) is a two-tier replication. A cascading, or chained, set up of three different HANA tiers. The third site connects to the secondary.

For more conceptual details about HANA HSR within one region and across different regions, see [SAP HANA availability across Azure regions](/sap/workloads/sap-hana-availability-across-regions#combine-availability-within-one-region-and-across-regions).

## Test the cluster setup

1. Test the migration. Before you start the test, make sure that Pacemaker doesn't have any failed action (via crm\_mon -r), there are no unexpected location constraints (for example leftovers of a migration test) and that HANA is sync state, for example with 'SAPHanaSR-showAttr':

   ```bash
    aspx-csharp
    SAPHanaSR-showAttr
    ```

     - You can migrate the SAP HANA master node by executing the following command:

   ```bash
    crm resource migrate msl_SAPHana_HN1_HDB03 hn1-db-1
    ```

     - If you set AUTOMATED\_REGISTER="false", this sequence of commands should migrate the SAP HANA master node and the group that contains the virtual IP address to hn1-db-1. Once the migration is done, the crm\_mon -r output looks like this:

   ```bash
    Online: [ hn1-db-0 hn1-db-1 ]
    
    Full list of resources:
    
    stonith-sbd (stonith:external/sbd): Started hn1-db-1
    
    Clone Set: cln_SAPHanaTopology_HN1_HDB03 [rsc_SAPHanaTopology_HN1_HDB03]
    
    Started: [ hn1-db-0 hn1-db-1 ]
    
    Master/Slave Set: msl_SAPHana_HN1_HDB03 [rsc_SAPHana_HN1_HDB03]
    
    Masters: [ hn1-db-1 ]
    
    Stopped: [ hn1-db-0 ]
    
    Resource Group: g_ip_HN1_HDB03
    
    rsc_ip_HN1_HDB03 (ocf::heartbeat:IPaddr2): Started hn1-db-1
    
    rsc_nc_HN1_HDB03 (ocf::heartbeat:anything): Started hn1-db-1
    
    Failed Actions:
    
    
    * rsc_SAPHana_HN1_HDB03_start_0 on hn1-db-0 'not running' (7): call=84, status=complete, exitreason='none',
    
    last-rc-change='Mon Aug 13 11:31:37 2018', queued=0ms, exec=2095ms
    ```

     - The SAP HANA resource on hn1-db-0 fails to start as secondary. In this case, configure the HANA instance as secondary by executing this command:

   ```bash
    su - hn1adm
    
    # Stop the HANA instance just in case it's running
    
    hn1adm@hn1-db-0:/usr/sap/HN1/HDB03> sapcontrol -nr 03 -function StopWait 600 10
    
    hn1adm@hn1-db-0:/usr/sap/HN1/HDB03> hdbnsutil -sr_register --remoteHost=hn1-db-1 --remoteInstance=03 --replicationMode=sync --name=SITE1
    ```

     - The migration creates location constraints that need to be deleted again:

   ```bash
    # Switch back to root and clean up the failed state
    
    exit
    
    hn1-db-0:~ # crm resource unmigrate msl_SAPHana_HN1_HDB03
    ```

     - You also need to clean up the state of the secondary node resource:

   ```bash
    hn1-db-0:~ # crm resource cleanup msl_SAPHana_HN1_HDB03 hn1-
    
    db-0
    ```

     - Monitor the state of the HANA resource using crm\_mon -r. Once HANA is started on hn1-db-0, the output should look like this:

   ```bash
    
    Online: [ hn1-db-0 hn1-db-1 ]
    
    Full list of resources:
    
    stonith-sbd (stonith:external/sbd): Started hn1-db-1
    
    Clone Set: cln_SAPHanaTopology_HN1_HDB03 [rsc_SAPHanaTopology_HN1_HDB03]
    
    Started: [ hn1-db-0 hn1-db-1 ]
    
    Master/Slave Set: msl_SAPHana_HN1_HDB03 [rsc_SAPHana_HN1_HDB03]
    
    Masters: [ hn1-db-1 ]
    
    Slaves: [ hn1-db-0 ]
    
    Resource Group: g_ip_HN1_HDB03
    
    rsc_ip_HN1_HDB03 (ocf::heartbeat:IPaddr2): Started hn1-db-1
    
    rsc_nc_HN1_HDB03 (ocf::heartbeat:anything): Started hn1-db-1
    ```

2. Test the Azure fencing agent (not SBD)

     - You can test the setup of the Azure fencing agent by disabling the network interface on the hn1-db-0 node:

   ```bash
    sudo ifdown eth0
    ```

     - The virtual machine should now restart or stop depending on your cluster configuration. If you set the stonith-action setting to off, the virtual machine is stopped and the resources are migrated to the running virtual machine.
     - After you start the virtual machine again, the SAP HANA resource fails to start as secondary if you set AUTOMATED\_REGISTER="false". In this case, configure the HANA instance as secondary by executing this command:

   ```bash
    su - hn1adm
    
    # Stop the HANA instance just in case it's running
    
    sapcontrol -nr 03 -function StopWait 600 10
    
    hdbnsutil -sr_register --remoteHost=hn1-db-1 --remoteInstance=03 --replicationMode=sync --name=SITE1
    
    # Switch back to root and clean up the failed state
    
    exit
    
    crm resource cleanup msl_SAPHana_HN1_HDB03 hn1-db-0
    ```

3. Test SBD fencing

     - You can test the setup of SBD by killing the inquisitor process.

   ```bash
    hn1-db-0:~ # ps aux | grep sbd
    
    root 1912 0.0 0.0 85420 11740 ? SL 12:25 0:00 sbd: inquisitor
    
    root 1929 0.0 0.0 85456 11776 ? SL 12:25 0:00 sbd: watcher: /dev/disk/by-id/scsi-360014056f268462316e4681b704a9f73 - slot: 0 - uuid: 7b862dba-e7f7-4800-92ed-f76a4e3978c8
    
    root 1930 0.0 0.0 85456 11776 ? SL 12:25 0:00 sbd: watcher: /dev/disk/by-id/scsi-360014059bc9ea4e4bac4b18808299aaf - slot: 0 - uuid: 5813ee04-b75c-482e-805e-3b1e22ba16cd
    
    root 1931 0.0 0.0 85456 11776 ? SL 12:25 0:00 sbd: watcher: /dev/disk/by-id/scsi-36001405b8dddd44eb3647908def6621c - slot: 0 - uuid: 986ed8f8-947d-4396-8aec-b933b75e904c
    
    root 1932 0.0 0.0 90524 16656 ? SL 12:25 0:00 sbd: watcher: Pacemaker
    
    root 1933 0.0 0.0 102708 28260 ? SL 12:25 0:00 sbd: watcher: Cluster
    
    root 13877 0.0 0.0 9292 1572 pts/0 S+ 12:27 0:00 grep sbd
    
    hn1-db-0:~ # kill -9 1912
    
    Cluster node hn1-db-0 should be rebooted. The Pacemaker service might not get started afterward. Make sure to start it again.
    ```

4. Test a manual failover

     You can test a manual failover by stopping the pacemaker service on the hn1-db-0 node:

   ```bash
    service pacemaker stop
    ```
    
    > [!Important]
    > When cluster nodes can't communicate to each other, there's a risk of a split-brain scenario. In such situations, cluster nodes will try to simultaneously fence each other, resulting in fence race.
    >
    > When configuring a fencing device, it's recommended to configure [`pcmk_delay_max`](https://www.suse.com/support/kb/doc/?id=000019110) property. So, in the event of split-brain scenario, the cluster introduces a random delay up to the `pcmk_delay_max` value, to the fencing action on each node. The node with the shortest delay will be selected for fencing.
    >
    > Additionally, to ensure that the node running the HANA master takes priority and wins the fence race in a split brain scenario, it's recommended to set  [`priority-fencing-delay`](https://documentation.suse.com/sle-ha/15-SP3/single-html/SLE-HA-administration/#pro-ha-storage-protect-fencing) property in the cluster configuration. By enabling priority-fencing-delay property, the cluster can introduce an additional delay in the fencing action specifically on the node hosting HANA master resource, allowing the node to win the fence race.
    
     After the failover, you can start the service again. If you set AUTOMATED\_REGISTER="false", the SAP HANA resource on the hn1-db-0 node fails to start as secondary. In this case, configure the HANA instance as secondary by executing this command:
    
   ```bash
    service pacemaker start
    
    su - hn1adm
    
    # Stop the HANA instance just in case it's running
    
    sapcontrol -nr 03 -function StopWait 600 10
    
    hdbnsutil -sr_register --remoteHost=hn1-db-1 --remoteInstance=03 --replicationMode=sync --name=SITE1
    
    # Switch back to root and clean up the failed state
    
    exit
    
    crm resource cleanup msl_SAPHana_HN1_HDB03 hn1-db-0
    ```

## SUSE tests

Run all test cases that are listed in the SAP HANA SR Performance Optimized Scenario or SAP HANA SR Cost Optimized Scenario guide, depending on your use case. The following tests are a copy of the test descriptions of the SAP HANA SR Performance Optimized Scenario from the [SUSE Linux Enterprise Server for SAP Applications 12 SP4 guide](https://www.suse.com/documentation/sles-for-sap-12/). For an up-to-date version, always also read the guide itself. Always make sure that HANA is in sync before starting the test and also make sure that the Pacemaker configuration is correct. In the following test descriptions, we assume PREFER\_SITE\_TAKEOVER="true" and AUTOMATED\_REGISTER="false". NOTE: The following tests are designed to run in sequence and depend on the exit state of the preceding tests.

- TEST 1: STOP PRIMARY DATABASE ON NODE 1
- TEST 2: STOP PRIMARY DATABASE ON NODE 2
- TEST 3: CRASH PRIMARY DATABASE ON NODE
- TEST 4: CRASH PRIMARY DATABASE ON NODE 2
- TEST 5: CRASH PRIMARY SITE NODE (NODE 1)
- TEST 6: CRASH SECONDARY SITE NODE (NODE 2)
- TEST 7: STOP THE SECONDARY DATABASE ON NODE 2
- TEST 8: CRASH THE SECONDARY DATABASE ON NODE 2
- TEST 9: CRASH SECONDARY SITE NODE (NODE 2) RUNNING SECONDARY HANA DATABASE

## Configure Pacemaker for Azure scheduled events

Azure offers [scheduled events](/azure/virtual-machines/linux/scheduled-events). Scheduled events are sent via the metadata service and allow time for the application to prepare for such events.

The Pacemaker resource agent `azure-events-az` monitors for scheduled Azure events. If events are detected and the resource agent determines that another cluster node is available, it sets a cluster health attribute.

When the cluster health attribute is set for a node, the location constraint triggers and all resources with names that don't start with `health-` are migrated away from the node with the scheduled event. After the affected cluster node is free of running cluster resources, the scheduled event is acknowledged and can execute its action, such as a restart. 

- [SUSE: Configure Pacemaker for Azure scheduled events](/sap/workloads/high-availability-guide-suse-pacemaker?tabs=msi#configure-pacemaker-for-azure-scheduled-events)
- [RHEL: Configure Pacemaker for Azure scheduled events](/sap/workloads/high-availability-guide-rhel-pacemaker?tabs=msi#configure-pacemaker-for-azure-scheduled-events)