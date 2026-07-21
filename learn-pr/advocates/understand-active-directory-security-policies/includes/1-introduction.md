*Group Policy security settings* are the collection of policies under `Computer Configuration` > `Policies` > `Windows Settings` > `Security Settings` in a Group Policy Object (GPO). They're the primary mechanism you use to centrally define and enforce a consistent security posture across every domain-joined computer in an Active Directory environment. On a standalone server, the same settings appear in Local Security Policy (`secpol.msc`) under `Local Computer Policy` > `Windows Settings` > `Security Settings`.

Misconfigured or missing security settings are a leading cause of both outages and breaches. A too-aggressive account lockout policy floods the help desk and can create a denial of service; an over-broad logon right or a weak authentication setting hands an attacker lateral movement, credential theft, or privilege escalation. Getting these settings right is one of the highest-impact tasks a Windows Server administrator performs.

## What the Security Settings node contains

The Security Settings node spans 16 policy areas. This module groups them by the unit that covers them:

| Policy area | Covered in |
| --- | --- |
| Account Policies (Password, Account Lockout, Kerberos) | Unit 2 |
| Local Policies: User Rights Assignment | Unit 3 |
| Local Policies: Security Options | Unit 4 |
| Local Policies: Audit Policy | Unit 5 |
| Advanced Audit Policy Configuration | Unit 5 |
| Restricted Groups, System Services, Registry, File System, Event Log | Unit 6 |
| Windows Defender Firewall with Advanced Security, IP Security Policies, Software Restriction Policies, Application Control Policies (AppLocker), Public Key Policies, Network List Manager Policies, Wired (802.3) and Wireless (802.11) Network Policies | Unit 7 |

> [!NOTE]
> Current Microsoft documentation generally uses the name **Windows Firewall**. In Group Policy and the MMC snap-in, the node is still labeled **Windows Defender Firewall with Advanced Security**. This module uses the Group Policy label in procedures.

## How security settings are processed

Computer-side security settings apply when a computer starts and again on the periodic background refresh (approximately every 90 minutes with random offset on member servers, and every 5 minutes on domain controllers). Group Policy processing follows the **LSDOU** order (**L**ocal, **S**ite, **D**omain, then **O**rganizational Unit), and later policies overwrite earlier ones unless you use **Enforced** (formerly *No Override*) or **Block Inheritance**.

Two behaviors are specific to security settings and worth knowing up front:

- **Account Policies are domain-scoped.** For *domain* user accounts, **Password Policy**, **Account Lockout Policy**, and **Kerberos Policy** take effect only when they're defined in a GPO linked at the **domain** level. Password and Account Lockout settings in an OU-linked GPO affect only the local (SAM) accounts of the computers in that OU; **Kerberos Policy** has no local-account equivalent and is meaningful only at the domain (KDC) level. You learn more in Unit 2.
- **Security settings reapply on a schedule.** The Security client-side extension refreshes settings even when the GPO version hasn't changed (by default, at least every 16 hours). This behavior helps correct configuration drift, but it also means a manual change to a policy-managed setting is reverted at the next refresh.

## Tools of the trade

You author and validate security settings with several tools:

- **Group Policy Management Console (`gpmc.msc`)** and the **Group Policy Management Editor**: create, link, and edit domain GPOs.
- **Local Security Policy (`secpol.msc`)** and the **Local Group Policy Editor (`gpedit.msc`)**: edit local policy on a standalone or workgroup server.
- **`auditpol.exe`**: view and set the effective advanced audit policy on a host.
- **`secedit.exe`** and **Security Configuration and Analysis**: export, analyze, and apply `.inf` security templates for security-template areas such as account and local policy, user rights, restricted groups, service security, registry ACLs, and file-system ACLs. They don't validate every Group Policy or Administrative Template setting; on Server Core, use `secedit` and PowerShell because the Security Configuration and Analysis MMC snap-in isn't available.
- **`gpupdate`** and **`gpresult`**: refresh policy and report the resultant set of policy (RSoP) on a target.
- **OSConfig** is the Windows Server 2025 security-configuration stack (a PowerShell module, also driven from Windows Admin Center) that applies Microsoft's role-aware security baseline and keeps it enforced with built-in drift control. You'll learn about OSConfig later in this module.

## A scenario to solve

Throughout this module, you harden **Contoso**, a new Windows Server 2025 domain that must pass a security audit. The audit requires strong passwords, restricted sign-in for privileged and service accounts, meaningful security auditing, hardened SMB and NTLM authentication, application allowlisting on jump servers, and host-firewall isolation for sensitive servers. Each unit closes one part of this audit.

## Learning objectives

By the end of this module, you're able to:

- Describe how Group Policy security settings are structured, processed, and targeted, and select the right tool to author and test them.
- Configure Account Policies and explain the domain-scope rule and fine-grained password policies.
- Assign user rights and configure security options to enforce least privilege and harden authentication.
- Configure auditing with the Advanced Audit Policy Configuration, and secure group membership, services, registry, file system, and event logs.
- Deploy network and application security policies, and manage security settings at scale with the OSConfig baseline.
