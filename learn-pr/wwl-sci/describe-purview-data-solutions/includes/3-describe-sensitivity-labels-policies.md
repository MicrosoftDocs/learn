

Organizations must protect their data to safeguard customers and business operations and to meet compliance standards. Admins can enable their organization to protect its data through capabilities like sensitivity labels and sensitivity label policies in Microsoft Purview.

## Sensitivity labels

Sensitivity labels from Microsoft Purview Information Protection let you classify and protect your organization's data, while making sure that user productivity and the ability to collaborate aren't hindered. When you assign a sensitivity label to content, it's like a stamp that's applied and travels with the content wherever it goes.

Sensitivity labels are:

- **Customizable**: Admins create different categories specific to the organization, such as Personal, Public, Confidential, and Highly Confidential.
- **Clear text**: Each label is stored in clear text in the content's metadata, so third-party apps and services can read it and then apply their own protective actions if needed.
- **Persistent**: After you apply a sensitivity label to content, the label is stored in the metadata of that email or document. The label then moves with the content, including the protection settings, and this data becomes the basis for applying and enforcing policies.

Each item that supports sensitivity labels can only have one label applied to it at any given time.

### What sensitivity labels can do

Sensitivity labels can be configured to:

- **Encrypt emails and documents.** Encryption prevents unauthorized people from accessing labeled content. You can specify which users or groups have permissions to perform which actions and for how long.
- **Mark the content** when Office apps are used. Content markings include adding watermarks, headers, or footers. Headers or footers can be added to emails or documents. Watermarks can be applied to documents but not to email.
- **Apply the label automatically** in Office apps or recommend a label. Admins choose the types of sensitive information to trigger the label. The label can be applied automatically or configured to prompt users to apply the recommended label.
- **Protect content in containers** such as SharePoint sites, Teams sites, and Microsoft 365 groups. This configuration doesn't result in documents being automatically labeled. Instead, the label settings protect content by controlling access to the container where documents are stored.
- **Extend sensitivity labels to third-party apps and services.** The Microsoft Information Protection SDK enables third-party apps to read sensitivity labels and apply protection settings.
- **Classify content without using any protection settings.** A classification can be assigned to content as a tag that persists and roams with the content as it's used and shared. The classification generates usage reports and activity data for sensitive content.

### Label scopes

When you create a sensitivity label, you configure its scope, which determines which label settings are available and to which types of content the label applies. Label scopes let you create labels tailored to specific content types:

- **Files & other data assets**: Covers files in Word, Excel, PowerPoint, and PDF, as well as items in Microsoft Fabric and Power BI. This scope is selected by default for all new labels.
- **Emails**: Covers Outlook emails. Many labeling features require both Files and Emails to be selected, since emails frequently contain file attachments that share the same sensitivity.
- **Meetings**: Covers calendar events, Teams meeting options, and Teams chat. Requires the Files and Emails scopes to also be selected.
- **Groups & sites**: Covers SharePoint sites, Teams sites, Microsoft 365 groups, and Viva Engage communities. Labels applied at this scope protect the container by controlling access settings, but don't automatically label the individual items inside.

This scope configuration means you can have sensitivity labels designed specifically for documents and emails, and separate labels for protecting team collaboration spaces. Users only see the labels that are published to them and that apply to the type of content they're working with.

The following image shows the settings for a sensitivity label named Confidential-Finance, which includes settings for encryption, content marking, and auto-labeling for files and emails.

:::image type="content" source="../media/sensitivity-label-v2-inline.png" lightbox="../media/sensitivity-label-v2-expanded.png" alt-text="A screen capture of a sensitivity label named Confidential-Finance, which includes settings for encryption, content marking, and autolabeling for files and emails.":::

### Sensitivity labels and Microsoft 365 Copilot

Sensitivity labels are recognized and honored by Microsoft 365 Copilot and Microsoft 365 Copilot Chat. When Copilot generates a response that draws on data from multiple items, it recognizes the sensitivity labels applied to that data and inherits the most restrictive label—typically the highest-priority label. If a label applies encryption from Microsoft Purview Information Protection, Copilot checks whether the user has the permissions needed to access and reference that content before including it in a response. This ensures that the protection configured for labeled content is respected even in AI-assisted workflows.

## Sensitivity label policies

After sensitivity labels are created, they need to be published to make them available to people and services in the organization. Sensitivity labels are published to users or groups through sensitivity label policies. Sensitivity labels then appear in Office apps for those users and groups, and can be applied to documents and emails.

Sensitivity label policies enable admins to:

- **Choose the users and groups that can see labels.** Labels can be published to specific users, distribution groups, or Microsoft 365 groups in Microsoft Entra ID, and more.
- **Apply a default label** to all new emails and documents that the specified users and groups create. Users can always change the default label if they believe the document or email has been mislabeled.
- **Require justifications for label changes.** If a user wants to remove a label or replace it with a lower-sensitivity label, admins can require the user to provide a valid justification to complete the action. The user is prompted to provide an explanation for why the label should be changed.
- **Require users to apply a label (mandatory labeling).** This ensures a label is applied before users can save their documents, send emails, or create new sites or groups.
- **Link users to custom help pages.** This helps users understand what the different labels mean and how they should be used.

Once a sensitivity label is applied to an email or document, any configured protection settings for that label are enforced on the content.
