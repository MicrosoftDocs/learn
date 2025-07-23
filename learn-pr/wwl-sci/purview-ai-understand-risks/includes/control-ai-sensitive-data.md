Once sensitive content and AI-related risks have been identified, the next step is to apply controls that help prevent inappropriate access. Microsoft Purview builds on existing data security tools to limit how sensitive content is used in AI interactions. These tools include **sensitivity labels** and **data loss prevention (DLP) policies**, which apply across supported Microsoft 365 services and AI scenarios.

## Enforce access boundaries with sensitivity labels

**Sensitivity labels** help enforce access controls during AI interactions by defining how content can be used. Labels can include encryption, content marking, and usage restrictions. These protections carry over when data is accessed or processed by AI tools.

For example, Microsoft 365 Copilot respects label settings in these ways:

- If content is labeled with encryption that restricts access, Copilot can't include that content in its responses unless the user running the prompt has permission to read the file.
- If **auto-labeling** is enabled, sensitive content can be automatically labeled before it's accessed by AI tools, helping enforce protection even without user involvement.
- Labels that restrict copying, extracting, or printing can prevent AI-generated output from including protected content.

These protections extend to Copilot in Microsoft Word, Excel, PowerPoint, Outlook, and Teams, and other AI-enabled Microsoft 365 apps that support sensitivity label enforcement.

## Use DLP policies to block or audit AI activity

**Microsoft Purview DLP policies** help control how sensitive data is shared during AI interactions, especially when content is copied into or out of AI-enabled environments.

DLP policies can be configured to:

- **Block or audit prompts** that include sensitive information
- **Detect pasting or typing** of protected content into AI chat windows
- **Monitor file uploads** into browser-based AI tools, such as ChatGPT or Gemini

Microsoft 365 Copilot (preview) is now available as a **DLP policy location**, which lets you apply DLP rules directly to Copilot prompts. You can configure policies to block, audit, or notify users when Copilot activity matches a sensitive information type or label.

Browser-based interactions can be governed using **endpoint DLP** and **Microsoft Edge for Business**, which help detect when users paste or upload protected content into unmanaged AI services.

## Understand which protections apply to each AI tool

Different AI tools support different protection methods. Microsoft Purview applies controls based on the type of tool:

| AI tool type | Protections supported |
|-----|-----|
| **Microsoft Copilot** | Sensitivity labels, DLP, Audit, Insider Risk Management |
| **Copilot Studio / Fabric** | DLP, sensitivity labels, and custom policy logic |
| **Enterprise AI apps** | DLP and access controls when integrated with Microsoft Entra ID |
| **Browser-based tools** | Endpoint DLP, browser control policies, file transfer restrictions |

Understanding which protections apply helps ensure sensitive data remains secure, regardless of how users interact with AI tools.
