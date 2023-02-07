Azure Backup uses the Microsoft Azure Recovery Services (MARS) agent to back up files, folders, and system data from your on-premises machines and Azure virtual machines. The MARS agent is a full-featured agent that offers many benefits for both backing up and restoring your data.

:::image type="content" source="../media/recovery-agent-354fbf08.png" alt-text="Screenshot of the MARS agent.":::

### Things to know about the MARS agent

Let's review some of the characteristics of the MARS agent.

- Azure Backup for files and folders relies on the MARS agent to be installed on your Windows client or Windows Server.

- The data that's available for backup depends on where you install and run the MARS agent.

- You can back up files and folders on Windows virtual machines or physical machines. Virtual machines can be on-premises or in Azure.

- The MARS agent doesn't require a separate backup server.

- The MARS agent isn't application-aware. You can restore files and folders from backups, or do a volume-level restore.

### Things to consider when using the MARS agent

You can deploy the MARS agent on any Windows Server virtual machine or physical machine. The data that's available for backup depends on where you run the MARS agent. There are several ways you can run the MARS agent.

| Backup scenario | MARS agent implementation |
| --- | --- |
| **Consider on-premises direct backup** | _Run the MARS agent on your on-premises Windows machines to back up your machine data directly to a Recovery Services vault in Azure_. |
| **Consider back up for specific files or folders** | _Run the MARS agent on Azure virtual machines to back up specific files and folders on your virtual machine. Your Azure virtual machines must run Windows side-by-side with the Azure Virtual Machines Backup extension_. |
| **Consider back up to MABS or System Center DPM** | _Run the MARS agent on a Microsoft Azure Backup Server (MABS) instance or a System Center Data Protection Manager (DPM) server. Back up your machines and workloads to MABS or DPM by using the MARS agent to back up to a Recovery Services vault in Azure_. |