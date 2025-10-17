Now that your governance is in place, this unit ensures your integrations-like Azure Boards and Azure Pipelines-still function post-migration. It also focuses on helping developers get up to speed with new tools through checklists, communication, and lightweight training plans that reduce friction and encourage immediate productivity.

**In this unit, you'll learn:**
- How to verify autolinks and full Azure Boards integration
- How to validate hybrid Azure Pipelines configurations
- Common integration pitfalls and how to resolve them
- How to create verification scripts, onboarding communications, and training plans for developers

### Azure Boards verification (autolinks vs full integration)

Use GitHub CLI to verify Azure Boards integration:

```bash
# azure-boards-integration-test.sh (per repo loop recommended)

# Check autolinks
gh api "/repos/$GITHUB_ORG/$REPO/autolinks" | jq -r '.[] | "\(.key_prefix) -> \(.url_template)"'

# Webhooks (present for integrate-boards full setup)
gh api "/repos/$GITHUB_ORG/$REPO/hooks" | jq -r '.[] | select(.config.url|contains("dev.azure.com")) | "\(.id) \(.active) \(.config.url)"'

# Test webhook delivery if present
gh api -X POST "/repos/$GITHUB_ORG/$REPO/hooks/$HOOK_ID/tests"
```
> [!TIP]
> In addition to the CLI checks, it’s often faster to pop into the repo Settings → Webhooks tab and confirm that a webhook pointing to dev.azure.com is present and active. If it looks healthy there, you usually don’t need to dig deeper unless issues are reported.

### Azure Pipelines hybrid sanity checks

Verify the following components are properly configured:
- GitHub service connection shared to the right ADO projects
- Pipelines rewired to GitHub repos for triggers
- `azure-pipelines.yml` paths/filters confirmed

### Common issues and fixes

**No ADO webhook**: Run `integrate-boards` or reconfigure the service connection
**Triggers not firing**: Verify repo name/path in pipeline resource and branch filters
**Permissions**: Ensure ADO PAT has "All organizations" if integrating across multiple orgs

### Success criteria for integrations
- Work items like AB#123 show up as clickable links in GitHub
- ADO work items display GitHub development links when full integration is set up
- Pipelines trigger from GitHub pushes where expected


### Reduce friction with simple, standardized verification

Provide teams with a clear verification checklist to ensure they can be productive immediately.

### Developer verification checklist (shareable)

- Can sign in to GitHub via SSO
- Has access to the right organization and repositories
- Can clone, create branch, push, and raise a PR
- Branch protection behaves as expected (cannot push to protected branches)
- Required reviews and checks appear on PRs
- AB# references link to Azure Boards (if applicable)

### Quick self-test script

Provide this script to developers for quick verification:

```bash
# quick-repo-verification.sh
REPO_URL="$1"; [ -z "$REPO_URL" ] && { echo "Usage: $0 https://github.com/org/repo.git"; exit 1; }
NAME=$(basename "$REPO_URL" .git); DIR="/tmp/verify-$NAME"
rm -rf "$DIR"; git clone "$REPO_URL" "$DIR" || exit 1
cd "$DIR"; git checkout -b verify/$(date +%s)
echo "verification" > _migration_verify.txt
git add . && git commit -m "Post-migration verification"
git push -u origin HEAD || echo "Push blocked (likely by protection) - expected for mainline"
```
> [!NOTE]
> This test assumes that **branch protection rules** (or org/repo rulesets) are in place to block direct pushes to main branches.
> However, if you don’t have branch protection rules, a successful push here does **not** necessarily mean something is wrong; it simply means protections have not been configured yet.

### Communications that help

Provide clear communications to reduce confusion:

- "What changed, what to do now" email/Teams post
- Copy/paste remote URL update commands
- Where to ask for help (channel, office hours)

### Example communication snippet

```text
# GitHub Migration Complete - Start Here
New repo URL: https://github.com/[org]/[repo]
Update existing clone:
git remote set-url origin https://github.com/[org]/[repo].git

PRs require at least one CODEOWNER review; AB#[id] creates a link to Azure Boards.
Support: #github-migration | Weekly office hours Wed 10:00-10:30
```

### Make the new path explicit

- Update onboarding docs: cloning, PR flow, CODEOWNERS, branch strategy
- Provide short videos or GIFs for PR/review basics
- Publish a FAQ: "Why can't I push to main?", "How do I link AB# work items?"

### Training plan (lightweight)

- **Week 1**: GitHub fundamentals + PR workflow
- **Week 2**: Security and governance features
- **Week 3**: Team workflows (branching, release), Q&A/office hours
