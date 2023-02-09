The **Recovery Services vault** is a storage entity in Azure that stores data. Recovery Services vaults make it easy to organize your backup data, while minimizing management overhead.

### Things to know about Recovery Services vaults

Let's review some characteristics of Recovery Services vaults.

- The Recovery Services vault can be used to back up Azure Files file shares or on-premises files and folders.

- Recovery Services vaults store backup data for various Azure services, such as IaaS virtual machines (Linux or Windows) and Azure SQL databases.

- Recovery Services vaults support System Center Data Protection Manager, Windows Server, Azure Backup Server, and other services. 

- In the Azure portal, you can create a Recovery Services vault from the Backup center dashboard.

   :::image type="content" source="../media/create-vault.png" alt-text="Screenshot that shows how to create a Recovery Services vault in the Azure portal.":::

   To complete the initial configuration, you need to specify the subscription, resource group, and geographic region, along with a name to identify the vault.

   > [!Note]
   > Within an Azure subscription, you can create up to 500 Recovery Services vaults per region.

   It can take several minutes to create the Recovery Services vault. You can monitor the operation status in the Backup center **Notifications** area. 

### Things to know about configuring Recovery Services vaults

Azure Backup automatically handles the storage for your vault. Depending on your configuration, you need to specify how your storage is replicated.

- If you're using Azure Backup for Azure Files file shares, you don't need to configure the storage replication type. Azure Files backup is snapshot-based, and no data is transferred to the vault. Snapshots are stored in the same Azure storage account as your backed-up file share.

- You can configure replication for your Recovery Services vaults from the Backup center dashboard under **Properties** > **Backup Configuration** > **Update**.

   :::image type="content" source="../media/vault-backup-options-b1a2792d.png" alt-text="Screenshot that shows how to configure a Recovery Services vault backup page in the Azure portal." border="false":::

- There are three storage replication options: Geo-redundant, locally redundant, and zone redundant. The following table provides recommendations for the replication types.

   | Replication type | Recommendation |
   | --- | --- |
   | **Geo-redundant** (GRS) | (Default) Use GRS when Azure is your primary backup storage endpoint. |
   | **Locally redundant** (LRS) | If Azure **isn't** your primary backup storage endpoint, use LRS to reduce your storage costs. |
   | **Zone redundant** | If you require data availability without downtime in a region and need to guarantee data residency, use ZRS. |

- You can also specify how to restore data in a secondary, Azure paired region by enabling the **Cross Region Restore**.

> [!Important]
> You must change the storage replication type for your Recovery Services vault before you try to configure a backup in the vault. After you configure a backup, the option to modify the replication type is disabled.