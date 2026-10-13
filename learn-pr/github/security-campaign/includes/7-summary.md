Security campaigns in GitHub Advanced Security provide a structured way for organizations to coordinate remediation of security alerts across multiple repositories. Instead of handling alerts individually, teams group related findings into campaigns to focus on specific risk areas and track remediation progress at scale.

GitHub generates security signals through features such as code scanning, secret scanning, and dependency scanning. These signals appear as alerts at the repository level and are aggregated in **Security and Quality**, which provides organization-wide visibility into risk, trends, and alert distribution.

Security campaigns use this aggregated alert data to help teams scope remediation efforts, assign ownership, and track resolution over time. Developers then resolve issues using standard GitHub workflows, primarily through pull requests and dependency updates. Alerts automatically update as changes are merged, allowing campaigns to reflect real-time remediation progress.

Alongside remediation, GitHub supports a prevention-first approach through controls such as push protection, pull request scanning, and dependency review. These controls reduce the introduction of new vulnerabilities before they reach production.

When combined, security campaigns and prevention-first controls enable organizations to move from reactive alert handling to structured coordination and finally toward preventive security practices that reduce long-term risk.

This creates a continuous improvement cycle:

**Identify → Remediate → Prevent → Measure → Repeat**

Over time, organizations see fewer recurring vulnerabilities, reduced alert volume, and more focused remediation efforts.

## Key takeaways

At the end of this module, you can:

- Define a security campaign in the context of GitHub Advanced Security
- Explain how alerts are aggregated and used for coordinated remediation
- Describe how teams remediate vulnerabilities using GitHub workflows
- Understand how prevention-first controls reduce future security risk
- Evaluate campaign success using alert trends and remediation metrics

## References

- [About security campaigns](https://docs.github.com/en/code-security/concepts/security-at-scale/about-security-campaigns)
- [Creating and managing security campaigns](https://docs.github.com/en/code-security/how-tos/manage-security-alerts/remediate-alerts-at-scale/creating-managing-security-campaigns)
- [Tracking security campaigns](https://docs.github.com/en/code-security/how-tos/manage-security-alerts/remediate-alerts-at-scale/tracking-security-campaigns)
- [About security overview](https://docs.github.com/en/code-security/security-overview/about-security-overview)
- [Managing code scanning alerts](https://docs.github.com/en/code-security/code-scanning/managing-code-scanning-alerts)
- [About secret scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning)
- [About Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)
- [Push protection for secret scanning](https://docs.github.com/en/code-security/secret-scanning/push-protection-for-secret-scanning)
