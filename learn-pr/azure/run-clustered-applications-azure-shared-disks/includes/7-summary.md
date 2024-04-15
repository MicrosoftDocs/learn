Your organization can now use Azure shared disks to migrate existing clustered or distributed applications from your on-premises environment to the cloud. 

Using Ultra Disk and Premium SSDs, you'll benefit from shared access to high-performance, durable block storage. A shared disk simplifies running clusters on Azure and offers a balance of price and performance. 

In this module, you learned about Azure shared disks and their benefits. You also learned how to create Azure shared disks and use them to deploy clustered VMs.

[!INCLUDE [azure-exercise-subscription-cleanup](../../../includes/azure-exercise-subscription-cleanup.md)]

## Learn more

To learn more, refer to the following articles:

- [Create an FCI with Azure shared disks - SQL Server on Azure VM](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-azure-shared-disks-manually-configure?tabs=windows2012)
- [Cluster an SAP ASCS/SCS instance on a Windows failover cluster by using a cluster shared disk in Azure](/azure/virtual-machines/workloads/sap/sap-high-availability-guide-wsfc-shared-disk)
- [Enable shared disks](/azure/virtual-machines/disks-shared-enable?tabs=azure-cli)
- [Share an Azure managed disk](/azure/virtual-machines/disks-shared)
- Red Hat Enterprise Linux (RHEL) ([support policy](https://access.redhat.com/articles/3444601))
    - [RHEL 7.9](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/deploying_red_hat_enterprise_linux_7_on_public_cloud_platforms/configuring-rhel-high-availability-on-azure_cloud-content)
    - [RHEL 8.3 and above](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/deploying_rhel_8_on_microsoft_azure/configuring-rhel-high-availability-on-azure_cloud-content-azure#azure-configuring-shared-block-storage_configuring-rhel-high-availability-on-azure)
- [Azure shared disks with "SLES for SAP / SLE HA 15 SP2"](https://www.suse.com/c/azure-shared-disks-excercise-w-sles-for-sap-or-sle-ha/)
- [Ubuntu high availability - Corosync, Pacemaker, and shared disk environments](https://discourse.ubuntu.com/t/ubuntu-high-availability-corosync-pacemaker-shared-disk-environments/14874)
- [Shared disk (multi-node ReadWrite)](https://github.com/kubernetes-sigs/azuredisk-csi-driver/tree/master/deploy/example/sharedisk) 
- [Azure Managed Disks pricing](https://azure.microsoft.com/pricing/details/managed-disks/)
- [Run clustered applications on Azure with shared disks](https://www.youtube.com/watch?v=BRNelyXLQ4o&t=40s)
