Resultant Set of Policy (RSoP) evidence explains policy selection. It doesn't prove file retrieval, client-side extension success, effective state, or application compatibility.

:::image type="complex" source="../media/effective-policy-state.svg" alt-text="Diagram that shows policy evidence layers from configuration through application behavior.":::
[Diagram that shows policy evidence layers from configuration through application behavior.]
:::image-end:::

## Select the correct tool

When determining RSoP, select the appropriate tool:

| View | Answers | Limits |
| --- | --- | --- |
| GPO report | What's configured in one GPO? | Doesn't calculate scope or client state |
| Group Policy Modeling | What should apply for a simulated user, computer, site, group, slow link, WMI result, or loopback mode? | Doesn't evaluate local GPOs, GPT availability, network timing, CSE execution, or effective state |
| Group Policy Results | What RSoP data did a target computer record? | Requires remote access. Can reflect an earlier processing cycle |
| `gpresult` | What actual RSoP data is available locally or remotely? | Doesn't prove every setting became effective |
| `Get-GPResultantSetOfPolicy` | How can actual RSoP be written to HTML or XML through PowerShell? | Logging mode only. It doesn't perform Modeling |
| `rsop.msc` | What limited interactive RSoP detail is available? | Doesn't show all modern Group Policy settings |

Use Group Policy Results or `gpresult` as the primary actual-result source. Use `rsop.msc` only when its interactive precedence view helps with a setting it supports.

## Read `gpresult` as evidence

Useful report forms include:

```console
gpresult /scope computer /r
gpresult /scope user /v
gpresult /h C:\Reports\policy-result.html /f
gpresult /x C:\Reports\policy-result.xml /f
```

A remote query reads another computer's recorded RSoP:

```console
gpresult /s APP01 /user CONTOSO\Adele /scope user /z
```

Use only the detail needed. `/z` is large. HTML is easier to review. XML is easier to compare with automation.

An advanced review extracts:

- Report time.
- Target user.
- Target computer.
- User plus computer organizational units.
- Site.
- Domain controller.
- Last processing time.
- Slow-link state.
- Applied GPOs.
- Denied GPOs.
- Denial reasons.
- GPO version data.
- Component status.
- Winning or contributing GPOs.

The table lists example output:

| Field | Sanitized value | Provenance |
| --- | --- | --- |
| Target | `APP01.contoso.com`; computer scope | `gpresult`/Group Policy Results header |
| Collection and last-processing time | `2026-07-31 15:43:02 +10:00`; last computer processing `15:41:19` | Report metadata; preserve original time zone |
| Selected DC | `DC02.contoso.com` | `gpresult`/actual RSoP field; correlate with the same Activity-ID timeline |
| Link classification | Fast; threshold 500 kbps | Actual RSoP/report field where exposed |
| Applied GPOs | `Server Authentication Baseline`; `Application Server Settings` | Applied-GPO list from actual RSoP |
| Denied GPO | `Legacy Server Exception` (Security) | Denied-GPO list and recorded reason from actual RSoP |
| AD/SYSVOL revisions | Baseline `42/42`; App settings `17/17` | Separate XML fields such as `VersionDirectory`/`VersionSysvol` where present, or named-DC `Get-GPO`/GPO report; label the join |

| Setting/component | Reported RSoP evidence | Processing evidence | Effective/application evidence |
| --- | --- | --- | --- |
| LDAP client signing requirement | Reported resultant value: **Require signing**; reported winning source where the actual RSoP surface exposes it | Correlated Security CSE event/status from the same cycle; a report component status alone isn't proof of each setting | `secedit /export /mergedpolicy` or other responsible subsystem evidence, followed by application bind behavior |
| Registry policy processing | Reported resultant value: **Enabled**; reported winning source where exposed | Correlated Registry extension start/completion and code | Effective managed registry/feature state; reload/restart state if applicable |
| Firewall rule collection | Applied GPOs and any contributors exposed by RSoP | Correlated firewall/security processing status and events | `Get-NetFirewallRule -PolicyStore ActiveStore` plus behavior; derive additional contributors from GPO reports/CSE semantics only when labeled |

Interpret this information with these rules:

1. `gpresult` plus Group Policy Results can provide actual RSoP context, applied plus denied lists, source DC, slow-link data, setting/result data, precedence where exposed, plus component status in different formats. No single native format produces the table earlier in this unit.
1. Call values **reported resultant policy values**, never effective values.
1. State a winner or contributor only when the actual report exposes it or when it's separately derived plus labeled. `/z` doesn't guarantee complete additive provenance for every extension.
1. "CSE reported success or completion" doesn't prove every setting took effect, a subsystem reloaded, or an application worked.
1. Effective values require the responsible subsystem tool. Application behavior requires consumer evidence.
1. Preserve the original HTML, XML, or text plus record every joined source, omitted field, normalization, plus pseudonym mapping.
1. `/h` plus `/x` can't be combined with `/u`, `/p`, `/r`, `/v`, or `/z`. Don't promise alternate-credential remote HTML or XML through `gpresult`.

## Understand remote result requirements

GPMC Group Policy Results can fail even when Group Policy processing is healthy. Remote collection depends on:

- The **Remotely access Group Policy Results data** permission on the target container, or local administrator rights on the target.
- Network connectivity.
- Windows Management Instrumentation (WMI).
- Remote Procedure Call (RPC).
- Required inbound firewall rules.
- A target user profile with RSoP data when user results are requested.

Treat a remote collection failure as a separate management-path failure until evidence links it to policy processing.

## Bound Group Policy Modeling

Modeling runs on a domain controller. It calculates directory-based scope, inheritance, security group changes, WMI assumptions, site changes, slow-link state, plus loopback.

It doesn't:

- Read the target's local GPO.
- Reproduce the target's current token.
- Prove the GPT exists on the server a client uses.
- Execute scripts or extensions.
- Reproduce network timing.
- Validate an application.
- Resolve settings controlled by another management authority.

During replication incidents, the selected domain controller's directory view can affect the result. Modeling is a planning tool, not runtime proof.

## Generate actual RSoP with PowerShell

`Get-GPResultantSetOfPolicy` writes logging-mode RSoP:

**Prerequisites:** `[RSAT-GP] [current identity; no -Credential] [target RSoP/WMI authorization if remote] [Creates HTML/XML evidence] [sensitive output]`

```powershell
$params = @{
    Computer   = 'APP01.contoso.com'
    User       = 'CONTOSO\Adele'
    ReportType = 'Html'
    Path       = 'C:\Reports\APP01-Adele.html'
}
Get-GPResultantSetOfPolicy @params
```

Use the output for repeatable collection. Compare its timestamp with the symptom plus the GPO's modification time.

## Refresh only after collection

Targeted refresh reduces unnecessary change. Collect evidence before any refresh.

> [!IMPORTANT]  
> This command changes the evidence state. Capture current actual RSoP plus the failing Activity-ID events first; record scope, authorization, plus possible script, preference, sign-out, restart, or application impact.

**Prerequisites:** `gpupdate /target:computer`: `[Built-in] [run on target; Microsoft doesn't document universal elevation for this form] [Refreshes policy]`; follow-on actions can still require elevation or restart. `gpupdate /target:user`: `[Built-in] [affected user context] [Refreshes policy]`.

```console
gpupdate /target:computer
gpupdate /target:user
```

`/force` asks CSEs to reprocess settings even when the applicable GPO list or version didn't change. It can be useful after evidence collection, but it can:

- Create a new Activity ID.
- Alter timestamps.
- Trigger scripts or preference items.
- Prompt for sign-out or restart.
- Mask intermittent retrieval failure.

A refresh can't replace required startup, sign-in, sign-out, service restart, or computer restart processing.

**Prerequisites (`Invoke-GPUpdate`/GPMC remote update):** `[RSAT-GP] [administrator on target or tested equivalent remote-task authorization] [Remote Scheduled Tasks RPC/RPC-EPMAP and WMI-in] [Refreshes policy]`; scheduling status isn't refresh success

Remote refresh through GPMC or `Invoke-GPUpdate` schedules `gpupdate` on target computers. Use random delay for broad scope to avoid a load spike. Treat remote refresh as a change, not a read-only diagnostic.

## Prove effective state

Select a tool that reads the actual subsystem.

| Policy area | Effective-state evidence |
| --- | --- |
| Administrative Template | Managed registry value, feature state |
| Advanced audit policy | `auditpol /get /category:*` |
| Security policy | `secedit /export`, local security policy, service state |
| Firewall | `Get-NetFirewallProfile`, `Get-NetFirewallRule -PolicyStore ActiveStore` |
| Service | `Get-Service`, service-specific logs |
| Kerberos | `klist`, Security events, service-ticket evidence |
| LDAP | Directory Service events, application bind errors, network evidence |
| Preference | Target file, registry value, mapped resource, Application log |

**Prerequisites:** `auditpol /get`: `[Built-in] [Read on the audit-policy security descriptor or SeSecurityPrivilege] [Read-only]`. `secedit /export`: `[Built-in] [Elevated on current Windows] [Creates evidence] [sensitive output]`; use `/mergedpolicy` for merged local plus domain policy.

Use setting-specific evidence. A registry value doesn't prove a service reloaded it. A service state doesn't prove the application uses that service path.

## Check competing authorities

On managed Windows clients, Group Policy can coexist with Mobile Device Management (MDM), Policy configuration service providers, security products, scripts, provisioning packages, plus application configuration.

If RSoP reports success but effective state differs:

1. Confirm the setting is supported on the target build, edition, plus role.
1. Confirm the responsible CSE completed.
1. Read the effective subsystem state.
1. Check whether another authority configures the same setting.
1. Collect that authority's diagnostic evidence.
1. Escalate with both policy sources identified.

For Policy CSP settings, `MDMWinsOverGP` can cause applicable MDM policy to block equivalent Group Policy settings. It doesn't apply to every CSP. Don't infer universal precedence from one control.

The diagnostic conclusion should state two results:

- **Policy result** - Which GPOs were selected? Did the CSE complete?
- **Behavior result** - Did the intended state become effective? Did the dependent application work?
