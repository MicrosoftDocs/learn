You can read through the following guided investigation to understand its flow, or you can even build your own lab to perform the steps to test out the process.

The scenario uses these fixed facts:

```powershell
$DomainName = 'contoso.com'
$Source = 'SEA-DC-01'
$Destination = 'BNE-DC-01'
$AffectedClient = 'BNE-CL-01.contoso.com'
$AffectedClientShortName = 'BNE-CL-01'
$GpoGuid = [guid]'C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57'
$ExpectedGpoDisplayName = 'Workstation Security Baseline'

$timestampFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
$invariantCulture = [Globalization.CultureInfo]::InvariantCulture
$parseStyle = [Globalization.DateTimeStyles]::None

$EvidenceStartInstant = [DateTimeOffset]::ParseExact(
    '2026-07-15T08:30:00+00:00',
    $timestampFormat,
    $invariantCulture,
    $parseStyle
)
$ExpectedConvergenceDeadline = [DateTimeOffset]::ParseExact(
    '2026-07-15T08:45:00+00:00',
    $timestampFormat,
    $invariantCulture,
    $parseStyle
)
$EvidenceEndInstant = [DateTimeOffset]::ParseExact(
    '2026-07-15T09:00:00+00:00',
    $timestampFormat,
    $invariantCulture,
    $parseStyle
)
$PublishedGroupPolicyActivityId =
    '4f789f6e-1189-4d09-b4bf-3a7f6b6d15c2'

if ($EvidenceStartInstant -ge $ExpectedConvergenceDeadline -or
    $ExpectedConvergenceDeadline -ge $EvidenceEndInstant) {
    throw 'The fixed scenario timeline is invalid.'
}
```

| Event | Absolute scenario time |
| --- | --- |
| GPO edit completed on `SEA-DC-01` | `2026-07-15T08:30:00+00:00` |
| Expected convergence deadline | `2026-07-15T08:45:00+00:00` |
| Evidence interval ends; bounded event collection may begin | `2026-07-15T09:00:00+00:00` |

The offset-bearing `DateTimeOffset` values represent absolute instants. Clock synchronization supplies a common time basis; hosts don't need the same local time-zone configuration.

The lab owner pre-provisions the disposable GPO through Group Policy Management and, if appropriate, disposes of it afterward. Creation, editing, and disposal aren't learner commands or scored steps.

## Prepare the investigation

The prepared management host has these components installed before the learner starts:

- The ActiveDirectory, GroupPolicy, and DFSR PowerShell modules and DFS Management Tools.
- The `repadmin`, `dcdiag`, and `nltest` command-line tools.
- DNS, authentication, authorization, and management network paths validated for the two named domain controllers.

The affected client needs local access to its Group Policy Operational log. The optional referral-target extension also requires a preinstalled `dfsutil`; otherwise use the supplied referral output. Installation and feature enablement aren't investigation steps.

Use an account delegated to read the required directory objects, GPOs, replication metadata, DFSR inventory and backlog, local Registry values, shares, and logs. Event-log access depends on the target log's ACL, commonly Event Log Readers or an explicit log ACL; elevation alone doesn't grant every log permission. `dcdiag` separately requires administrative rights and an elevated shell.

Use these exact execution contexts:

| Evidence | Default execution context |
| --- | --- |
| Domain, DC, GPO, GPC, replication metadata, DFSR inventory, and backlog | Prepared management host |
| Registry and `Get-SmbShare` | Locally on each intended DC |
| Directory Service and DFS Replication logs | Locally on `BNE-DC-01` |
| Domain-based GPT read and Group Policy Operational log | Locally on `BNE-CL-01` |
| `dcdiag /s:` | Elevated management-host session with administrative rights |

PowerShell remoting, CIM, remote event collection, and remote `dcdiag /s:` are optional prepared-lab paths. They add name-resolution, authentication, authorization, installed-component, and network/firewall dependencies. `Get-WinEvent -ComputerName` uses Event Log remoting RPC; WinRM applies when PowerShell remoting is used. The `Get-DfsrBacklog` contract doesn't guarantee one internal transport, so the lab must validate its management and network dependencies. Use supplied output if an optional path isn't prepared.

This module assumes SYSVOL uses DFSR and DFSRMIG is already in global state 3, `Eliminated`. FRS, transitional migration states, and migration work are out of scope.

## Resolve the target domain and domain controllers

Run this block on the prepared management host. `Get-ADDomain -Identity` selects the target domain object; `-Server` selects the directory endpoint used for the query.

```powershell
$DomainName = 'contoso.com'
$Source = 'SEA-DC-01'
$Destination = 'BNE-DC-01'

if ([string]::IsNullOrWhiteSpace($DomainName)) {
    throw 'DomainName must identify the target AD DS domain.'
}
if ([string]::IsNullOrWhiteSpace($Source) -or
    [string]::IsNullOrWhiteSpace($Destination)) {
    throw 'Source and Destination must both be nonempty.'
}
if ([string]::Equals(
        $Source,
        $Destination,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'Source and Destination must identify different DCs.'
}

$domain = Get-ADDomain `
    -Identity $DomainName `
    -Server $DomainName `
    -ErrorAction Stop
$DomainDnsRoot = [string]$domain.DNSRoot

if ([string]::IsNullOrWhiteSpace($DomainDnsRoot)) {
    throw 'The target domain didn''t return a DNS root.'
}

$sourceDc = Get-ADDomainController `
    -Identity $Source `
    -Server $DomainDnsRoot `
    -ErrorAction Stop
$destinationDc = Get-ADDomainController `
    -Identity $Destination `
    -Server $DomainDnsRoot `
    -ErrorAction Stop

$SourceHost = [string]$sourceDc.HostName
$DestinationHost = [string]$destinationDc.HostName

if ([string]::IsNullOrWhiteSpace($SourceHost) -or
    [string]::IsNullOrWhiteSpace($DestinationHost)) {
    throw 'Both DCs must resolve to nonempty dNSHostName values.'
}
if ([string]::Equals(
        $SourceHost,
        $DestinationHost,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'The resolved source and destination hosts must be different.'
}

$sourceDc |
    Select-Object HostName, Site, IsGlobalCatalog, IsReadOnly
$destinationDc |
    Select-Object HostName, Site, IsGlobalCatalog, IsReadOnly
```

Supplied result:

| HostName | Site | Global catalog | Read-only |
| --- | --- | --- | --- |
| `SEA-DC-01.contoso.com` | Seattle | `True` | `False` |
| `BNE-DC-01.contoso.com` | Brisbane | `True` | `False` |

Use the resolved `HostName` values for named-DC queries and direct UNC paths. Don't construct a host FQDN by appending the domain name to a short name; AD domains and computer DNS suffixes can be disjoint.

## Confirm the configured local paths and shares

Run the next block in a local PowerShell session on `SEA-DC-01`. `HKLM:` and `Get-SmbShare` describe the computer running PowerShell.

```powershell
$ExpectedShortName = 'SEA-DC-01'

if (-not [string]::Equals(
        $env:COMPUTERNAME,
        $ExpectedShortName,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'Run this block locally on SEA-DC-01.'
}

Get-ItemProperty `
    -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters' `
    -ErrorAction Stop |
    Select-Object 'DSA Database file', 'Database log files path'

Get-SmbShare -Name SYSVOL, NETLOGON -ErrorAction Stop |
    Select-Object Name, Path
```

Run the equivalent block in a separate local session on `BNE-DC-01`:

```powershell
$ExpectedShortName = 'BNE-DC-01'

if (-not [string]::Equals(
        $env:COMPUTERNAME,
        $ExpectedShortName,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'Run this block locally on BNE-DC-01.'
}

Get-ItemProperty `
    -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\NTDS\Parameters' `
    -ErrorAction Stop |
    Select-Object 'DSA Database file', 'Database log files path'

Get-SmbShare -Name SYSVOL, NETLOGON -ErrorAction Stop |
    Select-Object Name, Path
```

Supplied output from both DCs:

```text
DSA Database file       : C:\Windows\NTDS\ntds.dit
Database log files path : C:\Windows\NTDS

Name     Path
----     ----
NETLOGON C:\Windows\SYSVOL\sysvol\contoso.com\scripts
SYSVOL   C:\Windows\SYSVOL\sysvol
```

These checks read configuration and share definitions. Don't open, copy, rename, or compare `ntds.dit` or its log files.

## Establish directory-replication relationship state

Return to the management-host session containing the validated `$DomainDnsRoot`, `$SourceHost`, and `$DestinationHost`. Collect both summary perspectives and then the destination's inbound report:

```powershell
repadmin /replsummary /bysrc
repadmin /replsummary /bydest
repadmin /showrepl $DestinationHost
```

- The `/bysrc` switch summarizes source, or outbound, DSAs and omits destination names.
- The `/bydest` switch summarizes destination, or inbound, DSAs and omits source names.
- The `largest delta` value is the longest interval since a successful replication represented by the row.
- The `fails/total` value is the number of relationships whose latest recorded attempt is failing divided by the relationships represented by the row. It isn't a cumulative attempt history.
- An `error` value needs partner-level investigation; don't infer root cause from the summary column alone.
- The `/showrepl $DestinationHost` option reports inbound status for the named destination, grouped by naming context and source partner.

The optional `/showrepl $DestinationHost /all /verbose` depth retains the base inbound report and appends outbound change-notification neighbors and KCC connection objects.

Scope structured relationship evidence to the destination's domain naming context and fail closed:

```powershell
$rootDse = Get-ADRootDSE `
    -Server $DestinationHost `
    -ErrorAction Stop
$domainNc = [string]$rootDse.defaultNamingContext

if ([string]::IsNullOrWhiteSpace($domainNc)) {
    throw 'The destination didn''t return a default naming context.'
}

$domainPartnerEvidence = @(
    Get-ADReplicationPartnerMetadata `
        -Target $DestinationHost `
        -EnumerationServer $DomainDnsRoot `
        -Scope Server `
        -PartnerType Inbound `
        -Partition $domainNc `
        -ErrorAction Stop
)

if ($domainPartnerEvidence.Count -eq 0) {
    throw 'No inbound domain-NC partner metadata was returned; relationship evidence is unresolved.'
}

$sourceNtdsSettingsPattern =
    '^CN=NTDS Settings,CN=' +
    [regex]::Escape($Source) +
    ',CN=Servers(?:,|$)'
$regexOptions =
    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor
    [System.Text.RegularExpressions.RegexOptions]::CultureInvariant

$expectedInboundDomainNcRelationship = @(
    foreach ($relationship in $domainPartnerEvidence) {
        $partitionMatches = [string]::Equals(
            [string]$relationship.Partition,
            $domainNc,
            [System.StringComparison]::OrdinalIgnoreCase
        )
        $partnerMatches = [regex]::IsMatch(
            [string]$relationship.Partner,
            $sourceNtdsSettingsPattern,
            $regexOptions
        )
        $serverMatches = (
            [string]::Equals(
                [string]$relationship.Server,
                $DestinationHost,
                [System.StringComparison]::OrdinalIgnoreCase
            ) -or
            [string]::Equals(
                [string]$relationship.Server,
                $Destination,
                [System.StringComparison]::OrdinalIgnoreCase
            )
        )

        if ($partitionMatches -and
            $partnerMatches -and
            $serverMatches) {
            $relationship
        }
    }
)

if ($expectedInboundDomainNcRelationship.Count -ne 1) {
    throw 'The expected source-to-destination inbound domain-NC relationship is absent or ambiguous; relationship evidence is unresolved.'
}

$domainPartnerEvidence |
    Select-Object Server,
                  Partition,
                  Partner,
                  LastReplicationAttempt,
                  LastReplicationSuccess,
                  LastReplicationResult,
                  ConsecutiveReplicationFailures
```

`-EnumerationServer $DomainDnsRoot` prevents a cross-domain management host from silently enumerating its own domain. When neither `-Partition` nor `-Filter` is supplied, `Get-ADReplicationPartnerMetadata` uses the target's default naming context; this investigation supplies `-Partition` explicitly.

Supplied evidence contains exactly one expected inbound relationship:

```text
Server                  : BNE-DC-01.contoso.com
Partition               : DC=contoso,DC=com
Partner                 : CN=NTDS Settings,CN=SEA-DC-01,CN=Servers,CN=Seattle,CN=Sites,CN=Configuration,DC=contoso,DC=com
LastReplicationAttempt  : 2026-07-15T08:47:12+00:00
LastReplicationSuccess  : 2026-07-15T08:47:12+00:00
LastReplicationResult   : 0
ConsecutiveReplicationFailures : 0
```

This is the latest recorded relationship state at capture. It doesn't prove uninterrupted success during the interval or delivery, equality, or freshness of the scenario GPC object.

## Identify the SYSVOL replication objects

On the prepared management host, explicitly target `contoso.com` so the DFSR inventory cmdlets don't default to the current user's domain:

```powershell
Get-DfsReplicationGroup `
    -GroupName * `
    -IncludeSysvol `
    -DomainName $DomainName `
    -ErrorAction Stop |
    Select-Object GroupName, DomainName

Get-DfsReplicatedFolder `
    -GroupName 'Domain System Volume' `
    -DomainName $DomainName `
    -ErrorAction Stop |
    Select-Object GroupName, FolderName, DomainName
```

Supplied result:

```text
GroupName           FolderName   DomainName
---------           ----------   ----------
Domain System Volume             contoso.com
Domain System Volume SYSVOL Share contoso.com
```

The objects describe DFSR configuration in AD DS. They don't prove current file equality.

## Locate and validate the Group Policy container

Use the fixed GUID as identity. Omitting `Get-GPO -Server` normally directs the GroupPolicy cmdlet to the domain's PDC emulator, so the scenario names the resolved source host:

```powershell
$GpoGuid = [guid]'C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57'
$ExpectedGpoDisplayName = 'Workstation Security Baseline'

$gpo = Get-GPO `
    -Guid $GpoGuid `
    -Domain $DomainDnsRoot `
    -Server $SourceHost `
    -ErrorAction Stop

$guid = $GpoGuid.ToString('D').ToUpperInvariant()
$gpcDn = "CN={$guid},CN=Policies,CN=System,$($domain.DistinguishedName)"

$gpo |
    Select-Object DisplayName, Id, GpoStatus, ModificationTime
```

The display name isn't identity. If the prepared lab uses the expected label, this optional assertion can detect a mislabeled scenario object:

```powershell
if (-not [string]::Equals(
        $gpo.DisplayName,
        $ExpectedGpoDisplayName,
        [System.StringComparison]::Ordinal)) {
    throw 'The fixed scenario GPO has an unexpected display name.'
}
```

Save both direct GPC queries with provenance, require numeric versions and one nonblank raw schema-single-valued path per replica, then compare without trimming or normalizing:

```powershell
function ConvertTo-RequiredGpcVersion {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [object]$Value,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$QueriedServer
    )

    $values = @($Value)
    if ($values.Count -ne 1) {
        throw "versionNumber must contain one value on $QueriedServer."
    }

    $text = [string]$values[0]
    if ([string]::IsNullOrWhiteSpace($text) -or
        $text -notmatch '^[0-9]+$') {
        throw "versionNumber must be numeric on $QueriedServer."
    }

    [uint32]$version = 0
    if (-not [uint32]::TryParse(
            $text,
            [Globalization.NumberStyles]::None,
            [Globalization.CultureInfo]::InvariantCulture,
            [ref]$version)) {
        throw "versionNumber is outside the UInt32 range on $QueriedServer."
    }

    $version
}

$sourceGpc = Get-ADObject `
    -Identity $gpcDn `
    -Server $SourceHost `
    -Properties gPCFileSysPath, versionNumber `
    -ErrorAction Stop

$destinationGpc = Get-ADObject `
    -Identity $gpcDn `
    -Server $DestinationHost `
    -Properties gPCFileSysPath, versionNumber `
    -ErrorAction Stop

$gpcEvidence = @(
    [pscustomobject]@{
        QueriedServer = $SourceHost
        DistinguishedName = $sourceGpc.DistinguishedName
        RawGpcFileSysPath = $sourceGpc.gPCFileSysPath
        RawVersionNumber = $sourceGpc.versionNumber
    }
    [pscustomobject]@{
        QueriedServer = $DestinationHost
        DistinguishedName = $destinationGpc.DistinguishedName
        RawGpcFileSysPath = $destinationGpc.gPCFileSysPath
        RawVersionNumber = $destinationGpc.versionNumber
    }
)
$gpcEvidence

$sourcePathValues = @($sourceGpc.gPCFileSysPath)
$destinationPathValues = @($destinationGpc.gPCFileSysPath)

if ($sourcePathValues.Count -ne 1 -or
    [string]::IsNullOrWhiteSpace([string]$sourcePathValues[0]) -or
    $destinationPathValues.Count -ne 1 -or
    [string]::IsNullOrWhiteSpace([string]$destinationPathValues[0])) {
    throw 'gPCFileSysPath must contain one nonblank value on each GPC replica.'
}

$sourceGpcPath = [string]$sourcePathValues[0]
$destinationGpcPath = [string]$destinationPathValues[0]
$sourceVersionNumber = ConvertTo-RequiredGpcVersion `
    -Value $sourceGpc.versionNumber `
    -QueriedServer $SourceHost
$destinationVersionNumber = ConvertTo-RequiredGpcVersion `
    -Value $destinationGpc.versionNumber `
    -QueriedServer $DestinationHost

$expectedDomainGpt =
    "\\$DomainDnsRoot\SYSVOL\$DomainDnsRoot\Policies\{$guid}"

$gpcComparison = [pscustomobject]@{
    VersionNumbersEqual = (
        $sourceVersionNumber -eq $destinationVersionNumber
    )
    PathsEqual = [string]::Equals(
        $sourceGpcPath,
        $destinationGpcPath,
        [System.StringComparison]::OrdinalIgnoreCase
    )
    SourcePathMatchesExpected = [string]::Equals(
        $sourceGpcPath,
        $expectedDomainGpt,
        [System.StringComparison]::OrdinalIgnoreCase
    )
    DestinationPathMatchesExpected = [string]::Equals(
        $destinationGpcPath,
        $expectedDomainGpt,
        [System.StringComparison]::OrdinalIgnoreCase
    )
}
$gpcComparison

if (-not $gpcComparison.VersionNumbersEqual) {
    throw 'versionNumber differs between the queried GPC replicas.'
}
if (-not $gpcComparison.PathsEqual) {
    throw 'gPCFileSysPath differs between the queried GPC replicas.'
}
if (-not $gpcComparison.SourcePathMatchesExpected -or
    -not $gpcComparison.DestinationPathMatchesExpected) {
    throw "gPCFileSysPath isn't the expected domain GPT path: $expectedDomainGpt"
}

$verifiedDomainGpt = $sourceGpcPath
```

`gPCFileSysPath` is schema-single-valued. Multiple returned values indicate a retrieval or script representation anomaly, or invalid data, rather than a normal multi-valued state. Preserve the raw output and stop. Path comparison uses the untrimmed strings with `OrdinalIgnoreCase`; it doesn't collapse separators, append a separator, or otherwise normalize them.

Supplied result:

| Queried server | Numeric `versionNumber` | Raw `gPCFileSysPath` |
| --- | ---: | --- |
| `SEA-DC-01.contoso.com` | `196615` | `\\contoso.com\SYSVOL\contoso.com\Policies\{C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57}` |
| `BNE-DC-01.contoso.com` | `196615` | `\\contoso.com\SYSVOL\contoso.com\Policies\{C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57}` |

Both expected-path checks pass. The queries ran sequentially, so equality establishes agreement only at their respective query times, not an atomic cross-replica snapshot.

## Compare GPC attribute metadata

Run the canonical two-DC comparison for the two visible GPC attributes:

```powershell
$attributesToCompare = @(
    'versionNumber'
    'gPCFileSysPath'
)

$sourceAttributeMetadata = @(
    Get-ADReplicationAttributeMetadata `
        -Object $gpcDn `
        -Server $SourceHost `
        -Properties $attributesToCompare `
        -ErrorAction Stop
)
$destinationAttributeMetadata = @(
    Get-ADReplicationAttributeMetadata `
        -Object $gpcDn `
        -Server $DestinationHost `
        -Properties $attributesToCompare `
        -ErrorAction Stop
)

$gpcAttributeMetadataEvidence = @(
    foreach ($metadataRow in $sourceAttributeMetadata) {
        [pscustomobject]@{
            QueriedServer = $SourceHost
            AttributeName = $metadataRow.AttributeName
            Version = $metadataRow.Version
            LastOriginatingChangeDirectoryServerIdentity =
                $metadataRow.LastOriginatingChangeDirectoryServerIdentity
            LastOriginatingChangeDirectoryServerInvocationId =
                $metadataRow.LastOriginatingChangeDirectoryServerInvocationId
            LastOriginatingChangeUsn =
                $metadataRow.LastOriginatingChangeUsn
            LastOriginatingChangeTime =
                $metadataRow.LastOriginatingChangeTime
            LocalChangeUsn = $metadataRow.LocalChangeUsn
        }
    }
    foreach ($metadataRow in $destinationAttributeMetadata) {
        [pscustomobject]@{
            QueriedServer = $DestinationHost
            AttributeName = $metadataRow.AttributeName
            Version = $metadataRow.Version
            LastOriginatingChangeDirectoryServerIdentity =
                $metadataRow.LastOriginatingChangeDirectoryServerIdentity
            LastOriginatingChangeDirectoryServerInvocationId =
                $metadataRow.LastOriginatingChangeDirectoryServerInvocationId
            LastOriginatingChangeUsn =
                $metadataRow.LastOriginatingChangeUsn
            LastOriginatingChangeTime =
                $metadataRow.LastOriginatingChangeTime
            LocalChangeUsn = $metadataRow.LocalChangeUsn
        }
    }
)
$gpcAttributeMetadataEvidence |
    Sort-Object AttributeName, QueriedServer

$originatingStampComparison = foreach (
    $attributeName in $attributesToCompare
) {
    $sourceStamp = @(
        $sourceAttributeMetadata |
            Where-Object { $_.AttributeName -eq $attributeName }
    )
    $destinationStamp = @(
        $destinationAttributeMetadata |
            Where-Object { $_.AttributeName -eq $attributeName }
    )

    if ($sourceStamp.Count -ne 1 -or
        $destinationStamp.Count -ne 1) {
        throw "Expected one metadata row per DC for $attributeName."
    }

    $sourceStamp = $sourceStamp[0]
    $destinationStamp = $destinationStamp[0]
    $versionMatches =
        $sourceStamp.Version -eq $destinationStamp.Version
    $invocationIdMatches = (
        $null -ne
            $sourceStamp.LastOriginatingChangeDirectoryServerInvocationId -and
        $sourceStamp.LastOriginatingChangeDirectoryServerInvocationId -eq
            $destinationStamp.LastOriginatingChangeDirectoryServerInvocationId
    )
    $originatingUsnMatches =
        $null -ne $sourceStamp.LastOriginatingChangeUsn -and
        $sourceStamp.LastOriginatingChangeUsn -eq
            $destinationStamp.LastOriginatingChangeUsn
    $originatingTimeMatches =
        $null -ne $sourceStamp.LastOriginatingChangeTime -and
        $sourceStamp.LastOriginatingChangeTime -eq
            $destinationStamp.LastOriginatingChangeTime

    [pscustomobject]@{
        AttributeName = $attributeName
        VersionMatches = $versionMatches
        OriginatingInvocationIdMatches = $invocationIdMatches
        OriginatingUsnMatches = $originatingUsnMatches
        OriginatingTimeMatches = $originatingTimeMatches
        SameOriginatingUpdate = (
            $versionMatches -and
            $invocationIdMatches -and
            $originatingUsnMatches -and
            $originatingTimeMatches
        )
    }
}
$originatingStampComparison
```

`QueriedServer` is a custom provenance column populated from the exact `-Server` argument. `LocalChangeUsn` is local to that queried DC; never compare its magnitude with another DC's `LocalChangeUsn`.

Matching metadata `Version`, originating invocation ID, originating USN, and originating time for the same attribute supplies separate same-originating-update evidence. `LastOriginatingChangeTime` comes from the originating DC's clock and is provenance; timestamps alone can't order independently originated updates.

The supplied comparison returns `SameOriginatingUpdate = True` for both `versionNumber` and `gPCFileSysPath`. The supplied evidence package retains the two underlying rows and their originating fields. This object-specific result is separate from the relationship state.

## Capture the two named GPT replicas

Only after the raw path and expected-path checks pass, validate its suffix and derive named-DC diagnostic paths. The prepared lab preloads the following read-and-run helpers; learners inspect their evidence contract rather than retyping or memorizing them.

```powershell
function ConvertFrom-GptIniBytes {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [byte[]]$Bytes
    )

    $memoryStream = $null
    $reader = $null
    try {
        $strictUtf8 =
            [System.Text.UTF8Encoding]::new($false, $true)
        $memoryStream =
            [System.IO.MemoryStream]::new($Bytes, $false)
        $reader = [System.IO.StreamReader]::new(
            $memoryStream,
            $strictUtf8,
            $true
        )
        $reader.ReadToEnd()
    }
    finally {
        if ($null -ne $reader) {
            $reader.Dispose()
        }
        if ($null -ne $memoryStream) {
            $memoryStream.Dispose()
        }
    }
}

function Get-GptIniVersion {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Content
    )

    $generalSectionFound = $false
    $currentSection = $null
    $versionValues =
        [System.Collections.Generic.List[string]]::new()

    foreach ($line in @($Content -split '\r\n|\n|\r')) {
        if ($line -match '^\s*\[([^\]]+)\]\s*$') {
            $currentSection = $Matches[1]
            if ([string]::Equals(
                    $currentSection,
                    'General',
                    [System.StringComparison]::OrdinalIgnoreCase)) {
                $generalSectionFound = $true
            }
            continue
        }

        if ([string]::Equals(
                $currentSection,
                'General',
                [System.StringComparison]::OrdinalIgnoreCase) -and
            $line -match '^\s*Version\s*=\s*(.*?)\s*$') {
            [void]$versionValues.Add($Matches[1])
        }
    }

    if (-not $generalSectionFound -or
        $versionValues.Count -ne 1 -or
        $versionValues[0] -notmatch '^[0-9]+$') {
        throw 'gpt.ini must contain [General] and exactly one decimal Version value.'
    }

    [uint32]$version = 0
    if (-not [uint32]::TryParse(
            $versionValues[0],
            [Globalization.NumberStyles]::None,
            [Globalization.CultureInfo]::InvariantCulture,
            [ref]$version)) {
        throw 'The gpt.ini Version value is outside the UInt32 range.'
    }

    $version
}

function Get-StableFileCapture {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$LiteralPath,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$QueriedServer,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$RelativePath
    )

    $readStartedUtc = [DateTimeOffset]::UtcNow
    $itemBefore =
        Get-Item -LiteralPath $LiteralPath -ErrorAction Stop
    if ($itemBefore.PSIsContainer) {
        throw "Expected a file but found a directory: $LiteralPath"
    }

    [byte[]]$bytes =
        [System.IO.File]::ReadAllBytes($LiteralPath)
    $itemAfter =
        Get-Item -LiteralPath $LiteralPath -ErrorAction Stop
    $readCompletedUtc = [DateTimeOffset]::UtcNow

    if ([int64]$itemBefore.Length -ne [int64]$itemAfter.Length -or
        $itemBefore.LastWriteTimeUtc -ne
            $itemAfter.LastWriteTimeUtc) {
        throw "File metadata changed during the bounded read: $LiteralPath"
    }
    if ([int64]$bytes.LongLength -ne [int64]$itemAfter.Length) {
        throw "Captured byte length disagrees with file metadata: $LiteralPath"
    }

    $sha256 = $null
    try {
        $sha256 =
            [System.Security.Cryptography.SHA256]::Create()
        $hashBytes = $sha256.ComputeHash($bytes)
        $hashText =
            [System.BitConverter]::ToString($hashBytes).Replace('-', '')
    }
    finally {
        if ($null -ne $sha256) {
            $sha256.Dispose()
        }
    }

    $gptText = $null
    $gptVersion = $null
    if ([string]::Equals(
            $RelativePath,
            'gpt.ini',
            [System.StringComparison]::OrdinalIgnoreCase)) {
        $gptText = ConvertFrom-GptIniBytes -Bytes $bytes
        $gptVersion = Get-GptIniVersion -Content $gptText
    }

    [pscustomobject]@{
        ReadStartedUtc = $readStartedUtc.ToString(
            'o',
            [Globalization.CultureInfo]::InvariantCulture
        )
        ReadCompletedUtc = $readCompletedUtc.ToString(
            'o',
            [Globalization.CultureInfo]::InvariantCulture
        )
        QueriedServer = $QueriedServer
        RelativePath = $RelativePath
        LengthBefore = [int64]$itemBefore.Length
        LastWriteTimeUtcBefore =
            $itemBefore.LastWriteTimeUtc.ToString(
                'o',
                [Globalization.CultureInfo]::InvariantCulture
            )
        LengthAfter = [int64]$itemAfter.Length
        LastWriteTimeUtcAfter =
            $itemAfter.LastWriteTimeUtc.ToString(
                'o',
                [Globalization.CultureInfo]::InvariantCulture
            )
        CapturedByteLength = [int64]$bytes.LongLength
        StabilityCheckPassed = $true
        SHA256 = $hashText
        GptVersion = $gptVersion
        CapturedText = $gptText
    }
}

$domainUncPrefix = "\\$DomainDnsRoot"
$expectedGptSuffix =
    "\SYSVOL\$DomainDnsRoot\Policies\{$guid}"

if (-not $verifiedDomainGpt.StartsWith(
        $domainUncPrefix,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'The verified GPT path has an unexpected UNC prefix.'
}

$gptSuffix = $verifiedDomainGpt.Substring($domainUncPrefix.Length)

if (-not [string]::Equals(
        $gptSuffix,
        $expectedGptSuffix,
        [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'The verified GPT path has an unexpected SYSVOL-relative suffix.'
}

$sourceDirectGpt = "\\$SourceHost$gptSuffix"
$destinationDirectGpt = "\\$DestinationHost$gptSuffix"

$replicas = @(
    [pscustomobject]@{
        QueriedServer = $SourceHost
        Root = $sourceDirectGpt
    }
    [pscustomobject]@{
        QueriedServer = $DestinationHost
        Root = $destinationDirectGpt
    }
)
$scenarioFiles = @(
    'gpt.ini'
    'Machine\Registry.pol'
)

$directReplicaFileCaptures = $null
$directReplicaFileCaptures = @(
    foreach ($replica in $replicas) {
        foreach ($relativePath in $scenarioFiles) {
            $literalPath = Join-Path `
                -Path $replica.Root `
                -ChildPath $relativePath
            Get-StableFileCapture `
                -LiteralPath $literalPath `
                -QueriedServer $replica.QueriedServer `
                -RelativePath $relativePath
        }
    }
)

$directReplicaFileEvidence =
    $directReplicaFileCaptures |
        Select-Object ReadStartedUtc,
                      ReadCompletedUtc,
                      QueriedServer,
                      RelativePath,
                      LengthBefore,
                      LastWriteTimeUtcBefore,
                      LengthAfter,
                      LastWriteTimeUtcAfter,
                      CapturedByteLength,
                      StabilityCheckPassed,
                      SHA256,
                      GptVersion
$directReplicaFileEvidence

foreach (
    $gptCapture in @(
        $directReplicaFileCaptures |
            Where-Object { $null -ne $_.CapturedText }
    )
) {
    Write-Output (
        'Captured gpt.ini from {0} during {1} through {2}:' -f
            $gptCapture.QueriedServer,
            $gptCapture.ReadStartedUtc,
            $gptCapture.ReadCompletedUtc
    )
    Write-Output $gptCapture.CapturedText
}
```

Each file is read into bytes once during its recorded `ReadStartedUtc` through `ReadCompletedUtc` interval. The helper checks length and `LastWriteTimeUtc` before and after that read and verifies captured byte length before emitting a hash or parsed version. SHA-256 is computed from the captured bytes. The BOM-aware reader decodes the same in-memory `gpt.ini` bytes; the parser requires `[General]`, exactly one decimal `Version`, and a UInt32-valid value.

The text is displayed only after every requested capture succeeds. The captures are sequential, non-atomic, and not transactionally consistent. Equal hashes would prove equality only for bytes captured in the reported per-file intervals, not freshness or replication direction.

Supplied capture summary:

| Queried server | Relative file | Bounded read interval (UTC) | Supplied result |
| --- | --- | --- | --- |
| `SEA-DC-01.contoso.com` | `gpt.ini` | `2026-07-15T09:01:02.0000000Z` through `2026-07-15T09:01:02.0200000Z` | Stability passed; parsed version `196615` |
| `BNE-DC-01.contoso.com` | `gpt.ini` | `2026-07-15T09:01:03.0000000Z` through `2026-07-15T09:01:03.0250000Z` | Stability passed; parsed version `196614`; SHA-256 differs from source |
| `SEA-DC-01.contoso.com` | `Machine\Registry.pol` | `2026-07-15T09:01:04.0000000Z` through `2026-07-15T09:01:04.0400000Z` | Stability passed |
| `BNE-DC-01.contoso.com` | `Machine\Registry.pol` | `2026-07-15T09:01:05.0000000Z` through `2026-07-15T09:01:05.0450000Z` | Stability passed; SHA-256 differs from source |

**Supplied captured text for `SEA-DC-01.contoso.com`:**

```text
[General]
Version=196615
```

**Supplied captured text for `BNE-DC-01.contoso.com`:**

```text
[General]
Version=196614
```

The server labels are provenance, not file content.

## Compare directional DFSR backlog

Run both point-in-time directions from the management host. Merge only verbose output into the success stream, retain its total-count message, and keep backlog objects separate:

```powershell
$forwardCapture = @(
    Get-DfsrBacklog `
        -GroupName 'Domain System Volume' `
        -FolderName 'SYSVOL Share' `
        -SourceComputerName $SourceHost `
        -DestinationComputerName $DestinationHost `
        -Verbose `
        -ErrorAction Stop 4>&1
)
$forwardVerbose = @(
    $forwardCapture |
        Where-Object {
            $_ -is [System.Management.Automation.VerboseRecord]
        }
)
$forwardBacklog = @(
    $forwardCapture |
        Where-Object {
            $_ -isnot [System.Management.Automation.VerboseRecord]
        }
)
$forwardVerbose | Select-Object -ExpandProperty Message
$forwardBacklog | Select-Object FileName

$reverseCapture = @(
    Get-DfsrBacklog `
        -GroupName 'Domain System Volume' `
        -FolderName 'SYSVOL Share' `
        -SourceComputerName $DestinationHost `
        -DestinationComputerName $SourceHost `
        -Verbose `
        -ErrorAction Stop 4>&1
)
$reverseVerbose = @(
    $reverseCapture |
        Where-Object {
            $_ -is [System.Management.Automation.VerboseRecord]
        }
)
$reverseBacklog = @(
    $reverseCapture |
        Where-Object {
            $_ -isnot [System.Management.Automation.VerboseRecord]
        }
)
$reverseVerbose | Select-Object -ExpandProperty Message
$reverseBacklog | Select-Object FileName
```

The cmdlet emits at most 100 backlog objects even when the verbose total is larger. The raw localized `VerboseRecord.Message` values are retained and displayed as evidence, but this lab doesn't parse them to derive a count. The lab author reviews those messages together with the retained backlog objects and supplies the normalized directional/count summary.

Supplied retained backlog-object display collected at `2026-07-15T09:02:00+00:00`:

```text
FileName
--------
gpt.ini
Registry.pol
```

**Abridged interpreted summary derived from the retained raw verbose messages and backlog objects, not raw cmdlet output:**

```text
SEA-DC-01.contoso.com -> BNE-DC-01.contoso.com total backlog count: 2
BNE-DC-01.contoso.com -> SEA-DC-01.contoso.com total backlog count: 0
```

A listed item is pending from that query's source to its destination. Backlog alone may be normal replication latency. Here it corroborates the direct named-replica byte and version difference after the `2026-07-15T08:45:00+00:00` expected convergence deadline; it doesn't establish root cause.

## Test the affected client path

Management-host variables don't cross into the client session. The prepared client artifact therefore contains the concrete values established by the earlier path validation.

Run this preloaded read-and-run block locally on `BNE-CL-01`:

```powershell
function Read-ValidatedDomainGpt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExpectedShortName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ValidatedDomainGpt,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExpectedDomainGpt
    )

    foreach ($value in @(
            $ExpectedShortName,
            $ValidatedDomainGpt,
            $ExpectedDomainGpt
        )) {
        if ([string]::IsNullOrWhiteSpace($value) -or
            $value.IndexOf([char]60) -ge 0 -or
            $value.IndexOf([char]62) -ge 0) {
            throw 'Published client evidence must contain concrete values.'
        }
    }

    if (-not [string]::Equals(
            $env:COMPUTERNAME,
            $ExpectedShortName,
            [System.StringComparison]::OrdinalIgnoreCase)) {
        throw 'Run this block locally on the affected client.'
    }

    if (-not [string]::Equals(
            $ValidatedDomainGpt,
            $ExpectedDomainGpt,
            [System.StringComparison]::OrdinalIgnoreCase)) {
        throw 'The validated GPC path doesn''t equal the expected domain GPT path.'
    }

    $domainGptIni =
        Join-Path -Path $ValidatedDomainGpt -ChildPath 'gpt.ini'

    if (-not (Test-Path `
            -LiteralPath $domainGptIni `
            -PathType Leaf `
            -ErrorAction Stop)) {
        throw 'The validated domain GPT doesn''t contain gpt.ini.'
    }

    Get-Content -LiteralPath $domainGptIni -ErrorAction Stop
}

$AffectedClient = 'BNE-CL-01.contoso.com'
$AffectedClientShortName = 'BNE-CL-01'
$ValidatedDomainGpt =
    '\\contoso.com\SYSVOL\contoso.com\Policies\{C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57}'
$ExpectedDomainGpt =
    '\\contoso.com\SYSVOL\contoso.com\Policies\{C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57}'

$clientGptText = Read-ValidatedDomainGpt `
    -ExpectedShortName $AffectedClientShortName `
    -ValidatedDomainGpt $ValidatedDomainGpt `
    -ExpectedDomainGpt $ExpectedDomainGpt
$clientGptText

nltest /dsgetdc:contoso.com
gpresult /scope computer /r
```

The manual SMB read uses the PowerShell process's network security context (normally the invoking user in an interactive session). It isn't necessarily the LocalSystem or computer-account context used for computer policy, so correlate it with the affected computer-processing events.

`nltest` identifies a DC selected by DC Locator. It doesn't prove which DC served the later DFS namespace read. A successful domain UNC read proves access through some referral target, not the SMB target's identity.

As an optional read-only extension, run this immediately after the domain-based read only when `dfsutil` is already installed on the prepared client:

```powershell
dfsutil /pktinfo
```

Locate the exact `\\contoso.com\SYSVOL` cache entry and the target marked active. Don't flush the referral cache. If the exact entry or active target is missing or ambiguous, classify the referral target as unresolved.

Supplied client evidence:

| Evidence | Supplied result |
| --- | --- |
| Client provenance | `BNE-CL-01.contoso.com` / `BNE-CL-01` |
| Domain path equality and leaf checks | Passed |
| Domain-based `gpt.ini` read | `[General]`, `Version=196614` |
| `nltest /dsgetdc:contoso.com` | DC Locator selected `\\BNE-DC-01`; this isn't used as SMB-target proof |
| `gpresult /scope computer /r` | Lists **Workstation Security Baseline** |
| Prepared `dfsutil /pktinfo` capture | Exact `\\contoso.com\SYSVOL` entry has `\\BNE-DC-01.contoso.com\SYSVOL` marked active |

The supplied referral capture, not `nltest` or the domain UNC read alone, identifies `BNE-DC-01.contoso.com` as the active SMB target at that capture.

From an elevated management-host session, using administrative rights and the validated network path, collect readiness evidence:

```powershell
dcdiag /s:$DestinationHost /test:Advertising /test:SysVolCheck /test:NetLogons
```

The supplied tests pass. Advertising and share-readiness checks don't prove that every GPT version is current.

## Collect bounded local event evidence

The prepared lab preloads this helper into the local `BNE-DC-01` and `BNE-CL-01` sessions. Learners read its contract and run the guided calls; they don't retype or memorize the implementation. The supplied result objects are the fallback.

```powershell
function Get-LocalBoundedEventEvidence {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExpectedShortName,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$LogName,

        [Parameter(Mandatory = $true)]
        [DateTimeOffset]$StartInstant,

        [Parameter(Mandatory = $true)]
        [DateTimeOffset]$EndInstant
    )

    if ($EndInstant -le $StartInstant) {
        throw 'EndInstant must be later than StartInstant.'
    }

    $culture = [Globalization.CultureInfo]::InvariantCulture
    $startUtc = $StartInstant.ToUniversalTime()
    $endUtc = $EndInstant.ToUniversalTime()
    $collectionStarted = [DateTimeOffset]::Now
    $collectionStartedUtc = $collectionStarted.ToUniversalTime()

    if ($collectionStartedUtc -lt $endUtc) {
        throw 'Collection can''t begin before EndInstant.'
    }
    if (-not [string]::Equals(
            $env:COMPUTERNAME,
            $ExpectedShortName,
            [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Run this query locally on $ExpectedShortName."
    }

    $startLiteral = $startUtc.ToString(
        "yyyy-MM-dd'T'HH:mm:ss.fffffff'Z'",
        $culture
    )
    $endLiteral = $endUtc.ToString(
        "yyyy-MM-dd'T'HH:mm:ss.fffffff'Z'",
        $culture
    )
    $xpath = "*[System[TimeCreated[" +
        "@SystemTime >= '$startLiteral' and " +
        "@SystemTime <= '$endLiteral']]]"
    $pathType =
        [System.Diagnostics.Eventing.Reader.PathType]::LogName
    $session =
        [System.Diagnostics.Eventing.Reader.EventLogSession]::GlobalSession

    $preflightStartedUtc = [DateTimeOffset]::UtcNow
    $logInformationBefore =
        $session.GetLogInformation($LogName, $pathType)
    $preflightCompletedUtc = [DateTimeOffset]::UtcNow
    $beforeLastWriteUtc = $null
    if ($null -ne $logInformationBefore.LastWriteTime) {
        $beforeLastWriteUtc = (
            [DateTimeOffset]$logInformationBefore.LastWriteTime
        ).ToUniversalTime().ToString('o', $culture)
    }

    $query = New-Object `
        -TypeName System.Diagnostics.Eventing.Reader.EventLogQuery `
        -ArgumentList $LogName, $pathType, $xpath `
        -ErrorAction Stop
    $query.ReverseDirection = $false
    $query.TolerateQueryErrors = $false

    $rows = [System.Collections.Generic.List[object]]::new()
    $reader = $null
    $readStartedUtc = [DateTimeOffset]::UtcNow
    try {
        $reader = New-Object `
            -TypeName System.Diagnostics.Eventing.Reader.EventLogReader `
            -ArgumentList $query `
            -ErrorAction Stop

        while ($true) {
            $record = $reader.ReadEvent()
            if ($null -eq $record) {
                break
            }

            try {
                $rawXml = $record.ToXml()
                [xml]$eventXml = $rawXml
                $systemTime = [string](
                    $eventXml.Event.System.TimeCreated.SystemTime
                )
                if ([string]::IsNullOrWhiteSpace($systemTime)) {
                    throw 'An event record has no XML SystemTime.'
                }

                $eventTimeUtc = (
                    [System.Xml.XmlConvert]::ToDateTimeOffset(
                        $systemTime
                    )
                ).ToUniversalTime()

                if ($eventTimeUtc -lt $startUtc -or
                    $eventTimeUtc -gt $endUtc) {
                    continue
                }

                try {
                    $message = $record.FormatDescription()
                }
                catch {
                    $message = '[Message text unavailable]'
                }

                try {
                    $levelDisplayName = $record.LevelDisplayName
                }
                catch {
                    $levelDisplayName = $null
                }

                $activityId = $null
                if ($null -ne $record.ActivityId) {
                    $activityId = $record.ActivityId.ToString('D')
                }

                [void]$rows.Add([pscustomobject]@{
                    TimeCreatedUtc =
                        $eventTimeUtc.ToString('o', $culture)
                    MachineName = $record.MachineName
                    Id = $record.Id
                    ProviderName = $record.ProviderName
                    RecordId = $record.RecordId
                    Level = $record.Level
                    LevelDisplayName = $levelDisplayName
                    ActivityId = $activityId
                    Message = $message
                    RawXml = $rawXml
                })
            }
            finally {
                $record.Dispose()
            }
        }
    }
    finally {
        if ($null -ne $reader) {
            $reader.Dispose()
        }
    }
    $readCompletedUtc = [DateTimeOffset]::UtcNow

    $logInformationAfter =
        $session.GetLogInformation($LogName, $pathType)
    $postReadMetadataCapturedUtc = [DateTimeOffset]::UtcNow
    $afterLastWriteUtc = $null
    if ($null -ne $logInformationAfter.LastWriteTime) {
        $afterLastWriteUtc = (
            [DateTimeOffset]$logInformationAfter.LastWriteTime
        ).ToUniversalTime().ToString('o', $culture)
    }

    $rowArray = $rows.ToArray()
    $collectionCompletedUtc = [DateTimeOffset]::UtcNow
    [pscustomobject]@{
        Summary = [pscustomobject]@{
            CollectorHost = $env:COMPUTERNAME
            TargetLogHost = $ExpectedShortName
            LogName = $LogName
            CollectorTimeZoneId =
                [TimeZoneInfo]::Local.Id
            CollectorUtcOffsetAtStart =
                $collectionStarted.ToString('zzz', $culture)
            CollectionStartedUtc =
                $collectionStartedUtc.ToString('o', $culture)
            CollectionCompletedUtc =
                $collectionCompletedUtc.ToString('o', $culture)
            MetadataPreflightSucceeded = $true
            MetadataPreflightStartedUtc =
                $preflightStartedUtc.ToString('o', $culture)
            MetadataPreflightCompletedUtc =
                $preflightCompletedUtc.ToString('o', $culture)
            ReadSucceeded = $true
            ReadStartedUtc =
                $readStartedUtc.ToString('o', $culture)
            ReadCompletedUtc =
                $readCompletedUtc.ToString('o', $culture)
            PostReadMetadataCapturedUtc =
                $postReadMetadataCapturedUtc.ToString('o', $culture)
            QuerySucceeded = $true
            EventCount = $rowArray.Count
            StartInstantUtc =
                $startUtc.ToString('o', $culture)
            EndInstantUtc =
                $endUtc.ToString('o', $culture)
            XPath = $xpath
            LogInformationBefore = [pscustomobject]@{
                RecordCount = $logInformationBefore.RecordCount
                OldestRecordNumber =
                    $logInformationBefore.OldestRecordNumber
                FileSize = $logInformationBefore.FileSize
                LastWriteTimeUtc = $beforeLastWriteUtc
                IsLogFull = $logInformationBefore.IsLogFull
            }
            LogInformationAfter = [pscustomobject]@{
                RecordCount = $logInformationAfter.RecordCount
                OldestRecordNumber =
                    $logInformationAfter.OldestRecordNumber
                FileSize = $logInformationAfter.FileSize
                LastWriteTimeUtc = $afterLastWriteUtc
                IsLogFull = $logInformationAfter.IsLogFull
            }
        }
        Rows = $rowArray
    }
}
```

The helper verifies the local host, rejects collection before the completed interval, uses fixed inclusive UTC XPath boundaries, preflights one exact log, disables query-error tolerance, and applies no arbitrary event cap. It emits one result only after enumeration and post-read log metadata succeed; access, invalid-log, enumeration, and post-metadata errors remain failures rather than partial result objects.

Materializing every matching record, formatted message, and XML payload can consume substantial time and memory. The prepared lab validates the live log sizes and expected interval volume. Otherwise use supplied evidence. This deliberately uncapped helper isn't a production bulk-collection pattern.

### Run the two DC log queries locally on `BNE-DC-01`

Variables from the management host don't cross into this local DC session. The prepared lab preloads the helper plus `$EvidenceStartInstant` and `$EvidenceEndInstant` as `[DateTimeOffset]` values for the concrete `2026-07-15T08:30:00+00:00` through `2026-07-15T09:00:00+00:00` interval. The following caller fails closed if that typed interval contract isn't present:

```powershell
$Destination = 'BNE-DC-01'

if (-not (Test-Path -LiteralPath 'variable:EvidenceStartInstant') -or
    -not (Test-Path -LiteralPath 'variable:EvidenceEndInstant')) {
    throw 'The prepared DC session didn''t preload the evidence interval.'
}
if ($null -eq $EvidenceStartInstant -or
    $null -eq $EvidenceEndInstant) {
    throw 'The prepared DC evidence interval mustn''t be null.'
}
if ($EvidenceStartInstant -isnot [DateTimeOffset] -or
    $EvidenceEndInstant -isnot [DateTimeOffset]) {
    throw 'The prepared DC evidence interval must use DateTimeOffset values.'
}

if ($EvidenceEndInstant -le $EvidenceStartInstant -or
    $EvidenceStartInstant.TimeOfDay -ne
        [TimeSpan]::FromHours(8.5) -or
    $EvidenceEndInstant.TimeOfDay -ne
        [TimeSpan]::FromHours(9) -or
    $EvidenceStartInstant.Date -ne $EvidenceEndInstant.Date -or
    $EvidenceStartInstant.Offset -ne $EvidenceEndInstant.Offset) {
    throw 'The fixed DC evidence interval is invalid.'
}

$directoryEvidence = $null
$dfsrEvidence = $null

$directoryEvidence = Get-LocalBoundedEventEvidence `
    -ExpectedShortName $Destination `
    -LogName 'Directory Service' `
    -StartInstant $EvidenceStartInstant `
    -EndInstant $EvidenceEndInstant

$dfsrEvidence = Get-LocalBoundedEventEvidence `
    -ExpectedShortName $Destination `
    -LogName 'DFS Replication' `
    -StartInstant $EvidenceStartInstant `
    -EndInstant $EvidenceEndInstant

$directoryEvidence.Summary
$directoryEvidence.Rows
$dfsrEvidence.Summary
$dfsrEvidence.Rows

$directoryWarningOrErrorCandidates = @(
    $directoryEvidence.Rows |
        Where-Object { $_.Level -in 1, 2, 3 }
)
$dfsrWarningOrErrorCandidates = @(
    $dfsrEvidence.Rows |
        Where-Object { $_.Level -in 1, 2, 3 }
)

$directoryWarningOrErrorCandidates
$dfsrWarningOrErrorCandidates
```

Clear the caller result variables before each invocation. If reassignment throws, PowerShell otherwise preserves an old value. Preserve each complete returned bounded set before deriving warning/error candidates.

### Run the Group Policy query locally on `BNE-CL-01`

Use a separate local client session. The prepared lab preloads `$EvidenceStartInstant` and `$EvidenceEndInstant` as `[DateTimeOffset]` values for the concrete `2026-07-15T08:30:00+00:00` through `2026-07-15T09:00:00+00:00` interval. The Activity ID correlates related records; it doesn't identify a GPO. The second filter requires the correlated message or XML to name the fixed GUID, expected display name, or validated path:

```powershell
$AffectedClient = 'BNE-CL-01.contoso.com'
$AffectedClientShortName = 'BNE-CL-01'
$PublishedGroupPolicyActivityId =
    '4f789f6e-1189-4d09-b4bf-3a7f6b6d15c2'
$ExpectedGpoDisplayName = 'Workstation Security Baseline'
$GpoGuidText = 'C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57'
$ValidatedDomainGpt =
    '\\contoso.com\SYSVOL\contoso.com\Policies\{C8A3B9F4-8A72-4E6B-A9A8-11384B1C6E57}'

if ([string]::IsNullOrWhiteSpace($AffectedClientShortName)) {
    throw 'The affected client short name must be present.'
}
if (-not (Test-Path -LiteralPath 'variable:EvidenceStartInstant') -or
    -not (Test-Path -LiteralPath 'variable:EvidenceEndInstant')) {
    throw 'The prepared client session didn''t preload the evidence interval.'
}
if ($null -eq $EvidenceStartInstant -or
    $null -eq $EvidenceEndInstant) {
    throw 'The prepared client evidence interval mustn''t be null.'
}
if ($EvidenceStartInstant -isnot [DateTimeOffset] -or
    $EvidenceEndInstant -isnot [DateTimeOffset]) {
    throw 'The prepared client evidence interval must use DateTimeOffset values.'
}
if ($EvidenceEndInstant -le $EvidenceStartInstant -or
    $EvidenceStartInstant.TimeOfDay -ne
        [TimeSpan]::FromHours(8.5) -or
    $EvidenceEndInstant.TimeOfDay -ne
        [TimeSpan]::FromHours(9) -or
    $EvidenceStartInstant.Date -ne $EvidenceEndInstant.Date -or
    $EvidenceStartInstant.Offset -ne $EvidenceEndInstant.Offset) {
    throw 'The fixed client evidence interval is invalid.'
}

$publishedActivityId = [Guid]::Empty
if (-not [Guid]::TryParse(
        $PublishedGroupPolicyActivityId,
        [ref]$publishedActivityId) -or
    $publishedActivityId -eq [Guid]::Empty) {
    throw 'Published evidence must supply a valid Group Policy ActivityId.'
}

$groupPolicyEvidence = $null
$groupPolicyEvidence = Get-LocalBoundedEventEvidence `
    -ExpectedShortName $AffectedClientShortName `
    -LogName 'Microsoft-Windows-GroupPolicy/Operational' `
    -StartInstant $EvidenceStartInstant `
    -EndInstant $EvidenceEndInstant

$groupPolicyEvidence.Summary
$groupPolicyEvidence.Rows

$groupPolicyWarningOrErrorCandidates = @(
    $groupPolicyEvidence.Rows |
        Where-Object { $_.Level -in 1, 2, 3 }
)
$groupPolicyCycleEvidence = @(
    $groupPolicyEvidence.Rows |
        Where-Object {
            [string]::Equals(
                [string]$_.ActivityId,
                $publishedActivityId.ToString('D'),
                [System.StringComparison]::OrdinalIgnoreCase
            )
        }
)
$groupPolicyGpoEvidence = @(
    $groupPolicyCycleEvidence |
        Where-Object {
            $recordText =
                [string]$_.Message + "`n" + [string]$_.RawXml
            $recordText.IndexOf(
                $GpoGuidText,
                [System.StringComparison]::OrdinalIgnoreCase
            ) -ge 0 -or
            $recordText.IndexOf(
                $ExpectedGpoDisplayName,
                [System.StringComparison]::OrdinalIgnoreCase
            ) -ge 0 -or
            $recordText.IndexOf(
                $ValidatedDomainGpt,
                [System.StringComparison]::OrdinalIgnoreCase
            ) -ge 0
        }
)

$groupPolicyWarningOrErrorCandidates
$groupPolicyCycleEvidence
$groupPolicyGpoEvidence
```

Supplied bounded-query summary:

| Local host and log | Collection completed (UTC) | Successful bounded result | Derived review result |
| --- | --- | --- | --- |
| `BNE-DC-01`: Directory Service | `2026-07-15T09:05:00.3000000Z` | `QuerySucceeded=True`, `EventCount=12` | Zero warning/error candidates were returned from the currently retained bounded set |
| `BNE-DC-01`: DFS Replication | `2026-07-15T09:05:01.2500000Z` | `QuerySucceeded=True`, `EventCount=7` | Zero warning/error candidates were returned from the currently retained bounded set |
| `BNE-CL-01`: Group Policy Operational | `2026-07-15T09:06:00.4000000Z` | `QuerySucceeded=True`, `EventCount=24` | Nine records share Activity ID `4f789f6e-1189-4d09-b4bf-3a7f6b6d15c2`; three of those also identify the fixed GPO by GUID, display name, or validated path |

The warning/error filter is a reading aid, not proof that every failure mode was absent. A successful result is the bounded set returned by that enumeration, not an atomic log snapshot.

The before/after `RecordCount`, `OldestRecordNumber`, `FileSize`, `LastWriteTimeUtc`, and `IsLogFull` values are point-in-time provenance. They don't prove continuous retention. Current settings, one oldest retained record, or no retained clear event can't establish that the log was continuously available and uncleared throughout the interval. Without an author-supplied export or central collection chain covering continuity, retention, and clear history, say only that **zero matching currently retained events were returned**; never claim interval-wide event absence.

## Classify the evidence

Keep each result in its own evidence category:

| Evidence pattern | Safe classification |
| --- | --- |
| Missing, blank, or represented as multiple `gPCFileSysPath` values | Invalid or incomplete path evidence; preserve raw output and stop. |
| Different raw `gPCFileSysPath` values on the two DCs | GPC path replica discrepancy. Correlate timing, attribute metadata, and domain-NC state before assigning an AD DS replication-engine cause. |
| Paths agree but don't equal the expected domain UNC under raw `OrdinalIgnoreCase` comparison | Unexpected GPC path, not GPT version lag. |
| Numeric GPC `versionNumber` values differ | GPC version replica discrepancy; relationship state alone doesn't establish cause. |
| GPC visible values agree in sequential reads | Agreement at the two query times, not an atomic snapshot. |
| Both originating-stamp comparisons match | Same-originating-update evidence for those two attributes; separate from relationship status. |
| Exactly one expected inbound partner row has a successful latest result | Latest recorded source-to-destination domain-NC relationship state; not object proof. |
| Stability-checked named GPT captures differ after the expected interval | Bounded file-replica difference. Use directional backlog or other DFSR evidence before identifying a convergence issue. |
| Directional backlog lists the differing files after the expected interval | Corroborating DFSR evidence for that direction; backlog alone can be normal latency and doesn't establish root cause. |
| Domain UNC read succeeds | That invoking network security context accessed some referral target; it doesn't prove computer-policy access or the SMB target. |
| Exact `dfsutil /pktinfo` entry and active target are missing or ambiguous | Referral target unresolved. Don't infer it from `nltest` or the domain UNC read. |
| Positive Activity-ID records also name the fixed GPO | Correlated affected processing-cycle evidence. Activity ID alone isn't GPO identity. |

For this scenario:

1. Exactly one expected `SEA-DC-01` to `BNE-DC-01` inbound domain-NC relationship was identified, and its latest recorded result was successful. That's relationship evidence only.
2. The sequential GPC reads returned numeric version `196615` and the same raw expected domain path on both DCs.
3. The required metadata comparison reports the same originating update for `versionNumber` and `gPCFileSysPath`.
4. Post-deadline stable captures report source GPT version `196615`, destination GPT version `196614`, and different bytes for the two backlog-named files.
5. The forward backlog lists those two files; the reverse backlog is zero. This corroborates a source-to-destination DFSR convergence issue but doesn't identify root cause.
6. The client user's domain-based read returned version `196614`. Positive Group Policy records with the supplied Activity ID also identify the fixed GPO. The manual read still doesn't reproduce the computer account's security context.
7. The prepared `dfsutil` capture independently identifies `BNE-DC-01.contoso.com` as the active SYSVOL target. Without that exact capture, the target would remain unresolved.
8. The bounded DC log queries returned zero warning/error candidates from their currently retained sets. This isn't an interval-wide absence claim and doesn't override the positive GPT and backlog evidence.

The correct bounded conclusion is: **the named GPT replicas differed during their recorded post-deadline read intervals, and directional DFSR backlog corroborated a SYSVOL convergence issue on the path from `SEA-DC-01` to `BNE-DC-01`.** The evidence doesn't identify the root cause. It doesn't show a GPC path or version discrepancy, and relationship success alone isn't proof of object or file delivery.

Stop at that classification boundary and continue, if required, in dedicated AD DS or DFSR troubleshooting. Don't repair, force replication, copy files, flush referral caches, or change configuration in this investigation.

## Finish the investigation

The learner performed no cleanup because every learner action was read-only. If the lab owner created the disposable GPO for this exercise, the owner may remove it afterward through Group Policy Management. Don't delete the GPC and GPT separately.

Don't:

- Stop AD DS or DFSR services.
- Change connection objects, schedules, topology, or replication-group membership.
- Edit `gpt.ini`, `Registry.pol`, or GPC attributes.
- Copy policy files between replicas.
- Delete ESE logs, DFSR databases, or replicated content.
- Run authoritative or nonauthoritative synchronization.
- Force replication to hide the captured state.
- Flush the DFS referral cache.
