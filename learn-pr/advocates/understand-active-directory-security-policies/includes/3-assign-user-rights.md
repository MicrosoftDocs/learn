The User Rights Assignment node under `Security Settings` > `Local Policies` controls who can sign in to a computer and what system-wide actions they can perform. These settings are among your most powerful tools for enforcing least privilege and limiting an attacker's lateral movement.

## Logon rights compared with privileges

User rights fall into two kinds:

- **Logon rights** govern *how* a security principal can sign in: interactively at the console, across the network, through Remote Desktop, as a service, or as a batch job.
- **Privileges** govern *what* a signed-in principal can do system-wide, such as backing up files, debugging processes, or taking ownership. Each privilege maps to a constant that begins with `Se`, for example `SeBackupPrivilege`.

## Logon rights

Every logon right has an allow form and a matching deny form. **Deny always wins**, which makes deny rights your primary tool for shrinking attack surface.

| Allow right | Matching deny right | Typical use of the deny right |
| --- | --- | --- |
| Access this computer from the network | Deny access to this computer from the network | Block local accounts and high-value domain accounts from reaching the host over SMB or RPC. |
| Allow log on locally | Deny log on locally | Stop service accounts and unauthorized users from signing in at the console. |
| Allow log on through Remote Desktop Services | Deny log on through Remote Desktop Services | Restrict RDP to a specific administrative group. |
| Log on as a service | Deny log on as a service | Prevent an account from being configured to run a service. |
| Log on as a batch job | Deny log on as a batch job | Prevent an account from running scheduled tasks. |

**Real-world example.** Contoso runs applications under dedicated service accounts and requires that those accounts never sign in interactively. You add the service-account group to **Deny log on locally** and **Deny log on through Remote Desktop Services**. To reduce pass-the-hash lateral movement on member servers, add `NT AUTHORITY\Local account and member of Administrators group` (SID `S-1-5-114`) to **Deny access to this computer from the network**. Use `NT AUTHORITY\Local account` (SID `S-1-5-113`) only when you've verified that all local accounts can be denied network access.

> [!CAUTION]
> Don't add the local **Administrators** group as a broad substitute for the local-account SIDs; doing so can block legitimate administration and services. Avoid `S-1-5-113` on failover clusters unless you've validated cluster behavior, because the `CLIUSR` local account is used for cluster node management and isn't a local administrator. Treat domain controllers separately from member-server baselines and use caution with deny-network-logon rights because AD DS operations rely on network logons.

## High-value privileges

Some privileges effectively grant control of the computer and are common targets for privilege escalation. Know what each does and grant them sparingly:

| Privilege | Why it matters |
| --- | --- |
| Act as part of the operating system (`SeTcbPrivilege`) | Lets a process assume any identity; near-total control. |
| Debug programs (`SeDebugPrivilege`) | Read or inject into processes; enables credential theft. Where LSASS runs as a protected process (`RunAsPPL`, applied by the Windows Server 2025 baseline), a non-protected process can't read or inject into LSASS. |
| Impersonate a client after authentication (`SeImpersonatePrivilege`) | Basis of many local privilege-escalation exploits. |
| Back up files and directories / Restore files and directories | Bypass NTFS ACLs to read or overwrite any file. |
| Take ownership of files or other objects | Seize objects regardless of their permissions. |
| Load and unload device drivers | Load kernel code. |
| Manage auditing and security log (`SeSecurityPrivilege`) | Read and clear the Security log and set object auditing. |
| Enable computer and user accounts to be trusted for delegation | Configure delegation, which can be abused for impersonation. |
| Add workstations to domain | Join machines, which by default any authenticated user can do a limited number of times. |

Other rights to review include **Change the system time**, **Force shutdown from a remote system**, **Create symbolic links**, **Lock pages in memory**, **Access Credential Manager as a trusted caller**, and **Bypass traverse checking**.

## Deny wins: tiered administration

Because deny rights override allow rights, they're the mechanism behind a **tiered administration** model. In a tiered model, you isolate credentials by sensitivity: Tier 0 (domain controllers and identity systems), Tier 1 (servers and applications), and Tier 2 (workstations). You use deny logon rights so that a Tier 0 account can't sign in to Tier 1 or Tier 2 hosts, which prevents a compromise of a lower tier from exposing high-value credentials. The Tier 0/1/2 model is the on-premises Active Directory model; Microsoft's current guidance frames it within the broader **Enterprise Access Model**, but Group Policy deny logon rights remain the enforcement mechanism for AD-joined Windows hosts.

> [!CAUTION]
> When you define a user right in a GPO, the list you enter **replaces** the effective membership; it doesn't merge with the built-in defaults. Omitting required built-in accounts (for example, on **Access this computer from the network** or **Allow log on locally**) can break the operating system. Start from the known-good defaults and add to them.

Default assignments differ between member servers and domain controllers. Domain controller rights come from the **Default Domain Controllers Policy**, where over-broad membership (such as extra accounts in **Allow log on locally** or **Back up files and directories**) is a frequent audit finding.

## Assign a user right

Assign a right through Group Policy:

1. In `gpmc.msc`, edit the GPO linked to the target OU.
1. Go to `Computer Configuration` > `Policies` > `Windows Settings` > `Security Settings` > `Local Policies` > `User Rights Assignment`.
1. Double-click the right, select **Define these policy settings**, then add the required groups. Include the necessary built-in accounts alongside your additions.

Grant service and batch logon rights to a managed service account:

1. Add the account to **Log on as a service** (or **Log on as a batch job** for scheduled tasks).

Audit the current assignments on a host:

```powershell
New-Item -ItemType Directory -Force C:\Temp | Out-Null
secedit /export /mergedpolicy /cfg C:\Temp\rights.inf /areas USER_RIGHTS
gpresult /h C:\Temp\rsop.html
```
