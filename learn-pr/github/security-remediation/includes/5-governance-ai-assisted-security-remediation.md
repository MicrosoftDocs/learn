In this unit you'll learn:

- How organizations establish governance policies for security alert management.
- When alerts can be dismissed or accepted as risk.
- How GitHub Copilot Autofix can assist developers with vulnerability remediation.
- Why reviewing automated fixes is important before merging changes.

Consider the following scenario: A security team monitoring several repositories notices that many alerts remain unresolved for weeks. In some cases, developers dismiss alerts without documentation.
Without clear governance policies, it becomes difficult to understand which vulnerabilities were remediated, which were accepted as risk, and which were dismissed incorrectly.

### Why governance is necessary

As organizations adopt GitHub Advanced Security across many repositories, governance ensures that security alerts are handled consistently. Governance policies define who is authorized to review alerts, who can dismiss them, when additional security review is required, and how decisions related to risk acceptance are documented.

### Alert dismissal and risk acceptance

Not every alert requires remediation. In some cases, alerts may be dismissed if the vulnerability is a false positive, if the code exists only in test environments, or if the risk has already been mitigated through other controls. GitHub allows maintainers to dismiss alerts while recording the dismissal reason, and organizations often require additional documentation to ensure that these decisions remain transparent and auditable.

### Managing vulnerabilities across repositories

Security teams frequently monitor alerts across many repositories.
GitHub provides tools such as Security Overview that allow organizations to analyze vulnerability trends across repositories.

### Monitoring security posture

Security Overview dashboards display insights such as:

- Open alerts by severity

- Repositories with highest vulnerability counts

- Mean time to remediate

These dashboards help security teams identify where remediation efforts should be prioritized.

### Copilot Autofix in security remediation

A developer reviews a code scanning alert indicating a potential SQL injection vulnerability. Although the alert provides guidance, the developer is unsure how to safely modify the code.
Copilot Autofix can generate a suggested code change that resolves the vulnerability.

#### AI-assisted remediation

Copilot Autofix analyzes code scanning alerts and generates suggested fixes for supported vulnerabilities.
These suggestions appear directly in the alert interface, allowing developers to review and apply them within their workflow.

#### Reviewing Autofix suggestions

Although Autofix can accelerate remediation, developers should always review the suggested changes to ensure they address the root cause of the vulnerability, maintain the expected application behavior, and align with the overall project architecture.
When a supported alert is opened, Copilot may generate a suggested patch for the vulnerable code. Developers can review the suggestion and incorporate it into a pull request for team review.
After the suggested fix is applied and merged:

- Code scanning verifies the vulnerability has been resolved
- Alert status changes to Resolved
