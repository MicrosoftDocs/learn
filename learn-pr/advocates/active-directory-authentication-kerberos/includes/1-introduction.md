Being able to successfully troubleshoot Windows authentication requires you to separate identity proof, ticket issuance, service identity, delegation, and authorization. A single "access denied" or repeated credential prompt might be caused by DNS, Service Principal Names (SPNs), Kerberos encryption types, trust configuration, Privilege Attribute Certificate (PAC) validation, token size, service account configuration, NTLM fallback, or application impersonation.

In this module you learn how to troubleshoot Windows integrated authentication, migrate eligible authentication flows from NTLM to Kerberos, and prepare Kerberos-dependent environments for Windows Server 2025 hardening.

To get the most out of this module, you should already understand:

Kerberos:

- Is the preferred authentication protocol for Active Directory Domain Services (AD DS) domain accounts and services.
- The Key Distribution Center (KDC) runs on AD DS domain controllers. 
- The KDC issues a Ticket Granting Ticket (TGT) at initial authentication and service tickets for individual services.
- Identifies services through Service Principal Names (SPNs), such as HTTP/web01.contoso.com.
- Depends on DNS, time synchronization, domain connectivity, trusts, compatible encryption, and correct service identities.
- Supports mutual authentication and delegation.
- Carries authorization information in the PAC, but authentication doesn’t guarantee resource access.
- Uses cached, time-limited tickets rather than sending credentials to every service.

That NTLM:

- Uses challenge-response authentication based on password-derived credentials.
- Can validate domain credentials through a domain controller or local credentials on the target computer.
- Doesn’t use tickets or SPNs.
- Doesn’t provide Kerberos-style mutual authentication or delegation.
- Is commonly selected when Kerberos prerequisites aren’t met or an application explicitly requests NTLM.
- Is more exposed to relay, pass-the-hash, and credential-cracking attacks than Kerberos.
- Is deprecated but still enabled and supported in Windows Server 2025.

And that during protocol selection and diagnosis:

- Applications usually call the Security Support Provider Interface (SSPI) and request Negotiate rather than implementing either protocol directly.
- Negotiate normally prefers the Kerberos protocol but can select or fall back to NTLM.
- Successful access doesn’t prove Kerberos was used.
- You need to check event logs, klist, and setspn to confirm the selected protocol, requested SPN, and ticket path.
- Authentication proves identity; authorization evaluates whether that identity can access the resource.

## How AD DS authentication should occur

In a typical Active Directory Domain Services (AD DS) environment, authentication is a sequence of related operations rather than a single exchange. The client locates a domain controller, proves the identity of the user or computer, obtains Kerberos tickets, presents a service ticket to the target, and then receives an access token that the service uses for authorization.

The expected process is:

1. **The client locates the domain and a domain controller.** The client uses DNS service records and DC Locator to find a suitable domain controller for its domain and AD DS site. Correct DNS configuration, site mapping, network connectivity, and time synchronization are prerequisites for reliable Kerberos authentication.
1. **The user or computer establishes an initial identity.** During interactive sign-in, Local Security Authority Subsystem Service (LSASS) receives the credentials through a trusted sign-in component. Domain-joined computers also maintain a machine-account password and authenticate to the domain so that they can establish a secure channel with a domain controller.
1. **The client requests a TGT.** The Kerberos security package sends an Authentication Service Request (AS-REQ) to the Key Distribution Center (KDC) on a domain controller. The request identifies the principal and normally includes preauthentication data that proves possession of a key derived from the password or another credential.
1. **The KDC validates the principal and returns the TGT.** The KDC checks the account, preauthentication data, policy restrictions, supported encryption types, and available key material. If validation succeeds, it returns an Authentication Service Reply (AS-REP). The reply contains a TGT encrypted with the domain `krbtgt` account key and a client session key. The client caches the TGT and uses it for later ticket requests instead of sending the password to each service.
1. **The application asks SSPI for access to a service.** A Windows-integrated application usually calls SSPI with the Negotiate package and supplies a target name. That name must map to the intended SPN, such as `CIFS/fs01.contoso.com`, `HTTP/intranet.contoso.com`, or `MSSQLSvc/sql01.contoso.com:1433`.
1. **The client requests a service ticket.** The client sends a Ticket Granting Service Request (TGS-REQ) containing its TGT and the requested SPN. The KDC resolves the SPN to an AD DS account, evaluates ticket policy and encryption compatibility, and creates authorization data such as the Privilege Attribute Certificate (PAC).
1. **The KDC returns the service ticket.** In the Ticket Granting Service Reply (TGS-REP), the service ticket is encrypted with key material for the account that owns the SPN. Only the service running under that identity should be able to decrypt it. The client also receives a session key for its security context with the service.
1. **The client presents the ticket to the service.** The application sends an Application Request (AP-REQ) through its protocol, such as HTTP, SMB, or a database protocol. The service uses SSPI to accept the token, decrypt the ticket, validate the authenticator, and optionally return an Application Reply (AP-REP) for mutual authentication.
1. **Windows creates the security context and access token.** The service validates the PAC and combines domain authorization data with local groups, privileges, claims, and service-specific information. Windows then creates an access token that represents the authenticated identity in the service process.
1. **The service authorizes the requested operation.** Authentication establishes who the principal is. Authorization determines what that principal can do. The service compares the access token with file permissions, share permissions, application roles, database permissions, or other access-control rules.

If the target is in another trusted domain or forest, the KDC can return a referral TGT that directs the client to a KDC in the target domain. The client follows referrals until it can request the target service ticket. DNS, trust direction, name suffix routing, selective authentication, and encryption compatibility can all affect this path.

Kerberos tickets are cached and have finite lifetimes. The client can reuse a valid TGT to request additional service tickets and can renew eligible tickets without requiring another interactive sign-in. Cached tickets improve performance, but they can also preserve an earlier configuration state during troubleshooting, which is why administrators sometimes purge the cache before retesting.

NTLM is a different path, not an additional Kerberos phase. If the application requests NTLM explicitly, or if Kerberos prerequisites such as a usable SPN, domain connectivity, trust, or compatible encryption are missing, Negotiate might select NTLM when policy permits it. The target then validates a challenge-response exchange locally or through Netlogon pass-through authentication. A successful NTLM connection doesn't prove that the expected Kerberos path is configured correctly.

The following table summarizes the expected Kerberos exchanges.

| Exchange | Participants | Result |
| --- | --- | --- |
| Domain discovery | Client, DNS, DC Locator, domain controller | The client finds an appropriate domain controller and KDC. |
| AS-REQ and AS-REP | Client and KDC | The client proves its initial identity and receives a TGT. |
| TGS-REQ and TGS-REP | Client and KDC | The client receives a service ticket for a specific SPN. |
| AP-REQ and optional AP-REP | Client and target service | The service validates the ticket and establishes a security context, with optional mutual authentication. |
| Authorization | Service, Windows security subsystem, and protected resource | The service evaluates the resulting access token against permissions and policy. |

## Complexities in diagnosing authentication issues

Windows applications usually don't implement Kerberos or NTLM directly. They call the Security Support Provider Interface (SSPI), often through the Negotiate package. Negotiate then chooses a security package, normally Kerberos in an Active Directory Domain Services (AD DS) environment and NTLM when Kerberos can't be used or when the application explicitly requires NTLM.

That abstraction is useful, but it means the symptom doesn't always identify the failing layer. For example:

- A user can sign in successfully but can't access `\\fs01\finance` because the client requested a Common Internet File System (CIFS) service ticket for an SPN that's missing or duplicated.
- A web application can authenticate the user but fail when it connects to SQL Server because the first hop uses impersonation, while the second hop requires Kerberos delegation.
- A legacy appliance can appear to work before Windows Server 2025 domain controllers are introduced because it depends on RC4, but fail when the KDC no longer issues Ticket Granting Tickets (TGTs) with RC4 encryption.
- A helpdesk password reset or change portal can fail because it still uses a legacy remote Security Account Manager (SAM) Remote Procedure Call (RPC) password-change method that Windows Server 2025 blocks by default when called remotely.

## Use an evidence chain

Troubleshooting is easier when you address the following questions about authentication in order:

| Question | Evidence to collect | Common tools |
| --- | --- | --- |
| Did the client contact the expected domain controller? | DC Locator result, DNS records, site mapping | `nltest`, `Resolve-DnsName`, Netlogon logs |
| Did the user or computer obtain a TGT? | Event ID 4768, `klist`, Kerberos preauthentication errors | Event Viewer, `klist` |
| Did the client request the right service ticket? | Event ID 4769, requested SPN, ticket encryption type | Event Viewer, `klist get`, `setspn` |
| Did the service accept the ticket? | Service logon event, SPN ownership, service account key material | Event ID 4624, service logs, `setspn -Q` |
| Did authorization succeed after authentication? | PAC contents, group membership, claims, access control lists | `whoami /groups`, application logs, resource audit logs |
| Did the flow fallback to NTLM? | NTLM operational log, Event ID 4776, Event ID 4624 authentication package | Event Viewer, NTLM audit policy |

## Windows Server 2025 authentication improvements

Windows Server 2025 strengthens authentication in ways that affect planning and troubleshooting:

- **RC4 TGT removal**: Windows Server 2025 domain controllers don't issue TGTs using RC4, such as RC4-HMAC(NT). A principal that can only obtain Kerberos initial authentication with RC4 must be remediated.
- **RC4 service-ticket readiness**: RC4 can still appear in compatibility investigations for legacy services, trusts, and devices. Treat every RC4 dependency as technical debt because it weakens Kerberos and can block future hardening.
- **PKINIT cryptographic agility**: Public Key Cryptography for Initial Authentication in Kerberos (PKINIT), used by scenarios such as smart card or certificate-based sign-in, supports cryptographic agility by removing hardcoded algorithm assumptions.
- **Encryption type configuration**: Kerberos no longer honors the legacy `SupportedEncryptionTypes` registry value at `HKEY_LOCAL_MACHINE\CurrentControlSet\Control\Lsa\Kerberos\Parameters`. Use Group Policy and account attributes instead.
- **SAM RPC password-change hardening**: Secure protocols such as Kerberos are preferred. Windows Server 2025 accepts the newer AES-based remote SAM RPC password-change method by default on domain controllers and blocks older remote methods by default.
- **SMB NTLM blocking**: Beginning with Windows Server 2025, the SMB client can block NTLM for remote outbound SMB connections so organizations can force SMB access to use Kerberos except for explicit exceptions.

The operational goal isn't only to make authentication succeed. The goal is to prove which protocol was used, why it was selected, which account keys and policy settings were involved, and whether the outcome remains secure when Windows Server 2025 domain controllers and clients are introduced.

The module also explains how to move services from NTLM fallback to Kerberos. The migration approach begins with auditing, then classifies each dependency, remediates Kerberos prerequisites, validates the resulting ticket path, and applies NTLM restrictions in controlled phases.
