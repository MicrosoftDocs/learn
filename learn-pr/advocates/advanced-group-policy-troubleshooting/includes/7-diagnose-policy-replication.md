GPO metadata plus GPO files use independent replication systems. Consistency must be proven on the domain controller path used by the client. The following diagram separates the GPC path replicated through AD DS from the GPT file path replicated through DFSR. The paths converge independently: DC01 has GPC and GPT version 18, while DC02 has GPC version 18 but GPT version 17. A client that selects DC02 therefore observes the mismatch, so diagnosis must prove both paths on the server the client used.

:::image type="complex" source="../media/dual-policy-replication.svg" alt-text="Diagram that shows separate AD DS and DFSR replication paths for Group Policy.":::
[Diagram that shows separate AD DS and DFSR replication paths for Group Policy.]
:::image-end:::

## Recognize split-state failures

AD DS replicates:

- GPO object.
- GPO version metadata.
- GPO status.
- WMI filter link.
- Site, domain, plus organizational unit links.
- Security descriptor for the GPC.

DFSR replicates:

- `GPT.ini`.
- `Registry.pol`.
- Scripts.
- Security templates.
- Software Installation data.
- Group Policy Preferences XML.
- Security descriptor for the GPT.

This design creates several failure patterns:

| GPC state | GPT state | Client result |
| --- | --- | --- |
| Present | Missing | GPO discovered. SYSVOL retrieval fails |
| New | Old | Client sees a changed GPO but reads stale settings |
| Old | New | Client might not invoke the expected CSE change |
| Present, readable | Present, denied | Metadata succeeds. File access fails |
| Consistent on one domain controller | Stale on another | Results vary by selected server |

Replication delay can be expected. Persistent divergence, errors, missing data, or client impact requires you investigate further.

## Identify the client's source

Use:

- `gpresult` field **Group Policy was applied from**.
- Group Policy operational events.
- `nltest /dsgetdc:<domain>`.

Record the server before forcing rediscovery. A healthy peer might select another domain controller.

The domain-based SYSVOL path uses Distributed File System referrals. When evidence is inconsistent, compare both the domain path plus the named server path.

## Account for topology, schedules, and convergence

Use the following sequence when diagnosing Group Policy replication issues:

1. Record the client subnet/site and the DC selected by the failing Activity ID before rediscovery.
1. If selection is unexpected, test subnet mapping, DC Locator, DNS, and site availability before changing replication.
1. Define the expected change: GPO GUID, editing/source DC, user and computer AD/SYSVOL versions, report content, relevant GPT files, ACL expectations, and change time.
1. For AD DS, inspect KCC-generated inbound connection objects for the affected naming context in both the intrasite and intersite topologies. Intrasite replication normally uses change notification; intersite connection schedules and intervals derive from site-link properties.
1. For DFSR/SYSVOL, establish a separate expectation from DFSR topology/configuration, schedule, events, and observed progress. Don't reuse an AD DS estimate as a GPT deadline.
1. Use a conditional healthy-topology planning estimate, not a bound or SLA. If topology, schedules, health, or expected source is uncertain, elapsed time can't classify the state as normal.
1. Compare `/showobjmeta` for the same GPC object on the known source/edit DC and the client-used DC; one query alone doesn't prove arrival.
1. Query DFSR backlog in the expected origin-to-destination direction and in reverse when either member could have originated relevant changes.

| Observation | Correct interpretation | Safe next action |
| --- | --- | --- |
| Change is within a conditional healthy-topology estimate, expected versions/content progress, and no health error exists | Expected convergence remains plausible, not proved | Record assumptions and observe; don't force broad synchronization |
| Intersite schedule is closed or interval hasn't elapsed | Planned AD DS delay can be plausible | Wait for the allowed window while preserving evidence; evaluate DFSR separately |
| GPC matches expected change; named-DC GPT is stale | AD DS is ahead; DFSR/SYSVOL is lagging or inconsistent | Review DFSR events, expected files/ACL, and directional backlog |
| GPT matches expected change; named-DC GPC is stale | DFSR/SYSVOL is ahead; AD DS is lagging or inconsistent | Compare `repadmin /showrepl` and object metadata for the affected naming context |
| Client selected an unexpected site/DC | Discovery can explain the observed replica | Correct the site/DC Locator hypothesis before changing replication topology |
| Zero backlog or no active transfer, but expected file/content/ACL is wrong | Inconclusive | Check the reverse direction, expected source, conflicts/deletions, events, files, hashes/counts where available, and ACLs |
| AD and SYSVOL version counters match on one DC | Version-aligned only | Prove that both match the known expected change and validate relevant content/ACLs |
| Expected GPC and GPT state is correct on the client-used DC | Replication no longer leads the hypothesis | Return to retrieval identity, token, trigger, CSE, effective-state, and application evidence |

> [!NOTE]
> Backlog is directional: zero backlog means only that DFSR reports no pending updates from the named source to the named destination for that replicated folder at query time. It doesn't prove reverse convergence, selected-source correctness, content integrity, ACL correctness, or absence of conflict/deletion handling.

Define **current** as matching the known expected change from the editing/source DC, including the intended report content, AD and SYSVOL versions, relevant GPT artifacts, and required ACLs, not merely equal counters on one replica.

## Inspect GPMC evidence

For the affected GPO, review:

- **Details** - Globally unique identifier, owner, creation time, modification time, user version, computer version.
- **Settings** - Current configuration report.
- **Delegation** - GPC permissions.
- **Status** - Enabled user plus computer portions.
- **Infrastructure Status** - Version, replication, plus domain controller consistency.

Infrastructure Status is a high-value first comparison, but it doesn't replace examining AD DS or DFSR diagnostics when it reports a difference.

## Compare GPO versions by server

The following read-only PowerShell example asks two domain controllers for the same GPO:

```powershell
$gpoId = [guid]'11111111-2222-3333-4444-555555555555'

$servers = 'DC01.contoso.com', 'DC02.contoso.com'

foreach ($server in $servers) {
    Get-GPO -Guid $gpoId -Server $server |
        Select-Object DisplayName, Id, ModificationTime,
            UserVersion, ComputerVersion,
            @{Name = 'Server'; Expression = { $server }}
}
```

When you get the report back, compare:

- AD version.
- SYSVOL version.
- Modification time.
- GPO status.
- WMI filter.

You can generate server-specific reports when configuration differs:

```powershell
Get-GPOReport `
    -Guid $gpoId `
    -Server 'DC02.contoso.com' `
    -ReportType Xml `
    -Path 'C:\Reports\DC02-policy.xml'
```

## Inspect GPT content read-only

Use the GPO globally unique identifier to locate Group Policy Table content:

```text
\\DC02\SYSVOL\contoso.com\Policies\{GPO-GUID}
```

Check only the artifacts relevant to the incident:

- `GPT.ini`.
- `Machine\Registry.pol`.
- `User\Registry.pol`.
- Referenced script.
- Relevant preference XML.
- Relevant security template.
- File plus folder access control lists.

Compare with a healthy domain controller. Don't infer correctness from timestamp alone. DFSR preserves metadata in ways that can make timestamp comparison incomplete.

## Diagnose AD DS replication

Start with forest-wide health:

```console
repadmin /replsummary
```

Then inspect the affected server:

```console
repadmin /showrepl DC02
```

Read:

- Naming context.
- Source partner.
- Last success.
- Consecutive failures.
- Error code.
- Inbound versus outbound direction.

For one GPO object, `repadmin /showobjmeta` can expose per-attribute origin plus version:

```console
repadmin /showobjmeta DC02 "CN={GPO-GUID},CN=Policies,CN=System,DC=contoso,DC=com"
```

This evidence can show whether `versionNumber`, `gPCFileSysPath`, or the security descriptor reached the server.

> [!NOTE]
> AD DS replication depends on DNS, Kerberos, time, RPC, connectivity, topology, plus directory health. Fix the reported dependency. Don't force broad synchronization as a substitute for diagnosing what the persistent problem might be.

## Validate domain controller health

To determine domain controller health, use `dcdiag` tests including:

```console
dcdiag /s:DC02 /test:Advertising
dcdiag /s:DC02 /test:Replications
dcdiag /s:DC02 /test:SysVolCheck
dcdiag /s:DC02 /test:NetLogons
```

Interpret each test narrowly:

- Advertising confirms the server advertises required roles.
- Replications checks AD DS replication.
- SysVolCheck checks SYSVOL readiness, not file-by-file convergence.
- NetLogons checks required shares.

Passing `SysVolCheck` doesn't prove one GPO is current.

For basic DNS checks without dynamic-update side effects:

```console
dcdiag /s:DC02 /test:DNS /DnsBasic
```

> [!IMPORTANT]
> Bare `dcdiag /test:DNS` or `/DnsAll` are diagnostic writes; dynamic-update testing creates and removes a DNS test record. Never add `/fix`.

## Diagnose DFSR state

Review **Applications and Services Logs > DFS Replication** on source plus destination domain controllers.

Look for:

- Service initialization.
- Database recovery.
- Replicated-folder state.
- Connection failure.
- Content freshness protection.
- Journal or disk errors.
- Paused replication.

`dfsrdiag ReplicationState` shows active transfers. No active transfer doesn't prove that all expected files exist.

Backlog can test one direction:

```console
dfsrdiag backlog /rgname:"Domain System Volume" /rfname:"SYSVOL Share" /smem:DC01 /rmem:DC02
```

Interpret backlog with:

- DFSR events.
- Expected GPT files.
- GPO version.
- AD DS health.
- Connection topology.

## Distinguish Central Store issues

The Central Store under `\\<domain>\SYSVOL\<domain>\Policies\PolicyDefinitions` contains Administrative Template definitions. Missing or mismatched ADMX or ADML files can change how editors display settings. They don't by themselves prove that previously stored client policy failed.

Treat these as separate questions:

- Can an administrator display plus edit the setting?
- Can the client retrieve plus process the stored policy data?

## Recognize orphaned data

Possible states include:

- GPC exists. GPT is missing.
- GPT exists. GPC is missing.
- GPC plus GPT exist. Link is missing.
- Link references a deleted GPO.
- GPC permissions differ from GPT permissions.

Use GPMC reports plus Infrastructure Status first. Escalate destructive cleanup. Don't delete orphaned data during diagnosis.

## Avoid unsafe repair shortcuts

Avoid the following anti-patterns. Don't:

- Manually share SYSVOL.
- Set `SysvolReady` to hide a share problem.
- Edit GPT files.
- Copy one GPT folder between domain controllers.
- Use File Replication Service recovery guidance in a DFSR domain.
- Use `dfsrdiag pollad` as a generic fix.
- Perform authoritative or nonauthoritative SYSVOL synchronization without a validated recovery plan.
- Use `dcgpofix` for arbitrary GPO repair.

> [!IMPORTANT]
> `dcgpofix` is limited to disaster recovery for the default domain GPOs. It doesn't restore custom GPOs.

Authoritative or nonauthoritative SYSVOL synchronization changes replication state. Treat it as a separate recovery operation. Use the dedicated Microsoft procedure, validated backups, plus AD DS owner approval.
