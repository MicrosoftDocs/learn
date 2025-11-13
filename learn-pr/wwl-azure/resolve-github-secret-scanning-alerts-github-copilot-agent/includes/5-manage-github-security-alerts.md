GitHub centralizes all security findings in the Security tab of your repository, providing a unified dashboard for managing secret scanning alerts, code scanning results, dependency vulnerabilities, and other security issues. Understanding how to navigate and manage these alerts enables you to respond effectively to credential exposures.

## Accessing the Security tab

The Security tab serves as the central hub for all security-related information about your repository.

### Navigate to security alerts

To access security alerts in your repository:

1. Open your repository on GitHub.com.
1. Select the **Security** tab from the repository navigation menu (alongside Code, Issues, Pull requests).
1. Review the security overview, which displays summary counts for different alert types.
1. Select **Secret scanning alerts** to view all detected secrets.

The Security tab provides a comprehensive view of your repository's security posture, making it easy to identify and prioritize issues.

### Security overview

The security overview dashboard displays:

- **Alert counts by type**: Numbers of secret scanning, code scanning, and Dependabot alerts.
- **Severity indicators**: Visual indicators showing critical, high, medium, and low severity issues.
- **Open vs. resolved**: Status of alerts that require attention versus those already addressed.
- **Trend information**: Recent changes in security posture (new alerts, resolved alerts).

This high-level view helps security teams quickly assess repository health and prioritize response efforts.

## Understanding secret scanning alerts

Each secret scanning alert provides detailed information about the detected credential and its context.

### Alert components

When you select a secret scanning alert, GitHub displays:

#### Secret type

The category of credential detected, such as:

- "Azure Storage Account Key"
- "Stripe API Key"
- "AWS Access Key"
- "GitHub Personal Access Token"
- "Database Connection String"

The secret type helps you understand which service or system is affected and what actions are necessary (credential rotation, access review, etc.).

#### Location information

Precise details about where the secret appears:

- **File path**: The complete path to the file containing the secret (e.g., `src/services/PaymentProcessor.cs`).
- **Line number**: The exact line where the secret is located.
- **Branch**: The branch where the secret was detected.
- **Commit**: The specific commit that introduced the secret (includes commit hash and message).

This information enables you to quickly locate the problematic code and understand when the exposure occurred.

#### Code snippet

A preview of the code containing the secret, with the credential highlighted:

```csharp
// Example alert code snippet
public class PaymentService
{
    // SECRET DETECTED: Stripe API Key
    private const string _apiKey = "sk_live_51Abc123XYZ789...";
    
    public async Task ProcessPayment(...)
    {
        // Payment processing logic
    }
}
```

The code snippet provides immediate context about how the secret is used in the application.

#### Detection metadata

Additional information about the alert:

- **Detection date**: When GitHub first identified the secret.
- **Detection method**: Whether found through historical scanning or push-time detection.
- **Validation status**: For partner-validated secrets, whether the credential is confirmed active.
- **Provider notification**: Whether the secret's service provider was notified.

#### Severity and priority

Secret scanning alerts are typically marked as **Critical** because exposed credentials represent immediate security risks. Unlike code vulnerabilities that require specific conditions to exploit, exposed credentials provide direct access to protected resources.

### Alert states

Secret scanning alerts can be in several states:

- **Open**: The secret is detected and requires attention.
- **Resolved**: The secret has been remediated (rotated, removed from code, or otherwise secured).
- **Dismissed**: The alert has been marked as a false positive or accepted risk.

Understanding alert states helps you track progress in addressing security issues.

## Filtering and sorting alerts

As repositories accumulate security findings, filtering and sorting capabilities help you focus on the most important issues.

### Filter by secret type

Filter alerts to focus on specific credential types:

1. In the secret scanning alerts view, locate the **Filter** options.
1. Select **Secret type** from the filter menu.
1. Choose one or more secret types to display (e.g., "AWS Access Key", "Database credentials").

This helps when responding to a specific incident (like a compromised AWS account) or conducting focused security reviews.

### Filter by status

View alerts based on their resolution status:

- **Open alerts**: Secrets that require investigation and remediation.
- **Resolved alerts**: Previously detected secrets that have been addressed.
- **Dismissed alerts**: Alerts marked as false positives or accepted risks.

Filtering by status helps you focus on active issues requiring attention while maintaining visibility into historical security work.

### Sort alerts

Sort the alert list by different criteria:

- **Newest first**: See recently detected secrets (default).
- **Oldest first**: Identify long-standing issues that may have been overlooked.
- **Secret type**: Group similar credential types together.

Sorting helps prioritize remediation efforts based on age, type, or discovery order.

### Search alerts

Use the search functionality to find specific alerts:

- Search by file name or path.
- Search by commit hash or message.
- Search by secret type or pattern.

Search is particularly useful in large repositories with many alerts.

## Resolving secret scanning alerts

When you've successfully remediated a secret exposure, mark the alert as resolved to track progress and maintain accurate security records.

### What constitutes resolution?

An alert should be marked as resolved when you've completed all remediation steps:

1. **Rotated the credential**: The exposed secret has been revoked and replaced with a new one.
1. **Removed from code**: The secret is no longer hard-coded in any commits (including history).
1. **Implemented secure storage**: The credential is now accessed through environment variables, secret management service, or other secure method.
1. **Verified functionality**: Applications using the rotated credential are functioning correctly.

Simply removing a secret from the latest commit isn't sufficient if it remains in Git history where attackers could find it.

### How to resolve an alert

To mark an alert as resolved:

1. Navigate to the specific alert in the Security tab.
1. Review the alert details to confirm remediation is complete.
1. Select the **Resolve** button.
1. Choose a resolution reason:
   - **Revoked**: The credential has been rotated and is no longer valid.
   - **Used in tests**: The secret is test data, not a production credential (consider this carefully).
1. Optionally add a comment explaining the resolution.
1. Confirm the resolution.

The alert moves to the resolved state and no longer appears in the open alerts list.

### Removing secrets from Git history

Because Git preserves complete history, removing a secret from your current code doesn't eliminate the exposure. Attackers can still access historical commits containing the credential.

To fully remediate:

#### For recent commits (not yet pushed)

Use `git commit --amend` or interactive rebase:

```bash
# Amend the most recent commit
git add .
git commit --amend --no-edit

# For older commits, use interactive rebase
git rebase -i HEAD~5  # Adjust number as needed
```

#### For commits already pushed

Use `git filter-repo` (recommended) or `git filter-branch` to rewrite history:

```bash
# Install git-filter-repo if not already available
pip install git-filter-repo

# Remove a specific file from entire history
git filter-repo --invert-paths --path path/to/file/with/secret.cs

# Remove a specific string from all files
git filter-repo --replace-text <(echo "sk_live_51Abc123XYZ==>REDACTED")
```

**Warning**: Rewriting history requires force-pushing and affects all collaborators. Coordinate with your team:

```bash
git push --force-with-lease origin main
```

All team members must re-clone or carefully reset their local repositories after history rewriting.

#### For public repositories

If a secret was exposed in a public repository:

1. Assume the secret is compromised (public repositories are continuously scanned by bots).
1. Immediately rotate the credential before attempting to remove it from history.
1. Remove from history to prevent future discovery, but understand the credential may already be captured.
1. Monitor for unauthorized usage of the credential.

## Dismissing false positives

Occasionally, secret scanning detects patterns that aren't actual secrets. Properly handling false positives keeps your alert list clean and focused on real issues.

### When to dismiss

Dismiss alerts only when you're certain they're not real secrets:

- **Test data**: Example credentials in test fixtures clearly marked as fake.
- **Documentation**: Example code snippets showing credential formats without real values.
- **Pattern coincidence**: Random strings that happen to match secret patterns but aren't credentials.

Be conservative with dismissals. If there's any doubt whether a detected pattern is a real secret, treat it as real and rotate it.

### How to dismiss an alert

To dismiss a false positive:

1. Navigate to the alert in the Security tab.
1. Review the alert carefully to confirm it's not a real secret.
1. Select the **Dismiss** button.
1. Choose a dismissal reason:
   - **False positive**: Not a real secret, just a pattern coincidence.
   - **Used in tests**: Test data or fixtures (use carefully).
   - **Won't fix**: Accepted risk with documented justification (rare).
1. Add a detailed comment explaining why the alert is dismissed.
1. Confirm the dismissal.

The alert moves to the dismissed state and no longer appears in open alerts.

### Document dismissals

Always include clear justification when dismissing alerts:

- Explain why the pattern isn't a real secret.
- Reference relevant code comments or documentation.
- Note any verification steps taken.

Documentation helps future security reviews and audits understand why certain alerts were dismissed.

## Best practices for ongoing alert management

Effective security requires continuous monitoring and systematic response to alerts.

### Establish a response workflow

Create a standardized process for handling secret scanning alerts:

1. **Immediate notification**: Configure alerts to notify security teams immediately when secrets are detected.
1. **Initial assessment**: Within 1 hour, review the alert to confirm it's a real secret and assess the exposure scope.
1. **Credential rotation**: Within 4 hours, rotate the compromised credential.
1. **Code remediation**: Within 24 hours, remove the secret from code and implement secure storage.
1. **Alert resolution**: Mark the alert as resolved once all remediation steps are complete.

Adjust these timeframes based on your organization's security requirements and operational constraints.

### Make alert review routine

Integrate security alert review into regular development processes:

- **Daily standup**: Mention new security alerts as part of team status.
- **Sprint planning**: Allocate time for security remediation work.
- **Code review**: Check for open alerts affecting files being modified.
- **Release process**: Ensure no open secret scanning alerts before deploying.

Regular review prevents alerts from accumulating and becoming overwhelming.

### Prioritize critical alerts

Not all secrets have equal risk. Prioritize remediation based on:

- **Production vs. development**: Production credentials are highest priority.
- **Privilege level**: Administrative or high-privilege credentials require immediate action.
- **Exposure scope**: Public repository exposures are more critical than private repository exposures.
- **Service criticality**: Secrets for critical business services take precedence.

### Monitor alert trends

Track secret scanning metrics over time:

- **New alerts per week**: Increasing trends may indicate inadequate developer training or tooling.
- **Resolution time**: How quickly secrets are remediated after detection.
- **Recurring patterns**: Repeated exposures of similar credential types suggest systemic issues.
- **Bypass frequency**: High bypass rates for push protection may indicate usability issues.

Use metrics to guide improvements in security practices, developer education, and tooling.

### Implement preventive measures

Use alerts as learning opportunities to prevent future exposures:

- **Developer training**: When secrets are detected, provide targeted training to the responsible developers.
- **Template updates**: Improve starter templates and documentation to guide secure practices.
- **Pre-commit hooks**: Deploy local scanning tools that catch secrets before they're committed.
- **Code review checklists**: Add secret detection to code review criteria.

### Verify remediation effectiveness

After resolving an alert, confirm that the remediation was effective:

- **Test credential rotation**: Verify that applications work with the new credential.
- **Confirm removal from history**: Check that the secret no longer appears in any branch or commit.
- **Scan with additional tools**: Use other secret scanning tools to verify GitHub didn't miss related exposures.
- **Monitor for usage attempts**: Watch for unauthorized attempts to use the exposed credential.

### Maintain documentation

Keep records of secret exposures and remediations:

- **Incident timeline**: Document when secrets were exposed, detected, and remediated.
- **Lessons learned**: Note what led to the exposure and how to prevent similar incidents.
- **Process improvements**: Track changes made to development practices based on incidents.

Documentation supports compliance requirements, security audits, and continuous improvement efforts.

## Integrating alerts with other systems

GitHub supports integration with external security and workflow tools.

### Webhook notifications

Configure webhooks to send secret scanning alerts to:

- Security information and event management (SIEM) systems.
- Incident response platforms.
- Team communication tools (Slack, Microsoft Teams).
- Ticketing systems (Jira, ServiceNow).

Webhooks ensure security teams receive immediate notification through their preferred tools.

### API access

Use the GitHub REST API to:

- Programmatically retrieve secret scanning alerts.
- Update alert status from automated workflows.
- Generate security reports and dashboards.
- Integrate with custom security tooling.

API access enables custom automation and integration with organization-specific security platforms.

### Security advisories

For serious exposures that affect users or customers:

- Consider publishing security advisories through GitHub's security advisory feature.
- Notify affected parties about potential exposure.
- Provide guidance for users to rotate their credentials.

Transparency about security incidents builds trust and helps users protect themselves.
