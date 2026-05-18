As a security architect, you evaluate Windows Local Administrator Password Solution (Windows LAPS) to determine how it addresses your organization's requirements for managing local administrator account passwords. Windows LAPS is a Windows feature that automatically manages and backs up local administrator account passwords on Microsoft Entra joined and Windows Server Active Directory-joined devices.

## Security threats addressed by Windows LAPS

Local administrator accounts present significant security risks when passwords are shared or reused across devices. Windows LAPS addresses these threats:

- **Pass-the-hash attacks**: When attackers capture a local admin password hash from one device, they can use it to authenticate to other devices with the same credentials. Windows LAPS generates unique passwords for each device.
- **Lateral traversal**: Attackers who compromise one device often attempt to move laterally through the network. Unique local admin passwords limit this movement.
- **Credential persistence**: Static local admin passwords remain valid indefinitely unless manually changed. Windows LAPS rotates passwords automatically based on policy.

## Supported scenarios

Evaluate which Windows LAPS scenario matches your environment:

| Scenario | Backup directory | Use case |
| --- | --- | --- |
| Microsoft Entra joined devices | Microsoft Entra ID | Cloud-native or hybrid environments with Intune management |
| Windows Server AD-joined clients | Windows Server Active Directory | On-premises environments with Group Policy management |
| Windows Server AD domain controllers | Windows Server Active Directory | DSRM account password management |
| Hybrid joined devices | Either directory (one at a time) | Organizations with both cloud and on-premises identity |

## Backup directory evaluation

Your choice of backup directory affects security model, management tools, and access control.

**Microsoft Entra ID backup**

- Passwords are stored on the Microsoft Entra device object with additional encryption
- Access control uses Microsoft Entra RBAC with built-in roles (Global Administrator, Cloud Device Administrator, Intune Administrator)
- Supports custom roles and administrative units for granular access
- Conditional Access policies can protect password recovery operations
- Audit logs track password updates and recovery events through Microsoft Entra

**Windows Server Active Directory backup**

- Passwords are stored in attributes on computer objects
- Access control uses ACLs on computer objects and organizational units
- Optional password encryption uses CNG DPAPI (AES-256) and requires Windows Server 2016 Domain Functional Level or later. You can configure which security principal can decrypt (defaults to Domain Admins).
- Password history can be stored (requires encryption enabled; not available with Microsoft Entra ID)
- Recommended to enable password encryption when storing passwords in AD

## Policy capabilities

When evaluating Windows LAPS, consider these capabilities:

- **Password complexity**: Supports configurable password length and complexity, plus passphrase generation (Windows 11 24H2 and later)
- **Account targeting**: Can manage the built-in administrator account (identified by RID, not name), a named custom account, or an automatically created managed account
- **Automatic rotation**: Passwords are rotated based on a configurable age policy
- **Post-authentication actions**: After the managed password is used for authentication, Windows LAPS can automatically reset the password and sign out the account, reboot the device, or terminate remaining processes. This limits the window during which a retrieved password remains valid.

## Security model comparison

| Capability | Microsoft Entra ID | Windows Server AD |
| --- | --- | --- |
| Password encryption at rest | Always (additional layer) | Optional (requires DFL 2016+) |
| Access control model | RBAC with custom roles | ACLs on OUs and computer objects |
| Conditional Access | Supported | Not available |
| Password history | Not supported | Supported |
| Audit logging | Microsoft Entra audit logs | Windows event logs |
| DSRM password support | Not supported | Supported |
| Password expiration protection | N/A | Prevents tampering with expiration date in AD |
| Account tampering protection | Supported | Supported |

**Password expiration protection** (`PasswordExpirationProtectionEnabled`, enabled by default) prevents modification of the password expiration attribute in Active Directory, which could otherwise be used to prevent rotation. **Account password tampering protection** rejects unauthorized attempts to change the managed account's password outside of LAPS, returning an error and logging the event.

## Licensing

The Windows LAPS feature is available at no additional cost. Backing up passwords to Windows Server Active Directory has no licensing requirements. Backing up passwords to Microsoft Entra ID requires Microsoft Entra ID Free or higher. Intune management features and Conditional Access may require additional licensing.

## Migration from legacy LAPS

The legacy Microsoft LAPS product is deprecated as of Windows 11 23H2. Installation of the legacy LAPS MSI package is blocked on newer OS versions. Evaluate your migration path:

- Windows LAPS doesn't require legacy LAPS to be installed
- Legacy LAPS emulation mode supports migration scenarios
- Organizations can run both solutions side-by-side during migration if they target different accounts
- Windows LAPS uses the same AD schema attributes as legacy LAPS for backward compatibility

## Management tool options

Evaluate which management approach fits your operational model:

| Tool | Best for | Key consideration |
| --- | --- | --- |
| **Microsoft Intune** | Microsoft Entra joined and hybrid joined devices | Centralized endpoint security policies, password rotation through device actions, direct password retrieval in admin center |
| **Group Policy** | AD-joined devices in traditional environments | Windows LAPS administrative templates are included in Windows; familiar targeting through OUs |
| **PowerShell** | Unplanned operations and scripting | Password retrieval, forced rotation, and permission configuration for AD-backed scenarios |

## Evaluation criteria checklist

When evaluating Windows LAPS for your organization, assess these factors:

**Device coverage**

- What percentage of devices are Microsoft Entra joined vs. AD-joined?
- Are there devices on older OS versions that require legacy LAPS?
- Do you need to manage DSRM passwords on domain controllers?

**Access control requirements**

- Who needs ability to retrieve local admin passwords?
- Do you need Conditional Access protection for password recovery?
- Are administrative units required for delegated management?

**Compliance and audit**

- What audit logging is required for password access?
- Do regulatory requirements mandate password encryption?
- How long must password history be retained?

**Operational integration**

- Is Intune available for policy deployment?
- Are Group Policy management processes established?
- What help desk workflows need local admin password access?

## Platform requirements

Windows LAPS is available on these platforms:

- Windows 11 23H2 and later (natively included); Windows 11 22H2 and 21H2 with April 2023 update
- Windows 10 (with April 2023 update or later)
- Windows Server 2025 and later (natively included)
- Windows Server 2022 (with April 2023 update or later)
- Windows Server 2019 (with April 2023 update or later)

Windows LAPS isn't supported for Microsoft Entra registered devices (only joined and hybrid joined) or non-Windows platforms.

## Design recommendation

For most organizations, evaluate implementing Windows LAPS with:

- Microsoft Entra ID as the backup directory for cloud-managed devices
- Password encryption enabled for any passwords stored in Windows Server AD
- Intune endpoint security policies for centralized management
- Conditional Access policies protecting password recovery for sensitive environments
- Audit logging enabled to track all password retrieval operations
