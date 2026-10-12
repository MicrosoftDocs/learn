Shielded VM provisioning, startup, and migration depend on both working infrastructure and successful security checks. Similar symptoms can originate in network connectivity, Hyper-V host attestation, access to VM keys, or guest configuration. Identifying the failing layer helps you restore service without weakening VM protection.

Use the following checks and worked examples to interpret diagnostic results, isolate the cause, and select a targeted repair. Verify that the intended operation succeeds and that unauthorized hosts or altered templates are still rejected.

Determine whether the failure affects one VM, one Hyper-V host, one HGS node, a site, or the whole fabric. Check edition and feature installation before investigating certificates or policy. A single-VM failure on a Hyper-V host running other protected VMs suggests a different path from a site-wide attestation outage.

Preserve the original error, timestamps, source and destination Hyper-V hosts, VM identity, and recent changes. Correlate time across systems. Keep diagnostic bundles access-controlled and sanitize secrets, identifying data, and sensitive configuration before sharing them.

On the affected Hyper-V host, perform a read-only name-resolution and connectivity check, then obtains HGS client diagnostics. Use the intended service name rather than bypassing TLS-name validation with an IP address.

```powershell
Resolve-DnsName 'hgs.security.contoso.com'
Test-NetConnection -ComputerName 'hgs.security.contoso.com' -Port 443

Get-HgsClientConfiguration
Get-HgsTrace -RunDiagnostics -Detailed
```

A successful TCP connection doesn't prove a correct certificate, healthy service, acceptable Hyper-V host, or usable KP. Check each successive layer.

On the Hyper-V host or HGS node under the relevant administrator's authority, discover the available logs before selecting an exact channel.

```powershell
Get-WinEvent -ListLog '*HostGuardian*' |
    Select-Object LogName, IsEnabled, RecordCount

Get-WinEvent -FilterHashtable @{
    LogName   = 'Microsoft-Windows-CodeIntegrity/Operational'
    StartTime = (Get-Date).AddHours(-2)
} -MaxEvents 30
```

Use the corresponding installed Attestation, KeyProtection, HGS client, VMMS, and worker channels for the failing layer. A requested log with no events in the interval is evidence to interpret, not an instruction to suppress every error.

## Interpret attestation status accurately

The `AttestationStatus` value returned by `Get-HgsClientConfiguration` reports the Hyper-V host's attestation state. Interpret it alongside `AttestationSubStatus` and the relevant event logs before changing host enrollment or security policy.

- **`Passed`**: The Hyper-V host satisfied the evaluated attestation requirements. It doesn't mean a particular VM authorizes KPS or that the guest disk is encrypted.
- **`Expired`**: Check health-certificate validity, time synchronization, and renewal.
- **`TransientError`**: This suggests network or service availability issues. Correlate it with DNS, transport, and service evidence.
- **`InsecureHostConfiguration`**: Inspect `AttestationSubStatus` to identify which host security requirement failed.
- **`TpmError`**: Investigate TPM-related evidence or operational errors.
- **`UnauthorizedHost`**: Investigate host enrollment for the active attestation mode. Don't automatically apply a legacy AD-group repair to TPM or host-key mode.
- **`NotConfigured`**: This can indicate local mode rather than an HGS-backed configuration. Local operation isn't equivalent to guarded-fabric attestation.
- **`Unknown`**: This status is insufficient evidence. Collect diagnostics instead of treating it as success.

Relevant substatuses include `CodeIntegrityPolicy`, `SecureBootSettings`, `VirtualSecureMode`, `HypervisorEnforcedCodeIntegrityPolicy`, and `Iommu`. Others identify paging and boot conditions: `PagefileEncryption`, `FullBoot`, and `HibernationEnabled`.

Dump-related substatuses include `DumpsEnabled`, `DumpEncryption`, and `DumpEncryptionKey`. `TcgLogVerification` directs investigation toward measured-boot log verification. Match the actual result to the installed build and policy. See guarded Hyper-V host troubleshooting.

An HGS administrator checks a rejected identity against the Hyper-V host's actual TPM or public-key registration, not its DNS name alone. Investigate missing endorsement trust, incompatible artifact versions, and the intended active mode. The fabric administrator checks changed boot evidence and whether VBS, CI, and IOMMU protections are actually running before requesting a trust change.

## Distinguish provisioning failure from guest repair

If the PDK/VSC pair is inapplicable, the owner and publisher check template identity, version rules, and whether the PDK is for new templates or existing VMs. If secure template validation succeeds but specialization fails, inspect unresolved placeholders, owner-provided setup choices, and guest network or enrollment dependencies.

For an unreachable but provisioned guest, the fabric administrator checks placement and network connectivity while the owner verifies endpoint identity, guest firewall, and credentials. A BitLocker recovery prompt instead requires the owner's supported guest-recovery path. Don't respond to any of these symptoms by replacing the VM's KP.

## Worked failure: Approved servicing changes CI evidence

**Illustrative observation, not captured output:**

```text
Scope: HV02 only, immediately after driver servicing
IsHostGuarded: False
AttestationStatus: InsecureHostConfiguration
AttestationSubStatus: CodeIntegrityPolicy
```

The Hyper-V host reaches HGS but doesn't satisfy the measured software policy. The fabric administrator compares the change record, deployed binary, and active CI policy. The HGS administrator checks the registered unsigned policy. Confirm whether the intended enforced policy actually became active after the required restart.

The narrow repair is to correct an unintended deployment or approve and deploy the intended policy through change control. Reattest the Hyper-V host, start a protected test workload, and show that an unapproved configuration is still rejected. Don't replace the whole baseline with whatever the failing Hyper-V host currently reports.

## Worked failure: Attestation passes but one VM fails

**Illustrative observation, not captured output:**

```text
Scope: App01 only
Hyper-V host attestation: Passed
Other shielded VMs on the Hyper-V host: Start successfully
App01 key release: Rejected
Recent change: HGS key rollover
```

The fabric administrator checks the endpoint and preserves `App01`'s KP for owner inspection. The owner checks guardian authorization. The HGS administrator checks available signing/encryption keys and every node's private-key access. A stale KP, missing old key, or unavailable HSM key can fail even though Hyper-V host attestation is correct.

The narrow repair is the approved key-access correction or an owner-authorized update of the existing KP. Revalidate startup and owner access, then confirm that an unauthorized fabric remains unable to unlock the VM. Relaxing attestation wouldn't repair the authorization mismatch.

## Worked failure: Template checks and actual disk differ

**Illustrative observation, not captured output:**

```text
PDK/VSC applicability: Compatible
Hyper-V host attestation: Passed
Template presented to provisioning: Changed after signing
Provisioning: Rejects the template
```

Applicability didn't authenticate the modified disk. The fabric administrator quarantines it and preserves evidence. The publisher provides the approved protected template through an authenticated channel. The owner approves any genuine new catalog or version.

Repeat both the preliminary applicability check and actual provisioning validation. Confirm that the original approved disk succeeds and the altered disk fails. Don't remove the image qualifier or broaden the PDK's trust to accept an unexplained replacement.

## Worked failure: Migration authentication changes after upgrade

**Illustrative observation, not captured output:**

```text
Source Hyper-V host: Upgraded to Windows Server 2025
Source and destination Hyper-V host attestation: Passed
VM guardian authorization: Correct for the destination
Migration authentication: CredSSP delegation fails
```

Inspect Credential Guard and the migration-authentication path. Configure the approved Kerberos delegation design with the appropriate AD administrator, then test from the intended initiating identity.

Revalidate migration and workload health while retaining Credential Guard. Separately exercise a destination Hyper-V host that lacks the VM's guardian authorization and confirm rejection. A successful authentication repair mustn't weaken placement protection.
