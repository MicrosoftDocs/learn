This section covers:

- OS updates
- Disk setup
- Kernel parameters
- File systems
- The **/etc/hosts** file
- The **/etc/fstab** file

## OS updates

Check for Linux OS updates and fixes before you install extra software. By installing a patch, you might avoid a call to the support desk.

Make sure that you use:

- SUSE Linux Enterprise Server for SAP Applications.
- Red Hat Enterprise Linux for SAP Applications or Red Hat Enterprise Linux for SAP HANA.

Ensure you register the OS deployment with your Linux subscription from the Linux vendor. SUSE has OS images for SAP applications that already include services, and which are registered automatically.

Here's an example of how to check for available patches for SUSE Linux by using the zypper command:

`sudo zypper list-patches`

Depending on the kind of issue, patches are classified by category and severity.

Commonly used values for **category** are:

- `security`
- `recommended`
- `optional`
- `feature`
- `document`
- `yast`

Commonly used values for **severity** are:

- `critical`
- `important`
- `moderate`
- `low`
- `unspecified`

The zypper command looks only for the updates that your installed packages need. For example, you can use this command:

`sudo zypper patch --category=security,recommended --severity=critical,important`

You can add the parameter `--dry-run` to test the update without actually updating the system.

## Disk setup

The root file system in a Linux virtual machine on Azure has a size limitation. You need to attach extra disk space to an Azure Virtual Machine to run SAP. For SAP application server Azure Virtual Machines, the use of Azure standard storage disks might be enough. For SAP HANA DBMS Azure Virtual Machines, the use of Azure premium storage disks for production and nonproduction implementations is mandatory.

Based on the SAP HANA TDI storage requirements, the following Azure premium storage configuration is suggested:

| VM SKU | RAM | /hana/data and /hana/log striped with LVM or MDADM | /hana/shared | /root volume | /usr/sap |
|---|---|---|---|---|---|
| GS5 | 448 GB | 2 x P30 | 1 x P20 | 1 x P10 | 1 x P10 |

In the suggested disk configuration, the HANA data volume and log volume are placed on the same set of premium storage disks that are striped with LVM or MDADM. It isn't necessary to define any RAID redundancy level because Azure premium storage provides sufficient level of redundancy.

You can add more premium storage disks to the HANA DBMS virtual machines to store database or transaction log backups.

With Azure premium SSDs, you can define disk caching modes. For the striped set that holds **/hana/data** and **/hana/log**, disable disk caching. For the disks hosting other volumes, set the caching mode to ReadOnly.

> [!NOTE]
> It's important to attach the Azure storage disk by using a UUID.

## Kernel parameters

SAP HANA requires specific Linux kernel settings. These kernel settings aren't part of the standard Azure Marketplace images and must be set manually. Depending on whether you use SUSE or Red Hat, the parameters might be different.

SLES for SAP Applications 12 general availability and SLES for SAP Applications 12 SP1 have a new tool, tuned-adm that replaces the old sapconf tool. A special SAP HANA profile is available for tuned-adm. To tune the system for SAP HANA, set the following profile as a root user:

`tuned-adm profile sap-hana`

To make the SAP HANA kernel settings permanent, use grub2 on SLES 12. Another option is to change the settings by using YaST and the Boot Loader &gt; Kernel Parameters settings.

## File systems

The following screenshot shows two file systems that were created on the SAP app server virtual machine on top of the two attached Azure standard storage disks. Both file systems are of the type XFS and are mounted to /sapdata and /sapsoftware.

:::image type="content" source="../media/two-file-systems-sap-app-server-728cdf09.png" alt-text="Screenshot of output values for two file systems created on the S A P app server virtual machine on top of the two attached Azure standard storage disks.":::

It isn't mandatory to structure your file systems this way. You have other options for how to structure the disk space. The most important consideration is to prevent the root file system from running out of free space.

For the SAP HANA DB virtual machine, during a database installation, when you use SAPinst with SWPM and the typical installation option, everything is installed under **/hana** and **/usr/sap**. The default location for the SAP HANA log backup is under **/usr/sap**. Again, it's important to prevent the root file system from running out of storage space. Make sure that there's enough free space under **/hana** and **/usr/sap** before you install SAP HANA by using SWPM.

If during installation you receive a message that  there isn't sufficient swap space, you can manually configure a swap file by using dd, mkswap, and swapon. Another option is to configure swap space by using the Linux virtual machine agent as described earlier.

## The **/etc/hosts** file

Before you start to install SAP, make sure you include the host names and private IP addresses of the SAP virtual machines in the **/etc/hosts** file. Deploy all the SAP virtual machines within one Azure virtual network.

## The **/etc/fstab** file

It's helpful to add the `nofail` parameter to the **fstab** file. This way, if something goes wrong with the disks, the virtual machine doesn't stop responding in the boot process. But remember that extra disk space might not be available, and processes might fill up the root file system. If **/hana** is missing, SAP HANA can't start.
