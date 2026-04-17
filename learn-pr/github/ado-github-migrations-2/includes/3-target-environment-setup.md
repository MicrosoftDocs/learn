You're building a foundation your teams will work on daily. Decisions here shape their experience with authentication, collaboration, and software delivery. Focus on clarity, consistency, and making choices that won't surprise your users.

## Validate environment type and authentication

GitHub Enterprise Cloud offers different environment types with varying capabilities and requirements.

### Environment types

Understanding the differences helps you validate your setup:

- **Standard** - Traditional GitHub accounts with single sign-on overlay
- **Enterprise Managed Users (EMU)** - Identities fully managed by your enterprise
- **Data Residency** - EMU with additional regional data hosting guarantees

### Validate your current setup

Use these commands to check your environment status:

```bash
# Check SAML SSO status for enterprise
gh api /enterprises/{enterprise}/settings/saml

# Check SAML SSO status for organization
gh api /orgs/{org}/settings/saml

# Verify your user authentication
gh api /user --hostname github.com

# Check enterprise configuration flags
gh api /enterprises/{enterprise} --jq '{login, managed_users_enabled, data_residency_enabled}'
```

### Security posture validation

Ensure these security configurations are in place before migration:

- **SAML SSO** - Configured and active for your enterprise or organization
- **Team sync** - Enabled if you're using identity provider groups
- **SCIM provisioning** - Active for EMU or Data Residency environments
- **Two-factor authentication** - Enforced across the organization
- **Audit logging** - Enabled for compliance and security monitoring

Address any gaps in this security foundation before proceeding with migration. Authentication and identity issues multiply in complexity during the migration process.

### Organization and Team Design

Start with how your business collaborates, not with the tool's defaults. Choose a structure teams will recognize.

### Organization patterns

Consider these common approaches:

- **Single organization** - Simpler policies and easier cross-team collaboration (recommended for most cases)
- **Multiple organizations** - For distinct governance requirements, compliance boundaries, or scale considerations
- **Hybrid approach** - Start simple with a single organization, then split later if business needs require it

## Team structure principles

Design teams that reflect reality:

- **Sync with your identity provider (IDP) whenever possible** - If available, via EMU SCIM or another SCIM-based integration, map IDP groups directly to GitHub teams. This ensures membership stays in sync with your source of truth, reduces manual overhead, and supports compliance/audit requirements.

> [!Important]
> If SCIM isn't available, document a fallback (manual management or periodic API-driven sync) to prevent drift.

- **Mirror actual team boundaries** - Platform, product, and security teams should map to actual structures in your org chart. For cross-functional groups (like incident response, site reliability, or guilds), layer GitHub teams on top of IDP-synced groups rather than breaking the sync model.

- **Keep permissions predictable** - For example: developers get write access, administrators get admin access, security teams get triage access

## Implement CODEOWNERS for clear ownership

Make code ownership visible and actionable so reviews happen automatically and predictably.
> [!NOTE]  
> Many enterprises won't have consistent ownership practices in place today.  
> Treat **CODEOWNERS** as a *go-forward standard*—apply it to new repos and projects immediately, and introduce it gradually for legacy repos over time.

Example CODEOWNERS file structure:

```text
# Global ownership
* @enterprise/repository-admins

# Application code areas
/src/ @enterprise/product-a-developers
/api/ @enterprise/backend-team

# Infrastructure and automation
/terraform/ @enterprise/platform-engineering
/.github/ @enterprise/platform-engineering

# Security-sensitive areas
/security/ @enterprise/security
/auth/ @enterprise/security @enterprise/product-a-leads
```

## Establish governance and repository standards

These patterns represent recommended end-state practices. They’re critical for long-term health, but adoption should be staged to avoid overwhelming teams carrying legacy practices. Position them as “go-forward defaults”—new repos and active projects must follow them, while legacy repos can be remediated over time.

### Repository naming and visibility

Establish consistent patterns that reduce cognitive load:

- **Clear, descriptive names** - Use formats like `product-api`, `platform-tools`, or `security-scanner`
- **Default to private visibility** - Private by default, Internal for shared libraries and documentation, Public only by explicit policy
- **Consistent description patterns** - Help teams quickly understand repository purpose and scope

### Baseline repository template

Create a standard template that includes:

- **README.md** with clear project description and getting started instructions
- **CODEOWNERS** file for review assignments
- **CONTRIBUTING.md** with contribution guidelines
- **Issue and pull request templates** for consistent communication
- **.github/workflows/** folder if using GitHub Actions
- **Default branch** set to `main` with squash merge and automatic head branch deletion

## Repository rulesets

Implement security and quality controls that protect important branches while enabling collaboration.

Example enterprise security ruleset:

```yaml
name: 'Enterprise Security Ruleset'
target: 'branch'
enforcement: 'active'
conditions:
ref_name:
include: ['refs/heads/main', 'refs/heads/develop']
rules:
- type: 'required_status_checks'
parameters:
required_status_checks:
- context: 'build'
- context: 'security-scan'
- type: 'required_signatures'
- type: 'pull_request'
parameters:
dismiss_stale_reviews: true
require_code_owner_review: true
required_approving_review_count: 2
```

Start with protection that's restrictive enough to secure main branches and sensitive areas, then adjust based on team feedback and collaboration requirements.

### Organization rulesets for centralized governance

Organization Rulesets are now the recommended approach for enterprise governance, providing centralized policy management across all repositories. Unlike repository-level branch protection, rulesets apply consistently organization-wide and require minimal ongoing maintenance.

Configure organization-level rulesets during target environment setup:

1. Navigate to **Organization Settings** → **Repository rulesets**
1. Create a **Push ruleset** with enforcement set to "Active"
1. Target all repositories and main branches (`main`, `master`, `develop`)
1. Add core GitHub Flow rules:

    ```json
    {
    "name": "Enterprise GitHub Flow",
    "enforcement": "active",
    "target": {"repositories": "all", "branches": ["main", "master"]},
    "rules": [
    {
    "type": "pull_request",
    "parameters": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews_on_push": true,
    "require_code_owner_review": true
    }
    },
    {
    "type": "required_status_checks",
    "parameters": {
    "required_status_checks": ["ci/build", "ci/test", "security/scan"]
    }
    },
    {"type": "non_fast_forward", "parameters": {}}
    ]
    }
    ```

**Benefits**: New repositories automatically inherit policies, governance updates apply organization-wide, and compliance reporting is centralized.

**Repository-level supplements**: Use repository rulesets for project-specific requirements like file path restrictions or commit message patterns that don't apply organization-wide.

## Configure Azure integrations for hybrid workflows

During transition periods, you might need to maintain connections between GitHub repositories and Azure DevOps services.

### Azure Boards integration

For full bidirectional linking and work item traceability:

```bash
gh ado2gh integrate-boards \
--ado-org "$ADO_ORG" \
--ado-team-project "$ADO_TEAM_PROJECT" \
--github-org "$GITHUB_ORG" \
--github-repo "$GITHUB_REPO" \
--verbose
```

For simpler autolink references when you need basic linking with minimal setup:

```bash
gh ado2gh configure-autolink \
--github-org "$GITHUB_ORG" \
--github-repo "$GITHUB_REPO" \
--ado-org "$ADO_ORG" \
--ado-team-project "$ADO_TEAM_PROJECT" \
--verbose
```

### Azure Pipelines hybrid configuration

When you want to decouple code migration from release process modernization:

Share service connections across team projects:

```bash
gh ado2gh share-service-connection \
--ado-org "$ADO_ORG" \
--ado-team-project "$TARGET_TEAM_PROJECT" \
--service-connection-id "$SERVICE_CONNECTION_ID" \
--verbose
```

Update existing pipelines to reference GitHub repositories:

```bash
gh ado2gh rewire-pipeline \
--ado-org "$ADO_ORG" \
--ado-team-project "$ADO_TEAM_PROJECT" \
--ado-pipeline "$PIPELINE_PATH_OR_NAME" \
--github-org "$GITHUB_ORG" \
--github-repo "$GITHUB_REPO" \
--service-connection-id "$SERVICE_CONNECTION_ID" \
--verbose
```

These hybrid configurations let you migrate code repositories while maintaining existing deployment automation, reducing transition risk for production systems.
