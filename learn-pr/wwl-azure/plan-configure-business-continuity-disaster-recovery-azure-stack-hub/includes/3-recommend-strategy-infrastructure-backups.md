You can enable the Infrastructure Backup Service from the administrator portal so that Azure Stack Hub can generate infrastructure backups. The hardware partner can use these backups to restore your environment using cloud recovery if a catastrophic failure occurs. The purpose of cloud recovery is to ensure that your operators and users can log back into the portal after recovery is complete. Users will have their subscriptions restored, including:

 -  Role-based access permissions and roles.
 -  Original plans and offers.
 -  Previously defined compute, storage, and network quotas.
 -  Key Vault secrets.

However, the Infrastructure Backup Service doesn't back up IaaS virtual machines, network configurations, and storage resources such as storage accounts, blobs, tables, and so on. Users logging in after cloud recovery won't see any of these previously existing resources. Platform as a Service (PaaS) resources and data are also not backed up by the service.

Admins and users are responsible for backing up and restoring IaaS and PaaS resources separately from the infrastructure backup processes. For info on backing up IaaS and PaaS resources, see the following links:

 -  [Protect virtual machines deployed on Azure Stack Hub.](/azure-stack/user/azure-stack-manage-vm-protect?view=azs-2008)
 -  [Back up your app in Azure](/azure/app-service/manage-backup).
