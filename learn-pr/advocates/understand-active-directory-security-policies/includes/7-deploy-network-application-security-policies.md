The remaining Security Settings nodes protect the network and control which applications can run. You deploy them through Group Policy to establish a consistent baseline across every server.

## Windows Defender Firewall with Advanced Security

> [!NOTE]
> Current Microsoft documentation generally uses the name **Windows Firewall**. In Group Policy and the MMC snap-in, this feature is still labeled **Windows Defender Firewall with Advanced Security**. Use that node name when following the GPO steps in this unit.

This node deploys the host firewall to every computer in scope. You configure it per **profile** (Domain, Private, and Public) and define:

- **Default inbound and outbound actions** for each profile.
- **Inbound and outbound rules** that allow or block specific programs, ports, and protocols.
- **Connection security rules** that require authentication or encryption between hosts.

> [!NOTE]
> Connection security rules secure traffic with IPsec authentication or encryption. They don't create inbound or outbound allow rules for application traffic. If a profile's default inbound action is **Block**, you still need explicit Windows Firewall allow rules for the required programs, ports, and protocols.

A common baseline sets the default inbound action to **Block** and then allows only the traffic each server role needs, which reduces exposed ports and supports server isolation.

## IP Security Policies and connection security

The **IP Security Policies on Active Directory** node holds the legacy IPsec policy engine. For new work, prefer **connection security rules** under Windows Defender Firewall with Advanced Security, which implement server and domain **isolation**: only authenticated (and optionally encrypted) computers can communicate, typically using Kerberos for authentication. Keep the legacy node only for interoperability with older systems.

Use connection security rules together with firewall rules: create the allow rules required for the server role, then add connection security rules when that traffic must be authenticated or encrypted between hosts.

## Application control: AppLocker, SRP, and App Control for Business

The Security Settings node includes two Group Policy-based application-control areas, and Microsoft also provides a newer application-control platform outside this node:

- **Software Restriction Policies (SRP)**: a deprecated, still-present Group Policy engine that allows or blocks software by hash, path, zone, or certificate. Don't use SRP for new deployments; use App Control for Business where feasible, or AppLocker when you need a Group Policy allowlisting option and App Control isn't practical.
- **Application Control Policies (AppLocker)**: a supported Group Policy allowlisting engine that's useful when you need per-user or per-group rules, staged auditing, or compatibility with environments that already manage application control through GPO. AppLocker uses rule collections for **Executable**, **Windows Installer**, **Script**, **Packaged apps and packaged app installers**, and **DLL** files, with conditions based on **Publisher**, **Path**, or **File hash**. Each collection can run in **Audit only** or **Enforce rules** mode, and AppLocker depends on the **Application Identity** service.
- **App Control for Business**: the preferred Microsoft path for new, robust application-control deployments where feasible. It provides stronger system-wide control and is managed outside the Group Policy Security Settings node, so this unit only positions it rather than walking through a full deployment.

> [!IMPORTANT]
> Use AppLocker as a supported Group Policy and defense-in-depth option when its scoping and management model fit the environment. For Server Core or for a new deployment that needs stronger system-wide protection, evaluate App Control for Business first.

Before you build AppLocker rules, confirm that AppLocker fits the target servers and rollout model:

- AppLocker isn't supported on Server Core installations. Use App Control for Business for Server Core or for new deployments that need stronger system-wide application control.
- By default, AppLocker policy applies to code launched in a user's context. On Windows Server 2016 or later, you can extend AppLocker to nonuser processes when that scenario is required.
- Create the default rules for each managed rule collection before you add custom allow rules. Default rules are a starter policy that helps Windows and Program Files content continue to run while you test.
- If a rule collection contains allow rules, only files that match an allow rule and don't match a deny rule can run in that collection.
- The **Packaged apps and packaged app installers** collection uses publisher conditions only. The DLL rule collection is disabled by default; enable and enforce DLL rules only when you're ready to allow every DLL required by approved apps.

> [!IMPORTANT]
> AppLocker controls packaged apps (MSIX and Microsoft Store apps) through a separate rule collection. If you enforce any rules in the **Executable** collection, you must also create rules in the **Packaged apps and packaged app installers** collection, with at least the default rule, or AppLocker blocks *all* packaged apps and packaged app installers on those systems. Create and validate packaged-app allow rules before you switch executable rules to **Enforce rules**.

**Real-world example.** Contoso must allow list applications on administrative jump servers that run a supported full installation of Windows Server. You create default rules and publisher-based executable rules, deploy the collections in **Audit only** mode, enable the **Application Identity** service, review AppLocker events and `Test-AppLockerPolicy` results, then switch only the validated collections to **Enforce rules**.

## Public Key Policies

Public Key Policies distribute certificate trust and enrollment settings:

- **Certificate Services Client – Auto-Enrollment**: when AD CS prerequisites are met, automatically enrolls and renews computer or user certificates for scenarios such as LDAPS and 802.1X.
- **Encrypting File System (EFS)**: configure EFS behavior and data recovery agents.
- **BitLocker Drive Encryption**: add BitLocker data recovery agent certificates. Configure most BitLocker encryption, recovery password, TPM/PIN, and key-storage policy under `Administrative Templates` > `Windows Components` > `BitLocker Drive Encryption`, or with modern management where supported.
- **Trusted Root Certification Authorities**, **Enterprise Trust**, and **Intermediate Certification Authorities**: distribute trusted roots and control path validation.

## Network identification and access

- **Network List Manager Policies**: control how nondomain networks are named and categorized, including **Unidentified Networks** that Windows can't classify. Use them to set a trusted unidentified management or backup network to **Private** or to keep untrusted networks **Public**. Don't use Network List Manager to turn a domain network into Private; Windows applies the **Domain** firewall profile (the `DomainAuthenticated` network category reported by `Get-NetConnectionProfile`) automatically after successful domain detection and authentication by the network profile components.
- **Wired Network (IEEE 802.3) Policies** and **Wireless Network (IEEE 802.11) Policies**: push **802.1X** authentication, allowed profiles or SSIDs, and EAP types for network access control.

> [!IMPORTANT]
> If a domain-joined server is using the Public profile on a domain network, troubleshoot domain profile detection instead of forcing the network to Private. Check DNS discovery of domain controllers and LDAP connectivity to a domain controller, because Windows applies the **Domain** firewall profile (the `DomainAuthenticated` network category) only after domain detection and authentication succeed.

## Configure network and application policies

Create a firewall inbound rule and set the default action:

1. In `gpmc.msc`, edit the target GPO and go to `Security Settings` > `Windows Defender Firewall with Advanced Security`.
1. Set each profile's default inbound action to **Block**.
1. Add **Inbound Rules** for the traffic the role requires. If server or domain isolation is required, add **Connection Security Rules** for the same traffic after the allow rules are defined.

Build an AppLocker allow list in audit mode:

1. Confirm the target servers support AppLocker and aren't Server Core installations. In the target GPO, set the **Application Identity** service (`AppIDSvc`) startup mode to **Automatic** through `Security Settings` > `System Services`; after policy refresh or restart, verify the service is running, or start it explicitly for the current session.
1. Go to `Security Settings` > `Application Control Policies` > `AppLocker`.
1. For each rule collection you plan to manage, create the default rules first. Start with the **Executable**, **Windows Installer**, and **Script** collections. If the target systems run packaged (MSIX/Store) apps, also create rules in the **Packaged apps and packaged app installers** collection, including at least the default rule, before you enforce Executable rules, or all packaged apps and installers are blocked. Add **DLL** rules only when that collection is required.
1. Add allow rules for approved applications. Prefer publisher rules for signed applications because they're more resilient to updates; use path rules only for locations writable only by administrators, and use file-hash rules when no better condition is available.
1. Set each managed collection's enforcement mode explicitly to **Audit only** for the pilot rollout.
1. Link the GPO to a pilot OU, run `gpupdate /force`, and review the AppLocker event logs under `Application and Services Logs\Microsoft\Windows\AppLocker`.
1. Export and test the effective policy before enforcement:

   ```powershell
   Get-AppLockerPolicy -Effective -Xml > C:\Temp\Effective-AppLocker.xml
   Get-ChildItem 'C:\Program Files' -Filter *.exe -Recurse |
       Convert-Path |
       Test-AppLockerPolicy -XMLPolicy C:\Temp\Effective-AppLocker.xml -User CONTOSO\AdminUser -Filter Denied,DeniedByDefault
   ```

1. After audit events and `Test-AppLockerPolicy` results show that required apps are allowed, change the selected collections from **Audit only** to **Enforce rules** in a staged rollout.

Enable certificate autoenrollment and set a trusted nondomain network to Private:

> [!NOTE]
> Enabling **Certificate Services Client – Auto-Enrollment** only starts the client-side request process. Autoenrollment also requires an Enterprise CA, a certificate template that's configured and published for autoenrollment, and **Enroll** plus **Autoenroll** permissions for the target computers or users. Configure computer certificates under `Computer Configuration`; configure user certificates under `User Configuration`.

1. For computer certificates, go to `Computer Configuration` > `Policies` > `Windows Settings` > `Security Settings` > `Public Key Policies` > `Certificate Services Client – Auto-Enrollment`. For user certificates, use the same path under `User Configuration`. Set autoenrollment to **Enabled**, and select the renew and template-update options required by your certificate design.
1. Go to `Network List Manager Policies`, open **Unidentified Networks** or a named nondomain network, and set **Location type** to **Private** only for trusted internal networks. Leave untrusted or internet-facing networks as **Public**.

Validate the results:

```powershell
gpupdate /force

# Firewall profiles and rules
Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
Get-NetFirewallRule -PolicyStore ActiveStore | Select-Object DisplayName, Enabled, Direction, Action

# Network category/profile assigned by the network profile components and Network List Manager policies
Get-NetConnectionProfile | Select-Object InterfaceAlias, NetworkCategory

# Connection security (IPsec) rules delivered by the GPO
Get-NetIPsecRule -PolicyStore ActiveStore | Select-Object DisplayName, Enabled, Mode, InboundSecurity, OutboundSecurity

# AppLocker effective policy
Get-AppLockerPolicy -Effective -Xml

# Certificate auto-enrollment: trigger a pulse, then confirm issued machine certificates
certutil -pulse
Get-ChildItem Cert:\LocalMachine\My | Select-Object Subject, Issuer, NotAfter
```
