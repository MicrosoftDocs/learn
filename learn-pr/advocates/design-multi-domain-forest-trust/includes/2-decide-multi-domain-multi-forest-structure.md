You should always be reluctant to add domains to an existing forest, or adding new forests and trust relationships to your environment. You should be reluctant because making these additions will increase administrative and architectural complexity and the more complex an environment is, the more challenging it's to maintain.

Use the following drivers to decide whether you need an additional domain, an additional tree in the same forest, an additional forest, or whether your goals can be met with no structural change at all.

| Driver | Typical justification | Preferred structure |
| --- | --- | --- |
| Security isolation | A business unit or subsidiary mustn't share a schema, configuration partition, or Enterprise Admins/Schema Admins boundary with the rest of the organization. | Separate forest, connected by a narrowly scoped trust. |
| Legal or regulatory separation | Data residency, contractual, or regulatory requirements mandate a distinct administrative and directory boundary (for example, a regulated subsidiary or a government contract enclave). | Separate forest. |
| Administrative autonomy without full isolation | A division needs its own domain administrators and password/account policy, but shares schema governance and forest-wide trust with the rest of the organization. | Additional domain in the existing forest (same tree, or a new tree if the DNS namespace is discontiguous). |
| Mergers and acquisitions | An acquired company already operates its own AD DS forest, and immediate consolidation isn't feasible. | Separate forest with a forest trust, migrated later if consolidation is approved. |
| Replication, connectivity, or sovereignty constraints | A requirement prohibits specific directory data or forest-wide configuration from crossing a boundary, or a disconnected network must operate as a separately administered security boundary. A separate domain limits replication of its domain naming context, but it still receives the forest-wide schema and configuration naming contexts and contributes partial replicas to every global catalog. An RODC still requires writable-domain-controller connectivity for writes and for credentials that aren't already cached. | Use a separate forest when the requirement needs a separate security or forest-wide replication boundary. Use an additional domain only when domain naming-context scope and domain-level administration meet the requirement. Evaluate an RODC separately for a branch that has weaker physical security or limited administrative trust; don't use an RODC as a replacement for sustained AD DS connectivity. |
| Discontiguous namespace | The organization owns multiple unrelated DNS namespaces that must coexist under one directory. | Additional domain tree in the same forest. |

Every one of these drivers has a lower-complexity alternative that should be ruled out first. For example, administrative autonomy is frequently deliverable with OU-based delegation inside a single domain, and application or service isolation can sometimes be delivered by a resource forest. Separate forests don't replicate AD DS schema, configuration, domain, or application naming contexts to each other. A forest or external trust permits authentication and authorization across the boundary; it doesn't synchronize identities or merge directory data. If the design requires identity synchronization, coexistence, migration, or resource consolidation, record that as a separate workstream with its own data ownership, conflict resolution, rollback, and decommissioning plan. Document why the lower-complexity option was rejected, not only which option was chosen.

There are three forest design models that meet these drivers:

- **Organizational forest model** - user accounts and resources are managed within one forest, and inter-division autonomy is delivered through domains and OUs rather than separate forests.
- **Resource forest model** - a dedicated forest hosts resource servers and service accounts, and trusts allow user accounts from one or more account forests to access those resources without hosting user identities in the resource forest.
- **Restricted access forest model** - a separate forest isolates highly sensitive data or operations by having no trust relationships to other forests. Users who need both restricted and general resources hold a separate account in each forest instead of crossing a trust.

See [Mapping Design Requirements to Forest Design Models](/windows-server/identity/ad-ds/plan/mapping-design-requirements-to-forest-design-models) and [Creating a Forest Design](/windows-server/identity/ad-ds/plan/creating-a-forest-design) for the full set of scenarios, including cases that combine an organizational forest with a resource forest for service isolation.

## Evaluate the current state before deciding

Before proposing a target structure, gather evidence about what already exists. In an existing environment, you can use the following PowerShell code to inventory every forest and domain in scope for the decision:

```powershell
Get-ADForest | Select-Object Name, ForestMode, Domains, RootDomain, GlobalCatalogs

Get-ADForest | Select-Object -ExpandProperty Domains |
    ForEach-Object { Get-ADDomain -Identity $_ } |
    Select-Object Forest, DNSRoot, DomainMode, ParentDomain, ChildDomains
```

Use the output to confirm the current forest and domain count, the DNS namespace shape, and whether any domain already looks like a workaround for a driver in the table above - for example, a child domain that exists only to give one division separate account lockout and password policies. Windows Server 2025 doesn't by itself determine the required number of forests or domains. However, implementation is version- and lifecycle-dependent. Before approving the topology, create a compatibility gate for every affected forest and domain that records:

- Every domain controller operating system and whether it remains in Microsoft support.
- The current domain and forest functional levels and the minimum level required by each proposed feature.
- Whether SYSVOL replication has completed migration to DFS Replication (DFSR). Don't introduce a domain controller version that requires DFSR while SYSVOL still uses File Replication Service (FRS).
- Schema, application, backup, security product, and disaster-recovery compatibility with the target domain controller version.
- Feature-specific prerequisites and lifecycle limits, including Windows Server 2025-only features.

Run the following discovery commands with an account that can read all domains. SYSVOL FRS-to-DFSR migration state is tracked per domain, so run `dfsrmig` in every domain in scope — including child domains, not only forest root domains. Run `dfsrmig /getglobalstate` on each domain's PDC emulator from an elevated command prompt:

```powershell
$forest = Get-ADForest

$forest | Select-Object Name, ForestMode, RootDomain, Domains

foreach ($domainName in $forest.Domains) {
    Get-ADDomain -Identity $domainName |
        Select-Object DNSRoot, DomainMode, PDCEmulator, RIDMaster, InfrastructureMaster

    Get-ADDomainController -Filter * -Server $domainName |
        Select-Object HostName, Domain, Site, OperatingSystem, OperatingSystemVersion
}
```

```cmd
dfsrmig /getglobalstate
dfsrmig /getmigrationstate
```

Don't treat command output as approval by itself. Attach the inventory, product support statements, exception owners, and required remediation dates to the architecture decision record.

## Record the decision

A defensible decision record includes:

- The specific driver (security isolation, legal separation, autonomy, merger, replication constraint, or namespace).
- The lower-complexity alternative that was considered and rejected, and why.
- The chosen structure (additional domain, additional tree, additional forest, or resource forest) and its trust implications, which the next unit expands on.
- Any separate mechanism required across a forest boundary: trust-based resource access, identity synchronization, staged migration, or final consolidation. State explicitly that the trust doesn't replicate directory naming contexts.
- The owner responsible for the new domain or forest's schema, configuration, and Enterprise Admins/Domain Admins membership.

> [!IMPORTANT]
> Every additional domain and forest is a long-term operational commitment, not a one-time project deliverable. Before approving one, confirm that the organization has a distinct operations team, monitoring, and patching plan for it. An additional forest with no dedicated operational owner becomes a stale, unpatched trust risk within a year.
