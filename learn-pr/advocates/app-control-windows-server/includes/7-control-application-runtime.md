Native executable blocking and script enforcement are different. App Control can answer a script host's authorization query, while the host decides whether to block the script or restrict how it runs.

## Understand language modes

PowerShell's Full Language mode provides the complete language. Constrained Language Mode (CLM) restricts features such as arbitrary .NET access and other capabilities used by powerful automation.

PowerShell 7.3 and later use `WldpCanExecuteFile` when that API is available. Its per-file result can allow the file, block it, or require a sandbox. An unapproved script is therefore not guaranteed to run in CLM. Windows PowerShell 5.1 workers use the legacy detection path; test them separately.

Interactive PowerShell becomes constrained when an enforced UMCI policy and applicable script-enforcement configuration require it. A trusted script can run with Full Language rights while its untrusted caller remains constrained.

PowerShell 7.4 and later support App Control audit-mode diagnostics. Would-be language restrictions are logged rather than enforced. Don't interpret a reported language mode, a script-channel "blocked" event, or a successful exit without checking the policy mode and actual host behavior.

The following outcomes explain why a single language-mode check is insufficient.

| Context | Expected behavior under the described policy | Meaning |
| --- | --- | --- |
| Interactive session with enforced UMCI and script enforcement | Typically `ConstrainedLanguage` | Administrator elevation doesn't automatically escape control. |
| File receives `WLDP_CAN_EXECUTE_ALLOWED` | Can run with Full Language rights | Dependencies and the remaining lockdown restrictions still matter. |
| File receives `WLDP_CAN_EXECUTE_REQUIRE_SANDBOX` under enforcement | Runs with CLM restrictions | It might still complete simple commands. |
| File receives `WLDP_CAN_EXECUTE_BLOCKED` | Fails to run or load | Treat an expected block as a negative-test result, not a requirement to add an allow rule. |
| Untrusted code under PowerShell 7.4+ App Control audit | Would-be language restrictions generate audit evidence instead of enforcement errors | A mode label alone doesn't establish enforcement. |
| Another endpoint, identity, or 5.1 worker | Depends on that context's policy and runtime | A PowerShell 7 probe doesn't establish the worker's behavior. |

This read-only expression reports the language mode of the current context.

```powershell
$ExecutionContext.SessionState.LanguageMode
```

For a controlled comparison, use two existing diagnostic scripts with distinct content. Each should print its own PowerShell version, edition, and language mode, plus a distinct identifying message. Authorize one through the approved policy process and deliberately leave the other unapproved. Don't accidentally authorize both through a broad path, publisher, or matching hash rule.

Run the probes through the current PowerShell 7 installation. The example temporarily disables automatic native-exit errors so it can capture an expected negative result, then restores that preference.

```powershell
$ErrorActionPreference = 'Stop'
$hostPath = Join-Path $PSHOME 'pwsh.exe'
$savedNativePreference = $PSNativeCommandUseErrorActionPreference
try {
    $PSNativeCommandUseErrorActionPreference = $false
    $approvedOutput = @(& $hostPath -NoProfile -NonInteractive `
        -File 'C:\ApprovedScripts\Approved-Probe.ps1' 2>&1)
    $approvedExit = $LASTEXITCODE
    if ($approvedExit -ne 0) {
        throw "Approved probe failed ($approvedExit): $($approvedOutput -join ' ')"
    }
    $unapprovedOutput = @(& $hostPath -NoProfile -NonInteractive `
        -File 'C:\AppControl\Unapproved-Probe.ps1' 2>&1)
    $unapprovedExit = $LASTEXITCODE
    [pscustomobject]@{
        Probe = 'Approved'
        ExitCode = $approvedExit
        Output = $approvedOutput -join [Environment]::NewLine
    }
    [pscustomobject]@{
        Probe = 'Unapproved'
        ExitCode = $unapprovedExit
        Output = $unapprovedOutput -join [Environment]::NewLine
    }
} finally {
    $PSNativeCommandUseErrorActionPreference = $savedNativePreference
}
```

Under enforcement, correlate the unapproved result with the intended sandbox or block decision. A nonzero exit alone doesn't prove an App Control block; syntax errors, execution policy, and other controls can also prevent execution. A zero exit doesn't prove Full Language execution. Don't turn an unexplained result into a pass or bypass the responsible control.

## Capture PowerShell audit restrictions

On an isolated audit-policy test server, temporarily enable `PowerShellCore/Analytic` and exercise representative PowerShell 7 code. A probe that only prints its language mode might not exercise an operation that generates event 16387.

Enabling an analytic log clears its existing events. Export any existing evidence before starting a new capture. The example requires confirmation before enabling a disabled log.

Use the default noncircular log configuration for this example. A circular analytic log can't be queried while enabled; use an approved stop-and-export capture instead. Don't interrupt another collector or change retention just to run this snippet.

This example changes only analytic-log enablement. It selects events within the capture window and restores an initially disabled log when finished. If another collection process already enabled the log, it leaves that setting intact.

```powershell
$ErrorActionPreference = 'Stop'
$log = 'PowerShellCore/Analytic'
$settings = Get-WinEvent -ListLog $log -Force
if ($settings.LogMode -eq 'Circular') {
    throw 'Use a stop-and-export capture for a circular analytic log.'
}
$wasEnabled = $settings.IsEnabled
if (-not $wasEnabled) {
    $confirmation = Read-Host 'Type ENABLE after preserving existing analytic evidence'
    if ($confirmation -ne 'ENABLE') {
        throw 'Capture cancelled; no log settings were changed.'
    }
}
$start = Get-Date
try {
    if (-not $wasEnabled) {
        & wevtutil.exe sl $log /enabled:true /quiet
        if ($LASTEXITCODE -ne 0) {
            throw "Analytic-log enablement failed: $LASTEXITCODE"
        }
    }
    $null = Read-Host 'Run the approved audit workload, then press Enter'
    $end = Get-Date
    try {
        $auditEvents = @(Get-WinEvent -LogName $log -Oldest -ErrorAction Stop |
            Where-Object {
                $_.Id -eq 16387 -and
                $_.TimeCreated -ge $start -and $_.TimeCreated -le $end
            })
        if ($auditEvents.Count -eq 0) {
            Write-Warning 'No matching audit events; this does not prove authorization.'
        } else {
            $auditEvents | Select-Object TimeCreated, Id, Message
        }
    } catch {
        if ($_.FullyQualifiedErrorId -notlike 'NoMatchingEventsFound*') {
            throw
        }
        Write-Warning 'No matching audit events; this does not prove authorization.'
    }
} finally {
    if (-not $wasEnabled) {
        & wevtutil.exe sl $log /enabled:false /quiet
        if ($LASTEXITCODE -ne 0) {
            throw "Analytic-log disablement failed: $LASTEXITCODE"
        }
    }
}
```

Analytic logs can grow quickly. Retain required evidence through the approved collection process rather than leaving this capture enabled indefinitely. Event 16387 identifies would-be language restrictions; it's not an automatic ConfigCI allow rule or proof that the workload will pass enforcement.

## Authorize scripts and modules, not just the host

Allowing `pwsh.exe` doesn't grant Full Language rights to every script. Review `.ps1` scripts, `.psm1` modules, `.psd1` manifests, dependent modules, and compiled DLLs. Where a 5.1 worker is required, its `powershell.exe` and dependencies need their own appropriate authorization.

Modules under App Control must explicitly export the functions they intend to expose. Wildcard exports aren't an appropriate substitute. A trusted module mustn't assume that an untrusted dependency inherits its authorization.

Prefer modules to dot-sourced helper scripts. If a trusted script dot-sources another script, the second script must also satisfy the applicable trust requirements.

Inspect script signatures as an input to the investigation.

```powershell
Get-AuthenticodeSignature `
    -LiteralPath 'C:\ApprovedScripts\Approved-Probe.ps1' |
    Format-List Status, StatusMessage, SignerCertificate, TimeStamperCertificate
```

A `Valid` signature doesn't prove that the policy authorizes its signer. Signed-script validation also requires the appropriate root certificate in the device's trusted root store. Executable CI signature evaluation doesn't impose the same root-store requirement.

Test remote sessions, scheduled tasks, service accounts, and management agents in their actual contexts. An automation script that works interactively can fail when a different host, module path, identity, or endpoint is used.

## Recognize interpreter and COM boundaries

Different hosts enforce decisions differently. Avoid turning off script enforcement globally to repair one incompatible tool.

Use this comparison when a script-related failure appears.

| Host or component | App Control behavior to understand |
| --- | --- |
| PowerShell | Depending on runtime and policy, unapproved files can be blocked or sandboxed. Trusted scripts and dependencies still require appropriate authorization. |
| `wscript.exe` / `cscript.exe` | Supported scripts not permitted by policy are blocked. |
| MSHTA and MSXML | Code execution can be blocked whenever an applicable script-enforcing policy is active, including audit mode. |
| `cmd.exe`, `.bat`, and `.cmd` | Batch text isn't directly controlled like supported scripts; launched executables remain subject to CI policy. |
| Unenlightened third-party interpreters | Allowing the interpreter can implicitly allow scripts it runs without individual App Control evaluation. |
| COM | Additional COM authorization applies; option 11 doesn't disable COM enforcement. |

If a general-purpose interpreter is unnecessary on a fixed-workload server, removing that capability can be safer than attempting to infer the trust of every script it might execute.

## Validate .NET Dynamic Code Security

PowerShell 7 uses modern .NET. Don't assume that .NET Framework native-image generation describes PowerShell 7's own runtime. Assess the actual runtime used by each server application and by the 5.1 workers.

Option `19 Enabled:Dynamic Code Security` adds checks for selected .NET dynamic-code behaviors, including externally loaded code and generated-code integrity.

Windows Server 2025 supports **audit mode for Dynamic Code Security**. Older-version guidance that option 19 is always enforced in audit mustn't be applied unchanged to this platform.

Some dynamic-loading techniques remain incompatible with enforcement. Test the actual application, not just the presence of the runtime.

Event 3114 needs context. .NET can try two methods to run dynamic code. A single first-attempt event can be benign if the second method succeeds. Closely timed events for both attempts, together with application failure, indicate a problem to investigate.

For .NET Framework native-image workloads, policy updates can invalidate cached authorization. The runtime can fall back to the original intermediate-language assembly and later regenerate the native image. A native-image block event can therefore be benign while still producing a temporary performance effect.

Enforcement can also expose COM registration GUID mismatches. These failures might not provide useful CI events and might not appear during audit. Repair the application or obtain a vendor fix rather than treating missing telemetry as proof that App Control is unrelated.
