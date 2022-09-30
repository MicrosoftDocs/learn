## Summary

In this module, you learned how to implement a migration of your on-premises workloads to Azure with Azure Migrate. First, you saw how to register your Hyper-V host server with Azure Migrate Server Migration. Second, you learned how to configure your on-premises Hyper-V VMs for replication. 

You also learned how to monitor and test that your on-premises workloads could successfully failover to Azure with no data loss. You then saw how to complete a cutover of your VMs to complete the migration.

Finally, you learned how to secure the migrated VMs by improving resilience, limiting inbound access to VMs, and applying Azure Disk Encryption.

## Learn more

To learn more about the process of migrating Hyper-V VMs from on-premises to Azure, see these articles:

- [Migrate Hyper-V VMs to Azure](/azure/migrate/tutorial-migrate-hyper-v)
- [How does Hyper-V replication work?](/azure/migrate/hyper-v-migration-architecture)
- [Prepare Hyper-V hosts](/azure/migrate/tutorial-migrate-hyper-v#prepare-hyper-v-hosts)
- [Replicate Hyper-V VMs](/azure/migrate/tutorial-migrate-hyper-v#replicate-hyper-v-vms)

For information on post-migration best practices and ensuring security of your migrated VMs, see these articles:

- [Azure Virtual Machine Agent overview](/azure/virtual-machines/extensions/agent-windows)
- [Azure Backup service](/azure/backup/quick-backup-vm-portal)
- [Just-in-time virtual machine access](/azure/security-center/security-center-just-in-time)
- [Azure Disk Encryption](/azure/security/fundamentals/azure-disk-encryption-vms-vmss)