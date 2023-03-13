
Let's review how to use the MARS agent and Azure Backup to complete backups of your on-premises files and folders. The following diagram shows the high-level steps to use the MARS agent for Azure Backup.

:::image type="content" source="../media/file-folder-backup-6d3d3d1e.png" alt-text="Diagram that shows the steps to use the MARS agent for Azure Backup." border="false":::

### Step 1. Create Recovery Services vault

The first step is to create a Recovery Services vault for your backups. The vault must be created within your Azure subscription, as described in the [previous section](/training/modules/configure-file-folder-backups/4-setup-recovery-service-vault-backup-options).

### Step 2. Download MARS agent and credentials file

On the Backup center dashboard, the Recovery Services vault page provides a link to download the MARS agent (Recovery Services Agent). To complete the MARS agent installation, you also need to download the _vault credentials_ file. For details, see [Download the MARS agent](/azure/backup/install-mars-agent#download-the-mars-agent).

### Step 3. Install and register MARS agent

The MARS agent installer provides a wizard to configure the installation location, proxy server, and passphrase information. The downloaded credentials file is used to register the agent. The MARS agent is installed on your local machine.

> [!Important]
> You must install the latest version of the MARS agent. MARS agent versions earlier than 2.0.9083.0 must be upgraded by uninstalling and reinstalling the agent.

### Step 4. Configure backups

Now you're ready to use the MARS agent to create a backup policy. You can specify when to do the backup, what data to back up, how long to retain the backup items, and other settings such as network throttling.