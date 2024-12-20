Azure NetApp Files backup expands the data protection capabilities of Azure NetApp Files by providing fully managed backup solution for long-term recovery, archive, and compliance. Backups created by the service are stored in Azure storage, independent of volume snapshots that are available for near-term recovery or cloning. 

## Backup vaults 

Backup vaults are organizational units to manage backups. You must create a backup vault before you can create a backup. Although it's possible to create multiple backup vaults in your Azure NetApp Files account, it's recommended you have only one backup vault per account. 

## Cost model for Azure NetApp Files backup 

Pricing for Azure NetApp Files backup is based on the total amount of storage consumed by the backup. There are no setup charges or minimum usage fees.

Backup restore is priced based on the total amount of backup capacity restored during the billing cycle. 

To learn about pricing, see [Azure NetApp Files backup pricing](/azure/azure-netapp-files/backup-introduction#cost-model-for-azure-netapp-files-backup)