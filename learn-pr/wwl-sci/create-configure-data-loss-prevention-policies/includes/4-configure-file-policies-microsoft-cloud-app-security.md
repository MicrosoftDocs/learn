Microsoft Cloud App Security (MCAS) built-in DLP engine performs content inspection by extracting text from all common file types (100+) including Office, Open Office, compressed files, various rich text formats, XML, HTML, and more.

The engine combines three aspects under each policy:

- Content scan based on preset templates or custom expressions.

- Context filters including user roles, file metadata, sharing level, organizational group integration, collaboration context, and additional customizable attributes.

- Automated actions for governance and remediation.

Once enabled, the policy continuously scans your cloud environment and identifies files that match the content and context filters and applies the requested automated actions. These policies detect and remediate any violations for at-rest information or when new content is created. Policies can be monitored using real-time alerts or using console-generated reports.

The other option is to leverage the Data Classification Service that is also employed by the DLP policies configured in the Compliance center. You can use this option to have a uniform experience across all your configured DLP policies.

## Creating a new file policy

To create a file policy, follow this procedure:

1. In the **Cloud App Security** portal at [https://portal.cloudappsecurity.com](https://portal.cloudappsecurity.com/?azure-portal=true), select **Control** followed by **Policies**.

1. Select **Create policy** and select **File** **policy**.

1. Give your policy a name and description, if you want you can base it on a template.

1. Give your policy a **Policy severity**. If you have set Cloud App Security to send you notifications on policy matches for a specific policy severity level, this level is used to determine whether the policy's matches trigger a notification.

1. Within **Category**, link the policy to the most appropriate risk type. This field is informative only and helps you search for specific policies and alerts later, based on risk type. The risk may already be preselected according to the category for which you chose to create the policy. By default, File policies are set to DLP.

1. **Create a filter for the files this policy will act on** to set which discovered apps trigger this policy. Narrow down the policy filters until you reach an accurate set of files you wish to act upon. Be as restrictive as possible to avoid false positives. For example, if you wish to remove public permissions, remember to add the **Public** filter, if you wish to remove an external user, use the "External" filter etc.

1. Under the first Apply to filter, select **all files excluding selected folders** or **selected folders** for Box, SharePoint, Dropbox, OneDrive, where you can enforce your file policy over all files on the app or on specific folders. You're redirected to sign-in to the cloud app, and then add the relevant folders.

1. Under the second Apply to filter, select either **all file owners, file owners from selected user groups** or **all file owners excluding selected groups**. Then select the relevant user groups to determine which users and groups should be included in the policy.

1. Select the content **Inspection method**. You can select either [Built-in DLP](https://docs.microsoft.com/cloud-app-security/content-inspection-built-in) or [Data Classification Services](https://docs.microsoft.com/cloud-app-security/content-inspection?azure-portal=true).

1. Choose the **Governance** actions you want Cloud App Security to take when a match is detected and select Create Policy.

Once you've created your policy, you can view it in the **File policy** tab. You can edit a policy, calibrate its filters, or change the automated actions.

The policy is automatically enabled upon creation and starts scanning your cloud files immediately. Take extra care when you set governance actions, they could lead to irreversible loss of access permissions to your files.

It's recommended to narrow down the filters to exactly represent the files that you wish to act upon, using multiple search fields. The narrower the filters, the better. For guidance, you can use the **Edit and preview results** button in the Filters section.

> [!NOTE]
> The Inspection method supports several built-in sensitive information types and custom expressions that can be substrings, exact string matches, and regular expressions, which are the most powerful method to find the targeted information. Creating and maintaining the correct regular expressions is a recurring task and more information can be found in the resource section of this module.

## File policy matches

If you want to view all files that are suspected to violate a policy, follow these steps:

1. Select **Control** and then **Policies**.

1. Search the respective **File Policy** you want to view.

1. Select the three dots (**…**) on the right-side of the policy and select **View all matches**.

1. You will see a list of files that are currently recognized by the file policy to match the selected filters. You can use this view to see the impact your policy has before you change it to apply any Governance actions.

