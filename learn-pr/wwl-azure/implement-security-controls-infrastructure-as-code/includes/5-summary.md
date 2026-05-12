Remember the Contoso DevOps team deploying storage accounts without the HTTPS-only flag? Now the missing configuration never reaches production. A developer opens a pull request with a Bicep template, the Microsoft Security DevOps action runs Template Analyzer and Checkov, and the security finding appears as an inline annotation in the PR review. The developer fixes the configuration before merge, and even if they tried to deploy the noncompliant template manually, the Azure Policy Deny effect blocks it at the Azure Resource Manager layer.

You configured Microsoft Security DevOps to scan infrastructure as code in your CI/CD pipeline, surfacing findings directly in pull requests and feeding recommendations into Defender for Cloud. For repositories without pipeline integration, you enabled agentless scanning to run daily security checks with zero workflow changes. You applied Azure Policy Deny effects to create a platform-level enforcement layer that prevents noncompliant deployments regardless of how they're triggered. Finally, you explored Enterprise Policy as Code (EPAC) for managing policy definitions and assignments at management group scale through source control and continuous deployment.

You completed your implementation of security governance and regulatory compliance. The Contoso team started with resources deployed without security configurations. Contoso had backup vaults missing deletion protection, 37 identities with excessive access, and no automated security review for infrastructure as code. Across this learning path, you built policy enforcement and resource locks, standardized compliance baselines, right-sized role-based access control, protected backup infrastructure, and now prevent insecure configurations from deploying in the first place.

## Learn more

- [Defender for DevOps overview](/azure/defender-for-cloud/defender-for-devops-introduction)
- [Microsoft Security DevOps GitHub Action](/azure/defender-for-cloud/github-action)
- [Microsoft Security DevOps Azure DevOps extension](/azure/defender-for-cloud/azure-devops-extension)
- [IaC scanning with Microsoft Security DevOps](/azure/defender-for-cloud/iac-vulnerabilities)
- [Azure Policy as code](/azure/governance/policy/concepts/policy-as-code)
- [Enterprise Policy as Code (EPAC)](https://aka.ms/epac)
- [PSRule for Azure](https://azure.github.io/PSRule.Rules.Azure/)
