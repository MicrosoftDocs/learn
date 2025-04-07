AI tools like Microsoft 365 Copilot are changing how users interact with Microsoft 365 apps such as Word, Excel, PowerPoint, Outlook, and Teams. These tools use large language models like GPT-4 to generate content, summarize communications, and assist in meetings. Because Copilot can access and process large amounts of business data, it's important to ensure that sensitive information is consistently protected in line with your organization's policies. One way to help protect this content is by using sensitivity labels in Microsoft 365.

## What are sensitivity labels?

Sensitivity labels are part of Microsoft Purview Information Protection. They allow organizations to classify and protect their content based on its sensitivity level. Each label can apply a set of protection settings, including:

- **Encryption**: Ensures only authorized users can access the content, even if it's shared externally.
- **Content markings**: Adds headers, footers, or watermarks to indicate the sensitivity of the content.
- **Access restrictions**: Limits who can view, edit, print, or forward the content.

Sensitivity labels help organizations apply consistent protections, both within Microsoft 365 and across supported non-Microsoft tools and services.

## How Microsoft 365 Copilot works with sensitivity labels

Copilot respects the sensitivity labels that are applied to content it accesses. It follows the protection settings defined in those labels and only processes content the user has permission to access. This ensures that data protection policies remain in effect even when AI features are used.

Here's how sensitivity labels interact with Copilot:

- **Label recognition**: Copilot identifies and respects sensitivity labels when accessing data.
- **Label inheritance**: When Copilot creates new content based on labeled source files, it inherits the labels from those files.
- **Permission checks**: Copilot checks user permissions before accessing labeled content. If the user isn’t authorized, the content isn’t used.

If a user asks Copilot to summarize documents labeled as confidential, it will only do so if the user already has access. Copilot won't process content the user isn't authorized to view. The new summary will also carry the appropriate label based on the source content.

## Example scenario

Imagine a legal team using Microsoft 365 Copilot to summarize documents related to an internal investigation. These documents carry different sensitivity labels, including some labeled Highly Confidential. As Copilot processes the documents, it recognizes these labels. For documents marked Highly Confidential, Copilot limits the level of detail in the summary to help avoid unintentional disclosure. The new summary inherits the label from the most sensitive content it includes.

This approach helps protect sensitive information while allowing teams to benefit from AI-assisted productivity.

## Steps to get started

To start using sensitivity labels with Microsoft 365 Copilot, ensure your environment is properly configured.

| **Step** | **Description** | **Learn more** |
|------|-------------|------------|
| Verify prerequisites | Confirm that your environment meets the requirements for Copilot and sensitivity labels. | - [Microsoft 365 Copilot requirements](/microsoft-365-copilot/microsoft-365-copilot-requirements?azure-portal=true) <br> - [Get started with sensitivity labels](/purview/get-started-with-sensitivity-labels?azure-portal=true) |
| Understand label interaction | Learn how Copilot respects and applies sensitivity labels. | [Sensitivity labels and Microsoft 365 Copilot](/purview/sensitivity-labels?azure-portal=true#sensitivity-labels-and-microsoft-365-copilot)  |
| Confirm licensing | Make sure you have the necessary Microsoft 365 and Microsoft Purview licenses. | - [Microsoft 365 Copilot service description](/office365/servicedescriptions/office-365-platform-service-description/microsoft-365-copilot?azure-portal=true#available-plan) <br> - [Microsoft Purview Information Protection: Sensitivity labeling service guide](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance?azure-portal=true#microsoft-purview-information-protection-sensitivity-labeling) |
| Create and publish sensitivity labels | Define your sensitivity labels and publish them to users. Consider auto-labeling where needed. | - [Create and configure sensitivity labels and their policies](/purview/create-sensitivity-labels?azure-portal=true) <br> - [Apply a sensitivity label to content automatically](/purview/apply-sensitivity-label-automatically?azure-portal=true) |

## Use Data Security Posture Management (DSPM) for AI to apply default labels and policies

You can also use **DSPM for AI** in the Microsoft Purview portal to apply default sensitivity labels and policies. When you select the recommendation named **Protect your data with sensitivity labels**, Purview automatically sets up a labeling policy, client-side auto-labeling, and service-side auto-labeling. These configurations help protect sensitive data in Microsoft 365 apps, including content referenced by Microsoft 365 Copilot.

To access this, navigate to **DSPM for AI** > **Recommendations** > **Protect your data with sensitivity labels**:

:::image type="content" source="../media/dspm-ai-sensitivity-label-recommendation.png" alt-text="Screenshot showing the Protect your data with sensitivity labels recommendation in DSPM for AI." lightbox="../media/dspm-ai-sensitivity-label-recommendation.png":::

## Limitations to consider

While sensitivity labels provide strong protections, there are a few important limitations to be aware of:

- **Manual vs. inherited labels**: Copilot won't override a manually applied higher-priority label with an inherited one.
- **Double Key Encryption (DKE)**: Copilot can't access content protected by DKE.
- **Teams data**: Sensitivity labels applied to Teams chats or meetings aren't currently recognized by Copilot.
- **App-specific behavior**: Copilot in Word and PowerPoint can't generate content from encrypted files. In Microsoft Edge, encrypted files can only be referenced if the user has sufficient permissions.
- **Microsoft 365 Chat**: Copilot can access encrypted data depending on the user’s permissions, but some protections might not carry over fully.

Understanding these limitations helps set the right expectations and allows you to plan for secure AI usage across your organization.

Sensitivity labels help organizations maintain control over sensitive information, even when that data is processed by AI tools like Microsoft 365 Copilot. By inheriting labels, enforcing encryption, and respecting user permissions, Copilot works alongside your data protection strategy rather than bypassing it.

## Learn more

- [Data, Privacy, and Security for Microsoft 365 Copilot](/copilot/microsoft-365/microsoft-365-copilot-privacy?azure-portal=true)
- [Microsoft Purview data security and compliance protections for generative AI apps](/purview/ai-microsoft-purview?azure-portal=true)
- [Learn about sensitivity labels](/purview/sensitivity-labels?azure-portal=true)
- [Get started with Microsoft 365 Copilot - admin guide](/copilot/microsoft-365/microsoft-365-copilot-setup?azure-portal=true)
