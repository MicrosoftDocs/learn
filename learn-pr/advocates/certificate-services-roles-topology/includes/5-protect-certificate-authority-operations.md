Topology includes people and credentials. A two-tier deployment offers little assurance if the same daily administrator can change templates, administer issuing CAs, alter NTAuth, control the HSM, and recover the root CA by themselves.

## Administrative tiers and roles

The following table assigns the minimum scope of each PKI administrative function and shows which duties should remain separate when assurance requirements call for role separation.

| Function | Minimum scope | Keep separate from | Recovery implication |
|---|---|---|---|
| Root custodian / ceremony officer | Physical root system, local root identities, approved media | Daily domain administration and online issuing operations | At least two trained custodians and tested sealed recovery material |
| HSM security officer | HSM initialization, policies, partitions, quorum roles | Routine CA certificate management where separation is required | Quorum tokens, replacement officers, vendor support, and lost-token procedure |
| CA Administrator | CA configuration and service administration | Certificate Manager, Auditor, template owner where enforced role separation applies | Break-glass process must restore configuration without silently disabling controls |
| Certificate Manager | Approve/deny/revoke requests within assigned scope | CA configuration and audit review | Recovery must preserve request database and manager restrictions |
| CA Auditor | Review security/audit events | Operational changes and certificate approval | Audit logs and access must survive CA loss |
| CA Backup Operator | Back up CA database/key material under controlled authorization | Unilateral restore and HSM security administration | Backup custody, passwords/quorum, and restore privilege are separate decisions |
| Template/profile administrator | Modify template/profile settings and ACLs in AD DS | Routine enrollment and unrestricted CA administration | Version/export template inventory and ACL evidence; AD DS recovery alone may restore an unsafe change |
| Forest PKI trust administrator | Modify Public Key Services containers, root publication, and NTAuth | Routine CA/server administration | Enterprise-level break glass and replication validation are required |
| Enrollment service administrator | CEP/CES/NDES/Web Enrollment IIS, service accounts, and TLS | CA key/HSM and template approval | Must recover IIS/app configuration without gaining broad issuance policy control |

> [!NOTE]
> The described tiers and roles are appropriate for large well staffed organizations. In environments with small teams that require less stringent security, role separation is more challenging to implement.

### Role-separation decision

Windows CA role separation can enforce that a principal doesn't hold incompatible CA roles. Enable it only after mapping:

- Normal issuance, revocation, auditing, backup, restore, renewal, and configuration workflows.
- Staffing across leave, after-hours incidents, and disaster recovery.
- Group nesting and service identities that could accidentally combine roles.
- HSM roles, which are separate from Windows CA roles.
- A documented, approved, audited break-glass process.

Role separation that can't be staffed can extend an outage or make operators bypass controls. Lack of role separation can let one credential issue, conceal, and recover malicious certificates. Select the model from assurance and recovery requirements, not from a checkbox.

### Administrative-tier controls

Implement the following controls to prevent routine server or domain administration from becoming unrestricted PKI administration:

- Use dedicated privileged accounts and privileged access workstations.
- Deny routine interactive sign-in to CA servers; minimize local administrators.
- Keep CA servers dedicated to AD CS and required security/management agents.
- Restrict remote management paths by host, account, protocol, and maintenance window.
- Use separate groups for CA configuration, certificate management, template administration, HSM administration, backup, audit, and forest PKI objects.
- Require change records and independent review for template, CA ACL, NTAuth, AIA/CDP, provider, and policy-module changes.
- Rotate administrative credentials and review trust after suspected control-plane compromise.

## HSM placement

The following table compares hardware security module (HSM) placement options and the availability, recovery, and custody obligations created by each choice.

| Placement | Assurance benefit | Availability/capacity effect | Recovery and custody requirements | Design warning |
|---|---|---|---|---|
| Offline root HSM | Root key can remain nonexportable and require quorum for rare signing | Throughput is usually minor; device startup, token availability, and long offline storage dominate | Protected backup/replica, compatible replacement, quorum custody, battery/firmware lifecycle, vendor support that matches root lifetime | A permanently network-connected shared HSM can defeat the intended offline boundary |
| Online issuing CA HSM | Limits plaintext CA-key exposure and can enforce audited key use | Network HSM latency, sessions, partition capacity, high availability (HA), and firmware maintenance affect issuance/CRL signing | Replication/backup, failover tests, partition/object mapping, provider reinstall, replacement lead time | HSM outage can prevent CRL signing as well as issuance; shared chassis/admin may be a common-mode failure |
| Online Responder signing HSM | Protects high-use OCSP signing keys where risk justifies it | High signature volume can consume capacity and add response latency | Signing-certificate renewal, array consistency, HSM HA, and fallback behavior | Don't starve CA signing or create one HSM failure domain for all validation services |
| Enrollment or workload HSM | Protects selected server/service keys | Application topology, clustering, and key access latency become part of service availability | Application-aware replication/backup, access authorization, and certificate rebinding | This doesn't substitute for protecting the CA key or securing enrollment authorization |

### HSM approval evidence

An HSM approval record should contain enough detail to reproduce normal operation, failure handling, and recovery without relying on vendor marketing claims:

- Exact model, firmware, Windows Server 2025 provider, CSP/KSP mode, and supported algorithms.
- Partitioning and separation between root, issuer, responder, and workload keys.
- Measured normal and peak signing latency/capacity, including CRL and renewal events.
- HA behavior during node, network, partition, credential, and firmware failure.
- Protected backup/replication and a successful restore to replacement hardware.
- Quorum roles, token custody, lost-token response, service-account access, and audit export.
- Vendor support entitlement, replacement location, lead time, and end-of-support trigger.

**Security boundary:** An HSM prevents certain key extraction paths. It doesn't prevent a compromised authorized CA service from requesting malicious signatures while the key is available.

## Root ceremony and custody

A root ceremony is a documented, witnessed process for temporarily bringing an offline root CA into operation to perform sensitive tasks, such as:

- Issuing or renewing subordinate CA certificates
- Publishing a root CRL
- Revoking a subordinate CA
- Backing up root CA data

It uses authorized personnel, separated roles, verified inputs, recorded hashes, and controlled media. After independent verification, the root CA and its keys return to secure offline custody.

### Ceremony phases

**Objective:** Produce authorized root-signed artifacts and return the root key, system, media, and evidence to controlled offline custody.  
**Required privilege:** Approved offline-root local CA roles and HSM quorum roles. Don't use routine Domain Admin or Enterprise Admin credentials on the offline root.

1. **Authorization:** Approved purpose, inputs, expected output hashes/identifiers, participants, roles, time window, and abort criteria.
1. **Room and equipment control:** Physical access log, camera/evidence policy, trusted build media, HSM/tokens, transfer media, time source, and inventory reconciliation.
1. **System verification:** Tamper checks, boot/configuration state, malware-control process, account/role validation, date/time, and provider/HSM health.
1. **Operation:** Root CRL publication, subordinate request verification, issue/renew/revoke decision, CA database backup, and artifact export according to the script.
1. **Independent verification:** Certificate fields, chain, policy, AIA/CDP, validity, signature, serial, CRL number/time, and file hashes checked by a second role.
1. **Controlled transfer:** Write-approved artifacts to approved media, record custody and hashes, then publish from an authorized online workstation. Never connect the root directly to AD DS or `<PkiWebHost>`.
1. **Closure:** Back up, reconcile media/tokens, shut down, seal/store, update the next-action schedule, and sign the ceremony record.

**Expected success indicator:** Every artifact matches the approved request and recorded hash; independent verification passes; all keys, tokens, media, backups, and records return to named custody; the root is offline; and the next required action is scheduled.
