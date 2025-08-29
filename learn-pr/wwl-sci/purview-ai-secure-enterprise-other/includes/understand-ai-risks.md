AI tools are now part of everyday workflows, but many operate outside of IT governance. These include enterprise-approved applications like ChatGPT Enterprise, and public browser-based tools like Gemini or Claude. Some are integrated into systems through plugins or APIs, while others are used independently without visibility or control.

When users interact with these tools, there's a risk of exposing sensitive data through prompts, responses, or persistent histories. Identifying which tools are in use and understanding how they interact with organizational data is an essential first step in managing that risk.

## Classify non-Microsoft AI tools

External AI tools fall into two categories based on how they're introduced and managed in an organization.

### Enterprise AI apps

Enterprise AI apps are tools that your organization has formally approved or provisioned. These apps often include administrative controls or offer integration with Microsoft Entra ID or other governance frameworks. Examples include:

- **ChatGPT Enterprise**: Provides enterprise-grade privacy commitments and can be registered using a Microsoft Purview data connector
- **Other non-Microsoft apps**: Integrated through APIs or identity platforms and subject to organizational oversight

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
| **Prompt exposure** | Users might submit sensitive data (for example, customer records, internal documents) as part of an AI prompt. These inputs might be retained or processed externally.|
| **Generated content**  | AI-generated summaries, code, or responses might contain sensitive information or be shared without protections. |
| **Unapproved storage** | Some tools save prompts or outputs to external accounts, making data retrieval and control difficult. |
| **Shadow AI adoption** | Users might adopt AI tools independently, bypassing IT governance. This creates gaps in visibility for security teams. |

Without oversight, these risks can lead to data leakage, compliance violations, or misuse of intellectual property.

## Use Microsoft Purview to assess and reduce risk

When employees use public AI tools, even small actions can introduce outsized risk. A quick copy-paste of customer data into a chatbot might leave sensitive information outside your organization's control, and generated responses can just as easily expose internal details. These situations highlight why security teams need both visibility and safeguards.

Once you've identified which AI tools are in use, you can use Microsoft Purview capabilities to address the risks they create:

- **Data Security Posture Management (DSPM) for AI** highlights which tools are active and shows when sensitive data is being used, helping you spot prompt exposure before it becomes a problem.
- **Endpoint Data Loss Prevention (DLP)** reduces prompt exposure by blocking or restricting users from pasting or uploading sensitive information into browser-based AI tools.
- **Communication Compliance** detects when prompts or responses include inappropriate or confidential content, so you can respond before it leads to a violation.
- **Insider Risk Management** assigns risk levels when users engage in risky AI behavior, such as visiting unsanctioned tools or entering sensitive information into high-risk prompts.
- **Retention** ensures that captured AI interactions are kept or deleted according to compliance requirements, so sensitive data doesn't remain longer than necessary.
- **Compliance Manager** helps you evaluate whether your AI usage aligns with regulatory expectations and internal policies, closing gaps that could lead to compliance issues.
