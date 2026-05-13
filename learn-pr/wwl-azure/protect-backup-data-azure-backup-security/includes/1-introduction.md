Compromised backup administrator credentials are a ransomware operator's first target—not the last. When an attacker obtains backup admin access, they can disable recovery protections, delete all recovery points, and destroy the vault infrastructure before deploying ransomware on production systems. Without backups, the organization has no recovery path.

Contoso runs a ransomware attack tabletop exercise to test their backup security posture. The attack scenario: an attacker obtains Backup Contributor credentials through phishing, disables soft delete, deletes all backup items, removes the Recovery Services vault, and deploys ransomware on production VMs. The entire exercise completes in under 30 minutes with zero recovery options. The security gap: a single compromised credential gave one person the ability to destroy the entire backup infrastructure.

Here, you learn how to close that gap. You configure enhanced soft delete and vault immutability as time-based and permanent recovery point protections. Then you implement Multi-User Authorization with Resource Guard to require two-administrator approval for critical operations. By the end of this module, you know how to reach Azure Backup's "Excellent" security posture tier and prevent single-credential backup destruction.

## Learning objectives

By the end of this module, you're able to:

- Configure enhanced soft delete and vault immutability to protect recovery points from unauthorized deletion.
- Implement Multi-User Authorization with Resource Guard to enforce two-administrator approval for critical backup operations.
- Evaluate Azure Backup security posture and apply settings that achieve the "Excellent" security tier.
