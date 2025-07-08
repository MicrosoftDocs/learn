Before you implement message encryption across your organization, it's important to think through a few key decisions. These choices affect how encryption behaves for end users and how messages are received by external recipients. They also determine whether the features align with your organization's goals and licensing model.

Message encryption in Microsoft 365 is powered by Azure Rights Management (Azure RMS), which is automatically enabled for most eligible subscriptions. Once Azure RMS is active, Microsoft Purview Message Encryption is available to use. However, the way you configure it and how it's experienced by users can vary based on several design factors.

## Licensing and feature availability

To use Microsoft Purview Message Encryption, your tenant must have a supported license. This capability is included in Microsoft 365 E3, E5, and Business Premium plans. For other plans, such as Exchange Online Plan 1 or Office 365 E1, you can add Azure Information Protection Plan 1 to enable message encryption. Ensure that each user who benefits from message encryption has an appropriate license.

If you're using Active Directory Rights Management Services (AD RMS), you'll need to migrate to Azure RMS. Message Encryption doesn't work with AD RMS, and the transition must happen before you can enable Purview capabilities.

## Email client support

One of the key strengths of Purview Message Encryption is that it works across many platforms, including Outlook for desktop, mobile, and web. External recipients using Gmail, Yahoo, or other services can access encrypted messages through a secure web portal. They don't need to install special apps or sign in with a Microsoft 365 account.

The reading experience varies depending on the client. Users in Outlook often see the message natively, while other recipients receive a wrapper message with a link to the secure portal. For this reason, it's helpful to test the experience from multiple recipient types during rollout.

## Branding and user experience

You can customize the look and feel of encrypted messages by modifying the branding template used in the encrypted message portal. This helps ensure that external recipients know the message is legitimate and tied to your organization.

If you plan to use Advanced Message Encryption features, such as message expiration or revocation, custom branding is required. This branding is what allows the portal wrapper to be applied consistently and trigger the desired behavior.

## Choosing between encryption templates and sensitivity labels

In Microsoft 365, you can apply encryption in two primary ways:

- **Encryption templates**, used in mail flow rules or configured manually by admins  
- **Sensitivity labels**, which allow users to classify and protect content themselves

Templates are great for enforcing encryption automatically based on message conditions, such as specific recipients or keywords. Sensitivity labels offer a broader information protection strategy by applying encryption along with other settings, such as visual markings or access restrictions.

When choosing between the two, consider whether you need consistent, automated enforcement or want to give users more flexibility to classify their own content.

## When to use Advanced Message Encryption

Advanced Message Encryption builds on the base encryption experience and provides more granular control over external access. With this feature, you can:

- Expire access to encrypted messages after a specific time  
- Revoke access to a message after it's has been sent  
- Apply custom branding and ensure recipients use the secure portal  

These features are especially useful when dealing with sensitive information that has a short lifecycle or when your organization needs to meet strict compliance requirements. Here's a quick comparison to help you decide which version of message encryption best meets your needs

| Feature | Microsoft Purview Message Encryption | Advanced Message Encryption |
|--------|--------------------------------------|------------------------------|
| **Send encrypted email to internal and external recipients** | ✓ | ✓ |
| **Works with third-party services (Gmail, Yahoo, etc.)** | ✓ | ✓ |
| **View encrypted messages in Outlook or secure web portal** | ✓ | ✓ |
| **Custom branding for secure message portal** | ✕ (not customizable) | ✓ (branding required) |
| **Create multiple branding templates** | ✕ | ✓ |
| **Expire access to a message** | ✕ | ✓ |
| **Revoke access to a message after it’s sent** | ✕ | ✓ |
| **Required for applying encryption via mail flow rules** | ✓ | ✓ |
| **Available in Microsoft 365 E3** | ✓ | ✕ (requires E5 or AIP Premium P2) |
