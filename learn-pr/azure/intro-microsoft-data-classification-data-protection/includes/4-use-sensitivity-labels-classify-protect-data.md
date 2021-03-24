You’ve determined that sensitivity labels could be useful for Contoso. Now, you’d like to examine how these labels are used. In this unit, you’ll learn how sensitivity labels are used in data protection.

Before using labels for protection, you need to create and configure the sensitivity labels that you want to make available for apps and other services, such as the labels you want users to choose and apply from Office apps. Also, you need to create one or more label policies that contain the labels and policy settings that you configure. It's the label policy that publishes the labels and settings for your chosen users and locations.

## How to use sensitivity labels for data protection

The following steps identify the basic workflow in using sensitivity labels to help protect your organization's data:

1. Create the labels. Create and name your sensitivity labels according to your organization's classification taxonomy for different sensitivity levels of content. Use common names or terms that make sense to your users. If you don't already have an established taxonomy, consider starting with label names such as Personal, Public, General, Confidential, and Highly Confidential. You can then use sublabels to group similar labels by category. When you create a label, use the tooltip text to help users select the appropriate label.
2. Define what each label can do. Configure the protection settings you want associated with each label. For example, you might want lower sensitivity content (such as a "General" label) to have just a header or footer applied, while higher sensitivity content (such as a "Confidential" label) should have a watermark and encryption.
3. Publish the labels. After your sensitivity labels are configured, publish them by using a label policy. Decide which users and groups should have the labels and what policy settings to use. A single label is reusable—you define it once, and then you can include it in several label policies assigned to different users. For example, you could pilot your sensitivity labels by assigning a label policy to just a few users. Then when you're ready to make the labels available across your organization, you can create a new label policy for your labels and this time, specify all users.

### Sensitivity label policy

After you create your sensitivity labels, you must publish them in sensitivity label policies to make them available to people and services in your organization. The sensitivity labels can then be applied to documents and emails. Unlike retention labels, which are published to locations such as all Exchange mailboxes, sensitivity labels are published to users or groups. Sensitivity labels then display in Office apps for those users and groups. You can publish sensitivity labels by using label policies and you can also use auto-labeling policies to automatically apply sensitivity labels, if needed.

A label policy consists of:

- A set of labels.
- The scope of the label policy, meaning the users and groups included in the policy.
- The settings of the label policy described in the following section (default label, justification, mandatory label, and help link).

Label policies enable organizations to:

- Choose which users and groups have access to the labels. Labels can be published to any email-enabled security group, Microsoft 365 group, or distribution group.

- Apply a default label. Apply a default label to all new documents and email created by the users and groups included in the label policy. This option also applies to containers, if you've enabled sensitivity labels for Microsoft Teams, Microsoft 365 groups, and SharePoint sites. Users can always change the default label if it's not the right label for their document or email. Consider using a default label to set a base level of protection settings that you want applied to all your content. However, without user training and other controls, this setting can also result in inaccurate labeling.

- Require a justification for changing a label. If a user tries to remove a label or replace it with a label that has a lower-order number, you can require the user to provide a justification to perform this action. For example, a user opens a document labeled **Confidential** (order number 3) and replaces that label with one named **Public** (order number 1). Currently, the justification reason isn't sent to label analytics for the admin to review. However, the Azure Information Protection unified labeling client sends this information to Azure Information Protection analytics.

- Require users to apply a label to their email and documents. Also known as *mandatory labeling*, you can require users to apply a label before they can save documents and send emails. Use this option to help increase your labeling coverage. The label can be assigned manually by the user, automatically because of a condition that you configure, or be assigned by default (the default label option described previously).

- Provide a help link to a custom help page. If your users aren’t sure what your sensitivity labels mean or how to use them, you can provide a **Learn More** URL that displays at the bottom of the **Sensitivity label** menu in the Office apps.

After you create a label policy that assigns sensitivity labels to users and groups, allow up to 24 hours for these users to access the labels in their Office apps.

There's no limit to the number of sensitivity labels that you can create and publish, with one exception: If the label applies encryption, there's a maximum of 500 labels. However, as a best practice to reduce admin overhead and complexity for your users, try to keep the number of labels to a minimum. Real-world deployments have proved noticeably reduced effectiveness when users have more than five main labels or more than five sublabels per main label.

### Automatically apply a sensitivity label to content
When you create a sensitivity label, you can automatically assign that label to content when it matches conditions that you specify. As a result, the protection associated with that label is automatically applied.

:::image type="content" source="../media/4-sensitivity-labels-conditions.png" alt-text="Image displays automatic labeling configuration.":::

The ability to apply sensitivity labels to content automatically is important because you don’t need to:

- Train your users when to use each of your classifications.
- Rely on users to classify all content correctly.
- Ensure users know about your policies. Instead, they can focus on their work.
