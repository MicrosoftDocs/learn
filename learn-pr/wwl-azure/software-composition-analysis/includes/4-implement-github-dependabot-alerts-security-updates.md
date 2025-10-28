GitHub Dependabot provides automated dependency management integrated directly into GitHub repositories. Dependabot monitors dependencies for security vulnerabilities and outdated versions, alerting repository maintainers and automatically creating pull requests to update vulnerable or outdated dependencies. This integration makes dependency security accessible to all GitHub users without requiring separate tooling.

## Understanding GitHub Dependabot

GitHub Dependabot consists of three main features that work together to secure dependencies:

### Dependabot alerts

**Dependabot alerts** notify repository maintainers when vulnerable dependencies are detected. GitHub continuously monitors the GitHub Advisory Database and other vulnerability sources, comparing them against dependencies used in repositories.

**Alert triggers:**

- **New vulnerability disclosures:** Alerts are created when new vulnerabilities are added to the GitHub Advisory Database.
- **Advisory updates:** Existing alerts are updated when vulnerability information changes (severity, affected versions, patches).
- **Dependency graph changes:** New alerts are generated when code changes introduce vulnerable dependencies.
- **Mend vulnerability data:** Additional vulnerability intelligence from Mend (formerly WhiteSource) supplements the GitHub Advisory Database.

**Alert information includes:**

- **Vulnerability description:** Detailed explanation of the security issue.
- **Severity level:** CVSS score and severity classification (critical, high, moderate, low).
- **Affected versions:** Which dependency versions contain the vulnerability.
- **Patched versions:** Which versions fix the vulnerability.
- **CVE identifier:** Common Vulnerabilities and Exposures (CVE) identifier when available.
- **CWE classification:** Common Weakness Enumeration (CWE) type categorizing the vulnerability.
- **GitHub Security Advisory link:** Link to full advisory with additional details.

### Dependabot security updates

**Dependabot security updates** automatically create pull requests to update vulnerable dependencies to secure versions. When Dependabot alerts detect vulnerabilities with available patches, security updates can automatically generate pull requests fixing the vulnerabilities.

**Automatic pull request creation:**

- **Vulnerability-triggered:** Security updates create pull requests only when security vulnerabilities are detected, not for every dependency update.
- **Minimal version bumps:** Pull requests update dependencies to the minimum version that resolves the vulnerability while maintaining compatibility.
- **Compatibility scores:** GitHub calculates compatibility scores predicting whether updates will break existing functionality.
- **Release notes:** Pull requests include release notes and changelog information from updated dependencies.

**Pull request features:**

- **Automated testing:** Pull requests trigger existing CI/CD pipelines to validate that updates don't break functionality.
- **Vulnerability resolution:** Pull request descriptions explain which vulnerabilities are resolved by the update.
- **Update commands:** Special comments allow maintainers to control merge timing, rebase pull requests, or ignore specific updates.
- **Grouped updates:** Multiple vulnerable dependencies can be updated in a single pull request when appropriate.

### Dependabot version updates

**Dependabot version updates** keep dependencies up to date even when no vulnerabilities are present. Unlike security updates that only update vulnerable dependencies, version updates proactively update dependencies to latest versions based on configured schedules.

**Scheduled updates:**

- **Configurable frequency:** Updates can be scheduled daily, weekly, or monthly.
- **Update strategies:** Configure whether to update all dependencies, only direct dependencies, or specific dependency groups.
- **Version constraints:** Respect semantic versioning constraints defined in manifest files.
- **Pull request limits:** Control how many open pull requests Dependabot creates to avoid overwhelming maintainers.

## Enabling Dependabot alerts

Dependabot alerts are enabled by default for public repositories but must be manually enabled for private repositories.

### Enable alerts for a repository

**Navigation:**

1. Navigate to the repository on GitHub.
2. Click **Settings** in the repository menu.
3. Click **Security & analysis** in the left sidebar.
4. Locate the **Dependabot alerts** section.
5. Click **Enable** to activate Dependabot alerts.

**Dependency graph requirement:**
Dependabot alerts require the dependency graph to be enabled. The dependency graph is automatically enabled for public repositories but may need manual activation for private repositories.

**Enable dependency graph:**

1. In **Settings → Security & analysis**, locate **Dependency graph**.
2. Click **Enable** if the dependency graph is not already active.
3. GitHub will begin analyzing repository dependencies to build the dependency graph.

### Organization-wide enablement

Organization administrators can enable Dependabot alerts across all repositories:

**Organization settings:**

1. Navigate to organization **Settings**.
2. Click **Security & analysis** in the left sidebar.
3. Click **Enable all** next to Dependabot alerts to activate alerts for all current and future repositories.
4. Optionally select **Automatically enable for new repositories** to enable alerts for newly created repositories.

### Supported package ecosystems

Dependabot alerts support numerous package ecosystems including:

**Supported ecosystems:**

- **JavaScript:** npm (package.json, package-lock.json), Yarn (yarn.lock).
- **Python:** pip (requirements.txt, Pipfile, Pipfile.lock), Poetry (poetry.lock).
- **Ruby:** Bundler (Gemfile, Gemfile.lock).
- **Java:** Maven (pom.xml), Gradle (build.gradle, build.gradle.kts).
- **.NET:** NuGet (\*.csproj, packages.config, paket.dependencies).
- **Go:** Go modules (go.mod, go.sum).
- **PHP:** Composer (composer.json, composer.lock).
- **Rust:** Cargo (Cargo.toml, Cargo.lock).
- **Elixir:** Mix (mix.exs, mix.lock).
- **Dart/Flutter:** pub (pubspec.yaml, pubspec.lock).
- **Docker:** Dockerfiles (base image references).
- **GitHub Actions:** Workflow files (action versions).
- **Terraform:** Terraform configuration (module versions).

## Configuring Dependabot security updates

Dependabot security updates require explicit enablement even when alerts are enabled.

### Enable security updates

**Repository configuration:**

1. Navigate to **Settings → Security & analysis**.
2. Locate **Dependabot security updates**.
3. Click **Enable** to activate automatic security update pull requests.
4. Dependabot will begin monitoring for vulnerable dependencies and creating pull requests when patches are available.

**Organization-wide configuration:**

1. Navigate to organization **Settings → Security & analysis**.
2. Click **Enable all** next to Dependabot security updates.
3. Select **Automatically enable for new repositories** to enable for future repositories.

### Security update behavior

**Automatic pull request creation:**

- **Vulnerability detection:** When Dependabot alerts detect a vulnerable dependency with an available patch, security updates create a pull request.
- **Minimal updates:** Pull requests update only to the minimum version that resolves the vulnerability.
- **Semantic versioning:** Updates respect semantic versioning, preferring patch updates over minor or major updates when possible.
- **Testing integration:** Pull requests trigger existing CI/CD checks to validate updates.

**Compatibility scores:**
GitHub calculates compatibility scores indicating the likelihood that updates will break existing functionality:

- **High compatibility:** Update is likely safe based on analysis of similar repositories.
- **Medium compatibility:** Update might introduce breaking changes requiring review.
- **Low compatibility:** Update likely includes breaking changes requiring code modifications.
- **Unknown compatibility:** Insufficient data to assess compatibility.

**Pull request management:**

- **Automatic rebasing:** Dependabot automatically rebases pull requests when the base branch changes.
- **Conflict resolution:** Pull requests are closed if conflicts prevent automatic rebasing.
- **Superseding updates:** New pull requests supersede older pull requests when newer versions are released.
- **Scheduled updates:** Pull requests are created according to configured schedules to avoid overwhelming maintainers.

## Configuring Dependabot version updates

Version updates require a configuration file defining update schedules and behavior.

### Create dependabot.yml configuration

Version updates are configured using a `.github/dependabot.yml` file in the repository:

**Basic configuration:**

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
```

**Configuration options:**

- **version:** Configuration file schema version (always 2).
- **updates:** Array of update configurations for different package ecosystems.
- **package-ecosystem:** Package manager to monitor (npm, pip, bundler, maven, nuget, etc.).
- **directory:** Location of package manifest files (/ for root, or subdirectory path).
- **schedule.interval:** Update frequency (daily, weekly, monthly).
- **open-pull-requests-limit:** Maximum number of open pull requests Dependabot creates (default 5).

**Advanced configuration example:**

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
      day: "monday"
      time: "08:00"
      timezone: "America/New_York"
    open-pull-requests-limit: 10
    reviewers:
      - "team/frontend-developers"
    assignees:
      - "dependency-manager"
    labels:
      - "dependencies"
      - "npm"
    commit-message:
      prefix: "npm"
      include: "scope"
    ignore:
      - dependency-name: "lodash"
        versions: ["4.x"]
    allow:
      - dependency-type: "production"
```

**Advanced options:**

- **schedule.day:** Day of week for weekly updates (monday through sunday).
- **schedule.time:** Time of day for updates (24-hour format).
- **schedule.timezone:** Timezone for schedule (IANA timezone identifier).
- **reviewers:** GitHub users or teams automatically requested for pull request reviews.
- **assignees:** GitHub users automatically assigned to pull requests.
- **labels:** Labels automatically applied to pull requests.
- **commit-message.prefix:** Prefix for commit messages (helpful for conventional commits).
- **ignore:** Dependencies to ignore, optionally with specific version ranges.
- **allow:** Dependency types to update (production, development, all).

### Multiple package ecosystems

Repositories using multiple language ecosystems require separate update configurations:

**Multi-ecosystem configuration:**

```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/frontend"
    schedule:
      interval: "weekly"

  - package-ecosystem: "pip"
    directory: "/backend"
    schedule:
      interval: "weekly"

  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"

  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "monthly"
```

This configuration monitors npm dependencies in `/frontend`, Python dependencies in `/backend`, Docker base images throughout the repository, and GitHub Actions versions in workflows.

## Managing Dependabot pull requests

Dependabot pull requests support special commands for managing updates.

### Pull request commands

**Comment commands:**

- **`@dependabot rebase`:** Rebase the pull request against the current base branch.
- **`@dependabot recreate`:** Recreate the pull request, overwriting any manual edits.
- **`@dependabot merge`:** Merge the pull request once CI checks pass.
- **`@dependabot squash and merge`:** Squash commits and merge once checks pass.
- **`@dependabot cancel merge`:** Cancel a previously requested merge.
- **`@dependabot reopen`:** Reopen a closed pull request.
- **`@dependabot close`:** Close the pull request and prevent Dependabot from recreating it.
- **`@dependabot ignore this major version`:** Close the pull request and ignore future updates to this major version.
- **`@dependabot ignore this minor version`:** Close the pull request and ignore future updates to this minor version.
- **`@dependabot ignore this dependency`:** Close the pull request and ignore all future updates for this dependency.

### Reviewing and merging updates

**Review process:**

1. **Examine pull request description:** Understand which vulnerability is resolved or which version is updated.
2. **Review compatibility score:** Assess likelihood of breaking changes.
3. **Check CI/CD results:** Verify that automated tests pass successfully.
4. **Review release notes:** Understand changes included in the dependency update.
5. **Test locally if needed:** For major updates, test functionality locally before merging.
6. **Merge pull request:** Approve and merge the pull request to update the dependency.

**Automatic merging:**
For low-risk updates with high compatibility scores and passing tests, consider configuring automatic merging:

**GitHub Actions auto-merge:**

```yaml
name: Auto-merge Dependabot PRs
on: pull_request

jobs:
  auto-merge:
    runs-on: ubuntu-latest
    if: github.actor == 'dependabot[bot]'
    steps:
      - name: Enable auto-merge
        run: gh pr merge --auto --squash "$PR_URL"
        env:
          PR_URL: ${{ github.event.pull_request.html_url }}
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

This workflow automatically enables auto-merge for Dependabot pull requests that pass all required checks.

## Dependabot alerts and notifications

Dependabot provides multiple notification mechanisms for vulnerability alerts.

### Notification channels

**Web notifications:**

- **GitHub notifications:** Alerts appear in the GitHub notifications inbox.
- **Security tab:** Alerts are visible in the repository Security tab under Dependabot alerts.
- **Repository insights:** Dependency graph in Insights tab shows vulnerable dependencies.

**Email notifications:**

- **Digest emails:** Weekly summary emails listing new alerts.
- **Real-time emails:** Immediate emails for critical vulnerabilities.
- **Organization notifications:** Organization administrators receive notifications for all repositories.

**Custom notifications:**

- **Webhooks:** Configure webhooks to receive alert notifications in external systems.
- **GitHub API:** Query the Dependabot alerts API to programmatically retrieve alert information.
- **Security integrations:** Third-party security platforms can integrate with Dependabot alerts via API.

### Configuring notification preferences

**User notification settings:**

1. Navigate to GitHub **Settings → Notifications**.
2. Locate **Security alerts** section.
3. Configure notification preferences:
   - **Participating:** Receive notifications for repositories you're watching or participating in.
   - **Watching:** Receive notifications for all watched repositories.
   - **Email:** Enable email notifications for security alerts.
   - **Web:** Enable web notifications in GitHub UI.

**Organization notification settings:**

1. Navigate to organization **Settings → Security & analysis**.
2. Configure who receives security alert notifications:
   - **Organization owners:** Automatically receive all security alerts.
   - **Security managers:** Designated security team receives alerts.
   - **Repository administrators:** Each repository admin receives alerts for their repositories.

## Reviewing Dependabot alerts

The Security tab provides comprehensive alert management.

### Alert details

**Navigate to alerts:**

1. Open the repository on GitHub.
2. Click the **Security** tab.
3. Click **Dependabot alerts** in the left sidebar.
4. Review the list of active alerts.

**Alert information:**

- **Severity:** Critical, high, moderate, or low severity classification.
- **Package:** Affected dependency name and version.
- **Vulnerability:** CVE identifier and description.
- **Patched versions:** Versions that resolve the vulnerability.
- **Vulnerable code paths:** Whether the vulnerable code is actually used (if reachability analysis is available).
- **Auto-fix available:** Whether Dependabot can automatically create a pull request to fix the vulnerability.

### Managing alerts

**Alert actions:**

- **Review pull request:** If an automatic security update exists, review and merge the pull request.
- **Dismiss alert:** Dismiss false positives or accepted risks with a dismissal reason.
- **Snooze alert:** Temporarily dismiss alerts that can't be immediately addressed.
- **Reopen alert:** Reopen previously dismissed alerts if circumstances change.

**Dismissal reasons:**

- **Fix started:** Team is actively working on remediation.
- **No bandwidth:** Issue is acknowledged but can't be addressed currently.
- **Tolerable risk:** Vulnerability doesn't pose significant risk in this context.
- **Inaccurate:** Alert is a false positive.

## GitHub Advanced Security integration

GitHub Dependabot is a core component of **GitHub Advanced Security**, GitHub's comprehensive security platform that provides enterprise-grade security features for protecting your software supply chain.

### Advanced Security features

**Integrated security capabilities:**

- **Dependency scanning:** Dependabot automatically scans dependencies for known vulnerabilities using the GitHub Advisory Database and industry vulnerability databases.
- **Secret scanning:** Detects accidentally committed secrets, tokens, and credentials in repository code and history.
- **Code scanning:** Uses CodeQL and other analysis engines to find security vulnerabilities and coding errors in source code.
- **Security overview:** Provides organization-wide visibility into security alerts, vulnerabilities, and remediation status.
- **Supply chain security:** Dependency graph, dependency review, and SBOM generation for comprehensive supply chain visibility.

### Licensing and availability

**Advanced Security access:**

- **Public repositories:** All GitHub Advanced Security features are available for free on public repositories.
- **Private repositories:** Requires GitHub Advanced Security license (included with GitHub Enterprise Cloud and GitHub Enterprise Server).
- **GitHub Free/Team:** Dependabot alerts and security updates are available, but code scanning and secret scanning require Advanced Security licensing.

### Security overview dashboard

The Security overview provides organization-level visibility:

**Organization security metrics:**

- **Alert trends:** View security alert trends across all repositories over time.
- **Risk assessment:** Identify repositories with the highest security risk based on critical and high-severity alerts.
- **Team coverage:** Monitor which teams have security features enabled and track remediation progress.
- **Compliance reporting:** Generate reports for security compliance and audit requirements.

**Access security overview:**

1. Navigate to your organization on GitHub.
2. Click the **Security** tab.
3. Review organization-wide security metrics, alert counts, and trends.
4. Drill down into specific repositories or alert types for detailed investigation.

### Enabling Advanced Security

**For organization owners:**

1. Navigate to organization **Settings**.
2. Click **Code security and analysis**.
3. Enable **GitHub Advanced Security** for private repositories.
4. Configure default settings for:
   - Dependency graph (automatically enabled).
   - Dependabot alerts.
   - Dependabot security updates.
   - Secret scanning.
   - Code scanning (requires workflow configuration).

**Repository-level enablement:**

Individual repositories can enable or disable Advanced Security features:

1. Navigate to repository **Settings**.
2. Click **Code security and analysis**.
3. Enable desired security features:
   - **Dependency graph:** Required for Dependabot functionality.
   - **Dependabot alerts:** Vulnerability notifications.
   - **Dependabot security updates:** Automatic vulnerability fix pull requests.
   - **Secret scanning:** Credential leak detection.
   - **Code scanning:** Static application security testing (SAST).

### Integration with development workflows

GitHub Advanced Security integrates seamlessly with development processes:

**Pull request integration:**

- **Dependency review:** Automatically reviews dependency changes in pull requests, highlighting new vulnerabilities introduced by dependency updates.
- **Security checks:** Code scanning and secret scanning run automatically on pull requests, blocking merges if critical issues are found.
- **Required reviews:** Configure branch protection rules to require security team approval for pull requests with security alerts.

**Security policies:**

- **SECURITY.md:** Define vulnerability disclosure policies and security contact information.
- **Code owners:** Assign security team members as code owners for dependency files (package.json, requirements.txt, pom.xml).
- **Branch protection:** Require status checks for security scans before allowing merges.

**Audit and compliance:**

- **Audit log:** Track all security-related actions, including alert dismissals, feature enablement, and access changes.
- **Security policies:** Enforce organization-wide security standards across all repositories.
- **Compliance integration:** Export security data for SOC 2, ISO 27001, and other compliance frameworks.

GitHub Advanced Security provides enterprise-grade protection for your software supply chain, with Dependabot serving as the foundation for dependency security management. The platform's integrated approach ensures comprehensive vulnerability detection, automated remediation, and organization-wide security visibility.

GitHub Dependabot provides comprehensive, automated dependency security management integrated directly into GitHub workflows. By enabling alerts, security updates, and version updates, development teams can proactively address vulnerabilities and maintain up-to-date dependencies with minimal manual effort. The next unit explores how to integrate Software Composition Analysis checks into CI/CD pipelines beyond GitHub's built-in capabilities.
