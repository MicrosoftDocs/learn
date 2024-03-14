Microsoft Security DevOps is a command line application that integrates static analysis tools into the development lifecycle. Security DevOps installs, configures, and runs the latest versions of static analysis tools such as, **Security Development Lifecycle (SDL)**, security and compliance tools. Security DevOps is data-driven with portable configurations that enable deterministic execution across multiple environments.

| **Name**          | **Language**                                                                                                                                                                                      | **License**        |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------ |
| AntiMalware       | AntiMalware protection in Windows from Microsoft Defender for Endpoint that scans for malware and breaks the build if malware has been found. This tool scans by default on windows-latest agent. | Not Open Source    |
| Bandit            | Python                                                                                                                                                                                            | Apache License 2.0 |
| BinSkim           | Binary--Windows, ELF                                                                                                                                                                              | MIT License        |
| ESlint            | JavaScript                                                                                                                                                                                        | MIT License        |
| Template Analyzer | ARM Template, Bicep                                                                                                                                                                               | MIT License        |
| Terra scan        | Terraform (HCL2), Kubernetes (JSON/YAML), Helm v3, Kustomize, Dockerfiles, CloudFormation                                                                                                         | Apache License 2.0 |
| Trivy             | container images, Infrastructure as Code (IaC)                                                                                                                                                    | Apache License 2.0 |

## Prerequisites

 -  An Azure subscription If you don’t have an Azure subscription, create a free account before you begin.
 -  Connect your GitHub repositories.<br>
 -  Follow the guidance to set up GitHub Advanced Security to view the DevOps posture assessments in Defender for Cloud.<br>
 -  Open the Microsoft Security DevOps GitHub action in a new window.<br>
 -  Ensure that Workflow permissions are set to Read and Write on the GitHub repository. This includes setting "id-token: write" permissions in the GitHub Workflow for federation with Defender for Cloud.<br>

## Configure the Microsoft Security DevOps GitHub action

**To setup GitHub action**:

1. Sign in to GitHub.<br>

2. Select a repository you want to configure the GitHub action to.<br>

3. Select **Actions**.

:::image type="content" source="../media/github-actions-729545c0.png" alt-text="Screenshot showing how to Configure the Microsoft Security DevOps GitHub action.":::


4. Select New workflow.

5. On the Get started with GitHub Actions page, select set-up a workflow yourself

:::image type="content" source="../media/new-workflow-de35682c.png" alt-text="Screenshot showing how to Get started with GitHub Actions.":::
6. In the text box, enter a name for your workflow file. For example, `msdevopssec.yml`.

:::image type="content" source="../media/devops-code-tab-45fbfec6.png" alt-text="Screenshot showing how to enter a name for your workflow file.":::


7. Copy and paste the following **sample action workflow** into the Edit new file tab.

`yml`

`name: MSDO windows-latest`

`on:`

`push:`

`branches:`

`- main`

``

`jobs:`

`sample:`

`name: Microsoft Security DevOps Analysis`

``

`# MSDO runs on windows-latest.`

`# ubuntu-latest also supported`

`runs-on: windows-latest`

``

`permissions:`

`contents: read`

`id-token: write`

``

`steps:`

``

`# Checkout your code repository to scan`

`- uses: actions/checkout@v3`

``

`# Run analyzers`

`- name: Run Microsoft Security DevOps Analysis`

`uses: microsoft/security-devops-action@latest`

`id: msdo`

`with:`

`# config: string. Optional. A file path to an MSDO configuration file ('*.gdnconfig').`

`# policy: 'GitHub' | 'microsoft' | 'none'. Optional. The name of a well-known Microsoft policy. If no configuration file or list of tools is provided, the policy may instruct MSDO which tools to run. Default: GitHub.`

`# categories: string. Optional. A comma-separated list of analyzer categories to run. Values: 'code', 'artifacts', 'IaC', 'containers'. Example: 'IaC, containers'. Defaults to all.`

`# languages: string. Optional. A comma-separated list of languages to analyze. Example: 'javascript,typescript'. Defaults to all.`

`# tools: string. Optional. A comma-separated list of analyzer tools to run. Values: 'bandit', 'binskim', 'eslint', 'templateanalyzer', 'terrascan', 'trivy'.`

``

`# Upload alerts to the Security tab`

`- name: Upload alerts to Security tab`

`uses: github/codeql-action/upload-sarif@v2`

`with:`

`sarif_file: ${{ steps.msdo.outputs.sarifFile }}`

``

`# Upload alerts file as a workflow artifact`

`- name: Upload alerts file as a workflow artifact`

`uses: actions/upload-artifact@v3`

`with:`

`name: alerts`

`path: ${{ steps.msdo.outputs.sarifFile }}`

8. Select **Start commit**.

:::image type="content" source="../media/start-commit-774cb905.png" alt-text="Screenshot showing how to start the commit process for your workflows.":::
9. Select **Commit new file**.

:::image type="content" source="../media/commit-new-39cc2bad.png" alt-text="Screenshot showing how to Commit a new file.":::


> [!NOTE]
> The process can take up to one minute to complete.

10. Select **Actions** and verify the new action is running.

:::image type="content" source="../media/verify-actions-b00b46ce.png" alt-text="Screenshot showing how to verify the new action is running.":::


## View Scan Results

**To view your scan results**:

1. Sign in to **GitHub**.<br>

2. Navigate to **Security** &gt; **Code scanning alerts** &gt; **Tool**.<br>

3. From the dropdown menu, select **Filter by tool**.<br>

Code scanning findings will be filtered by specific **Microsoft Security DevOps (MSDO)** tools in GitHub. These code scanning results are also pulled into Defender for Cloud recommendations.<br>
