You’ve introduced yourself to Microsoft Information Protection and Azure Information Protection. Now you want to determine if sensitivity labels might be suitable for Contoso. In this unit, you’ll learn what sensitivity labels are and how you can use them.

You can use sensitivity labels to classify and help protect your sensitive content, while maintaining users’ productivity and ability to collaborate. You can use sensitivity labels in a wider scope than classic Azure Information Protection labels, and you can also use them on operating systems, such as MacOS, that don’t support Azure Information Protection client software. Recent updates to the Microsoft 365 client apps, such as Word and Excel, include a client for sensitivity labels.

## Sensitivity labels overview

When you assign a sensitivity label to a document or email, it's like applying a stamp to content that's:

- Customizable. You can create categories for different levels of sensitive content in your organization, such as Personal, Public, General, Confidential, and Highly Confidential.
- Clear text. Because the label is stored in clear text in the content's metadata, third-party apps and services can read it and then apply their own protective actions, if necessary.
- Persistent. After you apply a sensitivity label to content, the label is stored in the metadata of that email or document. This means the label roams with the content, including the protection settings, and these data become the basis for applying and enforcing policies.

In Office apps, a sensitivity label appears like a tag to users on an email or document. Each item of content can have a single sensitivity label applied to it. An item can have both a single sensitivity label and a single retention label applied to it.

:::image type="content" source="../media/3-sensitivity-not-set-callout.png" alt-text="Image depicts how a sensitivity label is selected in the Office app.":::

After a sensitivity label is applied to an email or document, any configured protection settings for that label are enforced on the content. With a sensitivity label, you can:

- Encrypt content. With sensitivity labels, you can encrypt the content in just emails, or in both email and documents. You can choose which users or groups have permissions to perform which actions and for how long. For example, you can choose to allow users in a specific group in another organization to have permissions to review the content for only seven days after the content is labeled. Instead of administrator-defined permissions, you can allow your users to assign permissions to the content when they apply the label.
- Mark content. When you use Office apps, you can mark the content by adding watermarks, headers, or footers to email or documents that have the label applied. Watermarks can be applied to documents but not email. Watermarks are limited to 255 characters. Headers and footers are limited to 1024 characters, except in Excel. Excel has a total limit of 255 characters for headers and footers, but this limit includes characters that aren't visible, such as formatting codes. If you reach that limit, the string you enter isn't displayed in Excel.
- Protect content. You can protect content in containers such as sites and groups when you enable the use of sensitivity labels with Microsoft Teams, Microsoft 365 groups, and SharePoint sites. Configuration options for Site and group settings don't display until you enable this capability. This label configuration doesn't result in documents being automatically labeled but instead, the label settings protect content by controlling access to the container where documents are stored. These settings include the privacy level, whether a Microsoft 365 group owner can add guests to the group, and the level of access granted to an unmanaged device.
- Apply the label automatically in Office apps or recommend a label. Choose what types of sensitive information that you want labeled, and the label can either be applied automatically, or you can prompt users to apply the label that you recommend. If you recommend a label, the prompt displays the text you choose.

When you create a sensitivity label, you can restrict access to content with that label. After a sensitivity label is applied to an email or document, any configured protection settings for that label are enforced on the content.

For example, with the encryption settings for a sensitivity label, you can protect content so that:

- Only users within your organization can open a confidential document or email.
- Only users in the marketing department can edit and print the promotion announcement document or email, while all other users in your organization can only read it.
- Users can't forward an email or copy information from it that contains news about an internal reorganization.
- The current price list that's sent to business partners can't be opened after a specified date.

All Microsoft Information Protection solutions are implemented by using sensitivity labels. To create and publish these labels, refer to your labeling admin center, such as the Microsoft 365 compliance center. You can also use the Microsoft 365 security center, or the Security &amp; Compliance Center.
