In this unit you'll learn:

- How organizations prioritize remediation using vulnerability severity.
- How code scanning and secret scanning alerts are investigated and remediated in GitHub.
- How CodeQL scanning workflows help detect vulnerabilities during development.
- How exposed credentials should be handled and remediated.
- How remediation actions change the status of security alerts.

Consider the following scenario: A repository receives several security alerts:

- A critical dependency vulnerability
- A medium-severity input validation issue
- A low-severity code pattern warning

Although all three vulnerabilities should eventually be resolved, they do not require the same level of urgency. Security teams must determine which vulnerabilities should be addressed immediately and which can be scheduled during normal development cycles.

### Severity influences remediation strategy

Security alerts vary widely in their potential impact. Some vulnerabilities may expose production systems to immediate risk, while others represent lower-priority issues that can be addressed during routine development work.
Organizations often define remediation timelines aligned with vulnerability severity.
| Severity | Typical remediation response |
| --- | --- |
| Critical | Immediate remediation |
| High | Address within defined SLA |
| Medium | Resolve during development cycles |
| Low | Track as technical debt |
This model allows teams to focus resources on the vulnerabilities that present the greatest risk.

### Remediating code scanning alerts

Code scanning alerts identify insecure code patterns in application code.
When reviewing a code scanning alert, developers can inspect the affected file and vulnerability description directly within GitHub.
Developers typically resolve these alerts by modifying the vulnerable code and submitting the change through a pull request.

### Responding to exposed secrets

Secret scanning alerts indicate that a credential has been committed to the repository. Unlike code vulnerabilities, exposed credentials often require immediate remediation because they may allow unauthorized access to systems or services. Typical remediation actions include revoking the exposed credential, generating a replacement credential, and removing the secret from the repository history if necessary.
After remediation actions are completed, the alert status reflects the resolution. The code scanning or secret scanning alert changes to Resolved, security scans confirm that the vulnerability is no longer present, and the alert no longer appears in the repository Security tab.