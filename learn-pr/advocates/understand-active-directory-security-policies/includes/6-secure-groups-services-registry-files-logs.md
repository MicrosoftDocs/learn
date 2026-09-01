Beyond accounts, rights, and auditing, several Security Settings nodes let you harden the system itself: group membership, service configuration, registry and file permissions, and the event logs that hold your audit data.

## Restricted Groups

Restricted Groups configures membership of **local** security groups on targeted computers through Group Policy. Use it for local groups such as **Administrators** on member servers or workstations. Don't use Restricted Groups to manage Active Directory domain group membership; manage domain groups with AD tools, delegation, and change control.

Restricted Groups has two modes, and the difference is critical:

- **Members of this group**: *authoritative*. The GPO defines the exact membership of the targeted local group; anything not listed is **removed** at each refresh. For the local **Administrators** group, the built-in Administrator account is the exception and isn't removed by this behavior. Manage that account separately, including password management with **Windows LAPS**.
- **This group is a member of**: *additive*. The GPO places a principal into target local groups without removing existing members.

> [!NOTE]
> A modern alternative is **Group Policy Preferences** > **Local Users and Groups**, whose *Update* action is additive by default and supports item-level targeting. For the local administrator *password*, use **Windows LAPS**. Choose Restricted Groups when you need an authoritative reset, and Preferences when you need additive flexibility.

**Real-world example.** Contoso must guarantee that only the `Server Admins` group and the built-in Administrator are members of the local **Administrators** group on every member server, and that anyone added out-of-band is removed automatically. You use **Restricted Groups** in *Members of this group* mode.

## System Services

The System Services node sets each service's **startup mode** (Automatic, Manual, or Disabled) and its **permissions** across every computer in scope. Use it to disable unused or risky services fleet-wide and, with **Edit Security**, to control which groups can start, stop, pause, or reconfigure a service. Pilot service security changes before broad deployment because an overly restrictive service ACL can break management tools or dependent services.

## Registry and File System

These two nodes deploy and enforce **permissions (DACLs)** and **auditing (SACLs)** on specific registry keys and on files and folders. Because the settings reapply on the security refresh, they keep hardened permissions consistent and revert ad-hoc changes.

> [!CAUTION]
> Registry and File System policies are powerful but easy to overuse. Broad or deep permission changes slow down policy processing and make troubleshooting harder. Target them narrowly at the specific keys or paths that need protection.

## Event Log

The Event Log node configures the **Maximum log size**, the **Retention method**, and **guest access** for the Application, Security, and System logs. Sizing and retention matter directly to auditing: if the Security log is too small or overwrites too aggressively, the events you enabled in Unit 5 are lost before you can act on them.

> [!CAUTION]
> Avoid **Do not overwrite events (clear log manually)** for the Security log unless you also have monitoring, archiving, and an operating procedure to clear the log before it fills. A full Security log can drop new audit events. If **Audit: Shut down system immediately if unable to log security audits** is enabled, Windows can stop when it can't write security audit events.

> [!TIP]
> For at-scale collection, forward events with **Windows Event Forwarding** to a central collector or SIEM rather than relying only on local log retention. Monitor log usage and oldest-event age so retention problems are detected before evidence is lost.

**Real-world example.** Contoso's audit requires that security events survive long enough to investigate an incident. You size the Security log for expected audit volume, choose a retention method that preserves the required investigation window, monitor log usage, and configure Windows Event Forwarding to a central collector.

## Configure these settings

Enforce local Administrators membership authoritatively:

1. In `gpmc.msc`, edit the GPO linked to the server OU.
1. Go to `Security Settings` > `Restricted Groups`, right-click, and select **Add Group**.
1. Add **Administrators** as the local group on targeted computers, then under **Members of this group** add only the approved accounts or groups.
1. Manage AD domain group membership separately in Active Directory; don't use Restricted Groups to define who belongs to a domain group.

Disable a service everywhere and set service permissions:

1. Go to `Security Settings` > `System Services`, open the service, and select **Define this policy setting**.
1. Set **Startup mode** to **Disabled**, **Manual**, or **Automatic** as required.
1. If you need to control who can manage the service, select **Edit Security**, grant only the required service-control permissions to approved groups, and remove unnecessary entries.
1. Apply the GPO first to a pilot OU and verify the service and dependent workloads before broad deployment.

Configure registry or file-system permissions and auditing:

1. In the GPO, go to `Security Settings` > `Registry` or `Security Settings` > `File System`.
1. Right-click the node, select **Add Key** or **Add File**, and choose the registry key, file, or folder to manage.
1. In the security dialog, define the required permissions (DACL) for approved users and groups.
1. If you need auditing, open **Advanced** > **Auditing** and add the SACL entries for the access you need to record. Also enable the matching Advanced Audit Policy subcategory from Unit 5, such as **Object Access > Audit Registry** or **Object Access > Audit File System**.
1. Choose inheritance and propagation options carefully. Avoid broad recursive changes unless you've tested them, because they can slow policy processing and overwrite application-specific permissions.
1. After policy refresh, verify DACLs with File Explorer Advanced Security, `icacls`, or `Get-Acl`; verify SACLs from the Advanced Security **Auditing** tab or with `Get-Acl -Audit` where available. Verify registry ACLs with Registry Editor permissions or `Get-Acl` on the registry provider path.

Set Security log size and retention:

1. Go to `Security Settings` > `Event Log`, set **Maximum security log size** for the expected audit volume, and choose a retention method that meets the investigation requirement. Prefer central forwarding plus monitored local retention over manual clearing. Use **Do not overwrite events (clear log manually)** only when archiving, alerting, and clear-log operations are in place.

Apply and verify on a target:

```powershell
gpupdate /force
Get-LocalGroupMember -Group Administrators
Get-Service -Name <ServiceName>
```
