Ransomware operators target backup systems first—before encrypting production workloads. If they successfully destroy the backups, the organization has no recovery path and faces pressure to pay the ransom. Azure Backup provides layered protections that convert single-point-of-failure scenarios into defense-in-depth architectures.

| Protection layer | What it prevents | Configuration commitment |
|---|---|---|
| **Enhanced soft delete** | Immediate permanent deletion of recovery points | Reversible or always-on (irreversible) |
| **Vault immutability** | Modification or deletion of recovery points before retention expires | Reversible or locked (irreversible) |

These two controls form the foundation of Azure Backup's security posture model. You configure both to protect Contoso's backup infrastructure from the attack pattern demonstrated in the tabletop exercise.

## Why backup infrastructure is an attack target

Ransomware attacks follow a predictable sequence. The attacker gains access to backup administrator credentials through phishing, credential stuffing, or privilege escalation. Once inside, they execute the backup destruction workflow: disable soft delete to remove the recovery window, stop backup with data deletion to remove all recovery points, delete the vault to eliminate the infrastructure, then encrypt production systems. If the backup infrastructure is destroyed before production encryption begins, the organization has zero recovery options.

Traditional backup systems treat the backup administrator as a trusted principal with unlimited destructive capability, which is why this attack pattern succeeds. A single compromised credential becomes an organizational catastrophe. Azure Backup's tiered security posture model addresses the problem by adding recovery windows, immutability guarantees, and multi-administrator approval requirements. The goal: make backup destruction impossible for a single compromised account, even if that account holds the Backup Contributor role.

## Enhanced soft delete—the recovery window

**Soft delete** creates a safety net for deleted backup items. When backup data is deleted—whether by an administrator, an attacker, or accidental user action—the recovery points enter a soft-deleted state instead of being immediately purged. During the soft delete retention period, you can recover the data at no extra cost. The data remains in Azure storage; only the deletion is reversed.

Azure Backup enforces soft delete by default across all global Azure regions as part of its **Secure by default** platform commitment. In regions where this enforcement is generally available, soft delete can't be disabled from the Azure portal for any vault. In regions where it's in preview, new vaults have soft delete enabled and enforced by default.

Within this baseline, you configure the **retention period** and the **always-on** setting:

- **Soft delete retention**: configurable from 14 to 180 days. The default is 14 days. Longer periods provide more time to detect advanced persistent threats before the recovery window expires.
- **Always-on soft delete**: makes the retention period itself irreversible. Once enabled, no user—including Global Administrators—can reduce or disable the retention period on that vault.

The always-on setting addresses a specific attack vector: an attacker who gains backup administrator credentials and attempts to shorten the retention window before executing a deletion attack. With always-on configured, the retention period is locked, and all deleted items remain recoverable for the full configured duration.

Soft delete coverage includes Azure VMs, SQL Server in Azure VMs, SAP HANA in Azure VMs, Azure Files (vaulted backup), and on-premises servers protected by the MARS agent.

To enable enhanced soft delete in the Azure portal:

1. Navigate to your Recovery Services vault
2. Under **Settings**, select **Properties**
3. Under **Soft delete**, select **Update**
4. Set the retention period—choose between 14 and 180 days based on your detection and response capabilities
5. Check **Enable always-on soft delete** to make soft delete permanent on this vault
6. Select **Save**

> [!IMPORTANT]
> The always-on setting is permanent and can't be reversed. Verify your retention period requirements before enabling always-on. You can increase the retention period later, but you can't decrease it after always-on is enabled. For production vaults protecting business-critical data, configure at least 90 days of soft delete retention to provide adequate time for threat detection and incident response.

Soft delete doesn't protect against all attack scenarios. An attacker with patience can wait out the retention period—though a 180-day retention window significantly limits this vector. Soft delete is the first layer of defense; vault immutability and Multi-User Authorization provide the other layers.

## Vault immutability - WORM protection for recovery points

**Vault immutability** prevents backup policies from being modified in ways that reduce recovery point retention, and prevents backup data from being deleted before the retention period expires. This implements WORM (Write Once, Read Many) storage behavior at the vault level. Recovery points, once written, can't be modified or deleted until their retention period expires naturally.

Immutability operates in three states:

- **Disabled**: No protection—the default state for existing vaults. Administrators can modify policies and delete data freely.
- **Enabled** (reversible): Immutability is active. Recovery points can't be deleted, and policies can't be modified to reduce retention. This setting can be disabled if organizational requirements change.
- **Enabled and Locked** (irreversible): Immutability is permanently active and can't be disabled by any user, including Global Administrators. Permanently active is the WORM compliance state.

The locked state provides the strongest protection. Once you lock vault immutability, no future action by any administrator—malicious or accidental—can reduce retention or delete recovery points before their scheduled expiration. The lock is appropriate for production vaults protecting business-critical workloads like databases, file servers, domain controllers, and compliance-sensitive data.

For development and test environments, Enabled (reversible) provides protection while retaining operational flexibility. If you need to decommission the vault or adjust retention policies downward, you can disable immutability before making those changes. The ability to disable locks maintains security without creating operational constraints in nonproduction scenarios.

To enable and lock vault immutability:

1. In the Recovery Services vault, navigate to **Settings** > **Properties**
2. Under **Vault immutability**, select **Update**
3. Select **Enable vault immutability**
4. To lock permanently, select **Apply vault immutability lock**
5. Read the confirmation warning carefully—this action is irreversible
6. Confirm the operation

> [!IMPORTANT]
> The Enabled and Locked state is irreversible by any user, including subscription owners and Global Administrators. Before locking, verify that your vault's backup policies and retention settings meet long-term organizational requirements. After locking, you can increase retention periods but never decrease them. Only lock production vaults after confirming that policy configurations are finalized.

Immutability complements soft delete. Soft delete provides a recovery window after deletion occurs. Immutability prevents the deletion from occurring in the first place. Together, they create overlapping protection layers that defend against both accidental and malicious data loss.

## Azure Backup security posture rating—your target state

Azure Backup evaluates each vault's configuration and assigns a security posture tier. The rating appears in the vault's **Overview** screen and in Azure Security Center recommendations. Your target for production vaults is the **Excellent** tier.

| Tier | Configuration requirements |
|---|---|
| **Excellent** | Vault immutability locked AND Multi-User Authorization enabled—OR—Always-on soft delete enabled AND Multi-User Authorization enabled |
| **Good** | Vault immutability enabled and locked—OR—Soft delete enabled (any configuration) |
| **Fair** | Multi-User Authorization enabled only, without immutability or enhanced soft delete |
| **Poor** | No advanced security features configured (default state for new vaults) |

The Excellent tier requires two elements: a deletion protection mechanism (either locked immutability or always-on soft delete), and Multi-User Authorization. The deletion protection mechanisms—soft delete and immutability—protect recovery points after an attack begins. Multi-User Authorization prevents a single compromised credential from disabling those protections.

> [!NOTE]
> With Secure by default platform enforcement, all new vaults in global Azure regions already start at the **Good** tier because soft delete is enforced. Configuring locked immutability or always-on soft delete combined with Multi-User Authorization is still required to reach the **Excellent** tier.

For Contoso's production environment, you configure always-on soft delete with 90-day retention and locked vault immutability, reaching the Excellent tier's first path: both deletion protections active at their strongest irreversible settings. The next unit completes the Excellent tier by adding Multi-User Authorization with Resource Guard.

Soft delete and immutability protect recovery points from deletion and modification, but they don't stop a backup administrator with compromised credentials from disabling those protections before launching an attack. Multi-User Authorization adds the second administrator requirement, converting single-credential attacks into scenarios that require collusion between two separate security principals.
