:::image type="content" source="../media/premium-support.png" alt-text="A graphic that shows a stylized support engineer, with icons that represent different times of day":::

This unit explains the enhanced support options available with GitHub Enterprise and outlines key responsibilities of administrators when working with GitHub Support. You'll apply this knowledge whether you're using GitHub Enterprise Server (self-hosted) or GitHub Enterprise Cloud (hosted by GitHub).



## Support Availability

| Availability                                        | GitHub Enterprise Support | Premium & Premium Plus Support |
|----------------------------------------------------|---------------------------|-------------------------------|
| Days of operation                                   | Monday–Friday              | Every day                     |
| Initial response (High-level issues)               | Within 8 hours             | Within 4 hours                |
| Initial response (Urgent-level issues)             | Within 8 hours             | Within 30 minutes             |

[Premium and Premium Plus Support](https://github.com/premium-support) customers receive additional benefits, including priority handling and dedicated technical guidance.



## Distinguishing Administrator Duties from GitHub Support

Knowing whether an issue should be handled internally or escalated to GitHub Support can reduce downtime and improve resolution time.

| Issue | Solved by Administrator | Requires GitHub Support |
|-------|--------------------------|--------------------------|
| Managing repository access | ✅ | ❌ |
| Removing sensitive data from commits | ✅ | ❌ |
| Restoring deleted branches | ✅ (if recent) | ❌ |
| Recovering deleted repositories | ❌ | ✅ (within 90 days) |
| Account recovery (lost access, compromised account) | ❌ | ✅ |
| Billing & subscription issues | ❌ | ✅ |
| Takedown requests (DMCA, copyright violations) | ❌ | ✅ |
| Restoring force-pushed commits | ❌ | ✅ (in limited cases) |
| Clearing caches after history rewriting | ❌ | ✅ |



## Administrative Scope of Support

GitHub Support typically assists with issues across three areas: accounts, security, and abuse. Your internal administrators handle tasks related to infrastructure, internal tools, or external authentication.

- Account Issues: By verifying identity and restoring access, support helps resolve account access issues, such as lost two-factor authentication credentials.
- Security Incidents: GitHub Support can help mitigate damage from compromised accounts, roll back repository changes, and assist with security recovery.
- Abuse Cases: Support investigates violations of GitHub’s terms, such as harassment or inappropriate content, and can remove users or content as needed.

> [!NOTE]
> Administrators are responsible for infrastructure configuration, CI/CD integrations, third-party auth systems (like SAML), internal scripting, hardware setup, and immediate on-prem issue resolution.



## Creating and Prioritizing Support Tickets

Use the [GitHub Support portal](https://support.github.com) with a support-entitled account to submit tickets.

Include the following:

- Steps to reproduce the issue  
- Context (e.g., first occurrence, frequency, business impact)  
- Error messages (verbatim)  

### GitHub Support Priority Levels

| Priority | Description | Typical Response Time |
|----------|-------------|------------------------|
| 🟢 Low | General inquiries, feature requests | 24–48 hours |
| 🟡 Medium | Technical issues affecting users | 12–24 hours |
| 🔴 High | Major bugs or service impact | Few hours |
| 🚨 Critical | Security, account lockout, billing | Immediate |



## Submitting Support Bundles and Diagnostics

Support bundles and diagnostic files provide vital information about your GitHub Enterprise Server instance and are essential for effective troubleshooting.

### What’s Included in a Support Bundle?

- Application logs  
- System diagnostics (CPU, memory, disk)  
- Configuration settings  
- Network errors and backups  
- Replication details (if applicable)  

### Generating Support Bundles

#### Using the Management Console

1. Log in to **Management Console**.  
2. Go to **Support > Support Bundles**.  
3. Click **Create and Download Support Bundle**.  
   *Download starts automatically once generated.*

#### Using the Command Line

```bash
ssh admin@your-ghes-instance
ghe-support-bundle -o /path/to/directory/
```

Locate the `.tar.gz` file in the specified directory.

### What's Included in Diagnostic Files? 

Diagnostic files collect information about the health and configuration of a GitHub Enterprise Server instance. Administrators can use this information to assess system status and help identify potential issues before or during troubleshooting. 

Diagnostic files can include information such as: 

- System configuration 
- Service status 
- Network configuration 
- Storage and resource information 
- Environment settings 

GitHub Support may request diagnostic files, along with a support bundle, when investigating issues such as performance problems, authentication failures, upgrade issues, or unexpected system behavior. 

## Uploading Support Bundles Securely

Once you've created a bundle:

### Option 1: Secure Upload Link (Recommended)

1. Submit a ticket via the [Support Portal](https://support.github.com) and indicate the need to share a bundle.  
2. GitHub Support will provide a one-time, secure upload link.

### Option 2: Alternative Methods

- **Encrypted Email**: Encrypt bundle using 7-Zip or PGP; send file and password separately.  
- **Secure Cloud Storage**: Use services like Google Drive, OneDrive, or Dropbox with access restrictions.  
- **Physical Transfer**: For large bundles, GitHub may provide a mailing address.



:::image type="content" source="../media/support-link.png" alt-text="Button to access Support area":::

You can also upload support bundles from within the GitHub Enterprise UI:

1. Select your enterprise under **Your Enterprises**.  
2. Go to **Settings > Enterprise Licensing**.  
3. Select **Upload a Support Bundle** in the **Help** section.

---

## Resolving and Closing Tickets

GitHub Premium Support may mark tickets as solved after providing a fix, workaround, or recommendation.

A ticket may be closed if:

- It’s outside the scope of support.  
- Repeated follow-ups go unanswered.  

If your ticket is closed due to inactivity, you can request to reopen it.
