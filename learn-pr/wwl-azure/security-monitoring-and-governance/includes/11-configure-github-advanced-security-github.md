**GitHub Advanced Security** provides comprehensive security capabilities protecting code repositories from vulnerabilities, exposed secrets, and supply chain attacks. GitHub Advanced Security includes **code scanning** (powered by CodeQL semantic analysis), **secret scanning** (detecting exposed credentials), **dependency scanning** (identifying vulnerable packages with Dependabot), **dependency review** (pull request impact analysis), and **security advisories** (curated vulnerability intelligence). These features integrate directly into GitHub workflow providing security feedback during development without disrupting developer productivity.

Organizations implementing DevSecOps practices require security controls embedded throughout software development lifecycle. GitHub Advanced Security delivers security automation at scale covering thousands of repositories while providing actionable findings directly in pull requests and Security tab where developers already work. This unit explores configuring GitHub Advanced Security features for both GitHub and Azure DevOps environments.

## Licensing and availability

**GitHub repositories:**

**Public repositories:**

GitHub Advanced Security features **permanently enabled** for all public repositories on GitHub.com without requiring licenses. Features cannot be disabled for public repositories.

**Private repositories:**

GitHub Advanced Security features require **GitHub Advanced Security licenses** for private repositories. Licenses are sold per **active committer** (unique users pushing code within trailing 90 days).

**Licensing model:**

- **Per-committer pricing:** Pay for active contributors, not repository count.
- **Organization-level purchase:** Licenses apply to all private repositories in organization.
- **Usage monitoring:** Track active committers in organization settings.

**Azure DevOps:**

**GitHub Advanced Security for Azure DevOps** provides similar capabilities for Azure Repos requiring separate licensing billed per active committer.

## Configuring GitHub Advanced Security at organization level

**Enable for organization:**

Organization owners can enable GitHub Advanced Security for all private repositories or allow repository administrators enabling individually.

**1. Navigate to organization settings:**

- Select **profile icon** (top right).
- Select **Your organizations**.
- Select organization name.
- Select **Settings**.

**2. Access security configuration:**

- Select **Code security and analysis** in Security section.

**3. Enable features organization-wide:**

**Feature configuration options:**

- **Dependency graph:** Maps all direct and transitive dependencies.

  - **Private repositories:** Manually enabled (always on for public repos).
  - **All repositories:** Select **Enable all**.

- **Dependabot alerts:** Notifies about vulnerable dependencies.

  - **All repositories:** Select **Enable all**.
  - Generates alerts for dependencies with known CVEs.

- **Dependabot security updates:** Automatically creates PRs updating vulnerable dependencies.

  - **All repositories:** Select **Enable all**.
  - Automated remediation reducing manual effort.

- **Dependabot version updates:** Creates PRs keeping dependencies current.

  - **Configuration required:** Requires `dependabot.yml` file in repositories.

- **GitHub Advanced Security:** Master toggle enabling code scanning and secret scanning for private repositories.

  - **Private repositories:** Select **Enable all**.
  - Confirms GitHub Advanced Security license consumption.

- **Secret scanning:** Detects exposed credentials in code.

  - **All repositories with GitHub Advanced Security enabled:** Select **Enable all**.
  - **Push protection:** Optional toggle blocking pushes containing secrets.

- **Code scanning:** Identifies code vulnerabilities using CodeQL.
  - **Requires workflow configuration:** Enabled per repository with GitHub Actions workflow.

**4. Confirm license usage:**

Enabling GitHub Advanced Security for private repositories displays active committer count and estimated licensing cost. Confirm to proceed.

## Configuring GitHub Advanced Security at repository level

Individual repository administrators can enable GitHub Advanced Security features for specific repositories.

**1. Navigate to repository settings:**

- Open repository on GitHub.com.
- Select **Settings** tab.
- Select **Code security and analysis** in Security section.

**2. Enable GitHub Advanced Security:**

For private repositories, enable **GitHub Advanced Security** consuming license for active committers.

**3. Configure individual features:**

- **Dependency graph:** Enable to visualize dependencies.
- **Dependabot alerts:** Enable to receive vulnerability notifications.
- **Dependabot security updates:** Enable automated security PRs.
- **Secret scanning:** Enable detecting exposed secrets.
- **Secret scanning push protection:** Enable blocking pushes with secrets.
- **Code scanning:** Configure via GitHub Actions workflow (next section).

## Code scanning with CodeQL

**CodeQL overview:**

**CodeQL** is semantic code analysis engine treating code as queryable database. CodeQL queries represent security patterns (SQL injection, XSS, insecure deserialization) executing against code extracting vulnerabilities.

**Supported languages:**

C/C++, C#, Go, Java, JavaScript/TypeScript, Python, Ruby, Swift, Kotlin.

**Configuration workflow:**

**1. Create CodeQL workflow:**

**Option A: Use GitHub template (recommended):**

- Navigate to **Security** tab in repository.
- Select **Set up code scanning**.
- Select **Configure CodeQL alerts**.
- GitHub creates `.github/workflows/codeql.yml` with default configuration.

**Option B: Manual workflow creation:**

Create `.github/workflows/codeql.yml`:

```yaml
name: "CodeQL Analysis"

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: "0 2 * * 1" # Weekly Monday 2 AM

jobs:
  analyze:
    name: Analyze Code
    runs-on: ubuntu-latest
    permissions:
      actions: read
      contents: read
      security-events: write # Required for SARIF upload

    strategy:
      fail-fast: false
      matrix:
        language: ["javascript", "python"]
        # Supported: 'cpp', 'csharp', 'go', 'java', 'javascript', 'python', 'ruby', 'swift'

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Initialize CodeQL
        uses: github/codeql-action/init@v2
        with:
          languages: ${{ matrix.language }}
          # Optional: Custom queries
          # queries: security-extended,security-and-quality

      # Autobuild for compiled languages (C/C++, C#, Java)
      - name: Autobuild
        uses: github/codeql-action/autobuild@v2

      # Alternative: Manual build steps for complex projects
      # - name: Build project
      #   run: |
      #     make bootstrap
      #     make release

      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v2
        with:
          category: "/language:${{ matrix.language }}"
```

**2. Workflow triggers:**

- **push:** Scans code pushed to main/develop branches.
- **pull_request:** Scans code in pull requests before merging.
- **schedule:** Weekly scans detecting newly discovered vulnerabilities.

**3. Language configuration:**

**Interpreted languages (JavaScript, Python, Ruby, Go):**

CodeQL analyzes source code directly without build requirements.

**Compiled languages (C/C++, C#, Java):**

CodeQL requires building code to analyze compiled output:

**Autobuild (simple projects):**

```yaml
- name: Autobuild
  uses: github/codeql-action/autobuild@v2
```

**Manual build (complex projects):**

```yaml
- name: Build C# project
  run: |
    dotnet restore
    dotnet build --configuration Release
```

**4. Custom CodeQL queries:**

Extend default queries with custom security patterns:

```yaml
- name: Initialize CodeQL
  uses: github/codeql-action/init@v2
  with:
    languages: javascript
    queries: security-extended,security-and-quality
    # Or path to custom query packs
    # packs: my-org/my-query-pack
```

**5. Results and alerts:**

After workflow completes:

- **Security tab:** Displays findings categorized by severity.
- **Pull request annotations:** Shows vulnerabilities inline in code diff.
- **SARIF report:** Downloadable artifact for external processing.

**6. Managing code scanning alerts:**

**Triage workflow:**

- Navigate to **Security** > **Code scanning**.
- Review alerts by severity (Critical, High, Medium, Low).
- Select alert for detailed description, affected code, remediation guidance.
- **Assign alert** to developer for fix.
- **Dismiss alert** if false positive with justification.
- **Create issue** tracking remediation work.

**Fix code vulnerability:**

```python
# BEFORE: SQL injection vulnerability
def get_user(username):
    query = f"SELECT * FROM users WHERE username = '{username}'"
    return db.execute(query)

# AFTER: Parameterized query (CodeQL alert resolved)
def get_user(username):
    query = "SELECT * FROM users WHERE username = ?"
    return db.execute(query, (username,))
```

**7. Pull request integration:**

CodeQL findings appear directly in pull requests:

- **Status check:** Pass/fail based on new vulnerabilities introduced.
- **Code annotations:** Inline comments highlighting vulnerable code lines.
- **Blocking merges:** Configure branch protection requiring code scanning success.

**Branch protection configuration:**

```yaml
# .github/workflows/codeql.yml includes required check
# In branch protection rules:
# - Require status checks: "CodeQL"
# - Require branches to be up to date
```

## Secret scanning

**Secret scanning overview:**

Secret scanning detects over 200 credential patterns from providers including:

- **GitHub tokens:** Personal access tokens, OAuth tokens.
- **Cloud providers:** Azure connection strings, AWS access keys, Google Cloud service accounts.
- **Third-party services:** Slack tokens, Stripe API keys, SendGrid keys.
- **Databases:** MongoDB connection strings, PostgreSQL passwords.

**Enable secret scanning:**

**Repository level:**

- Navigate to **Settings** > **Code security and analysis**.
- Enable **Secret scanning**.
- Optional: Enable **Push protection** blocking commits with secrets.

**Organization level:**

- Navigate to organization **Settings** > **Code security and analysis**.
- Enable **Secret scanning** for all repositories.

**Secret scanning alerts:**

When secret detected:

1. **Alert generated** in repository Security tab.
2. **Notification sent** to repository administrators and committers.
3. **Partner notification:** Some providers (GitHub, Azure, AWS) automatically notified.

**Managing secret alerts:**

- Navigate to **Security** > **Secret scanning**.
- Review detected secrets with type, location, commit.
- **Revoke exposed credential** immediately at provider.
- **Close alert** after secret revoked.
- **Dismiss alert** if false positive or test credential.

**Push protection:**

Push protection prevents secrets from entering repository:

**Enable push protection:**

- Navigate to **Settings** > **Code security and analysis**.
- Enable **Push protection** under Secret scanning.

**Developer experience:**

When developer attempts pushing commit with secret:

```bash
$ git push origin main
remote: ——— GitHub Secret Scanning ———————————————————————
remote: Azure connection string detected in commit 3a2b1c:
remote:
remote: File: config/database.yml
remote: Line: 15
remote:
remote: This push has been blocked. To proceed:
remote: 1. Remove the secret from your commit
remote: 2. Store secret securely (Azure Key Vault, GitHub Secrets)
remote: 3. Use --push-option=secret-scanning-bypass (not recommended)
remote:
To github.com:contoso/api-service.git
 ! [remote rejected] main -> main (secret scanning blocked)
error: failed to push some refs
```

**Developer remediation:**

```bash
# 1. Remove secret from code
vim config/database.yml
# Replace connection string with environment variable reference

# 2. Amend commit
git add config/database.yml
git commit --amend

# 3. Retry push
git push origin main
```

**Bypass push protection (emergency only):**

```bash
git push --push-option=secret-scanning-bypass
# Requires justification in push
```

**Custom secret patterns:**

Organizations can define custom patterns for proprietary credential formats:

- Navigate to organization **Settings** > **Code security and analysis** > **Secret scanning**.
- Select **New pattern**.
- Define regex pattern matching proprietary secret format.
- Test pattern against sample secrets.
- Enable pattern organization-wide.

## Dependency scanning with Dependabot

**Dependabot overview:**

Dependabot monitors dependencies for known vulnerabilities (CVEs) and outdated versions.

**Enable Dependabot alerts:**

Automatically enabled when dependency graph enabled (organization or repository settings).

**Dependabot security updates:**

Automatically creates pull requests updating vulnerable dependencies to secure versions.

**Enable security updates:**

- Navigate to **Settings** > **Code security and analysis**.
- Enable **Dependabot security updates**.

**Automatic PR creation:**

When vulnerable dependency detected:

1. **Dependabot creates PR** updating package to fixed version.
2. **PR description** includes CVE details, severity, affected versions, fix version.
3. **Compatibility score** estimates likelihood of breaking changes.
4. **Release notes** from package maintainer.
5. **CI/CD runs tests** validating update.
6. **Developer reviews** and merges PR.

**Example Dependabot PR:**

```markdown
**Bumps `lodash` from 4.17.15 to 4.17.21**

**Security vulnerabilities:**

- CVE-2020-8203 (High severity)
  Prototype Pollution in lodash versions < 4.17.20

**Release notes:**

- Fixed prototype pollution vulnerability
- Improved performance in merge operations

**Compatibility:** 95% (4 of 4 dependencies compatible)

**Commits:**

- Update lodash to 4.17.21
- Update test expectations
```

**Dependabot version updates:**

Keeps dependencies current even without security vulnerabilities.

**Configure version updates:**

Create `.github/dependabot.yml`:

```yaml
version: 2
updates:
  # JavaScript dependencies
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "09:00"
    open-pull-requests-limit: 10
    reviewers:
      - "security-team"
    labels:
      - "dependencies"
    versioning-strategy: increase

  # Python dependencies
  - package-ecosystem: "pip"
    directory: "/backend"
    schedule:
      interval: "weekly"
    allow:
      - dependency-type: "direct" # Only update direct dependencies
    commit-message:
      prefix: "chore"

  # Docker base images
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"

  # GitHub Actions
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "monthly"
```

**Configuration options:**

- **package-ecosystem:** npm, pip, maven, NuGet, docker, github-actions, terraform, etc.
- **schedule:** daily, weekly, monthly.
- **open-pull-requests-limit:** Maximum simultaneous PRs (default: 5).
- **reviewers/assignees:** Auto-assign PRs to teams/individuals.
- **labels:** Categorize dependency PRs.
- **versioning-strategy:** increase (minor/patch), increase-if-necessary (security only), widen (expand version range).

**Dependabot auto-triage rules:**

Automatically dismiss low-risk dependency alerts reducing alert fatigue.

**Example auto-triage configuration:**

- Navigate to organization **Settings** > **Code security and analysis** > **Dependabot**.
- Create rules dismissing alerts for:
  - Development dependencies with low severity.
  - Dependencies not reachable in production code paths.
  - Alerts requiring major version updates with breaking changes.

## Dependency review in pull requests

**Dependency review** analyzes dependency changes in pull requests showing impact before merging.

**Enable dependency review:**

Automatically available when dependency graph enabled.

**Pull request checks:**

When PR modifies `package.json`, `requirements.txt`, or other manifest files:

1. **Dependency review action** runs automatically.
2. **Changed dependencies** listed with:
   - Added packages.
   - Removed packages.
   - Updated packages with version changes.
3. **Vulnerability information** for any added/updated packages.
4. **License compliance** for new dependencies.
5. **Status check** fails if vulnerable dependencies introduced.

**Enforce dependency review:**

```yaml
# .github/workflows/dependency-review.yml
name: Dependency Review
on: [pull_request]

permissions:
  contents: read

jobs:
  dependency-review:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Dependency Review
        uses: actions/dependency-review-action@v3
        with:
          fail-on-severity: moderate
          deny-licenses: GPL-2.0, LGPL-2.1
```

**Branch protection:**

Configure branch protection requiring dependency review passing before merge preventing vulnerable dependencies entering codebase.

## Security policies and advisories

**SECURITY.md file:**

Document security vulnerability reporting process:

Create `.github/SECURITY.md`:

```markdown
# Security Policy

## Supported Versions

| Version | Supported              |
| ------- | ---------------------- |
| 2.x     | ✅                     |
| 1.x     | ⚠️ Security fixes only |
| < 1.0   | ❌                     |

## Reporting a Vulnerability

**DO NOT** create public GitHub issues for security vulnerabilities.

Please report security vulnerabilities to: security@example.com

Include:

- Description of vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if available)

We will respond within 48 hours acknowledging receipt.

Expected timeline:

- Initial response: 48 hours
- Vulnerability confirmation: 1 week
- Fix development: 2-4 weeks
- Public disclosure: After fix released

## Security Update Process

1. Security team reviews report
2. Vulnerability confirmed/declined
3. Fix developed in private fork
4. Security advisory created
5. Fix released with CVE assignment
6. Public disclosure
```

**Private vulnerability reporting:**

Enable in repository **Settings** > **Code security and analysis** > **Private vulnerability reporting**.

Allows security researchers submitting vulnerabilities privately through GitHub interface instead of email.

**Security advisories:**

When security vulnerability discovered in your project:

1. Navigate to **Security** > **Advisories** > **New draft security advisory**.
2. Describe vulnerability, affected versions, severity (using CVSS scoring).
3. Collaborate privately with reporters developing fix.
4. Request CVE from GitHub.
5. Publish advisory when fix released.
6. Advisory appears in GitHub Advisory Database informing downstream users.

GitHub Advanced Security provides comprehensive security capabilities integrated throughout development workflow. Through code scanning, secret scanning, dependency management, and security policies, organizations achieve proactive security posture preventing vulnerabilities before reaching production. Next unit provides knowledge check assessing understanding of security monitoring and governance concepts.
