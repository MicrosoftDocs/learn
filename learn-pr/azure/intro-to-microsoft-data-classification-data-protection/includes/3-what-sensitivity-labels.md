Microsoft Purview Information Protection solutions are implemented by using sensitivity labels. Sensitivity labels let you classify and protect your organization's data while making sure not to hinder user productivity and collaboration. This unit explains sensitivity labels, and how you can configure labels and labeling policies to help protect your organization's data.

## Sensitivity labels in Office client apps

Microsoft 365 client apps like Word and Excel now have sensitivity labeling built in. Users must be signed in to apply sensitivity labels or to open protected documents that they have access to.

In Office apps, a sensitivity label appears like a tag to users on an email or document. Each content item can have a single sensitivity label applied to it. An item can have both a sensitivity label and a retention label.

:::image type="content" source="../media/3-sensitivity-not-set-callout.png" alt-text="Screenshot that shows a sensitivity label applied in an Office document." lightbox="../media/3-sensitivity-not-set-callout.png":::

## Sensitivity label creation and configuration

You can create and publish sensitivity labels in the Microsoft Purview Compliance Portal, Microsoft 365 Defender portal, or Exchange admin center. When you create and configure a sensitivity label, you define access restrictions on content that has that label. You can configure the following settings:

- **Scope** of the label, such as files, emails, meetings, and sites or groups.

- **Encryption.** You can restrict access by encrypting the content in emails, or in both emails and documents. You define which users or groups have permissions to do what actions, and for how long. You can also allow users to assign those permissions when they apply the label.

- **Content marking** such as applying custom headers, footers, and watermarks to items that have the label. You can apply watermarks to documents, but not to email. Watermarks are limited to 255 characters. Headers and footers are limited to 1024 characters, except Excel has a total limit of 255 characters for headers and footers, including characters that aren't visible like formatting codes.

- **Autolabeling for files and emails.** You can choose what types of sensitive information you want labeled, and the label can be applied automatically. Or, you can prompt users to apply the recommended label. If you recommend a label, the prompt displays the text you choose.

- **Protection settings for groups and sites.** You can help protect content in containers such as sites and groups by using sensitivity labels with Microsoft Teams, Microsoft 365 groups, and SharePoint sites. This configuration doesn't apply to documents, but protects content by controlling access to the containers where documents are stored. These settings include privacy, whether a group owner can add guests to the group, external sharing settings, and how much access users have from unmanaged devices.

Sensitivity labels have the following characteristics:

- **Customizable.** You can create categories for different levels of sensitive content in your organization, such as Personal, Public, General, Confidential, and Highly Confidential.

- **Clear text.** The label is stored in clear text in the content's metadata, so third-party apps and services can read it and apply their own protections.

- **Persistent.** After you apply a sensitivity label to content, the label is stored in the metadata of that email or document. The label and associated protection settings travel with the content and become the basis for applying and enforcing policies.

After you or a content owner apply the label to an email or document, any configured protection settings for that label are enforced on the content. For example, you could configure sensitivity labels to restrict content such that:

- Only users within your organization can open a confidential document or email.
- Only users in certain departments can edit or print a document or email, while all other users in the organization can only read it.
- Users can't forward or copy an internal email or any information it contains.
- Recipients can't open an email that contains a current price list after a specified date.
- Users in a specific group in another organization can review the content only for a specified time interval.

