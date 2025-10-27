This unit helps you execute a controlled and audit-ready retirement of Azure DevOps. You’ll also define operational ownership and establish monthly health checks and KPIs to track adoption, security, and platform performance-ensuring your GitHub environment remains trusted, secure, and continuously improving.

**In this unit, you'll learn:**
- How to plan a phased ADO retirement (read-only, education, decommission)
- Which exports to capture for audits (e.g., work items, build definitions)
- How to assign platform ownership and set up escalation paths
- How to run monthly health checks and track outcome metrics post-migration

### Plan the runway

Establish a clear timeline for Azure DevOps retirement:
- **Weeks 1-2**: Read-only mode for ADO projects in scope
- **Weeks 3-4**: Education, redirects, and exceptions handling
- **Weeks 5-6**: Exports and archival (work items, build definitions)
- **Week 7+**: Decommission

### Archival commands (examples)

Use the az devops CLI when you need to export or archive data that still lives only in Azure DevOps:
```bash
# Work items (example with az CLI)
az boards query --wiql "SELECT [System.Id], [System.Title] FROM workitems" \
--output table > workitems-export.csv

# Build definitions
az pipelines build definition list --output table > builds-export.csv
```
### Success criteria for ADO retirement

- No net-new changes in ADO after read-only date
- Audit-ready exports stored in a known archive location
- Stakeholders confirm cutover and deprecation milestones

### Run the platform: health checks and KPIs

Make it measurable, then make it better

**Ops handover (for leadership)**

Define who owns platform operations (e.g., central DevOps team, platform engineering) and set an escalation path for incidents. This avoids confusion post-migration and ensures teams know where to go when issues arise.

**Monthly health checks (starter set)**

- Branch protection coverage (% of repos with protection on main)
- Security features adoption (secret scanning, Dependabot updates)
- Autolink/integration coverage (if Boards hybrid)
- Repo hygiene (archived stale repos, default branch consistency)

**Sample health check script**

```bash
# Security feature scan (illustrative)
for r in $(gh repo list "$GITHUB_ORG" --json name --jq '.[].name'); do
echo -n "$r: "
gh api "/repos/$GITHUB_ORG/$r" | jq -r '"secret_scanning: \(.security_and_analysis.secret_scanning.status // "unknown"), dependabot: \(.security_and_analysis.dependabot_security_updates.status // "unknown")"'
done
```
> [!NOTE]
> If your org is **not** using Dependabot or GitHub Advanced Security (GHAS) yet, you can safely skip this check for now.
> That said, enabling these features early in the migration is a strong *go-forward* practice-you’ll save yourself headaches later.

### Outcome metrics (share with leadership)

- **Adoption**: % of active devs pushing to GitHub within 30 days
- **Flow**: PR cycle time, review depth, merge strategy adherence
- **Security**: time-to-remediate alerts, code scanning enablement
- **Reliability**: pipeline success rate (if hybrid) or Actions success rate (if migrated)
- **Number of repositories**: total migrated vs. total planned
