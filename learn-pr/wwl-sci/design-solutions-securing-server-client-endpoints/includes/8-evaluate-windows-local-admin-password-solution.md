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
| Hybrid joined devices | Either directory | Organizations with both cloud and on-premises identity |

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
- Optional password encryption requires Windows Server 2016 Domain Functional Level or later
- Password history can be stored (not available with Microsoft Entra ID)
- Recommended to enable password encryption when storing passwords in AD

## Policy configuration options

When evaluating Windows LAPS, consider these configurable policy settings:

**Password settings**

- Password length (8-64 characters) and complexity requirements
- Passphrase support with configurable word count (new in Windows 11 24H2)
- Improved readability option that excludes easily confused characters

**Account management**

- Manage the built-in administrator account (identified by RID, not name)
- Specify a custom local administrator account name
- Automatic account creation (new feature for managed local accounts)

**Rotation settings**

- Password age (how long before automatic rotation)
- Post-authentication actions (what happens after the managed password is used)

## Security model comparison

| Capability | Microsoft Entra ID | Windows Server AD |
| --- | --- | --- |
| Password encryption at rest | Always (additional layer) | Optional (requires DFL 2016+) |
| Access control model | RBAC with custom roles | ACLs on OUs and computer objects |
| Conditional Access | Supported | Not available |
| Password history | Not supported | Supported |
| Audit logging | Microsoft Entra audit logs | Windows event logs |
| DSRM password support | Not supported | Supported |

## Migration from legacy LAPS

The legacy Microsoft LAPS product is deprecated as of Windows 11 23H2. Installation of the legacy LAPS MSI package is blocked on newer OS versions. Evaluate your migration path:

- Windows LAPS doesn't require legacy LAPS to be installed
- Legacy LAPS emulation mode supports migration scenarios
- Organizations can run both solutions side-by-side during migration if they target different accounts
- Windows LAPS uses the same AD schema attributes as legacy LAPS for backward compatibility

## Management tool options

Evaluate which management approach fits your operational model:

**Microsoft Intune**

- Endpoint security policies for account protection
- Centralized management for Microsoft Entra joined and hybrid joined devices
- Password rotation through device actions in Intune admin center
- View managed account details directly in Intune

**Group Policy**

- Traditional management for AD-joined devices
- Windows LAPS administrative templates included in Windows
- Familiar deployment and targeting mechanisms

**PowerShell**

- `Get-LapsADPassword` to retrieve passwords from AD
- `Reset-LapsPassword` to force immediate rotation
- `Set-LapsADReadPasswordPermission` to configure access

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

- Windows 11 (all supported versions)
- Windows 10 (with April 2023 update or later)
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
