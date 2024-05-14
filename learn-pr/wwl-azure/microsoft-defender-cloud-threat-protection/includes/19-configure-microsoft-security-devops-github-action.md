Microsoft Security DevOps is a command line application that integrates static analysis tools into the development lifecycle. Security DevOps installs, configures, and runs the latest versions of static analysis tools such as, **Security Development Lifecycle (SDL)**, security and compliance tools. Security DevOps is data-driven with portable configurations that enable deterministic execution across multiple environments.

| **Name**                                                                | **Language**                                                                                                                                                                                       | **License**                                                                     |
| ----------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| [AntiMalware](https://www.microsoft.com/windows/comprehensive-security) | AntiMalware protection in Windows from Microsoft Defender for Endpoint, that scans for malware and breaks the build if malware has been found. This tool scans by default on windows-latest agent. | Not Open Source                                                                 |
| [Bandit](https://github.com/PyCQA/bandit)                               | Python                                                                                                                                                                                             | [Apache License 2.0](https://github.com/PyCQA/bandit/blob/master/LICENSE)       |
| [BinSkim](https://github.com/Microsoft/binskim)                         | Binary--Windows, ELF                                                                                                                                                                               | [MIT License](https://github.com/microsoft/binskim/blob/main/LICENSE)           |
| [ESlint](https://github.com/eslint/eslint)                              | JavaScript                                                                                                                                                                                         | [MIT License](https://github.com/eslint/eslint/blob/main/LICENSE)               |
| [Template Analyzer](https://github.com/Azure/template-analyzer)         | ARM Template, Bicep                                                                                                                                                                                | [MIT License](https://github.com/Azure/template-analyzer/blob/main/LICENSE.txt) |
| [Terrascan](https://github.com/accurics/terrascan)                      | Terraform (HCL2), Kubernetes (JSON/YAML), Helm v3, Kustomize, Dockerfiles, CloudFormation                                                                                                          | [Apache License 2.0](https://github.com/accurics/terrascan/blob/master/LICENSE) |
| [Trivy](https://github.com/aquasecurity/trivy)                          | container images, Infrastructure as Code (IaC)                                                                                                                                                     | [Apache License 2.0](https://github.com/aquasecurity/trivy/blob/main/LICENSE)   |

## Prerequisites

 -  An Azure subscription If you don’t have an Azure subscription, create a [free account](https://azure.microsoft.com/free/) before you begin.
 -  [Connect your GitHub repositories](/azure/defender-for-cloud/quickstart-onboard-github).
 -  Follow the guidance to set up [GitHub Advanced Security](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-settings-for-your-organization/managing-security-and-analysis-settings-for-your-organization) to view the DevOps posture assessments in Defender for Cloud.
 -  Open the [Microsoft Security DevOps GitHub action](https://github.com/marketplace/actions/security-devops-action) in a new window.
 -  Ensure that [Workflow permissions are set to Read and Write](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#setting-the-permissions-of-the-github_token-for-your-repository) on the GitHub repository. This includes setting "id-token: write" permissions in the GitHub Workflow for federation with Defender for Cloud.

## Configure the Microsoft Security DevOps GitHub action

**To setup GitHub action**:

1.  Sign in to [GitHub](https://www.github.com/).
2.  Select a repository you want to configure the GitHub action to.
3.  Select **Actions**.
    
    :::image type="content" source="../media/github-actions-729545c0.png" alt-text="Screenshot showing how to Configure the Microsoft Security DevOps GitHub action.":::
    
4.  Select **New workflow**.
5.  On the Get started with GitHub Actions page, select **set-up a workflow yourself**.:::image type="content" source="../media/new-workflow-de35682c.png" alt-text="Screenshot showing how to Get started with GitHub Actions.":::
    
6.  In the text box, enter a name for your workflow file. For example, `msdevopssec.yml`.
    
    :::image type="content" source="../media/devops-code-tab-45fbfec6.png" alt-text="Screenshot showing how to enter a name for your workflow file.":::
    
7.  Copy and paste the following [sample action workflow](https://github.com/microsoft/security-devops-action/blob/main/.github/workflows/sample-workflow.yml) into the Edit new file tab.
8.  Select **Start commit**.
    
    :::image type="content" source="../media/start-commit-774cb905.png" alt-text="Screenshot showing how to start the commit process for your workflows.":::
    
9.  Select **Commit new file**.
    
    :::image type="content" source="../media/commit-new-39cc2bad.png" alt-text="Screenshot showing how to Commit a new file.":::
    

    > [!NOTE]
    > The process can take up to one minute to complete.

10. Select **Actions** and verify the new action is running.
    
    :::image type="content" source="../media/verify-actions-b00b46ce.png" alt-text="Screenshot showing how to verify the new action is running.":::
    

## View Scan Results

To view your scan results:

1.  Sign in to [GitHub](https://www.github.com/).
2.  Navigate to **Security** &gt; **Code scanning alerts** &gt; **Tool**.
3.  From the dropdown menu, select **Filter by tool**.

Code scanning findings will be filtered by specific MSDO tools in GitHub. These code scanning results are also pulled into Defender for Cloud recommendations.
