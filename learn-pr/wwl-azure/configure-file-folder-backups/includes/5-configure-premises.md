There are several steps to configuring Azure backup of on-premises files and folders.

> [!NOTE]
> The Backup agent can be deployed on any Windows Server VM or physical machine.

:::image type="content" source="../media/file-folder-backup-6d3d3d1e.png" alt-text="Diagram showing the implementation steps discussed in the topic.":::


1.  **Create the recovery services vault**. Within your Azure subscription, you will need to create a recovery services vault for the backups.
2.  **Download the agent and credential file**. The recovery services vault provides a link to download the Azure Backup Agent. The Backup Agent will be installed on the local machine. There is also a credentials file that is required during the installation of the agent. You must have the latest version of the agent. Versions of the agent below 2.0.9083.0 must be upgraded by uninstalling and reinstalling the agent.
3.  **Install and register agent**. The installer provides a wizard to configure the installation location, proxy server, and passphrase information. The downloaded credential file will be used to register the agent.
4.  **Configure the backup**. Use the agent to create a backup policy including when to backup, what to backup, how long to retain items, and settings like network throttling.
