Remove a Hyper-V host's authorization when it's compromised or suspected of compromise, retired, or reassigned outside the guarded fabric. This reduces the risk of releasing shielded VM keys to a system that's no longer trusted or approved to run those workloads.

Removing Hyper-V host authorization changes future admission decisions. It doesn't automatically shut down a running shielded VM, erase already released secrets, revoke every outstanding health certificate, or invalidate every eligible offline cache immediately.

Contain a compromised Hyper-V host explicitly: isolate its network and management access according to the incident plan, preserve evidence, and prevent further workload placement. Recover affected workloads on known-clean, authorized infrastructure. Coordinate shutdown and recovery with the owner rather than assuming HGS removal performs those actions.

## Withdraw the correct identity everywhere

On each applicable primary and fallback HGS deployment, an HGS administrator identifies the compromised Hyper-V host's TPM registration. Review the exact Hyper-V host identity and any versioned copies before removal. Avoid deleting a shared baseline as a substitute for removing one Hyper-V host.

```powershell
Get-HgsAttestationPolicy
Get-HgsAttestationTpmHost -Name 'HV01'
Remove-HgsAttestationTpmHost -Name 'HV01'
```

Recheck the remaining registrations and policies, including legacy artifacts. Fresh attestation from that removed identity must fail. That proves a bounded future-admission property, not immediate eviction of an already running VM.

For host-key attestation, remove the registration for the compromised **public key**, not merely a shown hostname or an expired certificate. If several Hyper-V hosts shared the key, assess the entire group.

Discover the mode-specific host-key interfaces with `Get-Command *HgsAttestation*HostKey*` and read installed help on the target build. The published reference set is incomplete for these interfaces. Confirm the exact registration and supported removal operation in staging before making host-key withdrawal part of a runbook.

Where an artifact is exposed as an attestation policy, the documented policy operations can withdraw it after its identity and scope are established:

```powershell
Get-HgsAttestationPolicy -Name 'Retired-ApprovedPolicy'
Disable-HgsAttestationPolicy -Name 'Retired-ApprovedPolicy'
```

After the retention and impact decision, `Remove-HgsAttestationPolicy -Name 'Retired-ApprovedPolicy'` removes that identified policy. Don't substitute a guessed policy name for a host-key registration or disable a broad built-in protection to resolve an outage.

Fallback HGS is a separate trust store. Withdrawing authorization only from the primary leaves the fallback path unchanged. Record and verify the change on every HGS service capable of authorizing the affected workload.

## Respond to HGS and owner-key compromise

If HGS or its private keys are compromised, rebuild from clean administrative authority, review enrollment and policy state, and establish clean key-protection identities. Owners must update affected KPs to withdraw compromised guardians and revise PDKs for future deployments. Restoring an old HGS export without review can restore malicious policy or compromised keys.

Removing a Hyper-V host registration, retiring an HGS key, and revoking a guardian in a VM's KP change different authorization objects. Verify each intended change separately. Rotating a wrapping key doesn't undo disclosure of plaintext, copied keys, old KPs, or guest credentials. Assess retained copies and rotate exposed guest secrets under owner authority.

If an owner key is compromised, assess every workload in that ownership group. Establish clean owner recovery authority through a validated recovery/reprotection process and address exposed guest secrets. Don't assume changing an HGS certificate repairs an owner-key compromise.

Old backups can contain KPs that still authorize a withdrawn guardian. Keep them isolated during restore, inspect authorization, and re-protect under clean owner authority before reconnecting them to normal operations. Revocation in the current VM doesn't rewrite historical backups.
