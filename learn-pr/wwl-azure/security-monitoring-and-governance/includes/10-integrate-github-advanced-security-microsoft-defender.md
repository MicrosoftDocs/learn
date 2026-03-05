Organizations adopting DevSecOps practices require unified security visibility across entire software development lifecycle from source code through cloud deployments. **Microsoft Defender for DevOps** bridges development and operations security providing centralized security management for GitHub, Azure Repos, GitLab, and Azure DevOps environments. Integration between **GitHub Advanced Security** and **Microsoft Defender for Cloud** delivers comprehensive security posture management spanning code repositories, cloud infrastructure, and deployed workloads.

This integration provides security teams single pane of glass for managing code security findings, infrastructure vulnerabilities, and runtime threats. Development teams benefit from actionable security recommendations directly within GitHub while security operations teams gain visibility into code-level risks alongside cloud resource vulnerabilities in Defender for Cloud portal.

## Integration architecture

**Microsoft Defender for DevOps:**

Defender for DevOps is component of Microsoft Defender for Cloud providing continuous security monitoring for source code repositories and CI/CD pipelines.

**Capabilities:**

- **Repository security posture:** Assesses configuration security of GitHub organizations, repositories, and branches.
- **Code scanning integration:** Surfaces GitHub Advanced Security code scanning findings in Defender for Cloud.
- **Secret scanning integration:** Aggregates secret scanning alerts from GitHub into unified security view.
- **Dependency scanning integration:** Correlates Dependabot vulnerability alerts with cloud infrastructure dependencies.
- **IaC security:** Scans Infrastructure as Code (Terraform, Bicep, ARM templates) for misconfigurations.
- **Unified recommendations:** Provides security recommendations spanning code, pipelines, and infrastructure.
- **DevOps posture management:** Tracks security controls across development environment (branch protection, required reviews, security policies).

**Data flow:**

1. **GitHub Advanced Security** performs code scanning, secret scanning, dependency scanning in GitHub repositories.
2. **GitHub connector** installed in Defender for Cloud authenticates with GitHub API.
3. **Security findings** automatically synchronized from GitHub to Defender for Cloud.
4. **Defender for Cloud** correlates code findings with infrastructure vulnerabilities and runtime threats.
5. **Unified dashboard** displays comprehensive security posture across development and cloud environments.
6. **Recommendations** generated for remediation actions spanning code fixes and infrastructure changes.

## Onboarding GitHub to Defender for Cloud

**Prerequisites:**

- **Azure subscription** with Microsoft Defender for Cloud enabled.
- **Defender CSPM plan** enabled for DevOps security features.
- **GitHub organization** admin permissions.
- **GitHub Advanced Security** licenses for private repositories (public repositories have free access).

**Onboarding steps:**

**1. Enable Defender CSPM in Azure subscription:**

```bash
# Enable Defender CSPM plan
az security pricing create \
  --name CloudPosture \
  --tier Standard \
  --subscription <subscription-id>
```

**2. Connect GitHub organization:**

- Navigate to **Azure portal** > **Microsoft Defender for Cloud**.
- Select **Environment settings** from left navigation.
- Select **Add environment** > **GitHub**.
- Enter **connector name** identifying GitHub organization.
- Select **Azure subscription** where connector metadata stored.
- Select **resource group** for connector.
- Select **region** for connector.
- Enable **Defender CSPM** plan for advanced DevOps security features.
- Select **Next: Configure access**.

**3. Authorize Azure to access GitHub:**

- Select **Authorize** button redirecting to GitHub authorization page.
- Review requested permissions:
  - Read access to code, metadata, security events.
  - Write access for status checks and security alerts.
- Select **Authorize Microsoft Defender for Cloud**.

**4. Install Defender for Cloud GitHub App:**

- After authorization, select **Install** on GitHub App installation page.
- Choose **All repositories** or **Select repositories** for Defender access.
- Select repositories requiring security monitoring.
- Select **Install** confirming installation.

**5. Verify connection:**

- Return to Azure portal Defender for Cloud Environment settings.
- Verify GitHub connector appears with **Connected** status.
- Defender for Cloud automatically discovers repositories in connected organization.

**Discovery process:**

- **Repository scanning:** Defender for Cloud enumerates all accessible repositories.
- **Configuration assessment:** Evaluates repository security settings (branch protection, required reviews).
- **Dependency analysis:** Identifies direct and transitive dependencies from manifest files.
- **IaC detection:** Locates Infrastructure as Code files for security scanning.
- **Security findings import:** Imports existing GitHub Advanced Security findings.

## Unified security visibility

**Defender for DevOps dashboard:**

After onboarding, Defender for Cloud provides centralized DevOps security dashboard:

**DevOps Inventory:**

- **Repositories grouped by organization:** All connected GitHub repositories listed.
- **Security posture score:** Per-repository score based on security controls and findings.
- **Active findings:** Count of open code scanning, secret scanning, dependency scanning alerts.
- **Exposure level:** Risk assessment considering public/private visibility, branch protection, findings severity.

**Access dashboard:**

- Navigate to **Microsoft Defender for Cloud** > **DevOps Security**.
- View **Repositories** grouped by GitHub organization.
- Select repository for detailed security assessment.

**Security recommendations:**

Defender for Cloud generates actionable recommendations for GitHub repositories:

**Code security recommendations:**

- **"Code repositories should have code scanning enabled":** Ensures CodeQL or third-party scanning configured.
- **"Code repositories should have secret scanning enabled":** Verifies secret scanning active.
- **"Code repositories should have dependency scanning enabled":** Confirms Dependabot alerts enabled.
- **"Code scanning findings should be resolved":** Lists unresolved code vulnerabilities with severity, location, remediation guidance.
- **"Secrets in code should be remediated":** Identifies exposed credentials requiring rotation and removal.
- **"Vulnerable dependencies should be updated":** Lists outdated packages with known CVEs and recommended versions.

**Repository configuration recommendations:**

- **"GitHub organizations should have two-factor authentication required":** Enforces 2FA for all organization members.
- **"Repositories should require pull request reviews":** Ensures code review before merging.
- **"Repositories should require status checks before merging":** Blocks merges if security scans fail.
- **"Repositories should enable branch protection for default branch":** Prevents direct commits to main/master branches.
- **"Repositories should disable forking for private repositories":** Reduces exposure risk for sensitive code.

**Access recommendations:**

Navigate to **Recommendations** section filtering by **DevOps** resource type showing all GitHub-related recommendations.

## Code scanning integration

**GitHub Advanced Security code scanning** uses **CodeQL** semantic analysis engine identifying security vulnerabilities in source code.

**How integration works:**

1. **CodeQL workflow** runs in GitHub Actions scanning code on push/pull request.
2. **SARIF results** (Static Analysis Results Interchange Format) generated containing findings.
3. **Findings uploaded** to GitHub Security tab.
4. **Defender for Cloud connector** synchronizes findings via GitHub API.
5. **Findings appear** in Defender for Cloud Recommendations as **"Code scanning findings should be resolved"**.

**Viewing code findings in Defender:**

- Navigate to **Microsoft Defender for Cloud** > **Recommendations**.
- Filter by **DevOps** resource type.
- Select **"Code scanning findings should be resolved"** recommendation.
- View findings with:
  - **Severity:** Critical, high, medium, low.
  - **Repository and file path:** Exact location of vulnerability.
  - **Rule:** CodeQL query identifying issue (SQL injection, XSS, path traversal).
  - **Recommendation:** Fix guidance with code examples.
- Select finding to view detailed description and remediation steps.
- Select **View in GitHub** link navigating to GitHub Security tab for detailed code context.

**Remediation workflow:**

1. **Security team** reviews findings in Defender for Cloud.
2. **Assignment:** Delegates finding to development team member.
3. **Developer** navigates to GitHub via link in recommendation.
4. **Code fix:** Implements recommended remediation.
5. **Pull request:** Creates PR with fix including reference to finding.
6. **Re-scan:** CodeQL runs on PR verifying fix.
7. **Finding resolution:** Alert automatically closes in GitHub and Defender for Cloud.

## Secret scanning integration

**GitHub secret scanning** detects credentials, API keys, tokens exposed in code, commits, pull requests.

**Integration workflow:**

1. **Secret scanning** runs continuously on repository content.
2. **Secrets detected** generate alerts in GitHub Security tab.
3. **Alerts synchronized** to Defender for Cloud.
4. **Recommendation created:** **"Secrets in code should be remediated"** appears in Defender.

**Managing secrets in Defender:**

- Navigate to **Recommendations** > **"Secrets in code should be remediated"**.
- View detected secrets with:
  - **Secret type:** GitHub token, Azure connection string, AWS access key, generic API key.
  - **Repository and location:** File, commit, or pull request containing secret.
  - **Exposure status:** Whether secret committed to default branch or pull request.
- Select secret for remediation guidance:
  - **Rotate credential:** Generate new secret in source system (Azure Key Vault, AWS IAM).
  - **Revoke exposed secret:** Invalidate compromised credential.
  - **Remove from history:** Use `git filter-repo` or BFG Repo-Cleaner for committed secrets.

**Push protection:**

GitHub **secret scanning push protection** blocks commits containing secrets before reaching repository:

- Enable in **GitHub repository** > **Settings** > **Code security and analysis** > **Secret scanning** > **Push protection**.
- When developer attempts pushing commit with secret, push rejected with alert identifying secret type and location.
- Developer removes secret, stores in secure vault (Azure Key Vault, GitHub Secrets), retries push.
- Push protection events logged in GitHub audit log and synchronized to Defender for Cloud for compliance tracking.

## Dependency scanning integration

**GitHub Dependabot** analyzes dependencies in `package.json`, `requirements.txt`, `pom.xml`, `go.mod` and other manifest files identifying known vulnerabilities.

**Integration workflow:**

1. **Dependabot** scans dependencies daily or when manifest files change.
2. **Vulnerable dependencies** generate Dependabot alerts in GitHub Security tab.
3. **Alerts synchronized** to Defender for Cloud.
4. **Recommendation:** **"Vulnerable dependencies should be updated"** created.

**Viewing dependency findings:**

- Navigate to **Recommendations** > **"Vulnerable dependencies should be updated"**.
- View vulnerable packages with:
  - **Package name and version:** Affected dependency.
  - **CVE:** Common Vulnerabilities and Exposures identifier.
  - **Severity:** Based on CVSS score.
  - **Fixed version:** Recommended update version.
  - **Dependency path:** Direct or transitive dependency chain.

**Automated remediation:**

**Dependabot security updates** automatically creates pull requests updating vulnerable dependencies:

- Enable in **GitHub repository** > **Settings** > **Code security and analysis** > **Dependabot security updates**.
- When vulnerability detected, Dependabot creates PR updating package to secure version.
- PR includes CVE details, compatibility notes, release notes.
- CI/CD pipeline runs tests validating update.
- Developer reviews and merges PR resolving vulnerability.
- Alert automatically closes in GitHub and Defender for Cloud.

## Microsoft Security DevOps integration

**Microsoft Security DevOps (MSDO)** is command-line tool integrating multiple open-source security scanners into CI/CD pipelines.

**Supported tools:**

- **Bandit:** Python security linter.
- **BinSkim:** Binary analyzer for Windows executables.
- **ESLint:** JavaScript/TypeScript security plugin.
- **Template Analyzer:** ARM template security scanner.
- **Terrascan:** Terraform/IaC security scanner.
- **Trivy:** Container image vulnerability scanner.

**GitHub Actions integration:**

```yaml
# .github/workflows/security-scan.yml
name: Security Scan
on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    permissions:
      security-events: write # For SARIF upload

    steps:
      - uses: actions/checkout@v3

      - name: Run Microsoft Security DevOps
        uses: microsoft/security-devops-action@v1
        id: msdo

      - name: Upload results to Security tab
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: ${{ steps.msdo.outputs.sarifFile }}
```

**Results visibility:**

- **SARIF results** uploaded to GitHub Security tab.
- **Findings** appear alongside GitHub Advanced Security findings.
- **Defender for Cloud** imports MSDO findings via GitHub connector.
- **Unified view** shows all security findings (GitHub Advanced Security + MSDO) in Defender dashboard.

**Pipeline control:**

Use MSDO results controlling pipeline execution:

```yaml
- name: Run Microsoft Security DevOps
  uses: microsoft/security-devops-action@v1
  id: msdo
  continue-on-error: true

- name: Check for critical vulnerabilities
  run: |
    # Parse SARIF results, fail if critical findings exist
    if grep -q '"level": "error"' ${{ steps.msdo.outputs.sarifFile }}; then
      echo "Critical vulnerabilities found!"
      exit 1
    fi
```

## DevSecOps scenarios

**Scenario 1: Unified security review before deployment:**

Security team reviews all code and infrastructure changes before production deployment:

1. **Developer** creates pull request with code changes and updated Terraform.
2. **GitHub Actions** triggers:
   - CodeQL code scanning.
   - Secret scanning.
   - Dependabot dependency review.
   - Microsoft Security DevOps Terrascan for IaC.
3. **Findings** appear in GitHub PR checks and synchronized to Defender for Cloud.
4. **Security team** reviews consolidated findings in Defender for Cloud dashboard filtering by repository.
5. **Approval or rejection** based on security posture.
6. **Merge and deployment** proceeds only after all critical/high findings resolved.

**Scenario 2: Proactive vulnerability management:**

Security operations team monitors vulnerability trends across all repositories:

1. **Defender for Cloud dashboard** shows vulnerability metrics:
   - Total open findings by severity.
   - Repositories with most findings.
   - Trending vulnerability types (SQL injection, XSS, outdated dependencies).
2. **Security team** identifies repository with high vulnerability count.
3. **Investigation:** Drills down into findings, identifies root causes (lack of input validation library, outdated framework version).
4. **Remediation initiative:** Creates task for development team implementing secure coding library and dependency updates.
5. **Progress tracking:** Monitors finding resolution over time in Defender dashboard.

**Scenario 3: Compliance reporting:**

Organization requires demonstrating code security compliance for regulatory audit:

1. **Compliance officer** accesses Defender for Cloud regulatory compliance dashboard.
2. **DevOps security controls** displayed:
   - Code scanning enabled percentage across repositories.
   - Secret scanning coverage.
   - Branch protection enforcement.
   - Average time to remediate findings.
3. **Evidence export:** Exports compliance report showing security posture improvements over time.
4. **Audit submission:** Provides evidence of proactive security monitoring and vulnerability management.

The integration between GitHub Advanced Security and Microsoft Defender for Cloud delivers unified DevSecOps security providing visibility, actionable recommendations, and automated workflows spanning code repositories through cloud deployments. This comprehensive approach enables organizations to shift security left while maintaining centralized security operations, reducing risk and accelerating secure software delivery. The next unit explores configuring GitHub Advanced Security features in detail.
