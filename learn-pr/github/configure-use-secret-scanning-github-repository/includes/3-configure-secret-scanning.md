For private repositories with GitHub Advanced Security, secret scanning has a few configurable parameters such as excluding files from being scanned and configurable notification recipients. But before you can configure secret scanning on a private repository, you must enable it.

This unit walks you through the necessary steps to enable secret scanning at the repository and organization level, as well as how you can configure it for your usage.

## Enable secret scanning for a private repository

Although secret scanning is enabled by default on public repositories, you must enable it manually on private repositories.

Follow the steps below to enable secret scanning on a private repository:

1. In your repository, navigate to **Settings > Security & analysis**.
2. Under **Configure security and analysis features**, click the **Enable** button next to **GitHub Advanced Security**.
3. Review the impact of enabling Advanced Security and click **Enable GitHub Advanced Security for this repository**.
4. Click the **Enable** button next to **Secret scanning**. If you see a **Disable** button, it means that secret scanning was already enabled at organization level.

:::image type="content" source="../media/enable-secret-scanning-repo.png" alt-text="Screenshot of GitHub Advanced Security section with Enable button for secret scanning highlighted.":::

## Enable secret scanning for an organization

Enabling secret scanning at organization level ensures that secret scanning is enabled by default on all private repositories where GitHub Advanced Security is enabled.

Follow the steps below to enable secret scanning for an organization:

1. In your organization, navigate to **Settings > Security & analysis**.
2. Under **Configure security and analysis features**, click the **Enable all** button next to **GitHub Advanced Security**.
3. Review the impact of enabling Advanced Security on all repositories and click **Enable all**.
4. Click the **Enable all** button next to **Secret scanning**.
5. Optionally enable the feature by default for new repositories in your organization, and click **Enable for eligible repositories**.

:::image type="content" source="../media/enable-secret-scanning-org.png" alt-text="Screenshot of confirmation screen for enabling secret scanning with Enable for eligible repositories button highlighted.":::

## Exclude files from being scanned

In some cases, you may not want secret scanning to scan certain files in your repositories. For example, test files or files that contain randomly generated content, can generate false alerts. You can create a `.github/secret_scanning.yml` file in your repository, that excludes some directories from being scanned.

In the file, use `paths-ignore` followed by the paths you want to exclude from secret scanning:

```yml
paths-ignore:
  - "foo/bar/*.js"
```

You can use special characters, such as `*` to filter paths. A filter pattern cheat sheet is available at the end of the module in the "Summary" unit.

> [!Note]
> - If there are more than 1,000 entries in `paths-ignore`, secret scanning will only exclude the first 1,000 directories from scans.
> - If `secret_scanning.yml` is larger than 1 MB, secret scanning will ignore the entire file.

## Configure recipients of secret scanning alerts

Provided that they are watching the repository and have enabled notifications for security alerts or for all the activity on the repository, GitHub notifies the following users of secret scanning alerts on a repository:

- Repository administrators
- Organization owners
- Authors of commits that trigger alerts

Additionally, repository administrators and organization owners can give view access to security alerts to people or teams who have write access to the repository under **Settings > Security & analysis**:

:::image type="content" source="../media/access-to-alerts.png" alt-text="Screenshot of Access to alerts section with Search for people or teams field highlighted.":::

If you want to give view access to security alerts to additional people in your team, type their name in the **Search for people of teams** field, click their name in the list of matches that appear, and click **Save**.
