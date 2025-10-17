Even the best migration plans need support. This unit provides a structured guide to troubleshoot common post-migration issues—ranging from large file errors and mannequin attribution to broken work item links and integration failures. You’ll get CLI commands, scripts, and rollback guidance for fast recovery when needed.

**In this unit, you'll learn:**
- How to diagnose and fix large file size, LFS, and repo bloat issues
- How to resolve mannequin attribution problems quickly
- How to troubleshoot Azure Boards and Azure Pipelines connectivity
- When and how to safely roll back migrated repositories in emergencies

### Repository size and large file issues

**Symptoms**

- Migration timeouts
- Pushes blocked for files >100MB
- Slow clones

**Diagnose**

```bash
# Overall size and hotspots
git-sizer --verbose

# Find blobs >50MB in history
git rev-list --objects --all | \
git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | \
awk '/^blob/ {if ($3 > 52428800) print $3/1024/1024 " MB " $4}' | sort -rn | head
```

**Remediate with Git LFS**

```bash
git lfs install
git lfs track "*.{zip,jar,exe,msi,dll,mp4,pdf}"
git add .gitattributes && git commit -m "Configure Git LFS"
git lfs migrate import --above=50MB --everything
git lfs ls-files
```

### Authentication and permissions failures

**Symptoms**

- Access denied, 403s, failed integrations

**Checks**

```bash
# GitHub token
gh auth status

# Azure DevOps token
curl -u :$ADO_PAT "https://dev.azure.com/$ADO_ORG/_apis/projects?api-version=6.0"
```

**Fix**

- **GitHub PAT**: repo, admin:repo_hook, read:org (and admin:org if needed), workflow
- **ADO PAT**: Build (read), Code (read), Project & Team (read), Service connections (manage), Work items (read/write), "All organizations"

### Mannequin resolution

** Symptoms**

- PRs/commits attributed to "Mannequin"

**Fix**

```bash
cat > user-mapping.csv << EOF
mannequin-login,target-user
john-mannequin,john.doe
EOF

gh ado2gh reclaim-mannequin \
--github-org "$GITHUB_ORG" \
--csv-file user-mapping.csv
```

### Azure Boards linking and connectivity

**Symptoms**

- AB# references not linked; no ADO updates

**Diagnose and fix**

```bash
# Check autolinks
gh api "/repos/$GITHUB_ORG/$REPO/autolinks" | jq -r '.[] | "\(.key_prefix) -> \(.url_template)"'

# Configure autolink (fallback)
gh api -X POST "/repos/$GITHUB_ORG/$REPO/autolinks" \
-f key_prefix="AB#" \
-f url_template="https://dev.azure.com/$ADO_ORG/$ADO_TEAM_PROJECT/_workitems/edit/<num>" \
-f is_alphanumeric=false

# For full integration, ensure webhook exists
gh api "/repos/$GITHUB_ORG/$REPO/hooks" | jq -r '.[] | select(.config.url|contains("dev.azure.com"))'
gh api -X POST "/repos/$GITHUB_ORG/$REPO/hooks/$HOOK_ID/tests"
```

If missing, run:

```bash
gh ado2gh integrate-boards \
--ado-org "$ADO_ORG" \
--ado-team-project "$ADO_TEAM_PROJECT" \
--github-org "$GITHUB_ORG" \
--github-repo "$REPO" \
--verbose
```

### Azure Pipelines hybrid integration

**Symptoms**

- Pipelines don't trigger; cannot connect to GitHub repo

**Checks**

```bash
# List GitHub-type service connections in ADO
curl -s -u :$ADO_PAT \
"https://dev.azure.com/$ADO_ORG/$ADO_TEAM_PROJECT/_apis/serviceendpoint/endpoints?api-version=6.0-preview.4" | \
jq -r '.value[] | select(.type=="github") | {id,name}'
```

**Fixes**

```bash
# Share service connection across projects
gh ado2gh share-service-connection \
--ado-org "$ADO_ORG" \
--ado-team-project "$TARGET_TEAM_PROJECT" \
--service-connection-id "$SERVICE_CONNECTION_ID" \
--verbose

# Rewire pipeline to GitHub repo
gh ado2gh rewire-pipeline \
--ado-org "$ADO_ORG" \
--ado-team-project "$ADO_TEAM_PROJECT" \
--ado-pipeline "$PIPELINE_NAME_OR_PATH" \
--github-org "$GITHUB_ORG" \
--github-repo "$GITHUB_REPO" \
--service-connection-id "$SERVICE_CONNECTION_ID" \
--verbose
```

### Emergency rollback

**When to use:**
- Critical defects in migrated repos
- Major access or compliance failures

**Steps:**

1. Pause migrations; notify stakeholders
1. Roll back target repo (if needed and approved):
    ```bash
    gh repo delete "$GITHUB_ORG/$REPO" --confirm
    ```
1. Unfreeze ADO; restore access
1. Capture root cause; adjust plan; reschedule migration
