In this unit, you learn how to create and publish sensitivity labels. You use a labeling admin center such as the Microsoft Purview Compliance Portal, Microsoft 365 Defender portal, or Exchange admin center.

First, you create and configure the sensitivity labels that you want to make available for apps and other services. For example, you configure the labels you want users to choose and apply in Office apps. Then you create one or more *label policies* that contain the labels and policy settings that you configured. The label policy publishes the labels and settings to your chosen users and locations.

The following steps are the basic workflow for using sensitivity labeling to help protect your organization's data.

1. **Choose and name the labels.** Create and name your sensitivity labels according to your organization's classification taxonomy for content sensitivity levels. Use common names or terms that make sense to your users. If you don't already have an established taxonomy, consider starting with label names such as Personal, Public, General, Confidential, and Highly Confidential. You can then use sublabels to group similar labels by category. When you create a label, use tooltip text to help users select the appropriate label.

1. **Configure label settings.** Configure the protection settings you want associated with each label. For example, you might want lower sensitivity content such as a General label to have just a header or footer applied, while higher sensitivity content such as a Confidential label should have a watermark and encryption.

1. **Publish the labels.** Publish your configured labels by using a label policy. Decide which users and groups should use the labels and what policy settings to use. A single label is reusable. You define it once, and then can include it in several label policies assigned to different users. For example, you could pilot your sensitivity labels by assigning a label policy to just a few users. Then when you're ready to make the labels available across your organization, you can create a new label policy for your labels that specifies all users.

## Sensitivity label policies

After you create your sensitivity labels, you publish them in sensitivity label policies to make them available to people and services in your organization. You can also use autolabeling policies to automatically apply sensitivity labels.

Unlike retention labels, which are published to locations such as all Exchange mailboxes, sensitivity labels are published to users or groups. The labels then display in Office apps for those users and groups, and users can apply the sensitivity labels to documents and emails.

A label policy consists of:

- A set of labels.
- The scope of the label policy, meaning the users and groups that are included in the policy.
- The label policy settings, as described in the following section.

### Label policy settings

- **Sensitivity labels** to include in the policy.

- **Users and groups** that can use the labels. Labels can be published to any email-enabled security group, Microsoft 365 group, or distribution group.

- **Require justification for changing a label.** You can require a justification to remove a label or replace it with a label that has a lower-order number. For example, a user opens a document labeled Confidential, order number 3, and replaces that label with Public, order number 1. Currently, the justification reason isn't sent to label analytics for the admin to review. However, the Azure Information Protection unified labeling client sends this information to Azure Information Protection analytics.

- **Require users to apply a label** to their email, documents, or Power BI content, also known as *mandatory labeling*. You can require users to apply a label before they can save documents and send emails. Using this option helps increase your labeling coverage. The required label can be assigned manually, assigned automatically based on a condition you select, or be assigned by default.

- **Provide users with a link to a custom help page.** To help your users understand what the sensitivity labels mean and how to use them, you can provide a URL to a custom help page.

- **Apply a default label to documents.** Apply a default label to all new documents and email created by the users and groups in the label policy. This option also applies to containers if you've enabled sensitivity labels for Microsoft Teams, Microsoft 365 groups, and SharePoint sites.

  A default label sets a base level of protection for all your content. Users can change the default label if it's not the right label for their document or email. However, without user training and other controls, this setting can result in inaccurate labeling.

After you create a label policy that publishes sensitivity labels, allow up to 24 hours for users to be able to see and use the labels in their Office apps.

The only limit to the number of sensitivity labels you can create and publish is a maximum of 500 labels that apply encryption. However, to reduce admin overhead and complexity for your users, try to keep the number of labels to a minimum. Real-world deployments have shown noticeably reduced effectiveness when users have more than five main labels or more than five sublabels per main label to choose from.

## Automatically apply a sensitivity label

When you create a sensitivity label, you can automatically assign that label to content that matches conditions you specify. The protection associated with that label is then applied automatically.

When you automatically apply sensitivity labels to content, you don't need to:

- Train your users when to use each of your classifications.
- Rely on users to classify all content correctly.
- Ensure users know about your policies. Instead, users can focus on their work.

The following screenshot shows the **Auto-labeling** settings in the Microsoft Purview Compliance Portal.

:::image type="content" source="../media/4-sensitivity-labels-conditions.png" alt-text="Screenshot that displays automatic labeling configuration.":::

