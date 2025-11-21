While secret scanning detects credentials already in your repository, push protection prevents secrets from entering your repository in the first place. This proactive approach stops security vulnerabilities before they become incidents requiring remediation.

## What is push protection?

GitHub push protection is a preventive security feature that blocks commits containing detected secrets from being pushed to a repository. When you attempt to push code containing a high-confidence secret, GitHub stops the push operation and displays an error message identifying the detected credential.

Think of push protection as a security gate between your local environment and the remote repository. It inspects every commit before allowing it through, blocking any commits containing secrets and requiring you to remediate the issue locally before proceeding.

## How push protection works

Push protection integrates seamlessly into the standard Git workflow while providing robust credential detection.

### The push protection process

When you push commits to a repository with push protection enabled:

1. **Push initiation**: You execute `git push` to upload commits to GitHub.

1. **Pre-receive analysis**: GitHub analyzes all commits in the push for secret patterns.

1. **Detection**: A high-confidence secret pattern is identified.

1. **Push rejection**: The push is rejected with an error message showing:

   - Secret type (for example, "Stripe API Key").
   - File path and line number.
   - Options for remediation or bypass.

The push rejection occurs before any commits are added to the remote repository, ensuring that the secret never enters the repository's history.

### Example push protection response

When push protection detects a secret, you see output similar to:

```bash
$ git push origin main
remote: 
remote: —————— GitHub Push Protection ——————
remote: 
remote: Secret found in the following locations:
remote: 
remote:   • src/PaymentProcessor.cs:15
remote:     - Secret type: Stripe API Key
remote:     - Detected: sk_live_51Abc123...
remote: 
remote: Push protection has blocked this push.
remote: 
remote: To push these commits, you must:
remote:   1. Remove the secret from the commits (recommended)
remote:   2. Request a bypass (requires justification)
remote: 
To https://github.com/user/repo.git
 ! [remote rejected] main -> main (push declined due to secret scanning)
error: failed to push some refs to 'https://github.com/user/repo.git'
```

### Detection criteria

Push protection uses the same secret patterns as secret scanning but applies stricter criteria:

- **High-confidence patterns only**: Detects secrets with well-defined, verifiable patterns to minimize false positives.
- **Active validation**: Verifies patterns match legitimate credential formats.
- **Context analysis**: Considers surrounding code to distinguish real secrets from test data.

This conservative approach focuses on preventing definite credential exposures while post-commit secret scanning catches lower-confidence patterns.

## Push protection availability

Push protection availability varies based on repository visibility and GitHub subscription level.

### Public repositories

For public repositories:

- **Enabled by default**: All new public repositories automatically have push protection enabled (as of 2024).
- **Free**: No cost associated with the feature.
- **Globally available**: Works for all users with public repositories.

### Private repositories

For private repositories, push protection requires GitHub Advanced Security:

- **GitHub Enterprise Cloud**: Available with Advanced Security license.
- **GitHub Enterprise Server**: Available with Advanced Security license.
- **Organization-level control**: Administrators enable protection at the organization or repository level.

For detailed instructions on enabling push protection, see [GitHub's push protection documentation](https://docs.github.com/en/code-security/secret-scanning/push-protection).

For detailed instructions on enabling push protection, see [GitHub's push protection documentation](https://docs.github.com/en/code-security/secret-scanning/push-protection).

## Handling push protection blocks

When push protection blocks a push, you have three options for resolution.

### Remove the secret (recommended)

The secure approach is to remove the secret from your commits:

1. **Identify the secret**: Review the error message to locate the file and line containing the secret.

1. **Remove the secret locally**: Edit the file to remove the hard-coded credential:

   ```csharp
   // Before (blocked by push protection)
   private const string StripeKey = "sk_live_51Abc123...";
   
   // After (reads from environment variable)
   private readonly string _stripeKey = Environment.GetEnvironmentVariable("STRIPE_API_KEY");
   ```

1. **Amend the commit**: If the secret is in your most recent commit:

   ```bash
   git add .
   git commit --amend --no-edit
   ```

1. **Rewrite history for older commits**: If the secret is in earlier commits, use interactive rebase:

   ```bash
   git rebase -i HEAD~5  # Adjust number based on how far back the commit is
   ```

   Mark the problematic commits for editing, remove the secret, and continue the rebase.

1. **Push successfully**: With the secret removed, push again:

   ```bash
   git push origin main
   ```

This approach ensures no secrets enter the repository history.

### Bypass protection (use with caution)

In limited circumstances, you might need to bypass push protection. Valid reasons include:

- **False positives**: The detected pattern isn't actually a secret (for example, test data, example documentation).
- **Already known exposure**: The secret is already exposed elsewhere and rotation is planned separately.
- **Legacy code migration**: Moving existing code with secrets (remediating secrets in a separate process).

To bypass push protection, GitHub provides a bypass option when viewing the blocked push error. You need to provide justification for the bypass.

> [!IMPORTANT]
> Bypassing push protection doesn't dismiss the secret scanning alert. The secret is still flagged in the Security tab and requires remediation. Use bypass only when necessary and ensure bypassed secrets are still rotated and properly secured.

### Allow the pattern

If your organization configures allowed patterns (exemptions for test credentials, known safe examples, or specific file paths), the pattern might be permitted automatically. Contact your organization's security team if you believe a pattern should be added to the allowed list.

## Interaction between secret scanning and push protection

Secret scanning and push protection work together as complementary layers of credential protection:

- **Push protection (proactive)**: Prevents secrets from entering the repository in the first place.
- **Secret scanning (detective)**: Catches secrets that bypass push protection or existed before push protection was enabled.

### Common scenarios

Understanding how these features interact helps you respond appropriately.

#### Both enabled, new secret

When both features are active and you attempt to commit a new secret, push protection prevents the issue entirely:

1. You attempt to push a commit with a secret.
1. Push protection blocks the push.
1. You remove the secret and successfully push.
1. No secret scanning alert is generated (secret never entered repository).

#### Push protection bypassed

When you bypass push protection, secret scanning still creates an alert that requires remediation:

1. You bypass push protection with justification.
1. The commit enters the repository.
1. Secret scanning generates an alert in the Security tab.
1. You must still remediate the exposed secret.

#### Secret committed before protection enabled

Historical secrets require manual cleanup even after enabling push protection:

1. Push protection is newly enabled.
1. Secret scanning finds the historical secret.
1. Alert appears in Security tab.
1. You must remove the secret from Git history.

#### Low-confidence pattern

Each security feature handles ambiguous patterns differently, providing layered detection:

1. You commit code with an ambiguous pattern.
1. Push protection allows the push (only blocks high-confidence secrets).
1. Secret scanning might generate an alert for review.
1. You assess whether it's a real secret.

### Best practices

To maximize protection effectiveness:

- **Enable both features**: Maximum protection requires both secret scanning and push protection.
- **Don't rely on bypass**: Treat bypass as an exceptional action requiring documentation.
- **Clean historical secrets**: Enabling push protection doesn't retroactively clean existing secrets; use secret scanning alerts to guide cleanup.
- **Mark test data clearly**: Comment test credentials to help both systems distinguish them from real secrets.

## Limitations and considerations

Understanding push protection's limitations can help you implement comprehensive security:

### Scope limitations

Push protection operates only at push time:

- **No local protection**: Secrets in local commits are undetected until you push.
- **Pattern-based detection**: Custom or proprietary credential formats unknown to GitHub might not be detected.
- **No protection for non-Git workflows**: Doesn't prevent secrets in manual file uploads or API-based repository changes.

### Workflow impact

Push protection requires immediate action:

- **Blocked pushes must be resolved**: You can't defer remediation like with post-commit alerts.
- **Potential workflow disruption**: Developers unfamiliar with secret management might find blocks frustrating.

Providing good documentation and training minimizes workflow disruptions while maintaining security.

### Complementary practices

Use other tools alongside push protection:

- **Pre-commit hooks**: Catch secrets locally before attempting to push.
- **Environment variable templates**: Provide `.env.example` files showing required variables without actual values.
- **Secret management libraries**: Use Azure Key Vault SDK, Amazon Web Services (AWS) Secrets Manager SDK, or similar tools.
- **Code review**: Train reviewers to watch for hard-coded credentials.
