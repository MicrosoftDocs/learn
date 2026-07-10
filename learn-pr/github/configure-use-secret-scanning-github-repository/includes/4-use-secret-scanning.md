Secret scanning is now enabled and configured on your private repositories, and you were just notified of an alert. Your response to the alert mainly depends on the type of secret that was committed into the repository.

This unit walks you through the different ways to respond to a secret scanning alert. It also explores how you can create your own patterns to scan for the secrets that GitHub doesn't automatically detect.

## Review secret scanning alerts

You can review and sort the alerts in **Security > Secret scanning** to determine the source, provider, secret type, and more.

You can filter alerts by:

- Bypassed
- Validity
- Secret type
- Provider

:::image type="content" source="../media/secret-scanning-alerts-filter-secret-type.png" alt-text="Screenshot of secret type filter in secret scanning alerts.":::

## Respond to an alert

Once a secret has been committed to a repository, you should consider the secret compromised.

GitHub recommends the following actions.

### For a compromised GitHub personal access token

1. Delete the compromised token.
2. Create a new token.
3. Update any services that use the old token.

### For all other secrets

1. Verify that the committed secret is valid.
2. Create a new secret.
3. Update any services that use the old secret.
4. Delete the old secret.

After you've completed the appropriate remediation steps, resolve the alert by:

1. Selecting the alert from the **Secret scanning alerts** list.
2. Choosing an appropriate reason from the **Close as** drop-down menu.

   :::image type="content" source="../media/alert-close-reason.png" alt-text="Screenshot of secret scanning alert with the Close reason drop-down.":::

## Alert dismissal considerations

Before dismissing a secret scanning alert, administrators should verify that appropriate remediation actions have been completed.

When dismissing an alert:

- Confirm that the exposed credential has been revoked, rotated, or otherwise rendered unusable.
- Document the reason for dismissal.
- Ensure that any required incident response or investigation activities have been completed.
- Verify whether the secret was active at the time of exposure by reviewing validity check results, when available.

## Audit logging and compliance considerations

Organizations operating under compliance frameworks such as **SOC 2**, **ISO 27001**, **PCI DSS**, or internal security policies may require evidence that exposed credentials were investigated and remediated.

Security teams should:

- Retain records of alert investigations.
- Document remediation actions and credential rotations.
- Periodically review dismissed alerts for accuracy and policy compliance.
- Ensure that dismissal reasons are consistent with organizational security procedures.

Maintaining an auditable record of secret exposure events helps demonstrate that security incidents were reviewed and addressed appropriately.

## Create a custom pattern

As mentioned previously in this module's **What is secret scanning?** unit, GitHub automatically scans public and private repositories for secret patterns provided by GitHub and GitHub partners. However, for private repositories with GitHub Advanced Security, you can also scan for other secret patterns, such as credentials that are unique to your organization.

For these situations, you can define custom secret scanning patterns in your enterprise, organization, or private repository.

Secret scanning supports:

- Up to **500 custom patterns** for each organization or enterprise account.
- Up to **100 custom patterns** per private repository.

After you create a custom pattern, secret scanning scans for the custom secret throughout the repository's Git history on all branches and notifies repository administrators the same way as for any other secret scanning alert.

The following sections explain how to create custom patterns for private repositories and organizations.

## Create a custom pattern for a private repository

Follow these steps:

1. Navigate to **Settings > Advanced Security** in your repository.
2. Under **Secret protection**, select **New pattern**.
3. Provide the following information:
   - Pattern name
   - Secret pattern expressed as a **Hyperscan regular expression (regex)**
   - *(Optional)* Additional matching requirements under **More options**
   - A sample test string to validate the pattern.

   :::image type="content" source="../media/new-custom-pattern-octocat.png" alt-text="Screenshot of creating a new custom pattern for octocat token.":::

To test your pattern without generating alerts:

1. Select **Save and dry run**.
2. Wait for the dry run to complete.
3. Review the sample results (up to 1,000 matches).
4. Identify and correct any false positives.
5. Edit the pattern as needed and run another dry run.

When you're satisfied with the results, select **Publish pattern**.

## Create a custom pattern for an organization

Follow these steps:

1. Navigate to **Settings > Advanced Security > Global Settings** in your organization.
2. Under **Custom patterns**, select **New pattern**.
3. Provide the following information:
   - Pattern name
   - Secret pattern expressed as a **Hyperscan regular expression (regex)**
   - *(Optional)* Additional matching requirements under **More options**
   - A sample test string to validate the pattern.
4. Select **Save and dry run**.
5. Choose where to run the scan:
   - **All repositories in the organization**, or
   - **Selected repositories**, then search for and select up to 10 repositories.

   :::image type="content" source="../media/repos-to-dry-run.png" alt-text="Screenshot of options to select repositories to perform the dry run.":::

6. Select **Run**.
7. Review the sample results (up to 1,000 matches).
8. Identify any false positives.
9. Update the pattern if necessary.
10. Run another dry run to validate the changes.

When you're satisfied with the results, select **Publish pattern**.
