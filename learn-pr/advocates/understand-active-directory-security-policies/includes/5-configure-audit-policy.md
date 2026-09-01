Auditing turns security policy into visibility. Without it, you can't tell who changed a privileged group, who accessed a sensitive share, or which account is being brute-forced. Windows offers two auditing models, and this unit shows you how to use the modern one to produce precise, actionable logs.

## Basic compared with advanced auditing

The legacy **Audit Policy** under `Local Policies` > `Audit Policy` has nine broad categories. The **Advanced Audit Policy Configuration** under `Security Settings` > `Advanced Audit Policy Configuration` breaks these into 10 categories and 61 **subcategories**, so you can audit exactly what you need and avoid drowning the Security authentication noise.

> [!IMPORTANT]
> Don't mix the two models. Enable the security option **Audit: Force audit policy subcategory settings (Windows Vista or later)** so the advanced subcategory settings are authoritative. If both models are configured without this option, the results are unpredictable.

## The 10 advanced audit categories

| Category | What it captures (key subcategories) |
| --- | --- |
| Account Logon | Where credentials are validated. *Credential Validation* (NTLM) is logged on the domain controller for domain accounts and on the local computer for local SAM accounts; *Kerberos Authentication Service* and *Kerberos Service Ticket Operations* are logged on the domain controller. |
| Account Management | Changes to accounts and groups: *User Account Management*, *Computer Account Management*, and *Security Group Management*. For domain accounts and groups, configure and verify these subcategories on domain controllers; local account changes are audited on the local computer. |
| Detailed Tracking | *Process Creation*, *PNP Activity*, *Token Right Adjusted*. To include command lines in process creation events, also enable **Computer Configuration** > **Administrative Templates** > **System** > **Audit Process Creation** > **Include command line in process creation events**. |
| DS Access | Active Directory object access and changes: *Directory Service Access* and *Directory Service Changes*. Configure these subcategories on domain controllers and use AD object SACLs to scope which directory objects and operations generate events. |
| Logon/Logoff | *Logon*, *Logoff*, *Account Lockout*, *Special Logon* (privileged sign-ins), *Group Membership*. **Audit Group Membership** events (Event `4627`) are emitted with logon events, so enable **Audit Logon** too. |
| Object Access | Access to resources by subcategory: *File System* and *Registry* require a matching SACL on the object; *File Share* and *Detailed File Share* don't use share SACLs and audit share access on the computer when enabled; *Removable Storage* and *SAM* audit their specific object types. |
| Policy Change | *Audit Policy Change*, *Authentication Policy Change*, *Authorization Policy Change*, *MPSSVC (firewall) Rule-Level Policy Change*. |
| Privilege Use | *Sensitive Privilege Use* records selected sensitive privilege requests, such as Debug programs, Take ownership, and Manage auditing and security log. Backup and Restore privilege use is logged only when the separate security option **Audit: Audit the use of Backup and Restore privilege** is enabled; enable that option only when required because it can create high event volume. |
| System | *Security State Change*, *Security System Extension*, *System Integrity*, *IPsec Driver*. |
| Global Object Access Auditing | Apply a *File system* or *Registry* SACL across the whole system without editing each object. |

## Object access and SACLs

Object Access subcategories don't all work the same way:

- **Audit File System** and **Audit Registry** require both the relevant audit subcategory and a **system access control list (SACL)** on the file, folder, or registry key. The SACL specifies the principal, access type, and Success or Failure auditing to record.
- **Audit File Share** and **Audit Detailed File Share** don't use share SACLs. When these subcategories are enabled, Windows audits share access on that computer. **Detailed File Share** records each file or folder access through a share and can be high volume on file servers and domain controllers.

Global Object Access Auditing lets you apply a File System or Registry SACL across the whole system without editing each object, which is useful when you can't practically edit each object.

> [!TIP]
> Choose **Success**, **Failure**, or both deliberately, and pair auditing with adequate Security log sizing and forwarding (Unit 6). Auditing everything fills the log and buries the events that matter.

**Real-world example.** Contoso's audit requires proof of who modifies privileged groups and who touches a sensitive finance share. You enable **Account Management > Audit Security Group Management** and **Logon/Logoff > Audit Special Logon**, enable **Object Access > Audit File System**, and place a SACL on the finance folder. To support incident response, you also enable **Detailed Tracking > Audit Process Creation** and the Administrative Template policy **System > Audit Process Creation > Include command line in process creation events** so Event ID 4688 includes process command lines. Treat command lines as sensitive because arguments can contain passwords, tokens, connection strings, or user data.

> [!NOTE]
> Domain account-management and directory-service audit events are generated on domain controllers. If the audited object is a domain group, user, computer, or AD DS object, target the audit GPO to domain controllers and verify the effective policy on a domain controller. Use member-server or workstation audit GPOs for local resources such as files, registry keys, and process creation.

## Configure advanced auditing

Enable advanced auditing through Group Policy:

For domain-controller auditing, target the GPO to the **Domain Controllers** OU, or use the **Default Domain Controllers Policy** if that's where your organization manages DC audit settings. Enable the relevant **Account Management** and **DS Access** subcategories there, then add SACLs to the specific AD objects or containers that need Directory Service Access or Directory Service Changes auditing.

1. Confirm **Audit: Force audit policy subcategory settings** is **Enabled** under `Local Policies` > `Security Options`.
1. Go to `Security Settings` > `Advanced Audit Policy Configuration` > `Audit Policies`, open a category, then set each subcategory to **Success**, **Failure**, or both.

Audit access to a sensitive NTFS folder:

1. Enable **Object Access > Audit File System** in the GPO.
1. On the folder, select **Properties** > **Security** > **Advanced** > **Auditing** (select **Continue** if prompted for elevation) > **Add** > **Select a principal** (for example, *Everyone*), set **Type** to **Success**, **Fail**, or **All**, set **Applies to**, then select the access to audit (for example, *Modify* and *Delete*).
1. If the folder is shared and you also need share-level access events, enable **Object Access > Audit File Share** or **Audit Detailed File Share** on the file server. These share subcategories don't use the folder SACL and can generate high event volume.

Verify and inspect the effective policy on a host:

```powershell
gpupdate /force
auditpol /get /category:*
```

Run the same `auditpol` verification on a domain controller when you configure Account Management or DS Access auditing for domain objects. A member server's effective audit policy doesn't prove that domain controller audit policy is enabled.
