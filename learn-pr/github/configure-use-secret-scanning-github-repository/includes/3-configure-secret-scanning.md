For private repositories with GitHub Advanced Security, Secret Scanning has a few configurable parameters, such as excluding files from being scanned and configurable notification recipients. Before you can configure Secret Scanning on a repository, however, you need to enable it.

This unit walks you through the necessary steps to enable Secret Scanning at the repository and organization level, as well as how you can configure it for your usage.

## Enable Secret Scanning for a repository

Follow these steps to enable Secret Scanning and push protection on a private repository:

1. In your repository, navigate to **Settings**.
2. In the **Security** section, select **Advanced Security**.
3. Select the **Enable** button next to **Secret Protection**.
4. Review the impact of enabling and select **Enable Secret Protection**.
5. If you see a **Disable** button, it means that Secret Scanning was already enabled at the organization level.
6. Select the **Enable** button next to **Push protection**.
  :::image type="content" source="../media/enable-secret-scanning-repo-settings.png" alt-text="Screenshot of Secret Scanning enabled in repository settings.":::

## Enable Secret Scanning for an organization

Enabling Secret Scanning at the organization level ensures that Secret Scanning is enabled by default on all private repositories where GitHub Advanced Security is enabled. In order to configure, you'll need to set up GitHub Advanced Security.

Once set up, you can configure global Secret Scanning settings.

## Exclude files from being scanned

In some cases, you might not want Secret Scanning to scan certain files in your repositories. For example, test files or files that contain randomly generated content can generate false alerts.

You can create a `.github/secret_scanning.yml` file in your repository that excludes some directories from being scanned.

In the file, use `paths-ignore` followed by the paths you want to exclude from Secret Scanning:

```yaml
paths-ignore:
  - "foo/bar/*.js"
```

You can use special characters, such as `*`, to filter paths. A filter pattern cheat sheet is available at the end of the module in the Summary unit.

[!NOTE]
- If there are more than 1,000 entries in `paths-ignore`, Secret Scanning will only exclude the first 1,000 directories from scans.
- If `secret_scanning.yml` is larger than 1 MB, Secret Scanning will ignore the entire file.

## Enterprise enforcement policies

Organizations can improve secret protection by standardizing Secret Scanning and push protection requirements across repositories.

### Require push protection on all repositories

Configure organization-wide security settings to require push protection for all repositories covered by GitHub Secret Protection.

**Benefits include:**

- Preventing secrets from entering repository history.
- Reducing remediation workload.
- Providing immediate feedback to developers before secrets are exposed.

### Restrict bypass privileges

Limit push protection bypass permissions to:

- Security managers
- Dedicated security review teams
- Approved custom roles

This ensures that secret exposure decisions receive appropriate oversight.

### Protect public repositories

For repositories that are publicly accessible:

- Enable push protection wherever available.
- Review bypass events regularly.
- Monitor Secret Scanning alerts as part of routine security operations.
- Require rapid credential rotation for any exposed secret.

### Standardize custom secret patterns

Organizations that use internally generated credentials should create custom Secret Scanning patterns so that proprietary tokens, API keys, and service credentials are detected consistently across repositories.

### Monitor bypass activity

Security teams should periodically review:

- Bypass requests
- Approved exceptions
- Frequently recurring secret types
- Repositories generating the highest volume of alerts

These reviews can identify training opportunities and process improvements.

## Determine notifications for Secret Scanning alerts

When a new secret is detected, GitHub notifies all users with access to security alerts for the repository according to their notification preferences. These users include:

- Security managers
- Repository administrators
- Users with custom roles with read/write access
- Organization owners and enterprise owners, if they're administrators of repositories where secrets were leaked

[!NOTE] Commit authors who have accidentally committed secrets will be notified, regardless of their notification preferences.

You'll receive an email notification if:

- You're watching the repository.
- You've enabled notifications for **All Activity** or for custom **Security alerts** on the repository.
- In your notification settings, under **Subscriptions** > **Watching**, you've selected to receive notifications by email.

## Configure recipients of Secret Scanning alerts

Repository and organization administrators can give view access to security alerts to people or teams who have write access to the repository under:

**Settings > Security > Advanced Security > Access to Alerts**

:::image type="content" source="../media/access-to-alerts.png" alt-text="Screenshot of access to alerts section with Search for people or teams field highlighted.":::

If you want to give view access to security alerts to additional people in your team:

1. Type their name in the **Search for people or teams** field.
2. Select their name from the list of matches.
3. Select **Save changes**.

Alert recipients are notified according to their notification settings.

## Review and manage secret protection settings

After enabling Secret Scanning, GitHub offers additional settings to fine-tune how secrets are detected, verified, and managed:

- **Validity checks** – Verifies whether exposed secrets are still active by querying the relevant provider.
- **Non-provider patterns** – Scans for custom or non-partnered secret formats beyond the standard provider patterns.
- **Scan for generic passwords** – Uses AI to detect weak or generic passwords in your code.
- **Push protection** – Blocks commits containing supported secret types and prevents them from being pushed.

You can also manage:

- **Delegated bypass rules** – Define approved users, teams, and custom roles that can bypass push protection or review bypass requests. Organizations can require approval workflows for all other contributors and maintain audit visibility into bypass activity.
- **Alert dismissal rules** – Require justification before users can dismiss alerts (if enabled).
- **Custom patterns** – Define up to 100 custom patterns to detect internal secrets.

In your repository or organization, go to **Settings > Advanced Security > Secret Protection** to access these options.

[!NOTE] These settings provide more granular control and are helpful when scaling Secret Scanning across multiple repositories.

## Configure delegated bypass for push protection

For organizations that want stronger controls over secret exposure, GitHub supports delegated bypass for push protection.

Instead of allowing all contributors with write access to bypass push protection, organizations can require approval from designated reviewers before a blocked push containing a secret can proceed.

To configure delegated bypass:

1. Navigate to **Settings > Advanced Security > Secret Protection**.
2. Enable **Delegated bypass for push protection**.
3. Create a bypass list consisting of:
   - Individual users
   - Teams
   - Default roles
   - Custom organization roles
4. Apply the configuration to selected repositories or organization-wide security configurations.

Organizations can also create custom roles with the **Review and manage Secret Scanning bypass requests** permission. These roles allow designated security reviewers to approve or deny bypass requests without granting broader administrative permissions.

## Permission boundaries

When delegated bypass is enabled:

- Organization owners and security managers retain bypass capabilities.
- Members of approved bypass teams can bypass push protection after providing a justification.
- Other contributors must submit a bypass request for review.
- Requests expire automatically after seven days if no action is taken.

## Audit visibility

All bypass activity generates visibility for repository security teams.

Administrators can:

- Review bypass requests in the repository **Security** tab.
- Track approval and denial decisions.
- Review user-provided justifications.
- Investigate patterns of repeated bypass requests during security reviews.

This provides accountability while still allowing development teams to unblock legitimate workflows when necessary.
