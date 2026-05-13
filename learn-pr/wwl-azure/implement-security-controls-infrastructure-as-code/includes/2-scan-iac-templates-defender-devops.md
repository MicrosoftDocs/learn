Infrastructure as code templates define security configurations before resources exist. Scanning them in the pipeline catches misconfigurations when they're cheapest to fix—during code review, not after deployment. In this unit, you learn how to configure **Microsoft Security DevOps (MSDO)** to scan Bicep, ARM template, and Terraform templates directly in GitHub Actions and Azure Pipelines, and how **Defender for DevOps** surfaces findings in Defender for Cloud.

| Scanning Approach | When It Runs | Use Case |
|-------------------|-------------|----------|
| Pipeline scanning (MSDO) | On every commit or PR | Enforce compliance before merge |
| Agentless scanning | Every 24 hours | Legacy repos or vendor-managed pipelines |

## Connect GitHub and Azure DevOps to Defender for Cloud

DevOps security in Defender for Cloud provides visibility into security posture across code repositories. Before you scan IaC templates in the pipeline, you connect your source control environment to Defender for Cloud so findings can surface in the centralized security dashboard.

To enable the connection, go to Defender for Cloud → **Environment settings** → **+ Add environment** → choose **GitHub** or **Azure DevOps**. For GitHub, the process requires a GitHub App installation on the organization or selected repositories. The installation creates a connector resource in Azure that links Defender for Cloud to your GitHub environment. For Azure DevOps, you authorize access using an OAuth authorization or Azure DevOps personal access token, which creates a similar connector resource.

After connection, Defender for Cloud ingests repository metadata and begins generating DevOps security recommendations. Recommendations include exposure of secrets in code, open-source component vulnerabilities, and IaC misconfigurations. All findings appear under the **Recommendations** screen in Defender for Cloud, filtered to the **DevOps** category.

## Microsoft Security DevOps (MSDO) extension—IaC scanning in the pipeline

**Microsoft Security DevOps (MSDO)** is an extension that runs security analysis tools directly in the CI/CD pipeline. It's available as a GitHub Action and as an Azure DevOps task, making it compatible with both major source control platforms.

For GitHub workflows, the action name is `microsoft/security-devops-action`. You use it as a step in the workflow YAML file. For Azure Pipelines, the task name is `MicrosoftSecurityDevOps@1`, and you use it as a step in the pipeline YAML file.

By default, MSDO runs multiple tool categories: secrets scanning, code analysis, container scanning, and IaC scanning. For infrastructure repositories where you only care about template compliance, you set the `categories: 'IaC'` input to scope the scan to IaC templates only. The scoped configuration keeps pipeline execution fast by skipping unrelated analyzers.

**GitHub Actions example:**

```yaml
- name: Run Microsoft Security DevOps
  uses: microsoft/security-devops-action@v1
  with:
    categories: 'IaC'
```

> [!NOTE]
> Pin the action to a specific version tag (such as `v1`) rather than `@latest`. Pinning prevents unexpected breaking changes from new releases silently affecting your pipeline. Check the [MSDO releases page](https://github.com/microsoft/security-devops-action/releases) for the current stable version.

**Azure DevOps Pipeline example:**

```yaml
- task: MicrosoftSecurityDevOps@1
  inputs:
    categories: 'IaC'
```

Findings from MSDO surface as **GitHub Code Scanning alerts** in GitHub repositories or as **pipeline annotations** in Azure DevOps builds. All findings are also ingested into Defender for Cloud under the **Recommendations** screen within 24 hours, giving security teams a centralized view of IaC compliance across all repositories.

## Template Analyzer and Checkov—the scanning engines

MSDO orchestrates multiple scanning tools internally. Two are most relevant for IaC template analysis: **Template Analyzer** and **Checkov**.

**Template Analyzer** analyzes ARM templates and Bicep files for Azure-specific security misconfigurations. It checks for common issues like storage accounts without secure transfer required, Transport Layer Security (TLS) minimum version not set to 1.2, diagnostic logs not enabled, public access on storage accounts, and network rules allowing all traffic.

**PSRule for Azure** is also available as a discrete tool within MSDO. You can run it independently by specifying it in the `tools` parameter alongside or instead of Template Analyzer. It applies Azure Well-Architected Framework and CAF rules to Bicep and ARM templates, providing a complementary rule set to Template Analyzer's security-focused checks.

**Checkov** is an open-source static analysis tool that supports Bicep, ARM template, Terraform, Kubernetes manifests, Dockerfiles, and Helm charts. It's useful in mixed-IaC environments where teams use multiple template languages across different cloud providers.

> [!NOTE]
> Template Analyzer focuses on Azure Resource Manager and Bicep files with Azure-specific checks. Checkov provides broader coverage across IaC languages and cloud providers. MSDO runs both automatically when category is set to 'IaC'.

## PR annotations and blocking noncompliant merges

After MSDO runs, findings surface in different locations depending on your platform:

- **GitHub**: findings appear as **Code Scanning alerts** under the repository's **Security** tab, and as a check result on the pull request. Select the check to see each finding with its severity and remediation guidance.
- **Azure DevOps**: findings appear as **pipeline annotations** in the build results, listing each violation with a link to remediation detail.

All findings are also ingested into Defender for Cloud recommendations within 24 hours, regardless of platform. Security engineers see exactly which property on which resource is noncompliant, with a link to remediation guidance.

You configure severity-based blocking in the **GitHub branch protection rules** or **Azure DevOps branch policy**. When you require the MSDO check to pass before merging, you enforce the shift-left model: the PR author must fix findings before the code reaches the main branch. You can allow specific severity levels through while blocking others. For example, you might block High and Critical findings but allow Low severity findings to pass without blocking, deferring review to a separate process.

Severity-based blocking prevents noncompliant infrastructure from ever reaching production. The template is corrected during code review, when the context is fresh and the fix is straightforward.

## Agentless scanning—alternative for existing repos

For teams that can't modify pipelines—because of legacy pipeline configurations, vendor-managed repositories, or organizational constraints—Defender for Cloud offers **agentless IaC scanning**.

Agentless scanning works differently from pipeline scanning. Instead of running as a pipeline task, Defender for Cloud scans GitHub and Azure DevOps repositories directly, without any pipeline extension or code change. The scan runs every 24 hours automatically, versus being triggered on every commit like pipeline scanning.

You control scope by selecting which organizations, projects, and repositories to include. Agentless scanning is useful for large enterprises with hundreds of repositories where you want centralized scanning without individual pipeline updates. Findings surface in the same Defender for Cloud recommendations screen as MSDO findings, creating a unified compliance view.

Agentless scanning and MSDO scanning are complementary, not redundant. Use both where possible: MSDO scanning provides fast feedback in the PR workflow, while agentless scanning provides centralized compliance visibility across all repos without pipeline dependencies.

To enable agentless IaC scanning on an existing connector:

1. Go to **Defender for Cloud** > **Environment settings** > select the GitHub or Azure DevOps connector.
2. Select **Settings** on the connector.
3. Under **DevOps threat landscape**, toggle **IaC scanning** to **On**.
4. Select which organizations, projects, or repositories to include, then save the configuration.

Defender for Cloud begins scanning the selected repositories within 24 hours. Findings appear in the **Recommendations** screen under the **DevOps** category, alongside any MSDO pipeline findings.
