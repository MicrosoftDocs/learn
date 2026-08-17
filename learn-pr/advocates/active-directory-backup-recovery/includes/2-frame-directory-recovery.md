An Active Directory recovery plan begins with decisions about business impact, acceptable data loss, security state, and service dependency order.

Use four related measures to define your organization's recovery requirements:

| Measure | Recovery question |
|---|---|
| Recovery Time Objective (RTO) | How quickly must the identity capability return? |
| Recovery Point Objective (RPO) | How much committed directory change can the organization lose? |
| Maximum tolerable outage | When does identity unavailability create unacceptable business harm? |
| Recovery sequence | Which identity capabilities must return before dependent services can start? |

An RPO of eight hours doesn't mean that one backup every eight hours is sufficient. RPO is the objective: the maximum committed directory change the organization accepts losing. What a recovery achieves is the *recovery point*, the age of the selected completed backup at the loss or incident boundary, and that achieved recovery point must fall within the RPO. Backup cadence determines the candidate recovery points. Completion, copy availability, media access, and decryption determine which candidate is usable and can force selection of an older one, but don't alter any candidate's timestamp. Detection and investigation determine whether a usable candidate is safe because it predates corruption or compromise; detection latency doesn't change a candidate's timestamp or its age at the incident boundary.

Recovery scope decides how much the selected backup's age affects data loss. In domain controller recovery with healthy converged partners, inbound replication returns the directory to current state, so backup age governs supportability rather than committed-change loss. In domain or forest recovery, every surviving copy is discarded, so the selected backup's timestamp sets the achieved recovery point.

Restore duration, investigation, replication convergence, validation, and approval consume outage time and must fit inside the RTO for the identity capability being restored.

An RTO must identify the capability being measured. Restoring one domain controller isn't the same as restoring:

- Authoritative DNS.
- Kerberos ticket issuance.
- Global catalog queries.
- Password changes.
- Group Policy.
- Cross-domain trust.
- Application authentication.

## Recovery scope

There are four general recovery scopes for AD DS recovery:

- Object recovery
- Domain controller recovery
- Domain recovery
- Forest recovery

### Object recovery

Use object recovery when the directory remains healthy and the incident affects selected objects or attributes. Examples include:

- Deleted user.
- Deleted organizational unit.
- Removed group membership.
- Incorrect service principal name.
- Damaged access control list.

### Domain controller recovery

Use domain controller recovery when one server is lost or damaged but healthy replication partners contain the required directory state. Rebuilding is normally safer than restoring.

### Domain recovery

Use domain recovery when damage is confined to one domain naming context and shared forest state remains trustworthy. This scope requires explicit control of DNS, trusts, global catalog data, parent-child dependencies, and replication with healthy domains.

### Forest recovery

Use forest recovery when the organization can't trust shared forest state or safely isolate a narrower scope. Typical triggers include:

- Schema corruption.
- Configuration partition corruption.
- Forest-wide privileged compromise.
- Multiple damaged domains without a trustworthy shared state.
- Unsafe changes on writable domain controllers that can't all be isolated.
- Forest DNS or trust hierarchy damage that prevents safe domain-scoped recovery.

:::image type="content" source="../media/recovery-scope-decision.svg" alt-text="Diagram that shows recovery scope selection for objects, domain controllers, domains, and forests.":::

## Distinguish authority

In AD DS, *authoritative* doesn't mean "important." It describes which version should win replication.

- A nonauthoritative AD DS restore returns a domain controller to an earlier state. In routine domain controller recovery, inbound replication from healthy partners brings the restored controller current. During isolated forest recovery, the first restored writable controller in each domain instead provides the restored directory state that seeds recovery of that domain; it must remain disconnected from unrecovered prefailure writable domain controller instances.
- An authoritative object restore increases version numbers for selected objects so those versions replicate outward.
- Active Directory Recycle Bin reanimates deleted objects. It isn't an authoritative system-state restore.
- SYSVOL authority is separate from AD DS database authority.

During forest recovery, the first writable domain controller restored in each domain uses:

- Nonauthoritative AD DS recovery.
- Authoritative SYSVOL recovery.

Later domain controller recoveries in forest recovery use nonauthoritative SYSVOL synchronization or clean promotion.

## Model the dependency sequence

Identity services have a startup dependency order:

1. Trusted recovery administration.
1. Isolated networking.
1. A writable forest-root domain controller.
1. DNS required for directory location and replication.
1. Operations master roles for the scope being recovered. In forest recovery, that's the two forest-wide roles and the three forest-root domain roles, seized as required on the recovered forest-root controller. In domain recovery, it's that domain's three domain-wide roles.
1. Writable domain controllers in parent-before-child order. In forest recovery, one restored seed controller per domain, with that domain's three domain-wide roles seized on it as required. Admit later controllers through the cleanup-and-validation gate in the domain and forest recovery workflow: clean-promote replacement controllers (or use an approved supported cloning or Install from Media process), and admit a retained restored controller only after its completed supported AD-aware AD DS recovery and independent AD DS and SYSVOL validation. In domain recovery, apply the same distinction after the affected domain's first recovered controller passes that gate.
1. Global catalog capacity.
1. Trust validation.
1. Authentication validation.
1. Application reconnection.
1. Client reconnection.

Don't reconnect applications merely because a domain controller starts. A booted server can still have broken replication, absent SYSVOL, stale DNS, incorrect time, invalid trust, or attacker persistence.

## Add security gates

Availability recovery and compromise recovery have different success criteria.

For an availability failure, success can mean:

- Required directory partitions are healthy.
- Replication converges.
- SYSVOL is ready.
- DNS resolves required records.
- Authentication succeeds.

For scenarios where you're recovering from a security compromise, add:

- Trusted administrative workstations.
- Trusted installation media.
- Evidence-preserving isolation.
- Known-safe backups.
- Credential rotation strategy.
- Certificate and federation decisions.
- Group managed service account (gMSA) and Key Distribution Service decisions.
- Endpoint and hypervisor decisions.
- Backup infrastructure decisions.
- Attacker-eviction evidence.

> [!WARNING]
> Resetting `krbtgt` doesn't remove malicious accounts, certificates, federation keys, scheduled tasks, service credentials, endpoint persistence, or compromised backup administration.

## Control privilege and blast radius

Use the minimum approved authority. Default group membership isn't a reason to run every task as Enterprise Admin.

| Action | Typical required authority | Scope | Blast radius |
|---|---|---|---|
| Create system-state backup | Backup Operators, Administrators, or delegated equivalent | One server | Exposes Tier 0 backup material |
| Enable Recycle Bin | Enterprise Admins or validated forest-wide delegation | Entire forest | Irreversible feature enablement |
| Restore deleted object | Domain Admins by default or delegated reanimation plus destination rights | Selected object or hierarchy | Can restore access and identity |
| Restore system state | DSRM access plus approved local recovery authority | One controller | Replaces local operating system state |
| Authoritatively restore object | Domain recovery authority in DSRM | Selected object or subtree | Overrides newer replicated versions |
| Seize domain roles | Domain-specific approved authority | One domain | Former holders can't return |
| Seize forest roles | Forest-root role-specific approved authority | Entire forest | Former holders can't return |
| Reset `krbtgt` | Domain Admins or approved equivalent | One domain | Invalidates Kerberos tickets |
| Reset trust password | Approved authority on the required trust side | One trust | Can interrupt cross-boundary authentication |

When preparing and implementing a recovery plan, record the operator, approval, execution host, affected scope, expected result, validation, and stop condition for every action.
