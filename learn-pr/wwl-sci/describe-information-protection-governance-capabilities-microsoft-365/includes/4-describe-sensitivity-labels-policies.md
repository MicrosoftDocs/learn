Organizations must protect their data, to protect their customers and business operations, and to meet compliance standards. Admins can enable their organization to protect its data, through capabilities and tools such as sensitivity labels and policies in Microsoft 365 Compliance Center.

## Sensitivity labels

Sensitivity labels, available as part Information protection in the Microsoft 365 Compliance Center, enable the labeling and protection of content, without impacting productivity and collaboration. With sensitivity labels, organizations can decide on labels to apply to content like emails and documents, much like different stamps can be applied to physical documents:

Labels are:

- **Customizable**: Admins can create different categories specific to the organization, such as Personal, Public, Confidential, and Highly Confidential.
- **Clear text**: Because each label is stored in clear text in the content's metadata, third-party apps and services can read it and then apply their own protective actions, if necessary.
- **Persistent**. After you apply a sensitivity label to content, the label is stored in the metadata of that email or document. This means the label moves with the content, including the protection settings, and this data becomes the basis for applying and enforcing policies.

Each item that supports sensitivity labels can only have a single sensitivity label applied to it.

Sensitivity labels can be used to:

- **Encrypt** email only or both email and documents. When a document or email is encrypted, access to the content is restricted, so that:

  - It can be decrypted only by users authorized by the label's encryption settings.
  - Remains encrypted no matter where it resides, inside or outside your organization, even if the file is renamed.
  - It is encrypted both at rest (for example, in a OneDrive account) and in transit (for example, email as it traverses the internet).
- **Mark the content** when Office apps are used.  Marking the content includes adding watermarks, headers, or footers.  Headers or footers can be added to emails or documents that have the label applied. Watermarks can be applied to documents but not to email. 
- **Apply the label automatically** in Office apps or recommend a label. Admins can choose what types of sensitive information to be labeled. The label can be applied automatically or can be configured to prompt users to apply the recommended label.
- **Protect content in containers such as sites and groups** when this capability is enabled. This label configuration does not result in documents being automatically labeled. Instead, the label settings protect content by controlling access to the container where documents are stored.
- **Extend sensitivity labels to third-party apps and services**. Using the Microsoft Information Protection SDK, third-party apps can read sensitivity labels and apply protection settings.
- **Classify content without using any protection settings**. A classification can be assigned to content (just like a sticker) that persists and roams with the content as it's used and shared.  The classification can be used to generate usage reports and view activity data for sensitive content.

## Label policies

After sensitivity labels are created, they need to be published to make them available to people and services in the organization. Sensitivity labels are published to users or groups through label policies. Once published, sensitivity labels will appear in Office apps for those users and groups. The sensitivity labels can then be applied to documents and emails.
Label policies enable admins to:

- **Choose the users and groups that can see labels**.  Labels can be published to specific users, distribution groups, Microsoft 365 groups in Azure Active Directory, and more. 
- **Apply a default label** to all new emails and documents that the specified users and groups create. Users can always change the default label if they believe the document or email has been mislabeled.
- **Require justifications for label changes**. If a user wants to remove a label or replace it, admins can require the user to provide a valid justification to perform the action. The user will be prompted to provide an explanation for why the label should be changed.
- **Require users to apply a label (mandatory labeling)**. This ensures a label is applied before users can save their documents, send emails, or create new sites or groups.
- **Link users to custom help pages**. This will help users to understand what the different labels mean and how the labels should be used.

Once a sensitivity label is applied to an email or document, any configured protection settings for that label are enforced on the content. For example, by choosing encryption settings for a sensitivity label, admins can protect content so that:

- Only users within the organization can open a confidential document or email.
- Only users in a specific department can edit and print a document or email, while all other users in the organization can only it.
- Users cannot forward or copy information from an email.
- Users cannot open a document after a specified date.

Admins can also enable users to label and protect their files using the Windows File Explorer (to label additional file types, and more files simultaneously), by installing the Azure Information Protection unified labeling client on Windows devices.
