While secret scanning detects credentials already in your repository, push protection prevents secrets from entering your repository in the first place. This proactive approach stops security vulnerabilities before they become incidents requiring remediation.

## What is push protection?

GitHub push protection is a preventive security feature that blocks commits containing detected secrets from being pushed to a repository. When you attempt to push code containing a high-confidence secret, GitHub stops the push operation and displays an error message identifying the detected credential.

Push protection operates at the boundary between your local environment and the remote repository, acting as a security gate that enforces secret-free code policies before changes are recorded in version control.

Think of push protection as a checkpoint that inspects every commit before allowing it into your repository. If a secret is detected, the checkpoint blocks entry and requires you to remediate the issue locally before proceeding.

## How push protection works

Push protection integrates seamlessly into the standard Git workflow while providing robust credential detection.

### The push protection process

When you push commits to a repository with push protection enabled:

1. **Local commit**: You commit changes locally including a file with a secret.
1. **Push initiation**: You execute `git push` to upload commits to GitHub.
1. **Pre-receive analysis**: GitHub analyzes all commits in the push for secret patterns.
1. **Detection**: A high-confidence secret pattern is identified.
1. **Push rejection**: The push is rejected with an error message.
1. **Notification**: You receive details about the detected secret, including:
   - Secret type (e.g., "Azure Storage Account Key").
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
remote: Push protection has blocked this push. Secrets detected in your 
remote: changes were found and push protection blocked this push.
remote: 
remote: To push these commits, you must:
remote:   1. Remove the secret from the commits (recommended)
remote:   2. Request a bypass (requires justification)
remote: 
remote: Learn more about push protection:
remote: https://docs.github.com/code-security/secret-scanning/push-protection
remote: 
To https://github.com/user/repo.git
 ! [remote rejected] main -> main (push declined due to secret scanning)
error: failed to push some refs to 'https://github.com/user/repo.git'
```

This detailed feedback helps you quickly locate and remove the secret.

### Detection criteria

Push protection uses the same secret patterns as secret scanning but applies stricter criteria:

- **High-confidence patterns only**: Only detects secrets with well-defined, verifiable patterns to minimize false positives.
- **Active validation**: Verifies patterns match legitimate credential formats.
- **Context analysis**: Considers surrounding code to distinguish real secrets from test data or examples.

Push protection is more conservative than post-commit secret scanning, focusing on preventing definite credential exposures while allowing potential false positives to be handled by post-commit scanning.

## Enabling push protection

Push protection can be enabled at the repository, organization, or enterprise level.

### Repository-level enablement

Repository administrators can enable push protection for individual repositories:

1. Navigate to the repository on GitHub.com.
1. Select **Settings** from the repository menu.
1. Select **Code security and analysis** from the sidebar.
1. Locate the **Push protection** section under Secret scanning.
1. Select **Enable** to activate push protection.

Once enabled, all pushes to the repository are analyzed for secrets.

### Organization-level enablement

Organization owners can enforce push protection across all repositories:

1. Navigate to organization settings.
1. Select **Code security and analysis**.
1. Configure push protection settings:
   - Enable for all new repositories automatically.
   - Enable for all existing repositories.
   - Require enablement for new repositories.

Organization-level policies ensure consistent security practices across all projects and teams.

### Default enablement for public repositories

As of 2024, GitHub enables push protection by default for all new public repositories. This policy change reflects GitHub's commitment to protecting the open-source ecosystem from credential exposure.

For public repositories:

- Push protection is enabled automatically at creation.
- Repository administrators can disable it (not recommended).
- The feature operates identically to manually enabled protection.

## Handling push protection blocks

When push protection blocks a push, you have several options for resolution.

### Option 1: Remove the secret (recommended)

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

### Option 2: Bypass protection (use with caution)

In limited circumstances, you may need to bypass push protection. Valid reasons include:

- **False positives**: The detected pattern isn't actually a secret (e.g., test data, example documentation).
- **Already known exposure**: The secret is already exposed elsewhere and rotation is planned separately.
- **Legacy code migration**: Moving existing code with secrets that will be remediated separately.

To bypass push protection:

1. **Via GitHub web interface**: When viewing the blocked push error, select the option to request a bypass.

1. **Provide justification**: Explain why bypassing is necessary. For example:
   - "This is test data, not a real credential."
   - "This key is already exposed in production; rotation is tracked in ISSUE-123."

1. **Complete the bypass**: Confirm the bypass, and the commit is allowed through.

**Important**: Bypassing push protection doesn't dismiss the secret scanning alert. The secret is still flagged in the Security tab and requires remediation.

Use bypass only when absolutely necessary. Each bypass should be documented and reviewed.

### Option 3: Use allowed patterns

Organizations can configure patterns that are exempt from push protection:

- Test credential patterns.
- Known safe examples.
- Specific file paths or directories (like test fixtures).

Repository or organization administrators configure these exemptions in security settings.

## Interaction between secret scanning and push protection

Secret scanning and push protection work together as complementary layers of credential protection.

### How they complement each other

- **Push protection (proactive)**: Prevents secrets from entering the repository in the first place.
- **Secret scanning (detective)**: Catches secrets that bypass push protection or existed before push protection was enabled.

Together, they provide defense in depth:

1. Push protection blocks most secrets at commit time.
1. Secret scanning catches anything that slips through or was committed before protection was enabled.
1. Both generate alerts that guide remediation.

### Scenarios and behavior

Understanding how secret scanning and push protection interact helps predict system behavior:

#### Scenario 1: Both enabled, new secret

A developer commits code with a new secret:

1. Developer attempts to push the commit.
1. Push protection detects the secret and blocks the push.
1. Developer removes the secret and successfully pushes.
1. No secret scanning alert is generated (secret never entered repository).

**Result**: Best case – secret prevented entirely.

#### Scenario 2: Secret scanning enabled, push protection disabled

A developer commits and pushes code with a secret:

1. Push succeeds without protection.
1. Secret scanning detects the credential in the repository history.
1. Alert appears in the Security tab.
1. Developer must remediate the exposed secret and remove it from Git history.

**Result**: Secret detected but remediation is more complex.

#### Scenario 3: Push protection bypassed

A developer bypasses push protection:

1. Developer commits code with a secret.
1. Push protection blocks the push.
1. Developer bypasses with justification.
1. Commit enters the repository.
1. Secret scanning generates an alert.

**Result**: Alert created despite bypass; requires remediation.

#### Scenario 4: Secret committed before protection enabled

A secret exists in repository history before push protection:

1. Push protection is newly enabled.
1. Secret scanning finds the historical secret.
1. Alert appears in Security tab.
1. Developer must remove secret from history.

**Result**: Existing secrets require cleanup regardless of protection.

#### Scenario 5: Low-confidence pattern

A potential secret with lower confidence:

1. Developer commits code with an ambiguous pattern.
1. Push protection allows the push (only blocks high-confidence secrets).
1. Secret scanning generates an alert for review.
1. Developer assesses whether it's a real secret.

**Result**: Layered detection catches uncertain patterns without blocking workflow.

### Practical implications

The interaction between these features affects your security workflow:

- **Enable both features**: Maximum protection requires both secret scanning and push protection.
- **Expect alerts after bypasses**: Any bypassed secret creates a secret scanning alert.
- **Clean historical secrets**: Enabling push protection doesn't retroactively clean existing secrets; use secret scanning alerts to guide cleanup.
- **Test data considerations**: Mark test credentials clearly to help both systems distinguish them from real secrets.

## Best practices for push protection

Implement these practices to maximize push protection effectiveness.

### Maintain enabled protection

Keep push protection enabled at all times:

- **Default to enabled**: Use organization policies to automatically enable protection for new repositories.
- **Resist disabling**: Only disable in exceptional circumstances with documented justification.
- **Re-enable promptly**: If temporarily disabled for migration or other reasons, re-enable as soon as possible.

### Minimize bypass usage

Treat bypass as an exceptional action:

- **Document all bypasses**: Maintain a log of when and why bypasses occur.
- **Require justification**: Enforce policies requiring clear reasons for bypassing.
- **Review bypass patterns**: If bypasses are frequent, investigate whether security processes need adjustment.
- **Remediate bypassed secrets**: Ensure that bypassed secrets are still rotated and properly secured.

### Educate developers

Ensure your development team understands push protection:

- **Training**: Provide guidance on why push protection exists and how to respond to blocks.
- **Documentation**: Maintain clear instructions for removing secrets from commits.
- **Tooling**: Provide developers with tools like environment variable templates and secret management SDK examples.
- **Support**: Make it easy for developers to ask questions when push protection blocks their work.

### Implement complementary practices

Push protection works best as part of comprehensive secret management:

- **Pre-commit hooks**: Use local Git hooks to catch secrets before attempting to push.
- **Environment variable templates**: Provide `.env.example` files showing required variables without actual values.
- **Secret management libraries**: Standardize on tools like Azure Key Vault SDK, AWS Secrets Manager SDK, or HashiCorp Vault.
- **Code review focus**: Train reviewers to watch for hard-coded credentials.

### Monitor and respond to protection events

Track push protection effectiveness:

- **Review bypass reasons**: Regularly assess whether bypasses indicate systemic issues.
- **Measure protection events**: Track how often protection blocks pushes as a metric of security awareness.
- **Adjust patterns**: Work with GitHub or organization security teams to refine detection patterns based on false positives.

## Limitations and considerations

Understanding push protection's limitations helps you implement additional security controls.

### Scope limitations

Push protection operates only at push time:

- **Doesn't protect local repositories**: Secrets in local commits are undetected until you push.
- **No protection for non-Git workflows**: Doesn't prevent secrets in manual file uploads or API-based changes.
- **Limited to known patterns**: Custom credential formats may not be detected.

### Workflow impact

Push protection can affect development workflows:

- **Blocked pushes require remediation**: Developers must take action immediately when secrets are detected.
- **Cannot defer resolution**: Unlike post-commit alerts, push protection requires immediate action to proceed.
- **Potential for frustration**: Developers unfamiliar with secret management may find blocks disruptive.

Providing good documentation and training minimizes workflow disruptions while maintaining security.

### False positive management

Although push protection uses high-confidence patterns, false positives can occur:

- **Test data**: Credentials in test files may trigger protection.
- **Documentation examples**: Example code showing credential formats may be blocked.
- **Legacy code**: Historical credential formats that are no longer active.

Use bypass for legitimate false positives, but document each case to ensure true secrets aren't inadvertently allowed.
