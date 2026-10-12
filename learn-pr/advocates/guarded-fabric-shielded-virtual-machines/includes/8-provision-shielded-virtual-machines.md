A fabric administrator uses the ShieldedVMProvisioning tools on the provisioning Hyper-V host. The PDK and VSC must be the authenticated artifacts supplied for this workload. The following commands check whether the template identity and version in the VSC satisfy the PDK's trusted-image rules, then extract and show the PDK's key protector so you can inspect its authorized guardians. These read-only checks don't create a VM or authorize a Hyper-V host.

```powershell
Test-ShieldingDataApplicability `
    -ShieldingDataFilePath 'C:\Provisioning\App01.pdk' `
    -VolumeSignatureCatalogPath 'C:\Provisioning\WS2025.vsc'

$kpBytes = Get-KeyProtectorFromShieldingDataFile `
    -ShieldingDataFilePath 'C:\Provisioning\App01.pdk'

ConvertTo-HgsKeyProtector -Bytes $kpBytes
```

Applicability checks whether the PDK and catalog fit the intended relationship. Stop if that check reports a mismatch or error. It doesn't attest the Hyper-V host, prove the publisher is benevolent, or verify that the actual VHDX hasn't been replaced since the catalog was supplied. Secure provisioning must validate the actual template.

KP inspection helps identify authorized guardians. Never use a newly extracted PDK KP to overwrite the KP of an already provisioned VM. The existing VM has state tied to its existing protected secret.

## Understand the complete orchestration

Creating a generation 2 VM is only one step in the process of provisioning a new shielded VM. The complete path must copy the protected template, configure suitable storage and networking, attach the PDK-derived KP, apply the owner's security policy, enable the vTPM, supply specialization, and initialize provisioning.

`New-VM` creates the VM container. `Set-VMKeyProtector` attaches protector bytes. `Enable-VMTPM` enables the virtual device. `Set-VMSecurity -EncryptStateAndVmMigrationTraffic` controls a documented encryption setting. It isn't a substitute for applying the owner's shielding policy. The current reference doesn't expose a `-ShieldingRequested` setter to invent in a script.

## Stage and approve the GuardedFabricTools module

An authorized administrator downloads the pinned package into a staging directory on a trusted Windows Server management system. Organizational approval must cover the source, package version, signatures, nested modules, dependencies, error handling, and compatibility. Downloading isn't installation or approval.

```powershell
Save-Module -Name GuardedFabricTools -RequiredVersion 1.1.1 `
    -Repository PSGallery -Path 'C:\ToolStaging'

Get-AuthenticodeSignature -FilePath (
    'C:\ToolStaging\GuardedFabricTools\1.1.1\ShieldedVMDeployment\ShieldedVMDeployment.psm1'
)

Get-FileHash -Algorithm SHA256 -Path (
    'C:\ToolStaging\GuardedFabricTools\1.1.1\ShieldedVMDeployment\ShieldedVMDeployment.psm1'
)
```

A valid publisher signature is evidence of source integrity, not proof of fitness for this deployment. Record the accepted package identity and target-build results. Don't bypass execution policy, install the latest unpinned package automatically, or import unreviewed downloaded code on a guarded Hyper-V host.

After approval, deploy the exact reviewed version through the organization's software-distribution process. Validate its use of the installed Hyper-V, HgsClient, and ShieldedVMProvisioning interfaces. See the documented walkthrough and GuardedFabricTools 1.1.1 package.

## Provision a new shielded VM with GuardedFabricTools

A fabric administrator works on a guarded Hyper-V host that passes attestation and can use the KPS keys authorized by `App01.pdk`. The Hyper-V host has the approved helper and provisioning tools. `WorkloadNet` is the approved virtual switch. The selected VM storage directory already exists, is access-controlled, and has enough space.

The template is a protected copy prepared by the publisher. The Windows generation 2 firmware configuration must use the Microsoft Windows Secure Boot template. Verify the helper's Windows path and resulting configuration on the target build before admission.

```powershell
Import-Module GuardedFabricTools -RequiredVersion 1.1.1 -ErrorAction Stop

Get-Command New-ShieldedVM |
    Select-Object Name, Source, Version

$deployment = @{
    Name                  = 'App01'
    TemplateDiskPath      = 'C:\Provisioning\WS2025-Shielded.vhdx'
    ShieldingDataFilePath  = 'C:\Provisioning\App01.pdk'
    SwitchName            = 'WorkloadNet'
    VMPath                = 'D:\VMs\App01'
    MemoryStartupBytes    = 4GB
    CpuCount              = 2
    SpecializationValues  = @{
        '@ComputerName@' = 'App01'
        '@TimeZone@'     = 'GMT Standard Time'
    }
}

$job = New-ShieldedVM @deployment -ErrorAction Stop
Get-ShieldedVMProvisioningStatus -VMName 'App01'
```

Memory and processor values are illustrative workload choices, not capacity recommendations. The `New-ShieldedVM` function creates the VM, copies the disk, creates an FSK from the approved values, and starts provisioning. It doesn't consume the separately authored FSK example as an input parameter.

The **in-box** operation underneath the helper is `Initialize-ShieldedVM`. Its `-VMName` form targets an already prepared VM and returns a provisioning-job object. The following is a code-reading illustration of that stage, **not a second command to run after the helper**:

```powershell
$job = Initialize-ShieldedVM `
    -VMName 'App01' `
    -ShieldingDataFilePath 'C:\Provisioning\App01.pdk' `
    -ShieldedVMSpecializationDataFilePath 'C:\Provisioning\App01.fsk'

Get-ShieldedVMProvisioningStatus -ProvisioningJob $job
```

Observe the provisioning job until its reported outcome is unambiguous. A missing status object, a returned helper object, or a VM becoming visible in Hyper-V Manager doesn't prove success. Inspect job status and error descriptions. Keep a failed deployment isolated while collecting evidence. Don't rerun the creation command against an existing VM or weaken the PDK to make it start.

## Verify the VM and the owner's experience separately

The fabric administrator can inspect the resulting VM on its Hyper-V host with the following read-only checks:

```powershell
Get-VM -Name 'App01' |
    Select-Object Name, State, Generation, Version

Get-VMFirmware -VMName 'App01'
Get-VMSecurity -VMName 'App01'
Get-ShieldedVMProvisioningStatus -VMName 'App01'
```

Confirm generation 2, the intended Secure Boot template, vTPM enablement, shielded policy, and encryption of state and migration traffic. Then have the owner verify the shielded VM's guest identity and authenticated remote access. A security object queried on the Hyper-V host can't prove that the volumes inside the shielded VM are encrypted.

Connect to the shielded VM using owner-authorized RDP or PowerShell remoting. Run the following command with administrative privileges inside the guest operating system to inspect BitLocker without displaying key protectors.

```powershell
Get-BitLockerVolume |
    Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage
```

Windows shielding provisions encryption for the OS disk. Data volumes need their own owner-controlled protection and recovery policy.

For a newly attached data volume, the following owner-side example enables password-based protection and adds a recovery-password protector. It requires guest administration and an approved encryption policy. The returned objects can contain recovery material, so they're assigned rather than shown.

```powershell
$dataPassword = Read-Host -AsSecureString -Prompt 'Data-volume unlock password'

$dataVolume = Enable-BitLocker -MountPoint 'D:' `
    -EncryptionMethod XtsAes256 `
    -PasswordProtector -Password $dataPassword -ErrorAction Stop

$dataVolume = Add-BitLockerKeyProtector -MountPoint 'D:' `
    -RecoveryPasswordProtector -ErrorAction Stop
```

Escrow the recovery information directly to the approved owner-controlled vault and verify retrieval before relying on the volume. Choose a supported normal-unlock arrangement. Don't store an unlock secret in a script readable from the Hyper-V host. Monitor encryption completion and protection status separately. Avoid recording `$dataVolume` in a transcript or diagnostic bundle.

## Bound existing-VM conversion

Conversion isn't new-template provisioning. Plan a recoverable backup, downtime, and owner approval before changing protection.

The `GuardedFabricTools` PowerShell module from the PowerShell Gallery also contains conversion functionality, but that doesn't establish a universal in-box conversion command or Windows Server 2025 compatibility for every existing VM. Don't reuse the new-template recipe or assume that adding a vTPM encrypts existing guest volumes.

Conversion doesn't erase past exposure. Old disks, exports, backups, credentials, and copied data can remain accessible under their previous protection. Address those artifacts and rotate exposed credentials according to the owner's risk decision.
