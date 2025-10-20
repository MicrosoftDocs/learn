To apply Microsoft Purview Message Encryption dynamically, you can configure mail flow rules in Exchange Online. These rules allow you to automatically encrypt messages based on conditions such as sender, recipient, subject line, or keywords in the body.

## Use mail flow rules to apply encryption

You can create mail flow rules in the Exchange admin center (EAC) to apply encryption based on specific criteria. These rules help ensure that sensitive emails are protected without relying on end users to apply encryption manually.

To create a rule that applies Microsoft Purview Message Encryption:

1. In the Microsoft 365 admin center, go to **All admin centers** > **Exchange**.
1. In the Exchange admin center, select **Mail flow** > **Rules**.
1. Select **New rule**.
1. Select **+ Add a rule** > **Apply Office 365 Message Encryption and rights protection to messages** from the dropdown.

   :::image type="content" source="../media/exchange-mail-flow-rule.png" alt-text="Screenshot showing where to configure a mail flow rule in the Exchange Admin Center." lightbox="../media/exchange-mail-flow-rule.png":::

1. Give the rule a name, such as `Encrypt email to external recipients`.
1. Under **Apply this rule if**, choose conditions such as:
   - **The recipient is external/internal** > **Outside the organization**
   - **The subject or body includes** > specific keywords
   - **The sender is located** > **Inside the organization**
1. Under **Do the following**, choose **Modify the message security** > **Apply Office 365 Message Encryption and rights protection**.

   :::image type="content" source="../media/set-encryption-rule.png" alt-text="Screenshot showing where to configure the encryption rules in the Exchange Admin Center." lightbox="../media/set-encryption-rule.png":::

1. Select a template such as **Encrypt** or **Do Not Forward**, or choose a custom template if you have one configured.
1. Configure the rule settings:
   - Under **Rule mode**, choose **Enforce** to immediately apply the rule once it's saved.
   - Select the appropriate severity based on your organization's needs.
   - Optionally select when to activate and deactivate the mail flow rule.
   - In **Match sender address in message**, choose the option that best aligns with your organization's routing and enforcement needs.
1. Review your settings and create the rule.

> [!TIP]
> You can test mail flow rules before applying them broadly. Consider creating a test rule that applies encryption based on a unique subject keyword, then send a test message and verify the recipient experience.

## Update or remove encryption

You can also update existing mail flow rules to use Microsoft Purview Message Encryption, or create rules to remove encryption when necessary.

For example, you might want to remove encryption from replies sent by internal users, or remove attachment-level encryption from files shared within the organization.

To remove encryption using a mail flow rule:

1. In the EAC, go to **Mail flow** > **Rules**.
1. Select the rule to modify, then select **Edit rule settings**.
1. In the **Conditions** tab, remove or modify condition.

   :::image type="content" source="../media/modify-mail-flow-rule.png" alt-text="Screenshot showing where to modify the encryption settings in a mail flow rule." lightbox="../media/modify-mail-flow-rule.png":::

1. Select **Save** to save your changes.

You can also choose to remove **attachment rights protection**, if needed.

## Hybrid environment considerations

If you're using a hybrid Exchange configuration, encryption is only supported when mail is routed through Exchange Online. Make sure both inbound and outbound messages pass through Exchange Online to enforce encryption rules consistently.

Mail flow rules make it easy to apply Microsoft Purview Message Encryption automatically based on message conditions. You can apply default or custom templates to secure sensitive messages, and remove encryption when it's no longer needed. Testing and refining rules helps ensure the best user experience while maintaining your organization's data protection policies.
