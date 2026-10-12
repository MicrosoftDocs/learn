An **attestation artifact** is a file registered with HGS that identifies an approved Hyper-V host or defines an approved security configuration. In TPM-trusted attestation, these artifacts include the host's TPM identifier, a measured-boot baseline, and a code integrity policy. HGS uses them to evaluate the identity and security-state evidence a host presents during attestation.

Create attestation artifacts only from a secure and verified Hyper-V host configuration. A baseline captured from a compromised Hyper-V host merely describes the compromised state.

> [!NOTE]
> TPM-trusted attestation doesn't require the Hyper-V host to join a domain or the HGS forest. The host can remain in a workgroup or join a separate fabric domain. It must still meet the security prerequisites, resolve and reach the HGS endpoints, and trust the CA chain for HTTPS. Management, clustering, and Kerberos live migration have separate domain-membership and authentication requirements.

A fabric administrator installs the Hyper-V host features on an eligible Windows Server Datacenter edition Hyper-V host during a maintenance window. The Hyper-V host must meet the hardware requirements, and affected workloads must be drained. Installation can restart the server.

```powershell
Install-WindowsFeature -Name Hyper-V, HostGuardian `
    -IncludeManagementTools -Restart
```

Complete the required VBS, Secure Boot, firmware, driver, and Hyper-V host security configuration before exporting the TPM identifier and capturing the approved measured-boot baseline for registration with HGS. Capture the baseline only after the intended enforced code integrity policy is active and the host has restarted. Re-run the readiness inventory after reboot.

Three artifacts have different reuse boundaries.

- A **TPM identifier** belongs to one physical Hyper-V host.
- A **measured-boot baseline** describes an approved hardware, firmware, and security configuration class.
- A **code integrity policy** describes the software allowed by an approved Hyper-V host configuration.

One enrollment file can't replace all three.

## Develop code integrity policy safely

An App Control for Business code integrity (CI) policy defines which drivers and applications can run on a Hyper-V host. In enforced mode, Windows blocks code that the policy doesn't allow. In audit mode, it records what would be blocked without preventing execution. For TPM-trusted attestation, HGS checks that the host's measured CI policy matches a registered, approved policy. This check doesn't establish that the allowed software is free of vulnerabilities. You use these policies to ensure that only authorized drivers and applications can run on the Hyper-V host.

Two rule types offer different tradeoffs between software-update flexibility and precise control:

- Publisher-based rules allow appropriately signed updates more readily but trust a broader publisher identity. 
- Hash-based rules bind more narrowly to binaries and require maintenance when those binaries change.

A fabric security administrator prepares a policy on a known-good reference Hyper-V host containing the approved drivers, backup agents, and management tools. The following commands create an audit policy and its binary form. They don't deploy it or prove that the Hyper-V host is safe.

```powershell
New-CIPolicy -FilePath 'C:\Attestation\HyperV-2025.xml' `
    -Level FilePublisher -Fallback Hash -UserPEs

Set-RuleOption -FilePath 'C:\Attestation\HyperV-2025.xml' -Option 3

ConvertFrom-CIPolicy `
    -XmlFilePath 'C:\Attestation\HyperV-2025.xml' `
    -BinaryFilePath 'C:\Attestation\HyperV-2025-Audit.p7b'
```

Audit mode records what enforcement would block. Deploy and activate the audit policy before exercising workloads or using CodeIntegrity events to decide whether the policy is ready for enforcement.

The HGS capture procedure documents the single-policy CI update provider below. Use it only after confirming that provider and the selected policy format on the target build. Keep recovery access and the previous approved policy available before deployment.

```powershell
Get-CimClass -Namespace 'root\Microsoft\Windows\CI' `
    -ClassName PS_UpdateAndCompareCIPolicy -ErrorAction Stop

Invoke-CimMethod -Namespace 'root\Microsoft\Windows\CI' `
    -ClassName PS_UpdateAndCompareCIPolicy `
    -MethodName Update `
    -Arguments @{
        FilePath = 'C:\Attestation\HyperV-2025-Audit.p7b'
    } -ErrorAction Stop
```

> [!NOTE]
> For the single-policy HGS sequence shown here, restart the reference host after applying `HyperV-2025-Audit.p7b`, then verify that the intended policy is active in audit mode. Only then exercise backup, monitoring, management, driver-load, and servicing scenarios and review their CodeIntegrity events. An empty event log without a verified active audit policy and representative workload activity isn't evidence that enforcement is safe. Complete this audit-stage check before converting the policy to enforcement.

Windows Server 2025 also has documented App Control deployment through `CiTool --update-policy`. General support for that tool or a multiple-policy format doesn't establish that a particular combined policy arrangement is compatible with HGS attestation. Don't substitute deployment formats without validating both enforcement and HGS measurements.

After testing the required software and operations in audit mode and reviewing the CodeIntegrity events, update the policy to allow any missing approved code. Then remove the audit-mode option and compile the policy into an enforcement-mode binary. Deploy that binary with the validated method, restart the host as required, and verify that the policy is enforced before placing workloads on the host.

```powershell
Set-RuleOption -FilePath 'C:\Attestation\HyperV-2025.xml' `
    -Option 3 -Delete

ConvertFrom-CIPolicy `
    -XmlFilePath 'C:\Attestation\HyperV-2025.xml' `
    -BinaryFilePath 'C:\Attestation\HyperV-2025-Enforced.p7b'
```

Signed CI policies protect policy updates from unauthorized replacement. Keep their signing and update authority separate from routine Hyper-V host administration, and test recovery from a blocking policy. If the deployed policy is signed, register its matching **unsigned** form with HGS. The signature isn't the measured portion. Signed-policy deployment and recovery can also involve EFI placement and reboot requirements.

## Capture identity and approved boot evidence

On each enrolled Hyper-V host, a fabric administrator exports its TPM identifier. On the known-good representative Hyper-V host, the administrator also captures the approved boot baseline. Use an access-controlled staging directory, such as `C:\Attestation`, to hold these exported files temporarily before their authenticated transfer to HGS for review and registration. Create the directory before running the commands, and restrict write access to authorized administrators to prevent artifact alteration or substitution.

```powershell
(Get-PlatformIdentifier -Name 'HV01').InnerXml |
    Out-File 'C:\Attestation\HV01.xml' -Encoding UTF8

Get-HgsAttestationBaselinePolicy `
    -Path 'C:\Attestation\ServerClassA-2025.tcglog'
```

> [!NOTE]
> Transfer these artifacts to HGS through an authenticated change process. They don't contain the TPM's private endorsement key, but unauthorized alteration or substitution still changes the trust decision. 

## Register compatible artifacts

The following artifacts identify the permitted physical host, its approved boot configuration, and its approved software policy, respectively.

- The exported TPM identifier (`HV01.xml`)
- The approved measured-boot baseline (`ServerClassA-2025.tcglog`)
- The approved code integrity policy binary (`HyperV-2025-Enforced.p7b`). 

An HGS administrator reviews provenance and registers these artifacts with the HGS. The CI file in this example is the approved unsigned enforced binary, not the audit policy or a signed wrapper.

Before registering a TPM host, establish trust in its endorsement key certificate. The TPM manufacturer root and intermediate CA certificates are separate from the standalone CA certificates used for HGS signing, encryption, and HTTPS.

The following table distinguishes TPM manufacturer certificate trust from the host's endorsement key certificate.

| Item | Purpose | Where obtained |
|---|---|---|
| TPM root and intermediate CA certificates | Establish trust in the manufacturer's certificate chain used to validate TPM endorsement key certificates. | Obtain Microsoft's signed `TrustedTpm.cab` package through the Install trusted TPM root certificates documentation. If the TPM model isn't covered, obtain the certificates from the TPM vendor or server OEM. Verify the package signature before installation, and install the approved vendor certificates on every HGS node in the local computer's `TrustedTPM_RootCA` and `TrustedTPM_IntermediateCA` stores. |
| Endorsement key certificate (EK certificate) | Certifies the TPM's public endorsement key and provides evidence that it's a genuine manufacturer-provisioned TPM. | Normally provisioned by the manufacturer in the TPM. Run `Get-PlatformIdentifier` in elevated PowerShell on the Hyper-V host to include the certificate in the exported platform identifier file, which HGS reads during registration. |

Don't request the EK certificate from the standalone CA. If it's missing, investigate with the server OEM or TPM vendor rather than routinely bypassing validation.

```powershell
Add-HgsAttestationTpmHost -Name 'HV01' `
    -Path 'C:\Attestation\HV01.xml'

Add-HgsAttestationTpmPolicy -Name 'ServerClassA-2025' `
    -Path 'C:\Attestation\ServerClassA-2025.tcglog'

Add-HgsAttestationCiPolicy -Name 'HyperV-2025-Enforced' `
    -Path 'C:\Attestation\HyperV-2025-Enforced.p7b'

Get-HgsAttestationPolicy
```

This deployment uses **version 2 (v2) TPM attestation**, introduced in Windows Server 2019 and used by default beginning with that release. This version identifies the attestation method, not the Windows Server release. Unlike version 1 (v1), v2 requires a TPM endorsement key certificate when registering the host's TPM identity. Ensure that HGS trusts the certificate's manufacturer root and intermediate CA chain before registration. Investigate missing or untrusted certificates rather than bypassing validation or downgrading to v1.

All required artifacts must be compatible with the selected attestation version. Version 2 is attempted first, but matching retained version 1 artifacts can permit fallback. A preference for version 2 is therefore not evidence that version 1 is impossible.

Inventory policy versions deliberately and retire unapproved legacy artifacts after testing. The HGS server's software version, artifact version, and active attestation mode are separate concepts. Some current cmdlet reference pages expose historical version labels. Inspect target-build help and returned objects rather than inventing a `-PolicyVersion v2` switch.

## Understand built-in checks

HGS policy covers more than the allow list. Relevant checks include Secure Boot, VBS identity, hypervisor-enforced CI, IOMMU, encrypted paging, and a full boot rather than hibernation. Dump policy can require disabled dumps or appropriately encrypted dumps with an approved dump key.

BitLocker on the Hyper-V host is distinct from BitLocker inside a shielded VM. The documented attestation policy for Hyper-V host BitLocker is disabled by default. If Contoso requires encryption of Hyper-V host disks as an admission condition, configure and validate that requirement explicitly. Don't infer it from guest encryption.

## Configure client endpoints and interpret acceptance

A fabric administrator configures each Hyper-V host. This example assumes both the primary and recovery HGS endpoint pairs are deployed and that the Hyper-V host is authorized by each.

```powershell
Get-HgsClientConfiguration

Set-HgsClientConfiguration `
    -AttestationServerUrl 'https://hgs.security.contoso.com/Attestation' `
    -KeyProtectionServerUrl 'https://hgs.security.contoso.com/KeyProtection' `
    -FallbackAttestationServerUrl 'https://hgs.recovery.contoso.com/Attestation' `
    -FallbackKeyProtectionServerUrl 'https://hgs.recovery.contoso.com/KeyProtection'

Get-HgsClientConfiguration
Get-HgsTrace -RunDiagnostics -Detailed
```

On an initial deployment without recovery HGS, use the documented primary-only parameter set. When modifying an existing configuration, remember that omitting fallback parameters clears the fallback configuration.

Inspect `IsHostGuarded`, `AttestationStatus`, and `AttestationSubStatus` in the output of `Get-HgsClientConfiguration`. An `AttestationStatus` of `Passed` means the Hyper-V host satisfies the HGS attestation policy evaluated for that request. It doesn't prove that a VM template is approved and unmodified, that the VM's key protector authorizes this fabric's HGS keys, or that BitLocker has encrypted the guest volumes. Verify those conditions separately during provisioning and workload validation.

For example, an approved driver update can cause attestation to report `InsecureHostConfiguration` with a `CodeIntegrityPolicy` substatus if the host's updated CI policy isn't registered with HGS. Confirm that the installed driver matches the approved update and that the intended CI policy is active. If policy changes are required, review and approve the revised rules, deploy the updated policy, and register its matching unsigned binary with HGS before retrying attestation. Don't register an unexplained boot baseline or disable CI checks merely to obtain a `Passed` result.
