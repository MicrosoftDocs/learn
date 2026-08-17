Selecting the scope of recovery is a risk decision. The preferred method resolves the incident with the smallest authority change, smallest replication impact, and least data loss.

The following sequence allows you to determine the minimum scope required:

1. Determine whether the forest remains trustworthy.
1. Determine which directory partitions are affected.
1. Determine whether healthy writable replication partners exist.
1. Determine whether the object still exists.
1. Determine whether Recycle Bin was enabled before deletion.
1. Determine whether SYSVOL is healthy.
1. Determine whether the incident is an availability failure or compromise.
1. Select the narrowest supported recovery.

The following table lists the failure or issue you wish to recover from, the first place to start, and what further information would trigger an escalation to a broader scope:

| Failure | Preferred starting method | Escalation trigger |
|---|---|---|
| Recent attribute error | Correct from audit, replication metadata, known-good data, or offline backup inspection | Many unknown changes or unsafe source |
| Deleted object with Recycle Bin | `Restore-ADObject` | Object predates enablement or retention |
| Deleted hierarchy | Parent-first Recycle Bin recovery | Missing required objects or attributes |
| One failed controller with healthy partners | Rebuild and promote | No healthy writable partner |
| Controller requires restoration | Nonauthoritative AD DS restore | Selected objects must override replicated state |
| Selected objects require backup | Nonauthoritative restore plus authoritative object restore | Shared forest state is untrusted |
| Domain naming context damage | Domain-scoped recovery evaluation | Schema, configuration, forest DNS, privilege, or trust is untrusted |
| Forest-wide logical damage | Forest recovery | Not applicable |
| Confirmed identity compromise | Containment plus trusted-state recovery | Attacker eviction remains unresolved |

When determining which version of SYSVOL has authority:

Use firm rules:

- Routine controller restore with healthy partners: normally nonauthoritative SYSVOL.
- First writable controller restored in each domain during forest recovery: authoritative SYSVOL.
- Other controllers in that recovered domain: nonauthoritative SYSVOL or clean promotion.

Never make every restored controller authoritative.

You should prefer reprovisioning a domain controller (reinstall it from media) rather than restoring from backup. You should reprovision a failed controller when:

- Healthy writable partners exist.
- Required directory partitions replicate.
- SYSVOL has a healthy source.
- The server has no unique unrecoverable local data.
- Recovery time permits promotion.

Restoring from backup adds backup-age, operating system, storage, machine identity, invocation identity, and SYSVOL authority risks. Restore from backup when the directory state can't be obtained safely through replication.

## Escalate from domain recovery

Domain recovery is a supportable action when you can demonstrate:

- Damage is confined to one domain naming context.
- Schema and configuration partitions are trustworthy.
- Forest DNS dependencies are trustworthy or reconstructable.
- Healthy domains can be prevented from unsafe replication.
- Parent-child trust can be validated.
- Shared privileged administration is trustworthy.

Escalate to forest recovery when those statements can't be supported by evidence.

## Contain compromise first

Recovery from security compromise starts with:

- Incident authority.
- Isolation plan.
- Forensic preservation.
- Trusted recovery workstations.
- Trusted installation media.
- Last-known-safe evidence.
- Credential and key strategy.

Don't restore directly into a management plane where you have evidence that an attacker may still have persistence.

