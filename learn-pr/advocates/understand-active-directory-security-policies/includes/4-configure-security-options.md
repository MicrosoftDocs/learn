Security Options are a large set of registry-backed switches under `Security Settings` > `Local Policies` > `Security Options`. They control account behavior, authentication protocols, network access, device installation, interactive sign-in, and User Account Control. This unit groups the settings by their prefix and highlights the ones that solve today's important hardening challenges on Windows Server 2025.

## Accounts and interactive logon

- **Accounts: Rename administrator account** and **Rename guest account**: reduce the value of automated attacks that target the well-known names.
- **Accounts: Administrator account status** and **Guest account status**: keep the guest account disabled.
- **Accounts: Limit local account use of blank passwords to console logon only**: stop blank-password local accounts from being used over the network.
- **Accounts: Block Microsoft accounts**: prevent linking or creating Microsoft accounts on servers.
- **Interactive logon: Message text/title for users attempting to log on**: display a legal warning banner, which is a common audit requirement.
- **Interactive logon: Don't display last signed-in**, **Machine inactivity limit**, **Number of previous logons to cache**, and **Smart card removal behavior**: reduce credential exposure and enforce a secure sign-in experience.
- **Interactive logon: Do not require CTRL+ALT+DEL**: keep this policy **Disabled** (or **Not configured**, because the effective default is already Disabled) so users must press CTRL+ALT+DEL before signing in. The secure attention sequence establishes a trusted path that helps defend against spoofed sign-in screens that harvest credentials. Because the policy is negatively named, *enabling* it removes that protection, so don't enable it as a hardening step.

## Auditing

Security Options also control how audit policy is applied. Before you configure Advanced Audit Policy in Unit 5, enable **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings**. This setting makes the advanced audit subcategories authoritative so older category-level audit policy settings don't override the more precise subcategory settings.

Validate the effective audit configuration after Group Policy refresh:

```powershell
auditpol /get /category:*
```

## Authentication and network security

These settings are where you close the most dangerous legacy gaps:

| Setting | Recommended direction and why |
| --- | --- |
| Network security: LAN Manager authentication level | Use *Send NTLMv2 response only. Refuse LM & NTLM* as a transitional hardening setting. Windows Server 2025 removes NTLMv1, and LANMAN and NTLMv2 are deprecated, so don't treat NTLMv2 as the final state. |
| Network security: Minimum session security for NTLM SSP based (including secure RPC) **clients** and **servers** | Harden both sides by requiring 128-bit encryption and NTLMv2 session security while you remove NTLM dependencies. |
| Network security: Restrict NTLM (audit, then deny) | Inventory NTLM usage, define exceptions only where required, then block NTLM where possible. Have application owners use Negotiate so Kerberos is selected when the client can supply a valid target name such as an SPN, UPN, or NetBIOS account name. |
| Network security: Configure encryption types allowed for Kerberos | Require AES and remove RC4, but audit RC4 usage and remediate dependent accounts and devices first. |
| Network security: LDAP client signing requirements | Require signing to prevent LDAP tampering and relay. |
| Domain controller: LDAP server signing requirements | Require signing on the domain controller side. |
| Domain controller: LDAP server signing requirements enforcement | Windows Server 2025 setting that makes new Active Directory deployments require LDAP signing by default. It's separate from **Domain controller: LDAP server signing requirements** and takes precedence over it; when both are configured, the enforcement policy applies. Its *Not Configured* state has the same effect as *Enabled* (the new-deployment default). In-place upgrades to Windows Server 2025 preserve existing LDAP policies, so set this explicitly after upgrading a domain controller. |
| Domain controller: LDAP server channel binding token requirements | Start with compatibility validation, such as **When Supported** plus event monitoring, then use **Always** only after LDAP clients support channel binding. Channel Binding Tokens bind LDAP authentication over SSL/TLS to the TLS session, which helps protect LDAPS and simple-bind scenarios from relay and session-hijack attacks. |
| Microsoft network client: Digitally sign communications (always) and Microsoft network server: Digitally sign communications (always) | Require SMB signing to defeat SMB relay attacks. |
| Network access: Do not allow anonymous enumeration of SAM accounts and shares | Block anonymous reconnaissance that lists accounts and shares on member and standalone servers. This setting, along with the related **Network access: Do not allow anonymous enumeration of SAM accounts**, has no effect on domain controllers; on domain controllers, limit exposure with **Network access: Restrict clients allowed to make remote calls to SAM** and directory permissions. |
| Network access: Restrict clients allowed to make remote calls to SAM | Limit remote SAM queries to an explicit allow list. |

> [!NOTE]
> Windows Server 2025 requires outbound SMB signing by default. The Windows Server 2025 security baseline hardens SMB further by requiring signing for both SMB client and SMB server connections. Use **Microsoft network client: Digitally sign communications (always)** and **Microsoft network server: Digitally sign communications (always)** to confirm the baseline state, and validate older or non-Windows SMB devices before enforcement.

> [!IMPORTANT]
> Windows Server 2025 removes NTLMv1. LANMAN and NTLMv2 remain available only as deprecated compatibility technologies. Use the **Restrict NTLM** audit settings to find dependencies, then move applications and services toward Negotiate/Kerberos before you deny NTLM.

LDAP signing and LDAP channel binding solve related but different problems. LDAP signing verifies LDAP message integrity. LDAP channel binding uses Channel Binding Tokens (CBT) for LDAP over SSL/TLS so the authentication is bound to the TLS session. On Windows Server 2025, new Active Directory deployments require LDAP signing by default through **Domain controller: LDAP server signing requirements enforcement**, which takes precedence over the older **Domain controller: LDAP server signing requirements** policy. Domain controllers upgraded from earlier versions keep their existing LDAP settings, so review the LDAP signing and channel binding defaults, monitor Directory Service events, and move from audit or compatibility settings to stronger enforcement after clients are ready.

Other network settings to review include **Domain member: Digitally encrypt or sign secure channel data (always)**, **Domain member: Maximum machine account password age**, **Domain controller: Allow vulnerable Netlogon secure channel connections** (Zerologon hardening), and **Network access: Let Everyone permissions apply to anonymous users** (keep disabled).

> [!CAUTION]
> Removing RC4 from **Network security: Configure encryption types allowed for Kerberos** can break Kerberos authentication for accounts and devices that still rely on RC4. Before you enforce AES, audit RC4 usage: on domain controllers, review Kerberos events (Event IDs 4768 and 4769) and the `msDS-SupportedEncryptionTypes` attribute to find user, service, and computer accounts that request or accept RC4. Update those accounts and devices to support AES, then remove RC4 in stages and monitor for authentication failures.

## User Account Control

User Account Control (UAC) keeps administrators running with a standard token until they explicitly elevate. The key options are:

- **User Account Control: Run all administrators in Admin Approval Mode**: the primary control; keep it enabled.
- **User Account Control: Admin Approval Mode for the built-in Administrator account**: apply UAC to the built-in Administrator.
- **User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode** and **User Account Control: Behavior of the elevation prompt for standard users**: control whether users are prompted, prompted for credentials, or denied.
- **User Account Control: Switch to the secure desktop when prompting for elevation**: isolate the prompt from spoofing.
- **User Account Control: Detect application installations and prompt for elevation** and **User Account Control: Only elevate UIAccess applications that are installed in secure locations**: govern installer and accessibility elevation.

## Cryptography, shutdown, and devices

- **System cryptography: Use FIPS compliant algorithms**: enable only when a compliance requirement mandates Windows FIPS mode as part of a documented configuration. The setting doesn't make applications or services FIPS-compliant by itself and can affect TLS, Encrypting File System (EFS), Remote Desktop Services, and BitLocker behavior.
- **System cryptography: Force strong key protection for user keys stored on the computer**: require stronger protection for private keys used by users and applications.
- **Shutdown: Allow system to be shut down without having to log on**: disable on servers.
- **Devices: Prevent users from installing printer drivers**, **Devices: Restrict CD-ROM access to locally logged-on user only**, and **Devices: Restrict floppy access to locally logged-on user only**: reduce driver-based risk and limit simultaneous local and remote access to shared CD-ROM or floppy drives. The CD-ROM and floppy settings don't provide broad USB or removable-storage device control.

> [!TIP]
> Several strong hardening controls, namely the **MSS (legacy) settings, and running LSASS as a protected process (**RunAsPPL**), ship in the Windows Server 2025 security baseline rather than as individual Security Options. You apply that baseline with OSConfig in Unit 8.

**Real-world example.** Contoso's audit flags weak and legacy authentication. You set **LAN Manager authentication level** to *Send NTLMv2 response only. Refuse LM & NTLM*, require **SMB, and **LDAP** signing, configure **Domain controller: LDAP server channel binding token requirements**, remove RC4 from the allowed Kerberos encryption types, and block anonymous SAM enumeration. Because NTLMv2 is deprecated and older clients can depend on NTLM, unsigned LDAP, or LDAPS without channel binding, you first enable the **Restrict NTLM** audit options, review LDAP signing and channel-binding events with application owners, audit Kerberos encryption-type usage (Event IDs 4768 and 4769 and the `msDS-SupportedEncryptionTypes` attribute) and update accounts and devices to AES, and update applications to use Negotiate/Kerberos and supported LDAP protections before you move to enforcement.

## Configure a security option

Set an option through Group Policy:

1. In `gpmc.msc`, edit the target GPO.
1. Go to `Computer Configuration` > `Policies` > `Windows Settings` > `Security Settings` > `Local Policies` > `Security Options`.
1. Double-click the setting, select **Define this policy setting**, choose the value, then select **OK**.

> [!TIP]
> Unit 5 uses Advanced Audit Policy Configuration. The Security Option **Audit: Force audit policy subcategory settings (Windows Vista or later) to override audit policy category settings** keeps those advanced subcategory settings authoritative.

> [!CAUTION]
> Requiring SMB or LDAP signing, setting LDAP channel binding to **Always**, and restricting NTLM can break legacy applications and non-Windows clients. Stage these changes with audit or compatibility settings first, review Directory Service and NTLM audit events, and remember that some settings need a restart to take effect.
>
> Don't use **System cryptography: Use FIPS compliant algorithms** as a general hardening toggle. Enable it only for a documented FIPS requirement, and test application compatibility, TLS connections, EFS, Remote Desktop Services, and BitLocker before production rollout.

Validate the result after a refresh:

```powershell
New-Item -ItemType Directory -Force C:\Temp | Out-Null
gpupdate /force
gpresult /h C:\Temp\rsop.html
```
