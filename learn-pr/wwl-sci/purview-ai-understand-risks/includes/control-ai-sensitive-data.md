Once sensitive content and AI-related risks have been identified, the next step is to apply controls that help prevent inappropriate access. Microsoft Purview builds on existing data security tools to limit how sensitive content is used in AI interactions. These tools include **sensitivity labels** and **data loss prevention (DLP) policies**, which apply across supported Microsoft 365 services and AI scenarios.

## Enforce access boundaries with sensitivity labels

**Sensitivity labels** define how content can be used, and those rules carry into AI interactions. Think of labels as access boundaries that stay with the data no matter where it goes.

For example, in Microsoft 365 Copilot:

- A document labeled with encryption is protected. If a user doesn't have permission to read it, Copilot won't include that content in a response.
- Auto-labeling can apply protections to sensitive files before a user even tries to reference them in a prompt, closing gaps where someone forgets to label a file.
- Labels that restrict copying or extraction can prevent or reduce Copilot responses that expose that information, depending on label configuration.

Because these protections apply across Word, Excel, Outlook, Teams, and other Microsoft 365 apps, the same access rules your organization already relies on extend into Copilot interactions.

## Use DLP policies to block or audit AI activity

Data loss prevention (DLP) policies act as guardrails for how sensitive data moves during AI interactions. Consider a scenario where a user pastes personal customer data into a Copilot prompt. Depending on the rules in place, DLP could:

- Block the prompt from being submitted
- Warn the user or ask for justification before continuing
- Audit the activity for later review

When Copilot is available as a DLP policy location in your tenant, you can apply these controls directly to prompts. The same policies already protecting email and SharePoint now apply to AI activity as well.

Browser-based AI tools require a different approach. Endpoint DLP and Microsoft Edge for Business can detect when a user tries to paste or upload sensitive content into an unmanaged AI service like ChatGPT or Gemini, helping to close gaps outside of Microsoft 365.

## Understand which protections apply to each AI tool

Not every AI tool supports the same safeguards. The protections available depend on how the tool connects with your environment. If the tool is unmanaged or browser-based, endpoint and browser DLP are your primary protections.

| AI tool type | Protections supported |
|-----|-----|
| **Microsoft Copilot**| Sensitivity labels, DLP, Audit, Insider Risk Management |
| **Copilot Studio / Fabric** | Sensitivity labels, DLP, custom policy logic, and Purview integration for Dataverse agents |
| **Enterprise AI apps** | DLP through endpoints, Microsoft Edge, and Microsoft 365 data locations, with access controls enforced by Microsoft Entra ID |
| **Browser-based tools** | Endpoint DLP, browser control policies, file transfer restrictions|
| **Azure AI Foundry / developer AI tools** | DLP and labeling via Purview integration and SDK, visibility in Data Security Posture Management for AI |

This mapping helps you decide which tools can be governed with built-in protections and which require additional layers, such as endpoint or browser controls.
