To determine how a Group Policy was processed, it's important to understand that several mechanisms are interacting together and not necessarily in a strict sequence.

## Separate the Group Policy Container from the Group Policy Template

When troubleshooting, recognize that every domain GPO has two coordinated parts: These are the Group Policy Container and the Group Policy Template:

| Part | Storage | Typical content | Replication |
| --- | --- | --- | --- |
| Group Policy Container (GPC) | AD DS under `CN={GPO-GUID},CN=Policies,CN=System,<domain-DN>` | Display name, status, version, file-system path, extension metadata, WMI filter reference | AD DS replication |
| Group Policy Template (GPT) | `\\<domain>\SYSVOL\<domain>\Policies\{GPO-GUID}` | `GPT.ini`, `Registry.pol`, scripts, security templates, software data, preference XML | Distributed File System Replication (DFSR) |

The `gPCFileSysPath` attribute points from the Group Policy Container to the domain-based SYSVOL path. The Group Policy Container can replicate before the matching Group Policy Template content. The reverse can also occur. A client can therefore discover a GPO in AD DS but read missing or stale files from SYSVOL.

The domain-based path hides the selected server behind the SYSVOL referral. During an inconsistent incident, you may need to compare the domain path with a server-specific path:

```text
\\contoso.com\SYSVOL\contoso.com\Policies\{GPO-GUID}
\\DC02\SYSVOL\contoso.com\Policies\{GPO-GUID}
```

> [!IMPORTANT]  
> When performing diagnostic activities, use read-only inspection. Don't edit `GPT.ini`, `Registry.pol`, security templates, or preference XML directly.

## Interpret user versions plus computer versions

A GPO has separate user-side and computer-side versions. The Group Policy Container stores the combined version in AD DS. The file `GPT.ini` is used to store a corresponding value in SYSVOL. Group Policy tools normally present the user and computer values separately.

A version mismatch can indicate:

- Normal replication convergence after an edit.
- Failed AD DS replication.
- Failed DFSR replication.
- A missing Group Policy Template.
- Manual file changes.
- Permission divergence between the GPC and GPT.

Discovering version equality isn't complete proof that everything is functioning properly. Even with version equality, files can be absent, access can fail, or a client-side extension can reject content even when version values match.

## Build the link-derived candidate list

A site, domain, or organizational unit (OU) stores its ordered GPO links in `gPLink` and its inheritance option in `gPOptions`. In the raw `gPLink` string, the leftmost entry is link order 1. It has the highest precedence at that scope of management and is processed last among ordinary links at that same scope. The option field is stored as decimal text, although the protocol defines bit masks.

| Raw value | Exact meaning |
| --- | --- |
| Leftmost `gPLink` element | Link order 1; highest precedence at that site, domain, or OU |
| Stored link option `0` (`0x0`) | Enabled, not Enforced |
| Stored link option `1` (`0x1`) | Ignore or disabled |
| Stored link option `2` (`0x2`) | Enabled and Enforced |
| Stored link option `3` (`0x3`) | Ignore or disabled; the disable bit wins |
| `gPOptions = 0` | Normal inheritance |
| `gPOptions = 1` | Block non-Enforced links inherited from higher scopes; retain direct and higher Enforced links |

The candidate-list algorithm then applies GPO status, security and WMI eligibility, loopback, and extension semantics. Raw links aren't the final resultant policy. 

Compare the same distinguished name and naming context on each explicitly named domain controller. Sites are under `CN=Sites,CN=Configuration,...`; domains and OUs are in a domain naming context.

For example:

```powershell
$target = 'OU=Application Servers,DC=contoso,DC=com'

Get-ADObject -Identity $target -Server 'DC01.contoso.com' `
    -Properties gPLink,gPOptions |
    Select-Object DistinguishedName,gPLink,gPOptions

Get-ADObject -Identity $target -Server 'DC02.contoso.com' `
    -Properties gPLink,gPOptions |
    Select-Object DistinguishedName,gPLink,gPOptions
```

> [!IMPORTANT]  
> Use GPMC or supported GroupPolicy cmdlets for changes. Never write `gPLink` or `gPOptions` directly as a troubleshooting shortcut.

## Understand extension behavior

Understanding extension behavior is a key part of troubleshooting Group Policy. Understand that the Group Policy Service doesn't implement every policy element. The Group Policy Service invokes client-side extensions (CSEs) to perform some tasks. CSEs can be identified through GPO metadata plus local registration under:

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions
```

CSEs differ in timing, persistence, merge behavior, retry behavior, plus logging. When troubleshooting, take into account the variety of CSE behaviors.

| Setting type | Common processing model | Troubleshooting implication |
| --- | --- | --- |
| Administrative Templates | Registry-based policy. A later setting normally wins for the same managed value. | Confirm the winning GPO, `Registry.pol`, CSE status, plus effective registry data. |
| Security settings | The security extension applies supported settings to the local security database. | Compare RSoP with `secedit`, `auditpol`, service state, or security events. |
| Group Policy Preferences | Items process in order. Actions, item-level targeting, plus common options alter persistence. | An applied GPO doesn't prove that each item ran. |
| Scripts | Entries are ordered. The script still depends on its trigger, path, host, permissions, plus exit behavior. | A successful policy cycle can coexist with script failure. |
| Software Installation | Requires foreground startup or sign-in. | A background refresh doesn't process software installation. |
| Folder Redirection | Processes in user context during sign-in. File-server access plus permissions remain separate dependencies. | RSoP can show policy while redirection still fails. |

> [!IMPORTANT]  
> Don't assume every setting has one winning GPO. Registry values are often single-winner. Scripts, preference items, firewall rules, plus other extensions can be additive, ordered, or merged.

## Use the log hierarchy

| Log | Use |
| --- | --- |
| System | Find Group Policy warnings, errors, completion events, error codes, plus the Activity ID |
| Microsoft-Windows-GroupPolicy/Operational | Trace discovery, filtering, download, client-side extension processing, elapsed time, plus completion |
| Application | Review extension-specific events, including Group Policy Preferences, scripts, Windows Installer, plus security processing |
| Extension-specific logs | Validate the subsystem that consumed the setting |

Start with the System event nearest the symptom time. Read:

- Processing scope: user or computer.
- Event time.
- Domain controller.
- Error code.
- Error description.
- Activity ID.

> [!NOTE]  
> The event's **Details** tab often contains more useful data than the event title.

## Isolate one Activity ID

Each Group Policy processing instance receives a unique Activity ID. User processing plus computer processing use separate IDs. A new refresh creates new IDs.

An Event Viewer custom view can filter the operational log:

```xml
<QueryList>
  <Query Id="0" Path="Microsoft-Windows-GroupPolicy/Operational">
    <Select Path="Microsoft-Windows-GroupPolicy/Operational">
      *[System/Correlation/@ActivityID='{ACTIVITY-ID}']
    </Select>
  </Query>
</QueryList>
```

> [!NOTE]
> When performing this query, keep the braces around the globally unique identifier.

PowerShell can use the same correlation:

```powershell
$activityId = '{11111111-2222-3333-4444-555555555555}'
$xpath = "*[System/Correlation/@ActivityID='$activityId']"

Get-WinEvent `
    -LogName 'Microsoft-Windows-GroupPolicy/Operational' `
    -FilterXPath $xpath |
    Sort-Object TimeCreated |
    Select-Object TimeCreated, Id, LevelDisplayName, Message
```

### Read one captured processing instance chronologically

Correlate one scope plus one trigger per Activity ID. A refresh of both scopes can produce separate user plus computer timelines. Never merge them because their timestamps are close. Validate each retained ID, event version, payload name, plus message against a sanitized capture from the supported publication build or first-party provider metadata. Omit an informational row rather than invent an ID.

The following table is a sanitized computer-boot capture. Every row uses one pseudonymous Activity ID:

`{A1B2C3D4-1111-2222-3333-444455556666}`

| Time | ID in validated capture | Phase | Sanitized captured text or payload | Correct interpretation |
| --- | ---: | --- | --- | --- |
| 08:42:14.100 | 4000 | Start | Computer boot policy processing started for `CONTOSO\APP01$`. | Boot trigger, computer scope, plus start of this instance. Don't reuse this anchor for manual refresh. |
| 08:42:14.144 | 5308 | Discovery | Selected DC `DC02.contoso.com`; address `192.0.2.20`. | The DC selected for the instance. It doesn't prove successful LDAP, authentication, SYSVOL access, or download. |
| 08:42:14.301 | 5126 | Selection | Applicable-GPO retrieval completed successfully. | Optional capture-confirmed success marker. Include this row only when the publication-build sanitized capture contains event 5126 and confirms successful applicable-GPO retrieval; otherwise omit the row. |
| 08:42:14.303 | 5312 | Selection | Applicable GPOs: `Server Authentication Baseline`; `Application Server Settings`. | The applicable list as reported by Group Policy, not CSE or effective-state proof. |
| 08:42:14.304 | 5313 | Filtering | `Legacy Server Exception` was filtered out; captured reason: Security. | The captured denial plus reason. Don't infer a reason from a GPO name. |
| 08:42:14.589 | 5257 | Retrieval | Policy download completed successfully. | Optional capture-confirmed success marker. Include this row only when the publication-build sanitized capture contains event 5257 and confirms successful policy download; otherwise omit the row. CSE plus effective state remain unproved. |
| 08:42:14.601 | 4016 | CSE start | Registry Extension processing started. | The named CSE started. |
| 08:42:14.816 | 5016 | CSE completion | Registry Extension completed in 215 ms; `ErrorCode 0`. | The CSE reported successful completion or status. `6016` or `7016` can be warning or error alternatives in a real capture. This doesn't prove every value became active. |
| 08:42:15.115 | 8000 | Completion | Computer boot policy processing completed in 1 second. | End of this boot instance; earlier warnings still matter. |

Match the trigger family to the capture:

- Computer manual processing normally uses the `4004`/`8004` family.
- User manual processing normally uses the `4005`/`8005` family.
- Use the captured trigger's family; don't mix it with the boot example.

> [!NOTE]
> This table is a sanitized capture-derived teaching example, not a native universal sequence. Supported builds plus triggers can add, omit, or version informational records. Interpret event text, Details payload, scope, trigger, phase, error code, duration, plus paired records rather than memorizing IDs. Preserve native EVTX first, then sanitize a derivative while retaining chronology, time zone, Activity ID, ID plus version, level, error, plus duration.

## Read processing phases

In the preprocessing phase look for:

- Network availability.
- Domain discovery.
- Domain controller selection.
- Slow-link determination.
- User or computer context.
- Foreground or background mode.

A failure here can prevent the client from building the GPO list.

In the policy selection phase look for:

- Candidate GPO discovery.
- Disabled links or GPO sides.
- Security filtering.
- WMI filter evaluation.
- Loopback mode.
- Applied GPO list.
- Denied GPO list.

> [!NOTE]
> A denied result isn't automatically an error. A WMI filter that returns false is an expected decision if the filter was designed correctly.

In the retrieval phase look for:

- Group Policy Container access.
- Group Policy Template path.
- Domain controller name.
- SYSVOL read.
- File-not-found or access-denied errors.
- GPO version.

An AD DS lookup can succeed while the GPT read fails.

In the extension processing phase, look for:

- CSE name or globally unique identifier.
- Start event.
- Completion event.
- Elapsed time.
- Return code.
- Required foreground processing.
- Required sign-out or restart.

Pair each start with its matching completion. A missing completion can indicate timeout, termination, service failure, or a long-running extension.

In the postprocessing phase, look for:

- Overall completion.
- Warnings retained after success.
- Deferred work.
- Next refresh behavior.

Successful overall processing doesn't erase an extension warning.

## Interpret representative failures

Use event text plus the returned error. Event IDs are indexes to what the problem might be, not diagnoses of what the problem is.

| Symptom class | Common event family | Evidence to extract |
| --- | --- | --- |
| No domain controller connectivity | System event such as 1129 | Domain, network state, selected server, error text |
| LDAP authentication failure | System event such as 1006 | Decimal error, account context, DNS, time, secure channel |
| GPO list retrieval failure (AD DS) | System event such as 1030 | Selected domain controller, DNS plus LDAP reachability, GPC read permissions, error code |
| GPT read failure (SYSVOL) | System event such as 1058 | GPT path, domain controller, SYSVOL access plus DFSR state, error code |
| CSE failure | Operational start plus completion events | Extension, duration, return code, processing mode |

Common error meanings include:

- `5` - Access denied.
- `3` - Path not found.
- `53` - Network path not found.
- `81` - LDAP server unavailable.
- `258` - Timeout.

> [!IMPORTANT]
> Always validate the exact message. The same code can arise from different dependencies.

## Identify the responsible extension

The operational log can name the extension. Local registration data maps extension identifiers:

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions
```

Use this mapping when an event reports only a globally unique identifier. Confirm that the extension is installed, registered, plus supported on the target.

### Registry-based policy

For Administrative Templates:

- Confirm the GPO version changed when expected.
- Confirm the Administrative Templates extension ran.
- Check `Registry.pol` retrieval.
- Read the effective registry value.
- Confirm the target supports the setting.

An applied GPO can contain a setting that belongs to a disabled side, an unsupported build, or a CSE that skipped because no change was detected.

### Security policy

For security settings:

- Review Group Policy operational events.
- Review Application events from the security configuration engine.
- Compare RSoP with `secedit` or `auditpol`.
- Check service restart or computer restart requirements.
- Review Security or subsystem logs for rejected configuration.

Don't use RSoP alone to prove advanced audit policy or authentication behavior.

### Group Policy Preferences

Preference processing can fail at item level after the GPO applies. Review:

- Application events from the relevant preference extension.
- Error code.
- Item-level targeting.
- Action: Create, Replace, Update, or Delete.
- **Apply once and do not reapply**.
- **Remove this item when it is no longer applied**.
- Resource permissions.

Temporary preference tracing can write detailed logs under:

```text
%ProgramData%\GroupPolicy\Preference\Trace
```

Enable only the relevant extension. Disable tracing after collection.

## Export evidence

`wevtutil` can export the complete channel without changing events:

```console
wevtutil epl Microsoft-Windows-GroupPolicy/Operational C:\Reports\GroupPolicy-Operational.evtx
wevtutil epl System C:\Reports\System.evtx
wevtutil epl Application C:\Reports\Application.evtx
```

Export before log rollover. Record the local time zone plus the reproduction interval.

## Use service debug logging only when justified

If ordinary logs don't expose the failed operation, temporary Group Policy Service logging can add detail.

Registry location:

```text
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Diagnostics
```

Value:

```text
GPSvcDebugLevel = 0x30002
```

Log:

```text
%windir%\debug\usermode\gpsvc.log
```

The `usermode` folder must exist. Debug logging can reduce performance, consume disk, plus record domain names, user names, computer names, paths, or configuration. Enable it only long enough to reproduce the issue. Remove or disable it after collection.

## Prepare escalation evidence

A useful package contains:

- Symptom plus expected result.
- Target user plus computer.
- Reproduction time.
- Time zone.
- Activity ID.
- `gpresult` HTML or XML.
- GPO report.
- Exported System, Application, plus Group Policy operational logs.
- CSE registration data when relevant.
- GPSvc or extension trace when justified.
- Effective-state evidence.
- Healthy-peer comparison.
- Recent-change evidence.

Microsoft Trouble Shooting Script (TSS) can collect broader Group Policy data for support escalation. Use it after the failure domain is narrowed, not as the first diagnostic action. [Troubleshooting Support Script toolset](/troubleshoot/windows-client/windows-tss/introduction-to-troubleshootingscript-toolset-tss)
