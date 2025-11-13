GitHub Secret Scanning automatically detects exposed credentials in your repository, helping you discover and remediate security vulnerabilities before attackers can exploit them. Understanding how secret scanning works enables you to leverage this powerful security feature effectively.

## What is GitHub secret scanning?

GitHub Secret Scanning is an automated security feature that continuously monitors your repositories for exposed credentials and authentication tokens. When secret scanning detects a known secret pattern, it generates an alert that notifies repository administrators and security teams about the potential exposure.

Secret scanning operates on two levels:

- **Repository scanning**: Checks the entire Git history and all branches for secrets.
- **Real-time push protection**: Analyzes commits before they're pushed to prevent secrets from entering the repository.

Think of secret scanning as a vigilant security guard that continuously watches for credentials appearing anywhere in your code, whether in new commits, historical changes, or existing branches.

## How secret scanning works

Secret scanning uses pattern matching and validation techniques to identify credentials in your codebase with high accuracy.

### Detection mechanism

GitHub maintains an extensive database of secret patterns for over 200 different service providers and token types. When you push code to a repository with secret scanning enabled, GitHub:

1. Analyzes all files in the commit.
1. Compares content against known secret patterns using regular expressions.
1. Validates detected patterns to reduce false positives.
1. Generates alerts for high-confidence matches.

The scanning process operates on the following content:

- Source code files in all programming languages.
- Configuration files (JSON, YAML, XML, etc.).
- Documentation and markdown files.
- Scripts and shell files.
- Container definitions and infrastructure as code.

### Partner verification

For many supported secrets, GitHub partners with service providers to validate detected credentials. This verification process achieves the following goals:

- Confirms that a detected pattern is a valid, active credential.
- Notifies the service provider about the exposed credential.
- Enables automatic revocation of the compromised credential.
- Reduces false positive alerts.

For example, if secret scanning detects an AWS access key, GitHub can verify with Amazon that the key is valid and active. Amazon receives a notification and can automatically rotate the compromised credential.

### Historical scanning

When you enable secret scanning on a repository, GitHub doesn't just scan new commits. It analyzes the entire repository history across all branches:

- Every commit ever made to the repository.
- All branches, including merged and deleted branches.
- Forked repositories (in some cases).

This comprehensive approach ensures that secrets committed months or years ago are detected, even if they were later removed from the current codebase.

## Secret scanning coverage

Secret scanning detects a wide range of credential types from major service providers.

### Supported secret types

GitHub's secret scanning detects credentials from over 200 different service providers, including:

#### Cloud service providers

- **Azure**: Storage account keys, SQL connection strings, Service Bus connection strings, App Service publishing credentials, Function keys.
- **AWS**: Access keys, secret access keys, Session tokens, AWS API keys.
- **Google Cloud**: API keys, Service account keys, OAuth tokens.

#### Payment services

- **Stripe**: Publishable keys, secret keys, restricted keys.
- **PayPal**: Client IDs and secrets, API credentials.
- **Square**: Access tokens, OAuth credentials.

#### Development and collaboration platforms

- **GitHub**: Personal access tokens, OAuth tokens, App installation tokens.
- **GitLab**: Personal access tokens, Project access tokens.
- **Bitbucket**: App passwords, OAuth credentials.

#### Communication services

- **SendGrid**: API keys.
- **Twilio**: Account SIDs, Auth tokens.
- **Slack**: Webhook URLs, Bot tokens, OAuth tokens.

#### Databases

- **MongoDB**: Connection strings with embedded credentials.
- **PostgreSQL**: Connection strings.
- **MySQL**: Connection strings.
- **Redis**: Connection URLs with passwords.

#### Other services

- **Datadog**: API keys, Application keys.
- **New Relic**: License keys, API keys.
- **Sentry**: DSN strings with auth tokens.

The full list of supported patterns is maintained by GitHub and continuously expanded as new services and credential types emerge.

### Pattern detection accuracy

Secret scanning uses sophisticated pattern matching to minimize false positives while ensuring comprehensive detection:

- **High-confidence patterns**: Secrets with unique, verifiable formats (like Stripe keys starting with `sk_live_` or `pk_live_`).
- **Medium-confidence patterns**: Credentials with common formats that may require additional validation.
- **Context-aware detection**: Analyzes surrounding code to distinguish real credentials from test data or examples.

For example, a GitHub personal access token follows a specific format (`ghp_` followed by 36 alphanumeric characters). This unique pattern allows high-confidence detection with minimal false positives.

## Secret scanning availability

Secret scanning availability varies based on repository visibility and GitHub subscription level.

### Public repositories

For public repositories, secret scanning is:

- **Enabled by default**: All public repositories automatically have secret scanning enabled.
- **Free**: No cost associated with the feature.
- **Comprehensive**: Includes both historical scanning and push protection.
- **Globally available**: Works for all users with public repositories.

This ensures that open-source projects benefit from automatic credential protection without requiring configuration or payment.

### Private repositories

For private repositories, secret scanning requires GitHub Advanced Security:

- **GitHub Enterprise Cloud**: Available with Advanced Security license.
- **GitHub Enterprise Server**: Available with Advanced Security license.
- **Organization-level control**: Administrators enable scanning at the organization or repository level.

GitHub Advanced Security is a paid add-on that provides comprehensive security features including secret scanning, code scanning (CodeQL), and dependency review.

### GitHub Actions

Secret scanning also protects GitHub Actions workflows:

- Scans workflow files for exposed secrets.
- Detects secrets in workflow logs.
- Prevents secrets from being inadvertently exposed in Actions output.

## Enabling and configuring secret scanning

Repository administrators and organization owners can control secret scanning settings.

### Enable secret scanning for a repository

To enable secret scanning for a private repository:

1. Navigate to the repository on GitHub.com.
1. Select **Settings** from the repository menu.
1. Select **Code security and analysis** from the sidebar.
1. Locate the **Secret scanning** section.
1. Select **Enable** to activate secret scanning.

Once enabled, GitHub immediately begins scanning the repository's entire history.

### Organization-level configuration

Organization owners can enforce secret scanning across multiple repositories:

1. Navigate to the organization settings.
1. Select **Code security and analysis**.
1. Choose options for automatic enablement:
   - Enable for all new repositories.
   - Enable for all existing repositories.
   - Configure policies for repository creation.

This ensures consistent security practices across all organization repositories.

### Configuring notifications

Repository administrators can configure who receives alert notifications:

- Repository administrators (automatic).
- Organization security team.
- Custom security contacts.
- Integration with security information and event management (SIEM) systems.

Notifications ensure that security teams are immediately aware of exposed credentials and can respond quickly.

## Secret scanning in practice

Understanding how organizations use secret scanning helps you implement effective security workflows.

### Integration with security workflows

Secret scanning fits into broader security practices:

- **Continuous monitoring**: Alerts appear as soon as secrets are detected, enabling rapid response.
- **Security dashboard**: All alerts centralized in the repository's Security tab.
- **Integration with tooling**: Alerts can be exported to SIEM systems or ticketing platforms.
- **Compliance reporting**: Provides evidence of credential monitoring for audit requirements.

### Response workflow

When secret scanning detects a credential, the typical response workflow includes:

1. **Alert generation**: GitHub creates an alert visible in the Security tab.
1. **Notification**: Security team receives notification via email or webhook.
1. **Assessment**: Team reviews the alert to confirm it's a genuine secret (not a false positive).
1. **Rotation**: Immediately revoke and rotate the exposed credential.
1. **Remediation**: Remove the secret from code and implement secure storage.
1. **Resolution**: Close the alert once the credential is rotated and code is fixed.

### Reducing false positives

While secret scanning is highly accurate, false positives can occur. Strategies for managing them include:

- **Review context**: Check if the detected pattern is test data or an example.
- **Dismiss as false positive**: Mark alerts that aren't real secrets to keep the alert list clean.
- **Use test markers**: Comment test credentials clearly to help detection algorithms.
- **Implement custom patterns**: Configure organization-specific secret patterns.

## Performance and impact

Secret scanning operates efficiently with minimal impact on repository operations:

- **Background processing**: Scanning doesn't block commits or pushes.
- **No performance impact**: Doesn't affect repository clone, push, or pull operations.
- **Historical scanning**: Completed asynchronously after enabling the feature.
- **Incremental scanning**: New commits are scanned in real-time as they're pushed.

Developers experience no workflow interruptions from secret scanning itself, though push protection (covered in the next unit) does block pushes containing secrets.

## Limitations and considerations

Understanding secret scanning's limitations helps you implement complementary security measures:

### Pattern-based detection

Secret scanning relies on known patterns and can't detect:

- Custom or proprietary credential formats unknown to GitHub.
- Obfuscated or encoded secrets (Base64, hex encoding, etc.).
- Secrets split across multiple lines or files.
- Credentials in binary files or compiled code.

Organizations with custom authentication systems may need additional scanning tools.

### Encrypted repositories

Secret scanning cannot analyze encrypted content:

- Git-crypt encrypted files.
- Git LFS objects with encryption.
- Encrypted archive files.

Ensure secrets are never committed before encryption is applied.

### Repository boundaries

Secret scanning operates within repository boundaries:

- Doesn't scan local working directories before commits.
- Can't detect secrets in external dependencies or submodules.
- Limited visibility into secrets in binary dependencies.

Use pre-commit hooks and local scanning tools for additional protection.
