

Organizations must protect their data, to safeguard customers and business operations, and to meet compliance standards. Admins can enable their organization to protect its data, through capabilities and tools such as sensitivity labels and policies in the Microsoft Purview compliance portal.

## Sensitivity labels

Sensitivity labels, available as part of information protection in the Microsoft Purview compliance portal, enable the labeling and protection of content, without affecting productivity and collaboration. With sensitivity labels, organizations can decide on labels to apply to content such as emails and documents, much like different stamps are applied to physical documents:

Labels are:

- **Customizable**: Admins can create different categories specific to the organization, such as Personal, Public, Confidential, and Highly Confidential.
- **Clear text**: Because each label is stored in clear text in the content's metadata, third-party apps and services can read it and then apply their own protective actions, if necessary.
- **Persistent**. After you apply a sensitivity label to content, the label is stored in the metadata of that email or document. The label then moves with the content, including the protection settings, and this data becomes the basis for applying and enforcing policies.

Each item that supports sensitivity labels can only have one label applied to it, at any given time.

Sensitivity labels can be configured to:

- **Encrypt** email only or both email and documents.
- **Mark the content** when Office apps are used.  Marking the content includes adding watermarks, headers, or footers.  Headers or footers can be added to emails or documents. Watermarks can be applied to documents but not to email.
- **Apply the label automatically** in Office apps or recommend a label. Admins choose the types of sensitive information to be labeled. The label can be applied automatically or configured to prompt users to apply the recommended label.
- **Protect content in containers such as sites and groups**. This label configuration doesn't result in documents being automatically labeled. Instead, the label settings protect content by controlling access to the container where documents are stored.
- **Extend sensitivity labels to third-party apps and services**. The Microsoft Purview Information Protection SDK enables third-party apps to read sensitivity labels and apply protection settings.
- **Classify content without using any protection settings**. A classification can be assigned to content (just like a sticker) that persists and roams with the content as it's used and shared.  The classification can be used to generate usage reports and view activity data for sensitive content.

## Label policies

After sensitivity labels are created, they need to be published to make them available to people and services in the organization. Sensitivity labels are published to users or groups through label policies. Sensitivity labels will then appear in Office apps for those users and groups. The sensitivity labels can be applied to documents and emails.
Label policies enable admins to:

- **Choose the users and groups that can see labels**.  Labels can be published to specific users, distribution groups, Microsoft 365 groups in Azure Active Directory, and more.
- **Apply a default label** to all new emails and documents that the specified users and groups create. Users can always change the default label if they believe the document or email has been mislabeled.
- **Require justifications for label changes**. If a user wants to remove a label or replace it, admins can require the user to provide a valid justification to complete the action. The user will be prompted to provide an explanation for why the label should be changed.
- **Require users to apply a label (mandatory labeling)**. It ensures a label is applied before users can save their documents, send emails, or create new sites or groups.
- **Link users to custom help pages**. It helps users to understand what the different labels mean and how they should be used.

Once a sensitivity label is applied to an email or document, any configured protection settings for that label are enforced on the content.

To learn more, explore the interactive guides available in the Learn more section of the Summary and resources unit of this module.
