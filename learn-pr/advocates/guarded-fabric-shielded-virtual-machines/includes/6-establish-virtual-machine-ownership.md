A **guardian** packages signing and encryption identities used to protect or authorize a VM. The **owner guardian** represents the workload owner and carries recovery and update authority through its private keys. A **fabric guardian** represents an HGS fabric's public signing and encryption identities.

The **Key Protector (KP)** protects the VM's secret and authorizes guardians. A **shielding data file**, conventionally called a **PDK**, is an encrypted provisioning package prepared by the owner. A **volume signature catalog (VSC)** describes a signed template's identity, version, and integrity information. These artifacts are related but not interchangeable backups of one another.

Choose owner-key grouping deliberately. A shared owner guardian simplifies operations across a workload group but increases the impact of key theft or loss. Different owners or risk classes can justify separate guardians and custody processes.

## Set up the VM owner's management computer

Use a dedicated, owner-controlled Windows Server 2025 computer to create guardians, update key protectors, and prepare shielding data. It can be a physical server or a management VM, but keep it outside the guarded fabric and outside fabric-administrator control. This computer doesn't need the Hyper-V role or the HGS role. Use Desktop Experience if you need the graphical Shielding Data File wizard. The procedures below use Windows PowerShell.

### Install and verify the tools

Patch and harden the computer before placing owner secrets on it. Restrict administrative and remote access to authorized owner operators, protect its disks and backups, and configure authenticated remote management if required. Joining the HGS forest isn't necessary.

In elevated Windows PowerShell, install the shielding-data tools:

```powershell
Install-WindowsFeature -Name RSAT-Shielded-VM-Tools
```

Complete any restart requested by the installation, then verify that the feature is installed and the required commands are available:

```powershell
Get-WindowsFeature -Name RSAT-Shielded-VM-Tools
Get-Command -Name New-HgsGuardian, Import-HgsGuardian, `
    Grant-HgsKeyProtectorAccess, New-ShieldingDataFile -ErrorAction Stop
```

Stop if the feature isn't installed or a required command is missing. Resolve the installation before importing owner keys.

### Configure trust and protected working storage

Configure DNS and network access to the primary and recovery HGS HTTPS metadata endpoints. Obtain and independently verify the public root and intermediate CA certificates needed to validate those endpoints and the CA-issued guardian certificates. Install roots in the local computer's Trusted Root Certification Authorities store and intermediates in its Intermediate Certification Authorities store. Use owner-managed certificate policy. The HGS forest's trust GPO doesn't configure this computer.

Create `C:\Shielding` for guardian metadata, catalogs, answer files, and PDKs, and `C:\KeyExchange` for owner-authorized KP updates:

```powershell
New-Item -ItemType Directory -Path 'C:\Shielding', 'C:\KeyExchange' `
    -Force -ErrorAction Stop | Out-Null
```

Before using these directories, review their NTFS permissions and remove inherited access that exposes owner material to unauthorized users. Limit access to the authorized owner operators and required system accounts. Directory creation alone doesn't establish these permissions. Keep certificate-import staging separate, and don't place plaintext answer files, private keys, or PFX passwords in fabric-accessible shares or diagnostic transcripts.

### Install owner certificates and preserve recovery

Obtain distinct owner signing and encryption certificates with their private keys through the owner's approved certificate process. These are owner identities, not copies of the HGS service certificates. This example assumes approved password-protected PFX files have been securely staged in `C:\OwnerKeys`. Replace the paths with their actual locations.

Import the certificates into the local computer's Personal store in elevated Windows PowerShell:

```powershell
$ownerSigningPassword = Read-Host -AsSecureString -Prompt 'Owner signing PFX password'
$ownerEncryptionPassword = Read-Host -AsSecureString -Prompt 'Owner encryption PFX password'

$ownerSigningCert = Import-PfxCertificate `
    -FilePath 'C:\OwnerKeys\OwnerSigning.pfx' `
    -CertStoreLocation 'Cert:\LocalMachine\My' `
    -Password $ownerSigningPassword -ErrorAction Stop

$ownerEncryptionCert = Import-PfxCertificate `
    -FilePath 'C:\OwnerKeys\OwnerEncryption.pfx' `
    -CertStoreLocation 'Cert:\LocalMachine\My' `
    -Password $ownerEncryptionPassword -ErrorAction Stop

$ownerSigningCert, $ownerEncryptionCert |
    Select-Object Subject, Thumbprint, HasPrivateKey, NotAfter
```

Verify that each thumbprint matches the approved certificate, that each certificate has its private key, and that its profile and chain meet the guardian requirements. Restrict private-key permissions to the authorized owner operators who perform guardian operations. `HasPrivateKey` confirms key association, not that a particular operator can use the key. Verify usability when creating the owner guardian in the next section.

Retain independently recoverable copies of the owner keys in owner-controlled recovery storage, with PFX passwords protected separately, before removing temporary import files. A nonexportable local key isn't a replacement for recoverable owner authority. Don't copy owner private keys to HGS or Hyper-V hosts.

## Establish owner and fabric guardians

The VM owner uses a trusted Windows Server management environment with the shielding-data tools. Owner signing and encryption certificates, including the required private keys, must already be installed with approved access controls and trust. Don't import owner private keys onto a Hyper-V host.

```powershell
$ownerSigningThumbprint = Read-Host -Prompt 'Owner signing certificate thumbprint'
$ownerEncryptionThumbprint = Read-Host -Prompt 'Owner encryption certificate thumbprint'

$owner = New-HgsGuardian -Name 'Owner-AppWorkloads' `
    -SigningCertificateThumbprint $ownerSigningThumbprint `
    -EncryptionCertificateThumbprint $ownerEncryptionThumbprint
```

Obtain the fabric's public metadata from its authenticated endpoint, such as `https://hgs.security.contoso.com/KeyProtection/service/metadata/2014-07/metadata.xml`. Confirm the expected organization and key identities through an independent trusted channel before importing the file. Downloaded XML isn't, on its own, proof that the intended fabric supplied it.

```powershell
$primary = Import-HgsGuardian -Name 'PrimaryFabric' `
    -Path 'C:\Shielding\PrimaryFabric.xml'

$recovery = Import-HgsGuardian -Name 'RecoveryFabric' `
    -Path 'C:\Shielding\RecoveryFabric.xml'

Get-HgsGuardian
```

The owner authorizes a recovery fabric by including its guardian. This doesn't require sharing owner private keys with either fabric. Don't normalize untrusted-root bypass switches as a production trust-establishment method.

## Change an existing key protector without losing its secret

A **PDK** is the VM owner's encrypted provisioning data file (`.pdk`), also called a shielding data file. It carries VM protection settings, a key protector identifying authorized guardians, and any included guest setup secrets. Fabric administrators use it for provisioning without reading its protected contents. Changing a PDK affects future provisioning, not existing VMs' key protectors. Selecting a new HGS primary key also doesn't automatically authorize that key in every existing VM.

For an existing VM, preserve the existing protected secret. Creating an unrelated new KP, or replacing the KP with a local protector, can make its vTPM state inaccessible or undermine the intended authorization. Use owner-authorized grant and revoke operations on the existing KP.

For example: The fabric administrator performs an owner-approved clean shutdown of `App01` and keeps it off throughout the exchange. Capture the KP as bytes, retain a protected rollback copy, and transfer it through an authenticated channel. Formatted PowerShell output isn't lossless serialization.

On the guarded Hyper-V host, use an elevated Windows PowerShell session as an authorized fabric administrator. Prepare a local exchange directory before exporting the existing Key Protector. Creating `C:\KeyExchange` on the owner's management computer doesn't create it on this host.

```powershell
$hostExchangeDirectory = 'C:\KeyExchange'

if (Test-Path -LiteralPath $hostExchangeDirectory -ErrorAction Stop) {
    if (-not (Test-Path -LiteralPath $hostExchangeDirectory -PathType Container -ErrorAction Stop)) {
        throw "The host exchange path exists but is not a directory: $hostExchangeDirectory"
    }
} else {
    New-Item -Path $hostExchangeDirectory -ItemType Directory -ErrorAction Stop |
        Out-Null
}
```

Before writing or transferring Key Protector files, apply and verify your approved restrictive NTFS permissions on this host-side directory. Permit only the administrators and service identities that need access. The commands check or create the directory; they don't establish a restrictive access-control policy. Resolve a file occupying this path or an access-denied error before continuing.

If `App01-original.kp` already exists, preserve that export and select an unused filename, updating the corresponding transfer and owner-side read paths. The directory check leaves existing directory contents unchanged, but `File.WriteAllBytes` overwrites an existing destination file.

Continue with the module's existing `Get-VMKeyProtector` and export instructions. Transfer the exported Key Protector through the existing approved exchange process. Keep owner private keys on the trusted owner-management computer; preparing a host directory doesn't authorize copying those private keys to the fabric.

```powershell
$vm = Get-VM -Name 'App01' -ErrorAction Stop
if ($vm.State -ne 'Off') {
    throw 'App01 must remain off throughout the key-protector exchange.'
}

$kpBytes = Get-VMKeyProtector -VMName 'App01' -ErrorAction Stop
[IO.File]::WriteAllBytes('C:\KeyExchange\App01-original.kp', $kpBytes)
```

On the owner-controlled server, the VM owner loads the exported bytes and performs the complete approved change before writing a return file. The owner guardian's private signing authority must be available. Grant and revoke operations update the existing KP; don't create a new KP or replace the owner identity.

This example grants `RecoveryFabric` access and withdraws `RetiredFabric`. Use it only after authenticating both guardians, confirming that `RetiredFabric` is present in the existing KP, and approving the remaining clean-start and recovery paths. For an approved grant-only change, set `$withdrawnGuardianName` to `$null`. Removing a fabric guardian isn't permission to discard owner recovery authority.

Choose an unused return filename in the owner-controlled working directory. If `App01-updated.kp` already exists, preserve it and choose another name, updating the subsequent transfer and host-side read path as well. Run the complete block on the owner-controlled server while the VM remains off.

```powershell
$returnPath = 'C:\KeyExchange\App01-updated.kp'
$withdrawnGuardianName = 'RetiredFabric'

try {
    if (Test-Path -LiteralPath $returnPath -ErrorAction Stop) {
        throw 'The return path already exists. Preserve it and choose an unused path.'
    }

    $kp = ConvertTo-HgsKeyProtector -Bytes (
        [IO.File]::ReadAllBytes('C:\KeyExchange\App01-original.kp')
    ) -ErrorAction Stop

    $recovery = Get-HgsGuardian -Name 'RecoveryFabric' -ErrorAction Stop
    if ($null -eq $recovery) {
        throw 'The approved RecoveryFabric guardian was not found.'
    }

    $updatedKp = Grant-HgsKeyProtectorAccess `
        -KeyProtector $kp -Guardian $recovery -ErrorAction Stop

    if ($null -ne $withdrawnGuardianName) {
        $withdrawnGuardian = Get-HgsGuardian `
            -Name $withdrawnGuardianName -ErrorAction Stop
        if ($null -eq $withdrawnGuardian) {
            throw 'The approved withdrawal guardian was not found.'
        }

        $updatedKp = Revoke-HgsKeyProtectorAccess `
            -KeyProtector $updatedKp -Guardian $withdrawnGuardian -ErrorAction Stop
    }

    if ($null -eq $updatedKp -or $null -eq $updatedKp.RawData -or
        $updatedKp.RawData.Length -eq 0) {
        throw 'No completed key protector was returned.'
    }

    [IO.File]::WriteAllBytes($returnPath, $updatedKp.RawData)
} catch {
    Write-Error -Message "The key-protector update failed. Do not transfer a staged file. $($_.Exception.Message)" -ErrorAction Stop
}
```

> [!NOTE]
> If any read, guardian lookup, grant, required revocation, validation, or export fails, stop the exchange. Don't send an earlier or partially written return file, and don't continue with a grant-only result when the approved change requires revocation. Keep the original export unchanged. Before approving transfer, inspect the persisted return KP and confirm the owner and remaining guardians against the change record. Coordinate use of the private working directory so another operator can't reuse the chosen return path during this exchange. After successful approval, continue with the existing authenticated handoff, host-off check, KP application, and clean-start tests.

The fabric administrator checks that the VM remains off, authenticates the returned artifact, and applies the approved KP bytes.

```powershell
if ((Get-VM -Name 'App01').State -ne 'Off') {
    throw 'App01 changed state during the key-protector exchange.'
}

Set-VMKeyProtector -VMName 'App01' -KeyProtector (
    [IO.File]::ReadAllBytes('C:\KeyExchange\App01-updated.kp')
) -ErrorAction Stop
```

Test a clean start on each authorized fabric and rejection at an unauthorized destination. Keep the original KP until the approved verification and retention requirements are met. `Set-VMKeyProtector -RestoreLastKnownGoodKeyProtector` is a documented rollback interface, not a reason to restore a compromised guardian.

## Understand which artifacts to preserve

The following inventory identifies the artifacts to back up or retain for guarded-fabric recovery and repeatable VM deployment. It also identifies who must control each artifact and the consequences of loss or theft. A recoverable deployment needs matching keys, authorization, and protected VM state, not just copies of its virtual disks.

- **Owner keys and guardians:** The owner creates or obtains the owner identity and retains its private keys in an independently recoverable, owner-controlled secret vault or encrypted recovery repository. Public guardian metadata can be distributed, but its integrity and provenance matter. Theft affects every workload in that key group. Loss can remove update and recovery authority.
- **HGS keys and TLS:** HGS administrators control service signing/encryption private keys and their recovery copies or HSM recovery process. Store HGS state exports and key-recovery material in an encrypted, HGS-administered repository outside the production fabric. Hyper-V hosts consume the key-protection service, not private-key exports. TLS private keys remain with their endpoint administrators and require separate recovery planning. Losing TLS access breaks transport. Losing service keys can strand KPs that authorize those keys.
- **Template keys and catalogs:** The publisher retains its signing private key and a serviceable source image. Owners consume the public publisher identity and VSC. The fabric receives the protected VHDX. Keep approved catalogs and version records with the images in an access-controlled, versioned archive. Store signing-key recovery material separately under publisher authority. Signing-key theft can authorize malicious future images. A lost catalog or source disrupts repeatable deployment and servicing.
- **PDKs and answer files:** The owner creates and archives the original encrypted PDK, with its approvals, in an encrypted, access-controlled owner archive. The fabric receives the encrypted package for provisioning. Plaintext answer files, credentials, and private certificates remain in the owner's preparation environment and require controlled cleanup. If an answer file must be retained, store it as an encrypted secret, not alongside fabric-accessible deployment files. Losing the matching original PDK can defeat its documented guest-recovery path.
- **KPs and VM state:** The fabric stores the owner's authorization artifact with the VM and returns it for owner-authorized updates. Protect KP integrity and retain it with consistent VM configuration, vTPM state, disks, and disk-chain relationships in an encrypted VM backup repository. A KP alone isn't a VM backup, and mixing unrelated protected state can make data unreadable.

Keep guest BitLocker recovery escrow in an owner-controlled secret store, separate from HGS service recovery. Losing matching guest-recovery material can leave an otherwise intact encrypted disk unreadable. See grant and revoke reference details.

### Protect recovery storage and access

For exportable software-backed certificates, retain password-protected PFX files and escrow their passwords separately, with independently controlled access. For nonexportable or HSM-backed keys, use the provider's supported recovery mechanism to preserve the original keys. A public certificate or guardian metadata file isn't a private-key backup. Never place owner private keys on HGS or Hyper-V hosts, or collect all roles' secrets in a fabric-administrator-accessible share.

Use authenticated, encrypted channels to transfer recovery artifacts. Keep at least one encrypted off-site copy, with offline storage or immutable retention that routine fabric administrators can't disable. Restrict retrieval to authorized recovery operators and audit access. Ensure that repository access, recovery credentials, and backup decryption keys remain recoverable without starting VMs in the failed fabric. Local working directories such as `C:\Shielding` and `C:\KeyExchange` aren't independent backups.

Maintain an access-controlled inventory that links artifact versions, certificate thumbprints, original PDKs, and VM recovery points to their storage locations and responsible operators. Update it after provisioning, policy changes, or key rollover. Retain the key versions needed by approved backups for their retention period, without silently restoring trust in compromised keys. Periodically test authorized retrieval and an isolated restore of the matching recovery set.
