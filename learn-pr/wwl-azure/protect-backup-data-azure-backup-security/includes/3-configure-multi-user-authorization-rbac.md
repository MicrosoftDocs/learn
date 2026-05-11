Soft delete and vault immutability are recovery mechanisms that protect what happens after an attack begins. They create recovery windows and prevent premature deletion of backup data. But if an attacker has backup administrator credentials, they can still shorten the soft delete retention window (if always-on isn't configured), stop backup with data deletion, and remove vault immutability (if not locked) before those protections take effect. Multi-User Authorization (MUA) closes this gap by requiring two separate administrators to authorize critical backup operations.

| Operation | Single admin (no MUA) | With MUA |
|---|---|---|
| Shorten soft delete retention window | Vault admin executes immediately | Vault admin requests, Resource Guard owner approves |
| Stop backup with data delete | Vault admin executes immediately | Vault admin requests, Resource Guard owner approves |
| Remove MUA protection | Vault admin executes immediately | Vault admin requests, Resource Guard owner approves |

MUA converts single-credential attack scenarios into multi-credential collusion requirements. A compromised backup administrator credential alone can't destroy the backup infrastructure.

## The gap that soft delete and immutability don't close

In the Contoso tabletop exercise, the attacker obtained Backup Contributor credentials through phishing. This single credential provided full control over the backup infrastructure: the attacker weakened backup protections, deleted all backup items, removed the vault, and deployed ransomware—all within 30 minutes.

Always-on soft delete and locked vault immutability prevent the most destructive versions of this attack. With always-on soft delete configured, the attacker can't disable soft delete, so deleted items remain recoverable for up to 180 days. With locked immutability, the attacker can't delete recovery points before their retention expires. The protections work—but only if they're already configured before the attack begins.

MUA addresses the configuration phase vulnerability. Before you can lock immutability or enable always-on soft delete, those settings must be configured by a vault administrator. If an attacker compromises that administrator's credentials early—before the vault reaches the Excellent security tier—they can prevent the protective configurations from ever being applied. MUA requires a second administrator (who owns the Resource Guard) to approve changes to security settings, ensuring that a single compromised credential can't weaken the vault's security posture.

## Resource Guard - the MUA enforcement resource

**Resource Guard** is a separate Azure resource that acts as a gatekeeper for critical backup operations. The vault administrator configures backup policies and manages day-to-day backup operations. The Resource Guard owner (a separate security administrator) approves requests to perform operations that could weaken the vault's security posture.

The key architectural principle: the vault administrator must not have **Contributor**, **Backup MUA Admin**, or **Backup MUA Operator** permissions on the Resource Guard. Any of these roles allow self-approval of critical operations, defeating the two-administrator requirement. Effective MUA deployment requires role separation.

Recommended deployment pattern: create the Resource Guard in a different Azure subscription from the Recovery Services vaults. Assign ownership to a dedicated security team or a security administrator account that doesn't perform day-to-day backup operations. Alternative ownership creates organizational and technical separation between operational backup management and security oversight.

Resource Guard protects two mandatory operations for Recovery Services vaults that can never be excluded:

- **Disable soft delete or security features**: Prevents removal of the soft delete recovery window or other security settings.
- **Remove MUA protection**: Prevents disabling MUA itself, so an attacker can't remove the gatekeeper before executing other destructive operations.

Beyond the mandatory operations, Resource Guard can protect nine optional operations. All optional operations except **Restore** are enabled by default when you create a Resource Guard:

| Optional operation | Default | Description |
|---|---|---|
| **Delete protection** | Enabled | Stop backup and delete all recovery points for a backup item |
| **Modify protection** | Enabled | Add a new backup policy with reduced retention or increased RPO |
| **Modify policy** | Enabled | Modify a backup policy to reduce retention or increase RPO |
| **Get backup security PIN** | Enabled | Change the MARS agent security PIN |
| **Modify encryption settings** | Enabled | Change CMK encryption key or switch from PMK to CMK |
| **Stop backup and retain data** | Enabled | Stop backups while retaining existing recovery points |
| **Disable immutability** | Enabled | Disable the vault immutability setting |
| **Delete hybrid container** | Enabled | Delete DPM/MABS/MARS containers and associated backup data |
| **Restore** | Disabled | Perform restore operations on backup items |

For Contoso's production environment, leave all optional operations at their defaults. This creates a comprehensive approval workflow for any action that reduces backup protection scope or deletes backup data.

## Configure MUA - portal walkthrough

MUA configuration involves three roles: the security administrator who creates and manages the Resource Guard, the vault administrator who manages backup operations, and the Resource Guard owner who approves critical operation requests. The same person can assume multiple roles in small organizations, but they must use separate accounts for each role to maintain technical role separation.

**Step 1: Create the Resource Guard (security administrator account)**

The security administrator creates the Resource Guard in a subscription separate from the Recovery Services vaults:

1. Sign in to the Azure portal with the security administrator account
2. Search for **Resource Guards** and select the service
3. Select **+ Create**
4. Choose a subscription different from the one containing your Recovery Services vaults
5. Select or create a resource group—use a resource group dedicated to security infrastructure
6. Provide a name for the Resource Guard (for example, `rg-backup-security-prod`)
7. Select the region—must match the Recovery Services vault's region
8. Under **Protected operations**, review the default selections—all optional operations except Restore are enabled by default; deselect any that don't require two-administrator approval in your environment
9. To require approval for restore operations, select **Restore** (disabled by default)
10. Select **Review + create**, then **Create**

**Step 2: Assign the vault admin as Reader on the Resource Guard**

The vault administrator needs read access to the Resource Guard to see that it exists and to submit approval requests. They must not have **Contributor**, **Backup MUA Admin**, or **Backup MUA Operator** permissions on the Resource Guard—any of these roles allow self-approval of critical operations.

11. Navigate to the Resource Guard you created
12. Select **Access control (IAM)**
13. Select **+ Add role assignment**
14. On the **Role** tab, select **Reader**
15. On the **Members** tab, select the vault administrator account or the service principal used for backup operations
16. Select **Review + assign**

**Step 3: Configure the vault to use MUA**

The vault administrator configures the vault to enforce MUA using the Resource Guard:

17. Sign in as the vault administrator
18. Navigate to the Recovery Services vault
19. Under **Settings**, select **Properties**
20. Under **Multi-User Authorization**, select **Update**
21. Select **Protect with Resource Guard**
22. Use the cross-subscription resource picker to select the Resource Guard created in Step 1
23. Select **Save**

After this configuration, any attempt by the vault administrator to perform a protected operation generates a request that requires Resource Guard owner approval. The request includes context about the operation and the identity of the user requesting it.

> [!NOTE]
> When the vault administrator needs to perform a protected operation, the approval flow uses **Microsoft Entra Privileged Identity Management (PIM)**. The security administrator creates an eligible assignment of the **Backup MUA Operator** role on the Resource Guard for the vault administrator. When a protected operation is needed, the vault administrator activates their eligible assignment in PIM, which raises an approval request to the security administrator. After approval, the vault administrator holds the Backup MUA Operator role for the approved time window, and Azure Resource Manager validates that role membership when the critical operation is attempted. PIM automatically revokes the role when the approved period ends. For organizations without PIM, the security administrator can manually grant and revoke the Backup MUA Operator role via Access control (IAM) on the Resource Guard.

MUA doesn't prevent all critical operations—it prevents unauthorized critical operations. The vault administrator can still request to disable soft delete or stop backup with data deletion if there's a legitimate business reason (decommissioning a server, responding to a compliance requirement). The difference: those requests now require security team review and explicit approval.

## Backup RBAC roles - minimum privilege for backup operations

Azure Backup provides three built-in RBAC roles with different privilege levels. Assign roles based on the principle of least privilege: users should have the minimum permissions required to perform their job functions.

| Role | Operations permitted | When to use |
|---|---|---|
| **Backup Contributor** | Full backup management including stop backup with delete, manage policies, register servers, create vaults | Initial vault setup and configuration; accounts that need full backup administrative control |
| **Backup Operator** | Same as Contributor, however they can't stop backup with data delete, can't disable soft delete, can't delete backup data | Day-to-day backup operations including triggering backups, monitoring jobs, restoring data |
| **Backup Reader** | View all backup configurations, job status, and recovery points; no modification permissions | Monitoring dashboards, compliance auditing, SOC review, helpdesk troubleshooting |

Most backup operations—configuring new backups, triggering on-demand backups, monitoring job status, performing restores—require only **Backup Operator** permissions, not Backup Contributor. Assign Backup Contributor only to accounts that perform initial vault configuration, create backup policies, or manage vault-level security settings.

For automated backup management (service accounts, automation runbooks, Azure Functions), use **Backup Operator**. Backup Operator limits the blast radius of compromised service credentials. An attacker who obtains a service account with Backup Operator permissions can perform restores and monitor backups, but can't delete backup data or disable security protections.

For Contoso's environment, you assign roles as follows:

- **Backup Contributor**: Two named administrators who configure vaults and policies (accounts that submit MUA approval requests)
- **Backup Operator**: The service account used by automated backup scripts and Azure Automation runbooks
- **Backup Reader**: The SOC monitoring dashboard service principal, compliance auditors, and helpdesk staff

The role distribution ensures that only two human administrators can request destructive operations, and those requests require Resource Guard owner approval. Service accounts and monitoring tools have read-only or limited-write access that can't destroy backup data.

## Customer-managed key encryption for recovery points

By default, Azure Backup encrypts all recovery points using platform-managed keys. Microsoft manages the encryption keys, handles key rotation, and maintains the encryption infrastructure. Platform managed keys provides AES-256 encryption at rest with no configuration required. For most organizations, platform-managed encryption meets security and compliance requirements.

**Customer-managed key (CMK) encryption** lets you use encryption keys stored in Azure Key Vault that your organization controls. You manage key lifecycle, rotation policy, and access permissions. CMK provides more data sovereignty assurance for organizations with requirements to control cryptographic key material used to encrypt backup data.

CMK encryption for Recovery Services vaults is a one-way commitment. Once you enable CMK encryption on a vault, you can't revert to platform-managed keys. Azure Backup also only supports CMK on new vaults that have no registered backup items. You can't migrate an existing vault with backup data from platform-managed keys to customer-managed keys.

If CMK encryption is a compliance requirement, configure it during vault creation before registering any servers or VMs for backup. Configure the Key Vault, create (or import) the encryption key. Then grant the vault's managed identity permission to access the key, then enable CMK in the vault's **Properties** > **Encryption settings**.

For Contoso's scenario, platform-managed encryption provides sufficient security. The security focus is on preventing backup deletion through soft delete, immutability, and MUA. CMK would be appropriate if Contoso operates in a regulatory environment requiring customer control of encryption keys (certain government, healthcare, or financial services scenarios).

You configured defense-in-depth for Contoso's backup infrastructure. Enhanced soft delete with 90-day retention and always-on configuration provides a recovery window that can't be disabled. Locked vault immutability prevents deletion or modification of recovery points before retention expires. Multi-User Authorization ensures that disabling either protection requires approval from two separate administrators with different credentials.
