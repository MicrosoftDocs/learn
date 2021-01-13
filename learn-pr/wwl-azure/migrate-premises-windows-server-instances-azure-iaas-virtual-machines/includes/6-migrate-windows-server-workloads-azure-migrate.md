

Having considered the workloads that they want to migrate, IT staff at Contoso are undertaking the implementation stage in the project. There are four main technical implementation steps involved in actually moving a server workload to an Azure VM workload using Azure Migrate:

1. Prepare Azure for the Azure Migrate: Server Migration tool.
2. Prepare the on-premises VMs for migration.
3. Replicate the on-premises VMs.
4. Migrate the VMs.

## Technical implementation

It's important to consider the steps involved in a technical implementation phase. These are outlined in this section.

![A screenshot of the Azure portal. The administrator has added Azure Migrate and selected the Azure Migrate: Server Migration tool.](../media/m15-azure-migrate-1.png)

**1. Prepare Azure for the Azure Migrate: Server Migration tool**

First, you require the following Azure components to migrate your on-premises VMs to Azure:

- A **VNet** in which Azure VMs are connected when they're created during migration.
- The **Azure Migrate: Server Migration** tool provisioned and configured.

Start the imported image and configure the tool using the following high-level steps:

1. Set up the prerequisites.
1. Point the tool to the Azure subscription.
1. Add any Windows-based credentials for discovery.

After configuration, it will take some time for the tool to enumerate all the VMs. After the enumeration is complete, they are listed in the Azure Migrate tool in Azure for your review.

**2. Prepare on-premises VMs**

After migration, you will connect to the Azure VMs and allow Azure to manage the VMs. To do this, perform the following procedure before migration:

- For access over the internet:
  - Enable Remote Desktop Protocol (RDP) or Secure Shell (SSH) on the on-premises VM before migration.
  - Ensure that Transmission Control Protocol (TCP) and User Datagram Protocol (UDP) rules are added for the Public profile.
  - Check that RDP or SSH is allowed in the OS firewall.
- For access over site-to-site virtual private network (site-to-site VPN):
  - Enable RDP or SSH on the on-premises VM before migration.
  - Check that RDP or SSH is allowed in the OS firewall.
  - For Windows, set the operating system's SAN policy on the on-premises VM to **OnlineAll**.
  - Install the Azure agent.
- Other considerations:
  - For the Windows OS, there should be no Windows updates pending on the VM when triggering a migration. If there are, you won't be able to sign in to the VM until the updates complete.
  - After migration, check boot diagnostics to access a screenshot of the VM.

**3. Replicate the on-premises VMs**

Before you can run a migration to Azure, you need to set up and enable replication. With discovery completed, you can begin replication of the VMs to Azure. Perform the following steps:

1. In the Azure Migrate project, select **Servers**, select **Azure Migrate: Server Migration**, and then select **Replicate**.
2. In **Replicate**, select **Source settings**, select **Are your machines virtualized?**, and then select **Yes**.
3. In **On-premises appliance**, select the name of the Azure Migrate appliance that you set up, and then enter **OK**.
4. In **Virtual machines**, select the VMs you want to replicate, taking into consideration the following:

   - If you've run an assessment for the VMs, you can apply VM sizing and disk type (premium/standard) recommendations from the assessment results. To do this, in **Import migration settings from an Azure Migrate assessment?**, select the **Yes** option.
   - If you didn't run an assessment or you don't want to use the assessment settings, select the **No** option.
   - If you selected to use the assessment, select the VM group and assessment name.

5. In **Virtual machines**, search for VMs as needed. Select each VM you want to migrate, and then select **Next: Target settings**.
6. In **Target settings**, select the Azure subscription and region to which you'll migrate, and then specify the resource group in which the Azure VMs will reside after migration.
7. In **Virtual Network**, select the Azure VNet/subnet to which the Azure VMs will be joined after migration.
8. In Azure Hybrid Benefit, select the following:
   - Select **No** if you don't want to apply Azure Hybrid Benefit, and then select **Next**.
   - Select **Yes** if you have Windows Server machines that are covered with active Software Assurance or Windows Server subscriptions and you want to apply the benefit to the machines you're migrating, and then select **Next**.

9. In **Compute**, review the VM name, size, OS disk type, and availability set. VMs must conform with Azure requirements.

   - **VM size**. If you're using assessment recommendations, the VM size dropdown list will contain the recommended size. Otherwise, Azure Migrate picks a size based on the closest match in the Azure subscription. Alternatively, pick a manual size in Azure VM size.
   - **OS disk**. Specify the OS (boot) disk for the VM. The OS disk is the disk that has the operating system bootloader and installer.
   - **Availability set**. If the VM should be in an Azure availability set after migration, specify the set. The set must be in the target resource group you specify for the migration.

10. In **Disks**, specify whether the VM disks should be replicated to Azure, select the disk type (standard SSD/HDD or premium-managed disks) in Azure, and then select **Next**.

    - You can exclude disks from replication.
    - If you exclude disks, they won't be present on the Azure VM after migration.

11. In **Review and start replication**, review the settings, and then select **Replicate** to start the initial replication for the servers.

**4. Migrate the VMs**

You should first run a quick test migration (followed by a full migration to migrate the VMs) by performing the following steps:

1. In **Migration goals**, select **Servers**, select **Azure Migrate: Server Migration**, and then select **Test migrated servers**.
1. Right-click or access the context menu for the VM to test, and then select **Test migrate**.
1. In **Test Migration**, select the Azure virtual network (VNet) in which the Azure VM will be located after the migration. We recommend you use a nonproduction VNet.
1. After the Test migration job starts, monitor the job in the Azure portal notifications.
1. After migration finishes, review the migrated Azure VM in Virtual Machines in the Azure portal. The machine name will have the suffix **-Test**.
1. After the test completes, right-click or access the context menu for the Azure VM in **Replicating machines**, and then select **Clean up test migration**.

This concludes the test migration. The following lists the full migration steps:

1. In the **Azure Migrate project**, choose **Servers**, select **Azure Migrate: Server Migration**, and then select **Replicating servers**.
2. In **Replicating machines**, right-click or access the context menu for **VM**, and then select **Migrate**.
3. In **Migrate**, select **Shut down virtual machines and perform a planned migration with no data loss**, select **Yes**, and then select **OK**.

> [!NOTE]
> By default, Azure Migrate shuts down the on-premises VM and runs an on-demand replication to synchronize any VM changes that occurred since the last replication occurred. This ensures no data loss. If you don't want to shut down the VM, select **No**.

4. When the migration job starts for the VM, track the job in Azure notifications.
5. After the job finishes, you can review and manage the VMs from the **Virtual Machines** blade.
