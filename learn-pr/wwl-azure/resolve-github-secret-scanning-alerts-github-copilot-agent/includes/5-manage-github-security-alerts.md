GitHub centralizes all security findings in the Security tab of your repository, providing a unified dashboard for managing secret scanning alerts alongside code scanning results and dependency vulnerabilities. Understanding how to navigate and work with these alerts enables you to respond effectively to credential exposures.

## Accessing secret scanning alerts

The Security tab serves as the central hub for all security-related information about your repository.

### Navigate to security alerts

To access secret scanning alerts in your repository:

1. Open your repository on GitHub.com.
1. Select the **Security** tab from the repository navigation menu.
1. Select **Secret scanning** (or **Secret scanning alerts**) to view all detected secrets.

The Security tab provides a comprehensive view of your repository's security posture, making it easy to identify and prioritize issues.

### Security overview

The security overview displays:

- **Alert counts by type**: Numbers of secret scanning, code scanning, and Dependabot alerts
- **Open vs. resolved status**: Issues requiring attention versus those already addressed
- **Recent changes**: New alerts and recently resolved alerts

This high-level view helps you quickly assess repository security status and prioritize response efforts.

## Understanding secret scanning alerts

Each secret scanning alert provides detailed information about the detected credential to help you assess and remediate the exposure.

### Alert components

When you select a secret scanning alert, GitHub displays several key pieces of information.

#### Secret type

The category of credential detected, such as:

- "Azure Storage Account Key"
- "Stripe API Key"  
- "AWS Access Key"
- "GitHub Personal Access Token"
- "Database Connection String"

The secret type helps you understand which service is affected and what rotation actions are necessary.

#### Location information

Precise details about where the secret appears:

- **File path**: Complete path to the file containing the secret (e.g., `src/services/PaymentProcessor.cs`)
- **Line number**: Exact line where the secret is located
- **Branch**: Branch where the secret was detected
- **Commit**: Specific commit that introduced the secret (includes commit hash and author)

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

#### Validity status

For partner-validated secrets, GitHub indicates whether the credential is:

- **Valid**: The credential is confirmed active and functional
- **Invalid**: The credential has been revoked or is no longer active
- **Unknown**: Validity couldn't be determined

This status helps you prioritize remediation—valid credentials require immediate rotation.

### Alert states

Secret scanning alerts can be in several states:

- **Open**: The secret is detected and requires attention
- **Resolved**: The secret has been remediated (rotated and removed from code)
- **Dismissed**: The alert has been marked as a false positive or accepted risk

Understanding alert states helps you track progress in addressing security issues.

## Filtering and sorting alerts

When working with multiple alerts, filtering and sorting capabilities help you focus on specific issues.

### Filter by secret type

Filter alerts to focus on specific credential types:

1. In the secret scanning alerts view, locate the **Filter** options
1. Select **Secret type** from the filter menu
1. Choose one or more secret types to display (e.g., "AWS Access Key", "Azure credentials")

This helps when investigating specific types of exposures or conducting focused remediation.

### Filter by status

View alerts based on their resolution status:

- **Open alerts**: Secrets requiring investigation and remediation
- **Resolved alerts**: Previously detected secrets that have been addressed  
- **Dismissed alerts**: Alerts marked as false positives

Filtering by status helps you focus on active issues while maintaining visibility into historical security work.

### Sort and search

Sort the alert list by:

- **Newest first**: Recently detected secrets (default)
- **Oldest first**: Long-standing issues that may have been overlooked
- **Secret type**: Group similar credential types together

Use the search functionality to find alerts by file name, path, or secret type.

## Resolving secret scanning alerts

When you've successfully remediated a secret exposure, mark the alert as resolved to maintain accurate security records.

### Resolution requirements

An alert should be marked as resolved when you've completed these remediation steps:

1. **Rotated the credential**: The exposed secret has been revoked and replaced with a new one
1. **Removed from code**: The secret is no longer hard-coded in any commits (including Git history)
1. **Implemented secure storage**: The credential is now accessed through environment variables or a secret management service
1. **Verified functionality**: Applications using the rotated credential are functioning correctly

> [!IMPORTANT]
> Simply removing a secret from the latest commit isn't sufficient if it remains in Git history where it can still be discovered.

### How to resolve an alert

To mark an alert as resolved:

1. Navigate to the specific alert in the Security tab
1. Review the alert details to confirm remediation is complete
1. Select the **Close alert** dropdown
1. Choose a resolution reason:
   - **Revoked**: The credential has been rotated and is no longer valid
   - **False positive**: The detection was not an actual secret
   - **Used in tests**: Test data rather than a production credential
1. Optionally add a comment explaining the resolution
1. Confirm the resolution

The alert moves to the resolved state and no longer appears in the open alerts list.

### Removing secrets from Git history

Because Git preserves complete history, removing a secret from your current code doesn't eliminate the exposure. The credential remains accessible in historical commits.

#### For recent commits (not yet pushed)

If you haven't pushed the commits containing the secret:

```bash
# Amend the most recent commit
git add .
git commit --amend --no-edit

# For older commits, use interactive rebase
git rebase -i HEAD~5  # Adjust number based on commit depth
```

Mark the problematic commits for editing, remove the secret, and continue the rebase.

#### For commits already pushed

For commits already in the remote repository, you need to rewrite history using `git filter-repo` or similar tools:

```bash
# Install git-filter-repo if not available
pip install git-filter-repo

# Remove a specific string from all files in history
git filter-repo --replace-text <(echo "sk_live_51Abc123XYZ==>REDACTED")
```

After rewriting history, force-push the changes:

```bash
git push --force-with-lease origin main
```

> [!WARNING]
> Rewriting pushed history affects all collaborators. Coordinate with your team—they'll need to re-clone or carefully reset their local repositories after the force-push.

#### For public repositories

If a secret was exposed in a public repository:

1. **Immediately rotate** the credential—assume it's already compromised (public repos are continuously scanned)
1. Remove from Git history to prevent future discovery
1. Monitor for unauthorized usage of the old credential

## Working with false positives

Secret scanning occasionally detects patterns that aren't actual secrets. Properly handling false positives keeps your alert list focused on real issues.

### When to dismiss

Dismiss alerts only when you're certain they're not real secrets:

- **Test data**: Example credentials in test fixtures clearly marked as fake
- **Documentation**: Example code snippets showing credential formats without real values
- **Pattern coincidence**: Random strings that match secret patterns but aren't credentials

> [!CAUTION]
> Be conservative with dismissals. If there's any doubt whether a detected pattern is real, treat it as a secret and rotate it.

### How to dismiss

To dismiss a false positive:

1. Navigate to the alert in the Security tab
1. Review the alert carefully to confirm it's not a real secret
1. Select **Close alert** and choose **False positive**
1. Add a detailed comment explaining why it's not a real secret
1. Confirm the dismissal

Always document dismissals with clear justification for future reference and security audits.

Always document dismissals with clear justification for future reference and security audits.

## Best practices for alert management

Implement these practices to effectively manage secret scanning alerts.

### Respond quickly

When secret scanning detects a credential:

1. **Assess immediately**: Review the alert to confirm it's a real secret
1. **Rotate promptly**: Revoke and replace the exposed credential as soon as possible
1. **Remove from code**: Implement secure storage and remove the hard-coded secret
1. **Verify remediation**: Ensure applications work correctly with the rotated credential

The faster you respond, the smaller the window of opportunity for unauthorized access.

### Prioritize based on risk

Not all secrets have equal risk. Focus first on:

- **Valid credentials**: Alerts marked as "Valid" indicate active, functional secrets
- **Production systems**: Credentials for production environments over development
- **High-privilege access**: Administrative or elevated-privilege credentials
- **Public repositories**: Exposures in public repos where the secret is widely accessible

### Use alerts as learning opportunities

When secrets are detected:

- Understand how the secret ended up in code
- Identify gaps in development practices or tooling
- Share knowledge with your team about secure secret management
- Update templates and documentation to prevent similar exposures

### Leverage GitHub Copilot

GitHub Copilot can assist with alert remediation in two ways:

- **Ask mode**: Analyze alerts, understand exposure scope, and plan remediation strategies
- **Agent mode**: Implement code changes to remove hard-coded secrets and use secure storage

The following units explore using GitHub Copilot to streamline the alert resolution process.
