To use Azure Backup to protect your Azure virtual machines, you follow a simple three-step process: create a vault, define your backup options, and trigger the backup job.

:::image type="content" source="../media/backup-steps-97429b0d.png" alt-text="Illustration that shows the three basic steps to back up an Azure virtual machine by using Azure Backup." border="false":::

### Step 1. Create a Recovery Services vault

The first step is to create an Azure Recovery Services vault for your virtual machine backups. The vault must be created within your Azure subscription, and in the region where you want to store the data.

You also need to specify how you want your storage replicated, either geo-redundant (default) or locally redundant.

- **Geo-redundant** (GRS): (Default) Use GRS when Azure is your primary backup storage endpoint.

- **Locally redundant** (LRS): If Azure **isn't** your primary backup storage endpoint, use LRS to reduce your storage costs.

### Step 2. Define your backup policy options

After you create your vault, you need to define your backup policy. The policy specifies when to take the data snapshots, and how long to keep the snapshots. 

Your virtual machine is protected by taking snapshots of your data at defined intervals. The snapshots produce recovery points that are stored in your Recovery Services vault.

If it becomes necessary to repair or rebuild your virtual machine, you can restore your machine by using your saved recovery points. In your backup policy, you can specify to trigger a backup from one to five times per day.

### Step 3. Back up your virtual machine

The last step is to run the Azure Backup job process and create your backups.

To run the backup job, the Azure Backup extension requires the Microsoft Azure Virtual Machine Agent to be present on your Azure virtual machine.

- If your virtual machine was created from the Azure gallery, the agent is installed by default on your machine. 

- If your virtual machine was migrated from an on-premises data center, you need to manually install the agent on your machine.

For details, see [Install the Azure Virtual Machine Agent](/azure/virtual-machines/extensions/agent-windows#install-the-vm-agent).