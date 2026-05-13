In this module, you close a critical gap exposed in Contoso's ransomware tabletop exercise. A single compromised backup administrator credential can destroy the entire backup infrastructure in under 30 minutes. You deploy three Azure Backup security controls to prevent that scenario.

First, you enable enhanced soft delete with a 90-day recovery window and make it always-on at the vault level. The configuration prevents any administrator from disabling protection before an attack. Second, you configure vault immutability in Enabled and Locked mode. The WORM protection ensures no recovery point can be modified or deleted before its retention period expires—even a Global Administrator can't remove immutability once locked. Third, you implement Multi-User Authorization with a Resource Guard hosted in a separate subscription. The control requires a second administrator to authorize any attempt to disable soft delete or remove Multiuser Access (MUA) protection itself.

Together, the controls reach the Excellent tier in Azure Backup's security posture model. A single compromised credential can no longer destroy your backup infrastructure.

The final module in this learning path shifts focus from runtime data protection to the deployment pipeline itself—preventing insecure backup configurations from ever reaching production through infrastructure-as-code scanning and Azure Policy enforcement.

## Learn more

- [Azure Backup security overview](/azure/backup/security-overview)
- [Enhanced soft delete for Azure Backup](/azure/backup/backup-azure-enhanced-soft-delete-about)
- [Immutable vaults for Azure Backup](/azure/backup/backup-azure-immutable-vault-concept)
- [Multi-User Authorization for Azure Backup](/azure/backup/multi-user-authorization-concept)
- [Azure Backup RBAC roles](/azure/backup/backup-rbac-rs-vault)
