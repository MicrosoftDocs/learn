SSPI (Security Support Provider Interface) is the Windows API that applications use to perform authentication and establish secure communications without needing to implement authentication protocols themselves. Applications commonly use SSPI rather than directly implementing Kerberos or NTLM. SSPI lets the application acquire credentials, initialize or accept a security context, and exchange opaque tokens until authentication completes. While that abstraction is useful for developers, but it can hide the protocol path from administrators.

## SSPI and the Negotiate package

SSPI exposes security packages such as Kerberos, NTLM, Negotiate, Schannel, and CredSSP. Most Windows-integrated applications use **Negotiate**. Negotiate tries to select the strongest package that works for the target and the current credentials.

Kerberos is normally selected when:

- The client has domain credentials and can reach a Kerberos Key Distribution Center (KDC).
- The application passes a usable target name, usually an SPN such as `HTTP/web01.contoso.com`, `CIFS/fs01.contoso.com`, or `MSSQLSvc/sql01.contoso.com:1433`.
- The service account that runs the target service owns that SPN.
- The client, KDC, service account, and trust path share compatible Kerberos encryption types.

NTLM might be selected when:

- The target is referenced in a way that doesn't map to the expected SPN, such as an IP address or an alias that doesn't have a matching SPN.
- The server isn't domain joined or the client is in a workgroup.
- Kerberos fails and the application or protocol allows fallback.
- The application explicitly requests NTLM instead of Negotiate.
- A trust, delegation, or encryption type configuration prevents Kerberos from completing.

Windows Server 2025 makes this distinction more important. Server Message Block (SMB) can now block NTLM for remote outbound connections. If you enable SMB NTLM blocking, a connection that previously "worked" through NTLM fallback must use Kerberos or match an explicit exception.

## Kerberos flow

At the protocol level, Kerberos usually follows this pattern:

1. The user or computer signs in and requests a TGT from the KDC authentication service.
1. The KDC validates the principal, preauthentication data, policy, and encryption type compatibility, then returns a TGT.
1. The client requests a service ticket for an SPN from the KDC ticket-granting service.
1. The KDC evaluates the client, service account, SPN, policy, delegation settings, trust path, and encryption type compatibility.
1. The client presents an Application Request (AP-REQ) to the service.
1. The service decrypts the ticket with the key for its service account, validates the authenticator, and builds a security context.
1. Windows uses authorization data, including the PAC, group memberships, claims, and local resource permissions, to decide access.

The following table maps each phase to common evidence.

| Phase | Typical evidence | Example failure |
| --- | --- | --- |
| Initial authentication | Event ID 4768 or 4771 on the KDC, `klist tgt` on the client | Bad password, disabled account, failed preauthentication, unsupported TGT encryption type |
| Service ticket request | Event ID 4769 on the KDC, `klist get <SPN>` | Missing SPN, duplicate SPN, unsupported service-ticket encryption type |
| Ticket presentation | Event ID 4624 on the service, application logs | Service runs under a different account than the SPN owner, service lacks the key to decrypt the ticket |
| Authorization | Resource audit logs, application authorization logs, `whoami /groups` | User authenticated successfully but lacks access, token is too large, group membership is missing |

For example, a user might access `https://intranet.contoso.com`. The browser asks SSPI for a security context for `HTTP/intranet.contoso.com`. If the SPN is registered on the wrong account, the KDC can still issue a ticket, but the web server might be unable to decrypt it. If the SPN is missing, Negotiate might fall back to NTLM unless the application, browser, or protocol blocks fallback.

## SPNs and service identity

An SPN connects a service name to the AD DS account that owns the service key. Kerberos doesn't authenticate a host name by itself. It authenticates a service principal.

Common examples include:

| Service | Example SPN | Account that should own it |
| --- | --- | --- |
| SMB file server | `CIFS/fs01.contoso.com` | The computer account for `FS01` unless SMB is running under a custom identity |
| IIS web application | `HTTP/web01.contoso.com` | The computer account for kernel-mode authentication, or the application pool identity when configured to use it |
| SQL Server | `MSSQLSvc/sql01.contoso.com:1433` | The SQL Server service account |
| LDAP on a domain controller | `LDAP/dc01.contoso.com` | The domain controller computer account |

You can use `setspn` to inspect ownership before changing anything:

```cmd
setspn -Q HTTP/intranet.contoso.com
setspn -X
```

Use `setspn -S` rather than `setspn -A` when you add an SPN, because `-S` checks for duplicates before writing the value:

```cmd
setspn -S HTTP/intranet.contoso.com CONTOSO\svc-intranet
```

## NTLM flow and fallback

NTLM follows a challenge-response model. The server sends a challenge, the client proves knowledge of the password-derived secret, and the server either validates the response against its local Security Accounts Manager database or asks a domain controller through Netlogon pass-through authentication. NTLM doesn't provide the same server identity validation as Kerberos, and it doesn't provide Kerberos delegation.

Fallback matters because it can hide the original Kerberos problem. A file share accessed as `\\fs01.contoso.com\share` might use Kerberos, while the same share accessed through an IP address or unsupported alias might use NTLM. If the user has access, the business symptom disappears, but the environment still has a Kerberos dependency problem.

Use these signals to identify fallback:

- On the target server, Event ID 4624 in the Security log shows **Authentication Package** as `Kerberos` or `NTLM`.
- On the target server, Event ID 4625 in the Security log records a failed logon attempt. It doesn't by itself prove that the service received or decrypted a Kerberos ticket. Correlate its **Authentication Package**, status and substatus values, service or application logs, System Kerberos events, and KDC events before identifying the failed phase. A nearby Event ID 4769 doesn't by itself prove that the later failure was authorization.
- Event ID 4776 is recorded on the computer authoritative for the credentials: a domain controller for a domain account, or the local computer for a local account. It can identify the source workstation, but it doesn't identify the destination computer, so correlate it with target logon and NTLM operational events.
- The **Applications and Services Logs\Microsoft\Windows\NTLM\Operational** log records NTLM audit and block events when NTLM restriction policies are configured.
- For SMB on Windows Server 2025 and Windows 11, version 24H2 or later, `Set-SmbClientConfiguration -BlockNTLM $true` blocks outbound SMB NTLM unless an exception applies.

## Delegation and the double hop

A double-hop scenario occurs when a user authenticates to one service, such as a web server, which must then access another service, such as SQL Server, using the user’s identity. The second hop requires correctly configured Kerberos delegation; local impersonation alone isn’t sufficient. When troubleshooting double-hop scenarios, you need to distinguish impersonation from delegation:

- **Impersonation** lets a service use the client identity on the local computer. It doesn't allow the service to obtain a Kerberos ticket to another server.
- **Delegation** lets a service act on behalf of the client when it connects to another service.

Common delegation patterns include:

| Pattern | Use case | Risk or requirement |
| --- | --- | --- |
| Unconstrained delegation | Legacy applications that need broad delegation | High risk because the service can delegate to many services; avoid for new designs |
| Constrained delegation | Front-end service needs access to specific back-end SPNs | Requires correct SPNs and service account configuration |
| Constrained delegation with protocol transition | Front-end service receives non-Kerberos authentication but needs Kerberos to the back end | Uses Service-for-User (S4U) extensions and requires explicit configuration |
| Resource-based constrained delegation | Back-end resource owner controls which front-end services can delegate to it | Useful across domains and for service-owner administration |

For example, a web server that authenticates a user and then connects to SQL Server with the user's identity needs delegation. If the web application only impersonates locally, the SQL connection often runs as the web server identity or fails with a double-hop error.

## PAC, token size, and authorization

Kerberos authentication proves identity and carries authorization data. It doesn't guarantee access. The service still evaluates the user's token against local or application permissions.

The Privilege Attribute Certificate (PAC) can include security identifiers (SIDs), group memberships, user rights information, claims, and other authorization data. Large group memberships, SID history, and claims can increase ticket and token size. Symptoms can include authentication failures, HTTP request failures, or application-specific access denied errors. When troubleshooting, verify both the Kerberos exchange and the resulting authorization decision.

Useful commands include:

```cmd
klist
klist get HTTP/intranet.contoso.com
whoami /user
whoami /groups
```

- Use klist to display the Kerberos tickets currently cached on the system. If there are no Kerberos tickets, the problem is likely occurring before authorization is ever evaluated.
- Use `klist get HTTP/intranet.contoso.com` to verify that the KDC can resolve the SPN and issue and cache a service ticket for the client. This command doesn't present the ticket to the service or prove that the service can decrypt it.
- Make a real connection to the target, then confirm target-side Event ID 4624 or service-specific evidence showing Kerberos. Validate the application response and authorization result separately.
- Use whoami /user to determine the user's SID.
- Use whoami /groups to view all security groups in the user's access token.
