Windows Server 2025 updates Kerberos and related authentication behavior in several important ways. These changes improve security, but they also expose legacy dependencies that earlier domain controllers or permissive fallback paths might have hidden.

## Windows Server 2025 changes to plan for

| Area | Windows Server 2025 behavior | Planning impact |
| --- | --- | --- |
| TGT encryption | Domain controllers don't issue TGTs using RC4, such as RC4-HMAC(NT). | Clients and accounts that require RC4 for initial Kerberos authentication must be remediated before they depend on Windows Server 2025 KDCs. |
| PKINIT | PKINIT supports cryptographic agility by supporting more algorithms and removing hardcoded algorithm assumptions. | Certificate-based sign-in and smart card scenarios should be validated with current certificates, CA chains, and domain controller certificates. |
| Kerberos encryption configuration | Kerberos no longer honors the legacy `SupportedEncryptionTypes` registry value under `HKEY_LOCAL_MACHINE\CurrentControlSet\Control\Lsa\Kerberos\Parameters`. | Use Group Policy and account attributes for encryption type configuration instead of legacy registry tuning. |
| SAM RPC password change | Newer AES-based remote SAM RPC password-change behavior is accepted by default on domain controllers. Older remote SAM RPC password-change methods are blocked by default. | Test helpdesk tools, password portals, appliances, and custom scripts that change domain passwords remotely. |
| SMB NTLM blocking | The SMB client can block NTLM for remote outbound SMB connections. | If SMB NTLM blocking is enabled, SMB access must use Kerberos unless the target is in an explicit exception list. |

The most urgent readiness issue is RC4. Windows Server 2025 domain controllers don't issue RC4 TGTs. RC4 can also appear in service-ticket, trust, or legacy device investigations. Treat RC4 dependency as a modernization blocker, not as a tuning preference.

## Understand the Kerberos encryption type decision

Kerberos encryption type selection is the result of several inputs:

- The encryption types that the client advertises for the request.
- The keys available on the user, computer, service account, `krbtgt`, or trust account.
- The account's `msDS-SupportedEncryptionTypes` value, if configured.
- The KDC's assumed defaults for accounts that don't have an explicit value.
- The allowed encryption types are configured under **Network security: Configure encryption types allowed for Kerberos**, located at:
  - **Domain GPO (GPMC)**: **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**
  - **Local Group Policy Editor**: **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**
- Trust object encryption type settings for cross-domain or cross-forest referrals.
- The operating system and application support on clients, servers, appliances, and non-Windows Kerberos implementations.

Don't assume that one setting fixes all encryption problems. For example, enabling AES in Group Policy doesn't create AES keys for an old service account if the account password hasn't been reset since AES support was introduced. Setting `msDS-SupportedEncryptionTypes` on an account doesn't help if the service or device can't actually use AES. Changing KDC defaults can affect every account that doesn't have an explicit value.

This encryption-policy path is different from the **Advanced Audit Policy Configuration** path used to enable Kerberos Authentication Service and Kerberos Service Ticket Operations auditing. Test encryption-policy changes in stages: removing an encryption type that accounts or services still depend on causes Kerberos authentication failures across all systems bound by the policy. Apply the change in a lab first, then to a representative pilot OU, before broad deployment.

## Audit RC4 usage

Start with auditing. Security events 4768 and 4769 on KDCs expose ticket requests and encryption details when Kerberos account logon auditing is enabled.

Use these events:

| Event ID | Meaning | What to inspect |
| --- | --- | --- |
| 4768 | A Kerberos authentication ticket, or TGT, was requested. | Account, client address, advertised encryption types, TGT, and session encryption details, preauthentication behavior. |
| 4769 | A Kerberos service ticket was requested. | Requested SPN, service account, ticket encryption type, session encryption type, failure code. |

In Group Policy, Kerberos auditing is under **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **Advanced Audit Policy Configuration** > **Audit Policies** > **Account Logon**. Audit **Kerberos Authentication Service** for TGT activity and **Kerberos Service Ticket Operations** for service ticket activity.

Important event fields include:

- **MSDS-SupportedEncryptionTypes**: A processed view of supported encryption types for the account or service. Starting with Windows Server 2025, processed values for relevant security principals show AES-SHA1 and stronger algorithms rather than always showing DES and RC4 for compatibility.
- **Available Keys**: The keys available for the account in AD DS. RC4 can be shown regardless of whether the request used RC4.
- **Advertized Etypes**: The encryption types that the client advertised for the operation. The event field uses the spelling **Advertized**.
- **Ticket Encryption Type**: The algorithm used to encrypt the ticket. RC4 service tickets are commonly shown as `0x17`.
- **Session Encryption Type**: The algorithm used for the ticket session key.
- **Result Code** in Event ID 4768: Reports the outcome of the TGT request. For example, `0xE` maps to `KDC_ERR_ETYPE_NOTSUPP`, which indicates that the KDC couldn't find a supported encryption type.
- **Failure Code** in Event ID 4769: Reports the outcome of the service-ticket request. The same `0xE` value indicates that the KDC couldn't find a supported encryption type for that request.

Example interpretation:

| Observation | Meaning | Likely remediation |
| --- | --- | --- |
| Event ID 4769 shows `Ticket Encryption Type: 0x17` | A service ticket used RC4. | Identify the service account and verify AES support, AES keys, and application compatibility. |
| Event ID 4769 fails with `Failure Code: 0xE` | The KDC couldn't issue a ticket with a mutually supported encryption type. | Compare client advertised types, service account `msDS-SupportedEncryptionTypes`, available keys, Group Policy, and trust settings. |
| `msDS-SupportedEncryptionTypes` is empty for a service account with an SPN | The KDC uses default assumptions for that account. | Configure the service account deliberately if necessary, and confirm the service supports the selected types. |
| Account has no AES keys | The account password hasn't been changed since AES keys could be generated, or the account is otherwise missing key material. | Reset the password for the user or service account, or rotate the managed service account password. |

You can inspect service accounts with SPNs by using the Active Directory PowerShell module:

```powershell
Get-ADObject -LDAPFilter "(servicePrincipalName=*)" `
    -Properties servicePrincipalName,msDS-SupportedEncryptionTypes |
    Select-Object Name,ObjectClass,msDS-SupportedEncryptionTypes,servicePrincipalName
```

For a specific account:

```powershell
Get-ADUser svc-intranet -Properties servicePrincipalName,msDS-SupportedEncryptionTypes |
    Select-Object Name,Enabled,msDS-SupportedEncryptionTypes,servicePrincipalName
```

## Remediate RC4 dependencies

Common remediation actions include:

- Reset passwords for old user or service accounts so AES keys exist.
- Confirm that services, appliances, and non-Windows Kerberos clients support AES-SHA1 or stronger Kerberos encryption.
- Move traditional user-based service accounts to gMSAs or dMSAs where appropriate. Before using dMSA, confirm that at least one Windows Server 2025 domain controller is discoverable, all hosts that use the migrated account support dMSA, and migration can reach a read-write domain controller. You can't migrate from a gMSA to a dMSA. Validate every host in a mixed-version workload before migration, and after starting migration wait at least 14 days (two ticket lifetimes) before completing it; completing too early disables the original service account before all hosts have enrolled, causing authentication failures.
- Configure service accounts and computer accounts deliberately when an explicit `msDS-SupportedEncryptionTypes` value is required.
- Use Group Policy to define allowed Kerberos encryption types instead of the legacy `SupportedEncryptionTypes` registry value.
- Update or replace devices that only support RC4.
- Validate trust encryption types before disabling RC4 in cross-domain or cross-forest scenarios.
- Test line-of-business applications with NTLM fallback disabled or blocked so Kerberos problems aren't hidden.

If you set an explicit encryption type value on a service account, use a lab first and document the service requirement. For example, decimal `24` (`0x18`) represents AES128 plus AES256 in the `msDS-SupportedEncryptionTypes` bitmask:

```powershell
Set-ADUser svc-intranet -Replace @{"msDS-SupportedEncryptionTypes" = 24}
```

This example is appropriate only when the service supports AES and the account has AES keys. If the service can't use AES, the correct fix is to update or replace the service, not to preserve RC4 indefinitely.

For trusts, confirm the referral path. A client might support AES and the target service might support AES, but a trust object that only supports RC4 can still cause a referral failure when RC4 is disabled. In a lab, `ksetup /getenctypeattr <domain>` and `ksetup /setenctypeattr <domain> <encryption-types>` can help validate trust encryption behavior. In production, coordinate trust changes with both sides of the trust and test referral tickets before enforcement.

## Validate PKINIT and certificate-based sign-in

PKINIT is used when Kerberos initial authentication relies on public key cryptography, such as smart card sign-in and some certificate-based authentication scenarios. Windows Server 2025 PKINIT support for cryptographic agility means the implementation can support more algorithms and isn't tied to hardcoded algorithm assumptions.

Cryptographic agility doesn't remove the normal PKI requirements. Validate that:

- Domain controllers have appropriate certificates for Kerberos authentication.
- Clients trust the issuing certification authorities.
- Certificate templates and key algorithms meet your organization's security requirements.
- Certificate mapping, user principal names, and account status are correct.
- Smart card and certificate sign-in paths still produce usable TGTs after domain controller upgrades.

If certificate-based sign-in fails, separate certificate chain validation from Kerberos policy. A certificate trust failure, expired certificate, missing user mapping, unsupported algorithm, or account restriction can all surface before a TGT is issued.

## Test SAM RPC password-change workflows

Windows Server 2025 changes remote SAM RPC password-change behavior. Secure protocols such as Kerberos are preferred. On domain controllers, the newer `SamrUnicodeChangePasswordUser4` method that uses AES is accepted by default when called remotely. Older remote SAM RPC methods are blocked by default:

- `SamrChangePasswordUser`
- `SamrOemChangePasswordUser2`
- `SamrUnicodeChangePasswordUser2`

For domain users who are members of the Protected Users group, and for local accounts on domain member computers, all remote password changes through the legacy SAM RPC interface are blocked by default, including `SamrUnicodeChangePasswordUser4`.

The related policy is:

**Computer Configuration** > **Administrative Templates** > **System** > **Security Account Manager** > **Configure SAM change password RPC methods policy**

Include password-change workflows in compatibility testing for old helpdesk tools, embedded devices, custom password portals, identity management connectors, and scripts. A tool that can reset a password through LDAP or a supported management API might be fine, while a tool that changes a password through an older SAM RPC method might fail only after Windows Server 2025 domain controllers are used.

## Use staged enforcement

Use an evidence-driven rollout:

1. Enable auditing and collect 4768, 4769, NTLM, and service logon evidence.
1. Identify RC4 TGT, RC4 service-ticket, NTLM fallback, trust, and password-change dependencies.
1. Remediate accounts, SPNs, service identities, trusts, and applications.
1. Test with representative Windows, non-Windows, appliance, service account, smart card, and cross-forest scenarios.
1. Enforce stronger Kerberos encryption policy and SMB NTLM blocking in phases.
1. Keep documented exceptions temporary, owned, and monitored.

The best hardening plan proves compatibility before enforcement. It also proves that a successful connection is using the intended protocol, not succeeding only because NTLM or RC4 remained available.

