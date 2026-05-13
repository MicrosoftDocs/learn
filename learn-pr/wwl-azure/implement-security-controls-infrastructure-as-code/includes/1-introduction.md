Contoso's DevOps team deploys 15 storage accounts in a single Bicep deployment. None of them have HTTPS-only transfer or secure transfer requirements enabled. Defender for Cloud flags all 15 as noncompliant within minutes of deployment—but by that time, they're already in production. The fix takes three hours of remediation work for what was a two-line Bicep change.

The problem isn't that the team was careless. The problem is that nobody checked the templates before deploy. The cheapest time to fix a security misconfiguration is before the template is committed—not after 15 resources are in production. Defender for Cloud sees post-deployment violations, but it can't catch them in the pipeline before deployment begins.

Here, you learn how to use **Microsoft Security DevOps (MSDO)** to scan infrastructure as code (IaC) templates in the CI/CD pipeline before deployment, catching misconfigurations while they're still in source control. You also learn how to use Azure Policy to enforce compliance as a platform-level backstop—even for deployments that bypass the pipeline entirely. Together, these two layers form a complete defense-in-depth model for IaC security.

## Learning objectives

By the end of this module, you're able to:

- Configure Microsoft Defender for DevOps and the MSDO extension to scan Bicep and ARM templates in GitHub Actions and Azure Pipelines.
- Interpret IaC scan results and identify misconfigurations before templates reach production.
- Configure Azure Policy in a policy-as-code workflow to enforce security compliance at IaC deployment time.
- Explain how pipeline scanning and Azure Policy work together as complementary defense-in-depth layers for IaC security.
