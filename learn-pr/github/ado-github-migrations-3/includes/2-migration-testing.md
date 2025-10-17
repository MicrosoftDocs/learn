In testing, prove assumptions with evidence. Pick repositories that reflect your variety: a quick win, a representative "middle," and a heavyweight with history or binaries. Your goal isn't perfection—it's confidence and clarity about risks.

## Design the test plan

Treat tests as stakeholder rehearsal. You're validating not just code history but how people will work the day after migration.

### Execute test migrations

**Step 1. Create the test organization**

Create test organization for migration validation:

gh api -X POST /organizations \
  -f login="test-migration-org" \
  -f admin="your-username"

**Step 2: Select test repositories**

Choose tiers:

- Small (PoC): <100MB, simple branches, minimal integrations
- Medium (Representative): 100MB–1GB, multiple branches/tags, some integrations
- Large (Performance): >1GB, extensive history, complex branching or LFS needs

Define success criteria:

- Data integrity: history, branches, tags, files match
- Identity/auth: SSO works; team permissions map correctly
- Governance: default branch, protections/rulesets active
- Integrations: Boards linking and pipelines (if hybrid) function as expected
- Timing: within acceptable windows

> [!TIP]
> Document expected vs. observed outcomes for each tier; these become your production estimates.

**Step 3: Run test migration script**

```bash
#!/bin/bash
# test-migration.sh (example)

# Variables
ADO_ORG="source-ado-org"
ADO_TEAM_PROJECT="test-project"
ADO_REPO="test-repository"
GITHUB_ORG="test-migration-org"
GITHUB_REPO="migrated-test-repository"

# Execute test migration
gh ado2gh migrate-repo \
--ado-org "$ADO_ORG" \
--ado-team-project "$ADO_TEAM_PROJECT" \
--ado-repo "$ADO_REPO" \
--github-org "$GITHUB_ORG" \
--github-repo "$GITHUB_REPO" \
--wait

# Validate at a glance
gh repo view "$GITHUB_ORG/$GITHUB_REPO" --json createdAt,diskUsage,defaultBranchRef
```

What to watch:

- Long pauses may signal network throttling or repo size bottlenecks. Note timestamped milestones.

## Validate results

Use a structured checklist. Avoid "it looks okay" - require explicit evidence.

**Data integrity:**

- Files and structure preserved; sample diff checks pass
- Full commit history with correct authors and timestamps
- Branch and tag counts match expectations
- Releases present where expected (if in scope)

**Identity and access:**

- SSO login works for pilot users
- Teams and permissions reflect your Phase 3 design
- Unable to push to protected branches without PR (negative test)

**Governance and security:**

- Default branch is `main`
- Required reviews and status checks enforced on protected branches
- Secret scanning and dependency features enabled for private repos (if adopted)

**Integrations (optional/hybrid):**

- Azure Boards autolinks render (`AB#123`) and link correctly
- If full Boards integration: webhook active; test commit updates work item
- Azure Pipelines triggers from GitHub.com; builds succeed or expected errors are known with remediation

Useful scripts from your toolkit:

```bash
# Developer workflow smoke test
git clone https://github.com/org/repo.git
cd repo && git checkout -b feature/test-branch
echo "test change" >> README.md
git add README.md && git commit -m "Test commit"
git push origin feature/test-branch
gh pr create --title "Test PR" --body "Testing workflow"
```

## UAT and sign-off

Approach:

- Invite a small pilot team to validate daily workflows for 24–48 hours
- Collect feedback on developer ergonomics (PRs, reviews, required checks)
- Confirm integration behaviors in real usage
- Record gaps and remediation steps; adjust production plan (Phase 5)

"Definition of Ready" for Phase 5:

- Test objectives met or conscious exceptions documented with mitigation
- Stakeholders agree on production order and freeze windows
- Rollback plan rehearsed on a test repo
