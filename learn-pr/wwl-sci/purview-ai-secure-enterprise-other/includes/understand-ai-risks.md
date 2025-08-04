AI tools are now part of everyday workflows, but many operate outside of IT governance. These include enterprise-approved applications like ChatGPT Enterprise, as well as public browser-based tools like Gemini or Claude. Some are integrated into systems through plugins or APIs, while others are used independently without visibility or control.

When users interact with these tools, there's a risk of exposing sensitive data through prompts, responses, or persistent histories. Identifying which tools are in use and understanding how they interact with organizational data is an essential first step in managing that risk.

## Classify non-Microsoft AI tools

External AI tools fall into two categories based on how they're introduced and managed in an organization.

### Enterprise AI apps

Enterprise AI apps are tools that your organization has formally approved or provisioned. These apps often include administrative controls or offer integration with Microsoft Entra ID or other governance frameworks. Examples include:

- **ChatGPT Enterprise**: Provides enterprise-grade privacy commitments and can be registered using a Microsoft Purview data connector
- **Other third-party apps**: Integrated through APIs or identity platforms and subject to organizational oversight

Even with formal approval, these apps can pose data security risks if sensitive content is used without protective policies in place.

### Other AI apps

These tools are accessed in a web browser and aren't connected to your organization's identity or policy systems. They don't support identity controls, policy enforcement, or admin visibility. Examples include:

- **ChatGPT (free or Plus)**
- **Google Gemini**
- **Anthropic Claude**
- **Perplexity.ai**
- **Character.ai**

Because these tools aren't governed through formal channels, they often present a higher risk of sensitive data exposure. Prompts might be retained, logged, or used to train models without the user's knowledge.

## Understand how these tools increase risk

Whether intentional or not, users often share sensitive information with external AI tools. When an organization lacks visibility or control, these interactions introduce several types of data security risk.

| Risk type | Description |
|-----|-----|
| **Prompt exposure** | Users may submit sensitive data (e.g., customer records, internal documents) as part of an AI prompt. These inputs may be retained or processed externally.|
| **Generated content**  | AI-generated summaries, code, or responses may contain sensitive information or be shared without protections. |
| **Unapproved storage** | Some tools save prompts or outputs to external accounts, making data retrieval and control difficult. |
| **Shadow AI adoption** | Users may adopt AI tools independently, bypassing IT governance. This creates blind spots for security teams. |

Without oversight, these risks can lead to data leakage, compliance violations, or misuse of intellectual property.

## Use Microsoft Purview to assess and reduce risk

Microsoft Purview includes several capabilities to help detect, assess, and mitigate the risks introduced by external AI tools:

- **Data Security Posture Management (DSPM) for AI**: Identifies AI tools in use, detects how sensitive data is accessed or shared, and recommends protection strategies.
- **Endpoint Data Loss Prevention (DLP)**: Blocks users from pasting or uploading sensitive content into browser-based AI tools such as ChatGPT or Gemini.
- **Communication Compliance**: Flags inappropriate prompts and responses in supported enterprise and third-party AI apps.
- **Insider Risk Management**: Detects risky AI behavior, including visits to unsanctioned tools or the use of sensitive data in high-risk prompts.
- **Retention**: Applies retention and deletion policies to user prompts and AI-generated responses in supported enterprise and third-party apps. Content is copied to hidden folders in Exchange mailboxes for compliance purposes and remains available to eDiscovery tools until the retention period ends.
- **Compliance Manager**: Offers templates to assess regulatory and organizational requirements for using AI tools. These assessments help track control implementation and audit readiness.
