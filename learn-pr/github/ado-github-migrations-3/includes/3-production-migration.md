This is where coordination shines. Keep stakeholders close, communicate often, and measure progress visibly. Success is no surprises, steady cadence, and clean validation.

## Go-live readiness and checklists

Run of show (typical):

- T-48h: Final notice; confirm freeze windows; publish runbook and contacts
- T-4h: Tooling check, credentials validated, dry-run of scripts
- T-0: Enforce freeze, start batch 1, open war-room channel
- T+During: Status updates on a fixed cadence (e.g., every 60–90 minutes)
- T+Complete: Validation, unblock teams, publish summary, begin hypercare

Pre-migration checklist (adapt for your org):

- Environment verification complete:
  - GitHub.com org configured; teams, permissions, and rulesets ready
  - Repository templates available
  - Security controls active and verified
- Communication:
  - Stakeholders notified ≥48 hours prior with clear window and impact
  - Support channels staffed; escalation path defined
  - Rollback procedures rehearsed
- Source environment:
  - Repository freeze policy defined and scheduled
  - Final backups verified
  - Tooling and network connectivity tested

Freeze guidance:

- Use a "soft freeze" (PRs enabled, no merges) ahead of a "hard freeze" during cutover
- Communicate exact timestamps and expected developer actions

## Migration order and scheduling

Order strategies (pick and justify):

- Low-risk first: build momentum and refine tooling
- High-value first: accelerate business outcomes, if risk appetite enables this
- Size-based: surface size-related issues early with small-to-large
- Team-based: migrate coherent team sets to minimize cross-system coordination

Capacity planning:

- Batch sizes that respect rate limits and validation capacity
- Maintenance windows aligned to global teams
- Contingency time between batches for remediation

## Execute at scale and monitor

Use a consistent batch script and log everything. Apply baseline governance immediately post-create.

Example batch script (simplified):

```bash
#!/bin/bash
# batch-migration.sh (simplified)
ADO_ORG="your-ado-org"
GITHUB_ORG="your-github-org"
LOG_FILE="migration-log-$(date +%Y%m%d).txt"

REPOS=(
  "project1/repo1"
  "project1/repo2"
  "project2/repo3"
)

migrate_repository() {
  local tp_repo="$1"
  local tp=$(echo "$tp_repo" | cut -d'/' -f1)
  local r=$(echo "$tp_repo" | cut -d'/' -f2)

  echo "[$(date)] Start $tp/$r" | tee -a "$LOG_FILE"

  gh ado2gh migrate-repo \
    --ado-org "$ADO_ORG" \
    --ado-team-project "$tp" \
    --ado-repo "$r" \
    --github-org "$GITHUB_ORG" \
    --github-repo "$r" \
    --wait 2>&1 | tee -a "$LOG_FILE"

  if [ $? -eq 0 ]; then
    echo "[$(date)] SUCCESS $tp/$r" | tee -a "$LOG_FILE"
    # Baseline repo settings (example)
    gh api -X PATCH "/repos/$GITHUB_ORG/$r" \
      -f delete_branch_on_merge=true -f has_wiki=false
  else
    echo "[$(date)] FAILED $tp/$r" | tee -a "$LOG_FILE"
  fi
}

for entry in "${REPOS[@]}"; do
  migrate_repository "$entry"
  sleep 30
done

echo "[$(date)] Batch complete" | tee -a "$LOG_FILE"
```

Real-time monitoring:

```bash
#!/bin/bash
# monitoring-dashboard.sh
while true; do
  clear
  echo "=== GitHub Migration Dashboard ==="
  echo "Time: $(date)"
  echo
  echo "Active Migrations:"
  gh ado2gh list-migration-logs --github-org "$GITHUB_ORG" | head -10
  echo
  echo "Recent Repository Activity:"
  gh repo list "$GITHUB_ORG" --limit 10 --json name,createdAt
  sleep 30
done
```

War-room etiquette:

- Keep updates crisp: "What started, what finished, any blockers, next steps."
- Record decisions in a live log (who, what, when, why).

## Post-migration validation and stabilization

Automate validation; don’t just eyeball.

```bash
#!/bin/bash
# validate-migration.sh (excerpt)
GITHUB_ORG="your-github-org"
REPORT="validation-report-$(date +%Y%m%d).md"
echo "# Migration Validation Report" > "$REPORT"
REPOS=$(gh repo list "$GITHUB_ORG" --json name --jq '.[].name')

for repo in $REPOS; do
  echo "## Repository: $repo" >> "$REPORT"
  gh repo view "$GITHUB_ORG/$repo" --json \
    name,description,createdAt,diskUsage,defaultBranchRef \
    | jq -r '"- Created: \(.createdAt) | Size: \(.diskUsage)KB | Default Branch: \(.defaultBranchRef.name)"' \
    >> "$REPORT"

  echo "- Branch protection: $(gh api "/repos/$GITHUB_ORG/$repo/branches/main/protection" --silent && echo "✓" || echo "✗ Missing")" >> "$REPORT"

  last_commit=$(gh api "/repos/$GITHUB_ORG/$repo/commits" --jq '.[0].commit.committer.date' 2>/dev/null || echo "n/a")
  echo "- Last commit: $last_commit" >> "$REPORT"
  echo >> "$REPORT"
done

echo "Report: $REPORT"
```

Stabilization playbook:

- Team verification checklist: access, PRs, protection behavior, integrations
- Governance application: rulesets/branch protection where not inherited
- Mannequin resolution (if applicable)
- Known-issues list with workarounds and timelines
- 24–72 hour “hypercare” with fast response SLAs

Rollback decision tree (simplified):

- Can we correct forward within the window without data loss or security risk? → Roll forward.
- Is there unrecoverable data integrity or auth failure blocking work? → Roll back.
- Communicate clearly either way: what happened, action taken, ETA to resolution.

Status update template (stakeholders):

- What changed (repos, teams)
- When it changed (window)
- Current status (green/yellow/red) and why
- What’s next (next batch, validation steps)
- Who to contact for issues
