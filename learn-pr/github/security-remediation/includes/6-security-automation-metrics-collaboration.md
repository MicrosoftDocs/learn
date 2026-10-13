In this unit you'll learn:

- How GitHub integrates security scanning into CI/CD workflows.
- How automation tools such as Dependabot help remediate vulnerabilities.
- How organizations track remediation performance using operational metrics.
- How development, security, and platform teams collaborate to manage security alerts.

Consider the following scenario: A development team frequently merges code changes before security teams have time to review them manually.
By integrating security scanning into CI pipelines, vulnerabilities can be detected automatically before code reaches production.

### Security scanning in pull requests

GitHub allows security scanning tools such as CodeQL to run automatically during pull request workflows.
This ensures vulnerabilities are detected before code is merged. Dependabot can automatically generate pull requests that update vulnerable dependencies.

### Preventing secret exposure

Secret scanning and push protection help prevent credentials from entering repositories. Push protection analyzes commits and warns developers if a credential pattern is detected.
After CI scanning is enabled:

- Security scans run automatically during pull requests
- Alerts appear before insecure code is merged
- Developers receive immediate feedback

### Tracking security metrics

Organizations often track metrics such as:

| Metric | Purpose |
| --- | --- |
| Open alerts by severity | Indicates risk exposure |
| Mean time to remediate | Measures remediation speed |
| SLA compliance | Tracks whether remediation targets are met |
| Vulnerability trends | Shows improvement or deterioration |

Example security dashboard:
Security Overview dashboards may display metrics such as:
Critical alerts: 3
High alerts: 9
Mean time to remediate: 3.8 days
Repositories affected: 5
These insights help security teams identify remediation priorities.

### DevSecOps collaboration model

Effective vulnerability management depends on collaboration between development and security teams.

#### Development team responsibilities

- Developers typically resolve vulnerabilities in application code and dependencies.
- Because GitHub surfaces security alerts directly in repositories, developers can investigate vulnerabilities within their normal workflows.

#### Security team responsibilities

Security engineers:

- Define vulnerability management policies
- Review high-severity alerts
- Monitor security posture across repositories

#### Platform engineering responsibilities

Platform engineers maintain the infrastructure that enables:

- Security scanning
- CI workflows
- Vulnerability monitoring

When collaboration workflows are established, vulnerabilities can be resolved more quickly, developers receive guidance on secure coding practices, and security teams maintain visibility across repositories.