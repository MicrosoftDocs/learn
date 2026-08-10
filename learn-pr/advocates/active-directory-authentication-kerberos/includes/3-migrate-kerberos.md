Organizations that still use NTLM should be migrating to Kerberos. NTLM is deprecated but still supported in Windows Server 2025. Windows applications commonly request Negotiate authentication, and Negotiate selects Kerberos when the client, service, identity, name, and trust path meet Kerberos requirements. NTLM use often indicates that one of those requirements isn't met or that an application explicitly requests NTLM.

A safe migration therefore has two related goals:

- Make Kerberos work for domain authentication scenarios that currently fall back to NTLM.
- Restrict NTLM only after you understand and remediate the remaining dependencies.

> [!WARNING]
> Your first step shouldn't be to block NTLM across the domain. If you enforce restrictions before collecting evidence, you can interrupt applications, management tools, clustered services, appliances, trusts, and access to resources that can't yet use Kerberos.

## Define the migration boundary

Kerberos is the preferred authentication protocol for AD DS environments, but it can't replace every use of NTLM. When planning migration from NTLM to Kerberos, define which connections are expected to migrate and which scenarios need a different remediation.

| Scenario | Migration expectation |
| --- | --- |
| Domain user accesses a domain service by using its DNS name | Kerberos should normally be possible when the SPN, service identity, DNS, and trust path are correct. |
| Application explicitly requests NTLM | Reconfigure, update, or replace the application so that it uses Negotiate or Kerberos. |
| Client accesses a server by IP address | Use a DNS name that maps to a valid SPN. Kerberos doesn't normally use an IP address as the service identity. |
| Workgroup or local-account authentication | Traditional domain Kerberos isn't a direct replacement. Redesign the identity or access model, or document a constrained exception. |
| Legacy appliance or non-Windows service | Confirm whether it supports Kerberos and can use the required encryption types. Update, reconfigure, replace, or isolate it as appropriate. |
| Cross-domain or cross-forest access | Validate name resolution, trusts, referrals, SPNs, and encryption compatibility across the complete path. |
| Double-hop application | Configure an appropriate delegation model instead of relying on NTLM or passing reusable credentials. |

Treat each NTLM event as a connection between a client, an account, and a target service. A server name alone isn't enough to explain the dependency.

## Discover NTLM usage

You can use audit policy to determine NTLM utilization before implementing a restriction policy. The **Network security: Restrict NTLM** policies can audit incoming NTLM traffic, outgoing NTLM traffic to remote servers, and NTLM authentication in the domain. Audit events are written to:

**Applications and Services Logs** > **Microsoft** > **Windows** > **NTLM** > **Operational**

Event ID 4776 is recorded on the computer authoritative for the credentials: collect it from domain controllers for domain accounts and from relevant member computers or workstations for local accounts. The event identifies the source workstation but not the destination computer, so correlate it with NTLM operational events and target-side logon evidence. On target servers, successful logon Event ID 4624 identifies the authentication package and can confirm whether a connection used NTLM or Kerberos.

Prior to implementing change, collect enough evidence to cover normal business cycles, including determining whether NTLM is used in:

- Interactive and remote administration.
- Scheduled tasks and batch processing.
- Web, database, file, print, and application services.
- Cluster, backup, monitoring, deployment, and identity-management tools.
- Cross-domain, cross-forest, and external trust activity.
- Devices and applications that run only weekly, monthly, or during recovery procedures.

For each dependency, record:

| Field | Purpose |
| --- | --- |
| Client | Identifies where the authentication request originated. |
| User or service account | Distinguishes user activity from a service, task, or application identity. |
| Target server and service | Identifies the resource and the SPN that Kerberos would need. |
| Application or process | Shows whether configuration or code explicitly requests NTLM. |
| Access name | Reveals IP addresses, aliases, short names, or DNS names that don't map to the intended SPN. |
| Frequency and business owner | Supports prioritization, testing, and exception ownership. |
| Current reason for NTLM | Defines the remediation rather than treating all events alike. |

An NTLM inventory is only useful when it leads to an owner and a remediation decision. Aggregate event counts can show scale, but they don't explain whether one busy service or many unrelated applications produced the traffic.

## Classify the dependency

Use the evidence to place each NTLM flow into a remediation category.

### Name and SPN problems

Kerberos requires the client to request a ticket for the service's SPN. Common blockers include:

- Access through an IP address.
- A DNS alias without the corresponding SPN.
- A missing or duplicate SPN.
- An SPN registered on an account other than the identity that runs the service.
- A service that changes accounts without updating its SPNs.

Confirm the name used by the client and query the expected SPN:

```cmd
setspn -Q HTTP/intranet.contoso.com
setspn -X
```

Register a missing SPN only after you identify the account that actually runs the service. Use `setspn -S` so that duplicate checking occurs before the value is written.

### Application and service configuration

Some applications explicitly request NTLM, don't supply a target name to SSPI, or use a library that doesn't support Negotiate correctly. Other applications support Kerberos but need configuration such as:

- Enabling Windows integrated authentication and Negotiate.
- Placing Negotiate before NTLM in the provider order.
- Configuring the service account or application pool identity.
- Enabling kernel-mode authentication or configuring it for the intended identity.
- Supplying the correct service name to a database, web, or middleware client.
- Updating connection strings, URLs, mapped drives, or scripts to use a DNS name with a valid SPN.

Don't assume that domain membership makes an application Kerberos capable. Confirm the authentication method supported by the application and its client library.

### Identity and key material

The account that owns an SPN must have key material that the service can use to decrypt its tickets. For traditional user-based service accounts, old passwords or incorrect encryption-type configuration can prevent Kerberos or force weak compatibility behavior.

Where supported:

- Reset old service-account passwords so current Kerberos keys are generated.
- Migrate services to group Managed Service Accounts (gMSAs) or delegated Managed Service Accounts (dMSAs).
- Confirm that the service runs as the account that owns its SPNs.
- Configure `msDS-SupportedEncryptionTypes` only when an explicit value is required and the service supports those encryption types.

> [!IMPORTANT]
> Before selecting dMSA, confirm that at least one Windows Server 2025 domain controller is discoverable, every client or server that uses the migrated account supports dMSA, and the migration process can reach a read-write domain controller. In mixed-version application farms, validate every workload host before migration; don't migrate a shared service account while any participating host lacks dMSA support. You can't migrate from a gMSA to a dMSA; choose the target account type before beginning. After starting migration with `Start-ADServiceAccountMigration`, wait at least two ticket lifetimes (14 days) before completing it; keeping the account in the start state for four ticket lifetimes (28 days) is recommended. Completing migration too early excludes hosts that haven't yet renewed their tickets and cause those hosts to fail authentication when the original service account is disabled.

### Trust, DNS, and connectivity

Kerberos depends on DNS, domain controller discovery, time synchronization, and access to the KDC. Cross-domain flows also depend on a valid trust and compatible referral tickets.

Validate:

- Forward and reverse name resolution where the application depends on it.
- AD DS site and domain controller discovery.
- Time synchronization within the Kerberos tolerance.
- Network access to domain controllers and required Kerberos endpoints.
- Trust direction, selective authentication, name suffix routing, and encryption compatibility.

### Delegation and multi-tier applications

Replacing NTLM on the first hop doesn't automatically solve access from a front-end service to a back-end service. If the application must use the user's identity on the second hop, configure constrained delegation, protocol transition when required, or resource-based constrained delegation.

Avoid using unconstrained delegation as a migration shortcut. If the application doesn't require the user's identity on the back end, use a dedicated service identity and authorize that identity explicitly.

## Remediate by service

Migrate one service or application boundary at a time. A practical sequence is:

1. Identify the business owner, clients, service identity, target names, and downstream dependencies.
1. Correct DNS names, SPNs, service accounts, application configuration, trusts, and delegation.
1. Purge cached tickets on a test client and reconnect to the service.
1. Prove that the client requested the expected service ticket.
1. Confirm on the target that the successful logon used Kerberos.
1. Test all supported client types, access paths, scheduled operations, and failure-recovery workflows.
1. Continue NTLM auditing to detect alternate paths that still fall back.

Use `klist` to validate the client side:

```cmd
klist purge
klist get HTTP/intranet.contoso.com
klist
```

Use Event ID 4769 on the KDC to confirm the requested SPN and ticket encryption type. Use Event ID 4624 on the service to confirm that **Authentication Package** is `Kerberos`. A successful application response isn't sufficient evidence because the same request might have succeeded through NTLM fallback.

## Pilot NTLM restrictions

After representative flows use Kerberos, move from audit to restriction in controlled phases. Apply policies to a small group of test clients, servers, or accounts before expanding scope.

The **Network security: Restrict NTLM** policy family can control:

- Incoming NTLM traffic to a server.
- Outgoing NTLM traffic from a client to remote servers.
- NTLM authentication within a domain.
- Server exceptions for connections that temporarily require NTLM.

For SMB clients on Windows Server 2025 and Windows 11, version 24H2 or later, you can block NTLM for remote outbound SMB connections by running the following command:

```powershell
Set-SmbClientConfiguration -BlockNTLM $true
```

You can also test a specific mapping without applying a device-wide SMB setting:

```cmd
net use \\fs01.contoso.com\finance /blockntlm
```

**If Kerberos succeeds:** The command creates an SMB mapping. Verify the connection used Kerberos by running `klist` on the client to confirm a ticket for the target SPN, and by checking the target server for a logon Event ID 4624 with **Authentication Package** = Kerberos (or service-specific Kerberos evidence). Then remove the test connection before retesting:

```cmd
net use \\fs01.contoso.com\finance /delete
```

**If Kerberos can't be used:** The connection fails and NTLM is blocked. No mapping is created and no cleanup is needed. Investigate the name resolution, SPN, service identity, ticket, and target evidence rather than broadly re-enabling NTLM.

SMB-specific blocking doesn't replace domain-wide NTLM migration. It protects SMB connections and can expose SMB paths that don't have working Kerberos, while other protocols might still use NTLM.

During a pilot:

- Monitor NTLM operational events, logon failures, application health, and helpdesk reports.
- Confirm that successful connections continue to generate Kerberos evidence.
- Test service restart, failover, password rotation, disaster recovery, and alternate DNS names.
- Roll back the narrow restriction if an unrecorded critical dependency appears, then add that flow to the remediation inventory.

## Manage exceptions

Some dependencies might not be immediately replaceable. An exception should be a temporary risk decision, not an undocumented permanent state.

Record:

- The exact client, target, protocol, and account covered.
- The business and technical owner.
- Why Kerberos or another modern authentication method isn't currently possible.
- Compensating controls, such as network isolation, SMB signing, encryption, firewall restrictions, or privileged-account exclusion.
- The expiration date and migration milestone.
- The evidence required to remove the exception.

Keep exceptions as narrow as the policy and application allow. Don't exempt an entire domain or broad server group to preserve one legacy workflow.

## Complete the migration

An NTLM-to-Kerberos migration is complete for a defined scope when:

- Expected domain service connections obtain tickets for the correct SPNs.
- Target services report Kerberos rather than NTLM for successful logons.
- Applications, service identities, trusts, delegation, and encryption types support the Kerberos path.
- NTLM audit data contains no unexplained activity in the scope.
- Required exceptions are documented, approved, monitored, and time limited.
- NTLM restrictions have been piloted and deployed in stages with a tested rollback plan.

Continue auditing after enforcement. New applications, aliases, service-account changes, trust changes, and recovery operations can reintroduce NTLM dependencies.
