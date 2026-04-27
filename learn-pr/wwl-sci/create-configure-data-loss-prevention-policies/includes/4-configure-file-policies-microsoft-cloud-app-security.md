File policies in Defender for Cloud Apps let you scan files in connected cloud apps, detect sensitive content, and take automated action. For example, you might create a file policy that finds externally shared files containing financial data in a connected Box instance and automatically revokes the shared link.

## How file policies inspect content

The built-in data loss prevention (DLP) engine extracts text from more than 100 common file types, including Office files, Open Office files, compressed files, rich text formats, XML, and HTML.

Each file policy combines three elements. Consider a policy that detects externally shared files containing credit card numbers in a connected Dropbox instance:

- **Content scan** identifies files that match sensitive information types or custom expressions. In this case, credit card number patterns.
- **Context filters** narrow the scope based on metadata like sharing level, file owner, or app. Here, you'd filter to files with an external sharing level.
- **Automated actions** define what happens when both conditions match, such as revoking external access or sending an alert.

These three elements determine whether a policy is useful or noisy. A broad content scan with a narrow context filter catches only the files that matter. A narrow content scan with no context filter catches everything that matches, regardless of how it's shared.

Once enabled, the policy continuously scans your cloud environment, both existing files and new content, for matches and applies the configured actions. You can monitor results by using real-time alerts or console-generated reports.

## Choose an inspection method

File policies support two inspection methods:

- **Built-in DLP** uses Defender for Cloud Apps content inspection capabilities.
- **Data Classification Service** uses the same sensitive information types and trainable classifiers you already manage in Microsoft Purview.

If you already maintain sensitive information types and trainable classifiers in Purview, the Data Classification Service lets your file policies use those same definitions, so you're not maintaining two separate sets of detection rules.

## Create a new file policy

File policies are enabled immediately upon creation and begin scanning right away.

> [!CAUTION]
> Don't enable governance actions on a new file policy until you've reviewed the initial matches. Overly broad filters combined with actions like quarantine or access revocation can cause widespread, irreversible disruption.

### Step 1: Create the policy with monitoring only

1. In the **Microsoft Defender** portal at [https://security.microsoft.com](https://security.microsoft.com/?azure-portal=true), under **Cloud Apps**, go to **Policies** > **Policy management**.
1. Select the **Information Protection** tab.
1. Select **Create policy** and select **File policy**.
1. Give your policy a name and description.
1. Assign a **Policy severity**. The **Policy severity** setting determines whether matches trigger notifications based on your configured severity levels.
1. Within **Category**, select the most appropriate risk type. The **Category** field helps you filter policies and alerts later. File policies default to DLP.
1. **Create a filter for the files this policy will act on.** Be as restrictive as possible to avoid false positives. For example, if you want to target publicly shared files, add the **Public** filter. To target files shared with external users, use the **External** filter.
1. Under **Apply to**, choose whether the policy covers all files or only specific folders within your connected apps. Scoping to specific folders reduces noise and focuses the policy on high-risk locations.
1. Under **Select user groups**, choose which file owners the policy applies to. You can include all owners, specific groups, or exclude groups.
1. Select the content **Inspection method**. You can select either [Built-in DLP](/defender-cloud-apps/content-inspection-built-in) or [Data Classification Services](/defender-cloud-apps/content-inspection?azure-portal=true). The Data Classification Service is recommended for a consistent experience across your DLP policies.
1. Leave **Governance** actions unset for now and select **Create**.

Use the **Edit and preview results** button in the Filters section to verify your filters match the intended files before the policy starts scanning.

### Step 2: Review matches and validate scope

After the policy runs, review the matches to confirm it's detecting the right files. If you see unexpected results, such as too many matches, matches from apps you didn't intend to cover, or matches on files that shouldn't qualify, adjust the filters before proceeding. See the "File policy matches" section later in this unit for how to review results.

### Step 3: Add governance actions

Once you're satisfied that the policy scope is correct, edit the policy to add governance actions. Choose actions appropriate to the risk. For example, revoke external sharing on files with exposed financial data, or quarantine files that violate a regulatory requirement.

You can edit the policy and adjust filters or actions at any time from the **Information protection** tab.

> [!NOTE]
> The Inspection method supports built-in sensitive information types and custom expressions including substrings, exact string matches, and regular expressions. For more information, see [Working with the RegEx engine](/defender-cloud-apps/working-with-the-regex-engine?azure-portal=true).

## File policy matches

To view all files suspected to violate a policy:

1. In the Microsoft Defender portal, under **Cloud Apps**, go to **Policies** > **Policy management**. Select the **Information Protection** tab.
1. Find the file policy you want to review.
1. In the **Count** column, select the number of **matches** for the policy. You can also select the three vertical dots (**…**) on the right side of the policy and select **View all matches**.
1. The report opens with tabs that help you review results:

    - **Matching now** shows files that currently match the policy. Use the filters at the top to refine the results.

    - **History** shows a history of up to six months of files that previously matched the policy.

Use the report page to find patterns in your matches and decide if you need to take action. For example, if you notice a high volume of matches that all originate from a single user, investigate whether that user has a valid business reason to generate those matches.
