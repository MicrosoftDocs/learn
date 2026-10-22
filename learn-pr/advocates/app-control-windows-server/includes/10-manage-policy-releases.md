Enforcement is a release decision. Signing is an additional policy-protection decision. Neither should be used to compensate for incomplete application testing.

Keep the OSConfig and custom-policy promotion paths separate. Use the manager that owns the policy.

## Promote a custom base

For the custom-policy example, remove option 3 from a reviewed copy. Preserve the base ID so its existing supplements continue to reference the same policy.

This example changes an offline artifact only. The next version must be approved and higher than the source version.

```powershell
$ErrorActionPreference = 'Stop'
$next = Read-Host 'Enter the approved next four-part policy version'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ArgumentList $next -ScriptBlock {
        param([version]$NextVersion)
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $source = 'C:\AppControl\Source\Base-Audit.xml'
        $destination = 'C:\AppControl\Source\Base-Enforced.xml'
        [xml]$current = Get-Content -LiteralPath $source -Raw
        if ($NextVersion.ToString().Split('.').Count -ne 4 -or
            $NextVersion -le [version]$current.SiPolicy.VersionEx) {
            throw 'Provide a higher four-part version.'
        }
        if (Test-Path -LiteralPath $destination) {
            throw 'Choose a new release artifact rather than overwriting one.'
        }
        Copy-Item -LiteralPath $source -Destination $destination
        Set-RuleOption -FilePath $destination -Option 3 -Delete
        Set-CIPolicyVersion -FilePath $destination -Version $NextVersion.ToString()
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

Compile the reviewed result and deploy it to the approved canary system with CiTool. The supplementary allowances now participate in the enforced base's decisions.

A separate audit identity can be useful for side-by-side evaluation. If you intentionally create one, treat it as a new policy family and link its supplements accordingly. Don't reset the ID of an existing production policy by accident.

## Promote an OSConfig audit-only pilot

OSConfig exposes distinct audit and enforce scenarios. A mode change isn't permission to mix its desired state with direct CiTool edits.

The following example is limited to a console-managed, isolated **audit-only pilot** using the two default audit scenarios. Prepare and rehearse the target-mode supplemental relationships first. It's not an atomic replacement procedure for an already enforced production deployment.

After the enforcement gate is approved, remove that pilot's audit declarations and configure the corresponding enforce declarations.

```powershell
$ErrorActionPreference = 'Stop'
$version = Read-Host 'Enter the approved Microsoft.OSConfig version'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ArgumentList $version -ScriptBlock {
        param([string]$ModuleVersion)
        $ErrorActionPreference = 'Stop'
        Import-Module Microsoft.OSConfig -RequiredVersion $ModuleVersion
        Remove-OSConfigDesiredConfiguration `
            -Scenario 'AppControl\WS2025\DefaultPolicy\Audit'
        Remove-OSConfigDesiredConfiguration `
            -Scenario 'AppControl\WS2025\AppBlockList\Audit'
        Set-OSConfigDesiredConfiguration `
            -Scenario 'AppControl\WS2025\DefaultPolicy\Enforce' -Default
        Set-OSConfigDesiredConfiguration `
            -Scenario 'AppControl\WS2025\AppBlockList\Enforce' -Default
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

This sequence can temporarily remove audit coverage. If configuration fails, keep the pilot isolated, restore its approved audit configuration using the earlier commands, and investigate. Don't report the transition complete.

Requery OSConfig and CiTool, inspect the target-mode base IDs and supplements, and repeat workload and negative tests. Don't discover required supplemental changes for the first time on an in-service production domain controller.

## Decide whether to sign

Signed policies strengthen resistance to administrative tampering. On UEFI systems with Secure Boot enabled, their protection takes effect after restart. Removing or incorrectly updating a protected signed base can cause boot failure.

First prove the rules as unsigned policies. Then prove the signed lifecycle, including updates, signer rollover, and retirement.

The following requirements apply to policy signing.

| Requirement | Operational consequence |
| --- | --- |
| PKCS#7 policy signature | Use the policy-signing procedure, not a generic script-signing command. |
| RSA key of 2048, 3072, or 4096 bits | Don't use ECDSA for policy signing. |
| Supported digest | SHA-256 is used in this module; Server 2025 also supports the documented SHA-384/SHA-512 options. |
| Policy content OID `1.3.6.1.4.1.311.79.1` | Pass the correct content type to SignTool. |
| Authorized update signer | The current policy controls who can sign an accepted replacement. |
| Authorized supplemental signers | A signed base must authorize its signed supplements. |
| Secure Boot | Required for the signed policy's anti-tampering protection. |
| Nondecreasing signed-policy version | Replacing a signed policy with a lower version can prevent boot. |

Retain the private key in an approved signing environment, preferably with organizational key protection. Don't embed PFX passwords, private keys, or production certificate identifiers in scripts or release notes.

## Prepare signer authorization before the final transition

`Add-SignerRule -Update` authorizes policy updates. `-Supplemental` authorizes supplemental-policy signing. These flags are distinct from `-User` or `-Kernel`, which authorize application or driver code.

When an unsigned base already has supplements, coordinate the transition in this order:

1. Prepare an unsigned base update that authorizes the intended update and supplemental signers while option 6 still permits unsigned policy operation.
1. Version, compile, deploy, and verify that preparatory base update.
1. Prepare, sign, deploy, and verify each required supplemental policy.
1. Remove option 6 from the final base release, increment its version, sign it, and deploy it.
1. Restart representative test servers at least twice and rehearse an authorized update and recovery.

This avoids assuming that previously deployed unsigned supplements will remain valid after the base begins requiring signed policies.

The following offline changes add signer authorization to a reviewed base. `PolicySigner.cer` is the public certificate corresponding to the approved private key in the signing environment.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $base = 'C:\AppControl\Source\Base-Enforced.xml'
        $certificate = 'C:\AppControl\Certificates\PolicySigner.cer'
        Add-SignerRule -FilePath $base -CertificatePath $certificate `
            -Update -Supplemental
        Set-RuleOption -FilePath $base -Option 6
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

Assign an approved higher version and deploy this preparatory release before the later transition. Keep each intermediate release in the artifact record.

For a reviewed supplement, add its authorized updater and remove option 6 before compiling and signing its new release.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $supplement = 'C:\AppControl\Source\HyperV-Agent.xml'
        Add-SignerRule -FilePath $supplement `
            -CertificatePath 'C:\AppControl\Certificates\PolicySigner.cer' -Update
        Set-RuleOption -FilePath $supplement -Option 6 -Delete
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

After all required supplements are signed and verified, remove option 6 from the final base release as well. Use `Set-CIPolicyVersion` with an approved higher version for every changed release; don't reset the policy ID.

## Compile and sign one approved release

The example below runs only in the trusted signing environment. It signs one already reviewed and versioned XML file. Repeat it for the appropriate supplemental and base artifacts in the transition order.

The approved RSA code-signing certificate and its private key must be available in the signing user's **Personal** certificate store (`Cert:\CurrentUser\My`).

In an Active Directory Certificate Services (AD CS) environment, obtain an end-entity code-signing certificate from your enterprise certification authority (CA). In a multi-tier hierarchy, enroll through the issuing CA that chains to your trusted enterprise root CA. Keep an offline root CA offline; don't use a CA's own certificate or private key to sign App Control policies.

On an approved, domain-joined signing computer with the Certificates snap-in and access to the CA, use the following process:

1. Ask your public key infrastructure (PKI) administrator to publish a dedicated certificate template based on **Code Signing**. It must include the **Code Signing** application policy and use an RSA key of 2048, 3072, or 4096 bits, not ECDSA. The approved signing account needs **Read** and **Enroll** permissions on the template and permission to request certificates from the CA. Restrict enrollment to authorized signers.
1. Sign in as the account that will run SignTool and open `certmgr.msc`. Use **Certificates - Current User**, not the local computer's certificate store, because the signing script reads `Cert:\CurrentUser\My`.
1. Open the context menu for **Personal**, then select **All Tasks** > **Request New Certificate**. Select **Active Directory Enrollment Policy**, choose the approved code-signing template, provide any required subject information approved by your PKI team, and select **Enroll**. If approval is required, have the PKI team issue the certificate and complete enrollment on the same signing computer.
1. Verify that the issued certificate appears under **Personal** > **Certificates**, has a corresponding private key, and has the **Code Signing** intended purpose. Check its validity period, RSA key size, and certification path to the trusted enterprise root. Record the thumbprint for the signing script.
1. Export the certificate through **All Tasks** > **Export**, selecting **No, do not export the private key** and **DER encoded binary X.509 (.CER)**. Save the public certificate as `C:\AppControl\Certificates\PolicySigner.cer` for the policy-authoring examples.

Keep the private key in the approved signing environment, not on ordinary target servers. Use the public `.cer` file with `Add-SignerRule -Update` and, where applicable, `-Supplemental` during policy preparation. Trust in the root CA alone doesn't authorize the certificate to update a signed policy or sign its supplements.

SignTool must be on that environment's path. Only XML compilation runs in the 5.1 worker; certificate access and SignTool invocation remain in PowerShell 7.

```powershell
$ErrorActionPreference = 'Stop'
$xmlPath = Read-Host 'Enter the full path of the approved, versioned policy XML'
[xml]$policy = Get-Content -LiteralPath $xmlPath -Raw
$id = ([guid]$policy.SiPolicy.PolicyID).ToString('B')
$release = Join-Path 'C:\AppControl\Build' $policy.SiPolicy.VersionEx
$signedFolder = Join-Path $release 'Signed'
New-Item -Path $signedFolder -ItemType Directory -Force | Out-Null
$binary = Join-Path $release "$id.cip"
$signedBinary = Join-Path $signedFolder "$id.cip"
if (Test-Path -LiteralPath $signedBinary) {
    throw 'A signed artifact already exists for this ID and version.'
}
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 `
        -ArgumentList $xmlPath, $binary -ScriptBlock {
        param([string]$XmlPath, [string]$BinaryPath)
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        ConvertFrom-CIPolicy -XmlFilePath $XmlPath `
            -BinaryFilePath $BinaryPath | Out-Null
    }
} finally {
    Remove-PSSession -Session $winPS51
}

$thumbprint = (Read-Host 'Enter the approved signer thumbprint').Replace(' ', '')
if ($thumbprint -notmatch '^[0-9A-Fa-f]{40}$') {
    throw 'Provide the approved certificate thumbprint.'
}
$certificate = Get-Item -LiteralPath "Cert:\CurrentUser\My\$thumbprint"
if (-not $certificate.HasPrivateKey) {
    throw 'The selected certificate has no accessible private key.'
}
$signTool = (Get-Command signtool.exe -ErrorAction Stop).Source
& $signTool sign /sha1 $thumbprint /fd SHA256 `
    /p7 $signedFolder /p7co 1.3.6.1.4.1.311.79.1 $binary
if ($LASTEXITCODE -ne 0) {
    throw "Policy signing failed: $LASTEXITCODE"
}
Move-Item -LiteralPath (Join-Path $signedFolder "$id.cip.p7") `
    -Destination $signedBinary
Get-FileHash -LiteralPath $signedBinary -Algorithm SHA256
```

The signed `.p7` output becomes the deployed `{PolicyID}.cip` file. Deploy that signed result, not the unsigned input with the same base filename.

Protect the release directory. `New-Item` creates the directory; it doesn't independently establish your organization's required ACLs or signing approvals.

## Inspect the signed artifact

Decode the signed content and verify its cryptographic signature. This check is performed offline in the signing environment.

```powershell
$ErrorActionPreference = 'Stop'
$path = Read-Host 'Enter the full path of the signed policy binary'
Add-Type -AssemblyName System.Security.Cryptography.Pkcs
$message = [System.Security.Cryptography.Pkcs.SignedCms]::new()
$message.Decode([System.IO.File]::ReadAllBytes($path))
$message.CheckSignature($true)
if ($message.ContentInfo.ContentType.Value -ne '1.3.6.1.4.1.311.79.1') {
    throw 'Unexpected policy content type.'
}
$message.SignerInfos | ForEach-Object {
    $_.Certificate | Select-Object Subject, Thumbprint, NotAfter
}
```

`CheckSignature($true)` verifies the signature without performing certificate-chain trust validation. It doesn't prove that the target's current policy authorizes this signer. Compare the certificate with the approved updater/supplemental signer rules, then validate the actual deployment and restarts.

Signed-policy deployment involves the EFI policy store as well as OS policy state. Follow the Windows Server 2025 deployment method, and obey any restart requirement. Don't copy warnings specific to older Windows releases as if they described every Server 2025 activation.

## Release to an explicit target

Use a staged deployment system rather than discovering every domain computer and enforcing policies in a loop. The first ring can contain one explicitly approved host.

Prepare the target's approved PowerShell 7 installation and remoting endpoint through the server configuration process. Running `Enable-PSRemoting` from PowerShell 7 registers endpoints for that installation and changes WinRM/listener configuration. Review network exposure and endpoint permissions before doing so; it's not a routine connection-error workaround.

The following selects the registered `PowerShell.7` endpoint and changes one approved test target. Use the approved endpoint name if your organization uses a version-specific or custom endpoint. A default Windows PowerShell endpoint isn't an acceptable fallback.

The approved binary must already be present in the target's protected build directory. Set the XML path to the exact reviewed release source and use the corresponding signed or unsigned artifact path. Specify the approved target PowerShell version so an endpoint redirected to another release fails before activation.

```powershell
$ErrorActionPreference = 'Stop'
$target = 'HV25-01'
$targetPowerShellVersion = Read-Host 'Enter the approved target PowerShell version'
$xmlPath = Read-Host 'Enter the approved release XML path'
$artifact = Read-Host 'Enter the corresponding approved policy binary path'
[xml]$policy = Get-Content -LiteralPath $xmlPath -Raw
$id = ([guid]$policy.SiPolicy.PolicyID).ToString('B')
if ([System.IO.Path]::GetFileName($artifact) -ne "$id.cip") {
    throw 'The artifact filename must match the approved policy ID.'
}
$expectedHash = (Get-FileHash -LiteralPath $artifact -Algorithm SHA256).Hash
Invoke-Command -ComputerName $target -ConfigurationName 'PowerShell.7' `
    -ArgumentList $id, $expectedHash, $targetPowerShellVersion -ScriptBlock {
    param($PolicyId, $ExpectedHash, [string]$ExpectedPowerShellVersion)
    $ErrorActionPreference = 'Stop'
    if ($PSVersionTable.PSEdition -ne 'Core' -or
        $PSVersionTable.PSVersion.Major -ne 7 -or
        $PSVersionTable.PSVersion -lt [version]'7.4' -or
        $PSVersionTable.PSVersion.ToString() -ne $ExpectedPowerShellVersion -or
        -not $IsWindows -or -not [Environment]::Is64BitProcess) {
        throw 'The endpoint is not the approved 64-bit PowerShell 7 environment.'
    }
    $binary = Join-Path 'C:\AppControl\Build' "$PolicyId.cip"
    $actualHash = (Get-FileHash -LiteralPath $binary -Algorithm SHA256).Hash
    if ($actualHash -ne $ExpectedHash) {
        throw 'The target artifact does not match the approved release.'
    }
    & "$env:windir\System32\CiTool.exe" --update-policy $binary
    if ($LASTEXITCODE -ne 0) {
        throw "Policy update failed: $LASTEXITCODE"
    }
    $json = & "$env:windir\System32\CiTool.exe" --list-policies -json
    if ($LASTEXITCODE -ne 0) {
        throw "Policy read-back failed: $LASTEXITCODE"
    }
    $match = @(($json | ConvertFrom-Json).Policies | Where-Object {
        [guid]$_.PolicyID -eq [guid]$PolicyId
    })
    if ($match.Count -ne 1 -or [string]$match[0].IsEnforced -ine 'True') {
        throw 'The selected policy is not reported active; investigate activation.'
    }
    [pscustomobject]@{
        Computer = $env:COMPUTERNAME
        PowerShellVersion = $PSVersionTable.PSVersion.ToString()
        Edition = $PSVersionTable.PSEdition
        PolicyId = $PolicyId
        Version = $match[0].Version
        NextGate = 'Verify release version, options, events and workload tests.'
    }
}
```

The result deliberately doesn't say "rollout passed." Compare the reported version with the approved release, inspect the options and load evidence, and complete functional tests before admitting another target.

## Maintain policy and signer continuity

Policy maintenance is part of software servicing. A new DLL, changed publisher chain, updated unsigned binary, or regenerated catalog can change authorization even when the product name stays the same.

Monitor signing-certificate expiry and private-key availability so that authorized updates remain possible. For urgent application or vulnerable-driver blocks, retain narrow deny scope and representative workload/recovery tests; accelerate approvals rather than skipping the safety gates.

For certificate rollover, first authorize the replacement update and supplemental signing certificates in a release signed by the currently authorized signer. Deploy and verify that release across all targets before relying on the replacement key. Retire the old signer only after the migration is complete.

Retain this minimum release record:

- Policy source, type, ID, base ID, version, and selected options.
- Compiled artifact and independently recorded digest.
- Approved signer identities and signing evidence.
- PowerShell version, required 5.1 worker modules, and remote endpoint.
- Intended targets, deployment owner, and per-target results.
- Workload acceptance evidence and expected negative-test results.
- Known-good rules, recovery artifacts, and an authorized rollback process.

An exception needs an owner, a reason, a scope, and a review or expiry date. That administrative date doesn't automatically expire the rule in the policy. Remove or replace the rule through another controlled release.

No-reboot refresh doesn't terminate already-running processes or unload every driver. Restart services or the system when the required runtime state can't otherwise be established.
