An **audit policy** is an App Control policy with option `3 Enabled:Audit Mode` enabled. It evaluates code against its rules and records executables, DLLs, and drivers that would be blocked in enforcement mode, rather than blocking them under that policy. Use the results to identify missing rules for approved software before enabling enforcement. Other enforced policies still apply, and audit mode can still affect script-host behavior.

Audit results appear in the event logs on the server running the policy. In **Event Viewer**, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **CodeIntegrity** > **Operational**. Filter for event ID **3076** to find files the audit policy would block. Related **3089** events provide signature details, and **3099** confirms that a policy loaded.

On Desktop Experience, script and MSI audit results also appear under **Applications and Services Logs** > **Microsoft** > **Windows** > **AppLocker** > **MSI and Script**. Event ID **8028** identifies script or MSI files that wouldn't pass the policy in enforcement mode.

On Server Core, use `Get-WinEvent` to read `Microsoft-Windows-CodeIntegrity/Operational`. The MSI and Script events aren't available on Server Core, so supplement Code Integrity events with PowerShell diagnostics and workload tests. Audit logs don't normally record every allowed execution, and an empty log doesn't prove that enforcement is safe.

> [!WARNING]
> This unit follows the **custom-policy path**. Don't apply its base as an unexplained additional constraint on the OSConfig pilot. Use separate test targets or a deliberately reviewed combined design.

A folder scan records what's present. It doesn't establish provenance, necessity, or safety. A production server can contain obsolete tools, attacker-created files, or components that don't belong in the future policy. Make sure that the folder you scan only has the artefacts that you're certain of. 

Curate the dependency set before authoring. Include installers, services, DLLs, drivers, plug-ins, modules, scheduled tasks, update utilities, backup software, and recovery tools. In a representative nonproduction environment, test both everyday application use and infrequent tasks such as software upgrades, repairs, backup and restore, cluster failover, and recovery procedures. These tasks can launch additional executables or load DLLs and drivers that everyday use doesn't require. Make sure the policy permits these approved dependencies so that maintenance or recovery isn't unexpectedly blocked.

A suitable Windows template supplies baseline OS trust. Inspect embedded `HvciOptions` and kernel/user signing scenarios before changing it. An application-policy exercise mustn't unintentionally change the host's memory-integrity configuration.

## Create a new base

This example changes offline artifacts only. It requires ConfigCI, the Windows Server 2025 template, and the protected working directories described in Introduction.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $base = 'C:\AppControl\Source\Base-Audit.xml'
        $template = Join-Path $env:windir `
            'schemas\CodeIntegrity\ExamplePolicies\DefaultWindows_Audit.xml'
        if (Test-Path -LiteralPath $base) {
            throw 'Use an update workflow for an existing policy; do not reset its ID.'
        }
        Copy-Item -LiteralPath $template -Destination $base
        Set-CIPolicyIdInfo -FilePath $base -ResetPolicyID `
            -PolicyName 'Contoso-WS2025-Base'
        Set-CIPolicyVersion -FilePath $base -Version '1.0.0.0'
        0, 3, 6, 16, 17 | ForEach-Object {
            Set-RuleOption -FilePath $base -Option $_
        }
        Set-RuleOption -FilePath $base -Option 11 -Delete
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

The base includes UMCI, audit mode, unsigned-policy operation, supported no-reboot updates, and supplemental-policy support. Removing option 11 leaves script enforcement enabled, so test script-host behavior even before enforcement.

`-ResetPolicyID` is appropriate because this is a genuinely new policy. Repeating it for every release would create new policy identities rather than update the existing policy.

## Add a workload supplement

The next example scans a curated host-agent directory. `-UserPEs` includes user-mode PE files in addition to kernel files. `-MultiplePolicyFormat` produces a new policy that can be explicitly linked to the base.

The code changes a new offline artifact. Replace the sample directory with approved files for your actual agent.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $base = 'C:\AppControl\Source\Base-Audit.xml'
        $supplement = 'C:\AppControl\Source\HyperV-Agent.xml'
        if (Test-Path -LiteralPath $supplement) {
            throw 'The supplement already exists; preserve its ID when updating.'
        }
        New-CIPolicy -FilePath $supplement `
            -ScanPath 'C:\ApprovedSoftware\HostAgent' `
            -Level FilePublisher -Fallback Hash -UserPEs -MultiplePolicyFormat
        Set-CIPolicyIdInfo -FilePath $supplement `
            -BasePolicyToSupplementPath $base -PolicyName 'Contoso-HyperV-Agent'
        Set-CIPolicyVersion -FilePath $supplement -Version '1.0.0.0'
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

The fallback is deliberately Hash, not Publisher. A broader fallback could quietly authorize other products from the same vendor.

Inspect the resulting rules, including unsigned files accepted through the fallback. A supplement adds trust; it doesn't narrow trust already granted by the base. Create a separately scoped supplement for domain controller software.

## Add a targeted rule and merge carefully

`New-CIPolicyRule` supports individual files. Its `-DriverFilePath` parameter name also appears when the selected file is a user-mode executable.

After approving the sample executable, generate its rule and merge it into a new copy of the supplement. Both commands run in the same 5.1 worker so that `-Rules` receives live ConfigCI objects, not deserialized copies.

The following example generates one or more allow rules based on `C:\ApprovedSoftware\HostAgent\Helper.exe`.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $rule = New-CIPolicyRule `
            -DriverFilePath 'C:\ApprovedSoftware\HostAgent\Helper.exe' `
            -Level FilePublisher -Fallback Hash
        $original = 'C:\AppControl\Source\HyperV-Agent.xml'
        $updated = 'C:\AppControl\Source\HyperV-Agent-Reviewed.xml'
        if (Test-Path -LiteralPath $updated) {
            throw 'Choose a new reviewed-artifact path.'
        }
        Merge-CIPolicy -PolicyPaths $original -Rules $rule -OutputFilePath $updated
    }
} finally {
    Remove-PSSession -Session $winPS51
}
```

The `New-CIPolicyRule` cmdlet tries `FilePublisher`, which uses the file's signing identity, file metadata, and version information. If it can't generate that rule, it falls back to hash-based rules, such as for an unsigned file. Despite the parameter name `-DriverFilePath`, the input can be an ordinary executable. `Merge-CIPolicy` reads `C:\AppControl\Source\HyperV-Agent.xml`, combines its existing rules with the newly generated allow rules, and writes the result to `C:\AppControl\Source\HyperV-Agent-Reviewed.xml`. The original file remains unchanged. The script stops if the output file already exists. It doesn't deploy or activate the resulting policy.

A deliberate deny uses `-Deny`, for example with a hash of a retired file. Place such rules in the reviewed deny-policy design rather than automatically adding them to an allow supplement.

For multiple XML inputs, the first policy supplies the merged policy type and identity. Put the policy whose identity you intend to preserve first. Never merge an allow-all blocklist into a restrictive base without removing the allow-all rules.

## Inspect identity, options, and schema

Load the policy XML and read fields such as `PolicyID`, `BasePolicyID`, and `VersionEx` by name. Avoid extracting values from the human-readable output of `Set-CIPolicyIdInfo` by assuming that an identifier starts at a particular character position. Changes to the output's wording or layout can cause that approach to return an incorrect or incomplete identifier.

This read-only example exposes fields that should be included in artifact review.

```powershell
$ErrorActionPreference = 'Stop'
[xml]$policy = Get-Content `
    -LiteralPath 'C:\AppControl\Source\HyperV-Agent.xml' -Raw
$policy.SiPolicy |
    Select-Object PolicyType, PolicyID, BasePolicyID, VersionEx, HvciOptions
$policy.SiPolicy.Rules.Rule | Select-Object -ExpandProperty Option
```

Confirm that the supplement's `BasePolicyID` matches the intended base and that base-only options haven't been copied into it. Inspect the actual signer and file-rule sections; a correct GUID can't compensate for an overbroad rule.

Validate manually edited XML against the target server's policy schema. This checks XML structure, not operational safety.

```powershell
$ErrorActionPreference = 'Stop'
$path = 'C:\AppControl\Source\HyperV-Agent.xml'
$schema = Join-Path $env:windir 'schemas\CodeIntegrity\cipolicy.xsd'
[xml]$document = Get-Content -LiteralPath $path -Raw
[void]$document.Schemas.Add($document.DocumentElement.NamespaceURI, $schema)
$document.Validate($null)
```

Successful validation doesn't prove that every required driver is allowed, that a signer is appropriately scoped, or that the linked base is active.

## Compile and activate the audit artifacts

Compilation creates a binary; it doesn't sign it. Derive the deployment filename from the policy's actual GUID.

This authoring example compiles the base and supplement in a 5.1 worker. It returns only artifact paths; PowerShell 7 computes the transfer-verification hashes.

```powershell
$ErrorActionPreference = 'Stop'
$winPS51 = New-PSSession -UseWindowsPowerShell
try {
    $binaryPaths = Invoke-Command -Session $winPS51 -ScriptBlock {
        $ErrorActionPreference = 'Stop'
        Import-Module ConfigCI
        $sources = @(
            'C:\AppControl\Source\Base-Audit.xml'
            'C:\AppControl\Source\HyperV-Agent.xml'
        )
        foreach ($source in $sources) {
            [xml]$policy = Get-Content -LiteralPath $source -Raw
            $id = ([guid]$policy.SiPolicy.PolicyID).ToString('B')
            $binary = Join-Path 'C:\AppControl\Build' "$id.cip"
            ConvertFrom-CIPolicy -XmlFilePath $source `
                -BinaryFilePath $binary | Out-Null
            $binary
        }
    }
} finally {
    Remove-PSSession -Session $winPS51
}
$binaryPaths | ForEach-Object {
    Get-FileHash -LiteralPath $_ -Algorithm SHA256
}
```

Record each digest in the approved release record. Here the flat-file hash verifies the policy artifact transferred to a target, not an executable's App Control rule identity.

The following changes an isolated custom-policy test server. Copy the reviewed XML and corresponding binaries to it first. The XML check is a safety guard; release controls must also prove that the binary is the approved output of that XML.

```powershell
$ErrorActionPreference = 'Stop'
[xml]$base = Get-Content `
    -LiteralPath 'C:\AppControl\Source\Base-Audit.xml' -Raw
if ($base.SiPolicy.Rules.Rule.Option -notcontains 'Enabled:Audit Mode') {
    throw 'This activation example requires an audit base.'
}
$sources = @(
    'C:\AppControl\Source\Base-Audit.xml'
    'C:\AppControl\Source\HyperV-Agent.xml'
)
foreach ($source in $sources) {
    [xml]$policy = Get-Content -LiteralPath $source -Raw
    $id = ([guid]$policy.SiPolicy.PolicyID).ToString('B')
    $binary = Join-Path 'C:\AppControl\Build' "$id.cip"
    & "$env:windir\System32\CiTool.exe" --update-policy $binary
    if ($LASTEXITCODE -ne 0) {
        throw "Activation failed for $id with exit code $LASTEXITCODE."
    }
}
```

Deploy the base before its supplement, then verify both identities, active state, and policy-load events. Obey any reported restart requirement. Don't treat file copy, compilation, or a successful process exit as sufficient workload validation.

Multiple-policy artifacts can reside under `%windir%\System32\CodeIntegrity\CiPolicies\Active`. Signed-policy deployment also involves the EFI policy store. Use the supported management method rather than improvising file placement.
