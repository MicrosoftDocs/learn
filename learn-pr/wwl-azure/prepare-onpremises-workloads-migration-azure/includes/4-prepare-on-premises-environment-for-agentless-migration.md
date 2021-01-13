After setting up Azure for the migration, you next confirm that your on-premises environment is ready for the Azure Migrate deployment. Evaluate your Hyper-V host system and the Hyper-V machines you plan to migrate and make any needed adjustments.

In this unit, you’ll review the requirements for migrating Hyper-V VMs with Azure Migrate: Server Migration.

## Verify Hyper-V host requirements

Remember that the first phase of your migration consists of a pilot to migrate a small subset of older Linux and Windows workloads hosted on a single Hyper-V host to Azure. The system uses a single Hyper-V host because of the relatively small number of machines and the absence of a high availability requirement. 

Future phases of the migration will consist of more complex configurations, including VMware ESXi clusters, but for the pilot migration, a standalone deployment of a Hyper-V host is sufficient. Make sure you assign administrator permissions on the Hyper-V host, and that the host operating system runs on Windows Server 2012 R2 or greater.

### URL and port access

Ensure you set up internet connectivity between the on-premises environment and Azure. The Hyper-V host needs access to specific Azure URLs and ports to complete the replication and migration process. During migration, Azure Migrate: Server Migration relies on the URLs to manage identity, coordinate data transfer, upload data to storage, log replication process, and ensure accurate system time synchronization. 

Make sure the Hyper-V host can access the following URLs:

- login.microsoftonline.com 
- *.backup.windowsazure.com
- *.blob.core.windows.net
- dc.services.visualstudio.com
- time.windows.com

Also, verify that the Hyper-V host has outbound connections enabled on HTTPS port 443 so that it can send VM replication data to Azure Migrate. Each VM will also need outbound connections on port 443.

## Verify Hyper-V VM settings

As part of preparing your on-premises environment, review the workloads themselves to confirm that your VMs meet the requirements for migration. You already gleaned most of this information during the assessment phase, so consider this review as a final checklist.

### Supported operating systems

You’re migrating Windows Server and Linux workloads but want to make sure that the server operating system versions can run in an Azure virtual machine environment. The VMs you intend to migrate run on Windows Server 2012 R2 Datacenter and Ubuntu 14.04LTS. With either operating system version, your VMs can run in Azure without needing any manual changes before migration.

Review the links in the summary unit to learn about Azure support for Windows and Linux operating systems.

### System startup

Azure Migrate automatically converts a VM using Unified Extensible Firmware Interface (UEFI) to a Binary Input Output System (BIOS) boot VM. All the workloads you plan to migrate are UEFI-based, and as a best practice, you’ve created backups of the VMs.

BIOS boot mode supports disk partitions of 2TB or less so plan to allocate up to five partitions per migrated OS disk, with an OS disk size of less than 300 GB.

### Disks

When you migrate your on-premises VMs, Azure converts unmanaged VM disks to managed disks. You can choose between a disk type of Standard SSD/HDD or premium-managed disks. For the workloads you plan to migrate in the pilot, Standard HDD disks provide sufficient capacity. In subsequent phases of the migration, where you will migrate larger and more complex workloads, many of the workloads will require premium managed disks.

## Azure VM requirements

When you replicate your on-premises VMs to Azure, Site Recovery runs a prerequisites check for replication. This check validates that replicated on-premises VMs meet the equivalent Azure VM requirements.

You have already verified that your workloads run on supported 64-bit operating systems.

Review the Azure VM requirements before you proceed with the migration and make any necessary adjustments to the on-premises VMs.

### Disks

Next determine how many data disks your Hyper VMs require to run in Azure, based on capacity and performance. Decide the desired maximum disk size and speed for your VMs and calculate the number of disks needed. Note that this can also impact your choice of VM size.

In Azure, you can have up to 64 data disks and disk size can be up to 4,095 GB. The disk configurations of the VMs selected for the migration pilot fall within those parameters.

Several of the Windows Server VMs you plan to migrate are protected with BitLocker Drive Encryption. Turn off BitLocker for those machines before you enable replication.

### Windows Server VMs

As you prepare your Hyper-V VMs, review this list to make sure you've taken these actions before migrating any Windows Server VMs to Azure.

> |**Action**|**Details**|
> |-|-|
> |Configure the SAN policy as Online All.|This ensures that Windows volumes in Azure VM use the same drive letter assignments as the on-premises VM. Automatically set in most cases, but may need to be manually configured for operating systems earlier than Windows Server 2008 R2.|
> |Enable Azure screen access console for the Azure VM|Use for troubleshooting. You don’t need to restart the VM as the Azure VM starts using the disk image.|
> |Enable Remote Desktop (RDP)|You need to connect to Azure VMs running Windows after migration. Check that Windows Firewall isn’t blocking RDP access on any network profiles.|


### Linux VMs

Review this list and perform any needed actions on any Linux Server VMs, before migrating them to Azure.

> |**Action**|**Details**|
> |-|-|
> |Install Hyper-V Linux Integration Services|Most new versions of Linux distributions include this by default|
> |Enable Azure serial console logging|Use for troubleshooting. You don’t need to restart the VM as the Azure VM starts using the disk image.|
> |Update device map file|Use persistent device identifiers for device name to volume associations|
> |Update fstab entries|Update entries to use persistent volume identifiers|
> |Remove udev rules|Remove rules that reserve interface names based on MAC addresses|
> |Update network interfaces|Ensure network interfaces can receive DHCP-based IP addresses|
> |Enable SSH|You need to connect to Azure VMs after migration using SSH. Set the sshd service to start automatically on system reboot. Check firewall rules allow an SSH connection.|