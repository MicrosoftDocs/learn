After you identify the security and compliance risks introduced by AI tools, the next step is to understand how Microsoft Purview addresses those risks. Microsoft Purview uses a layered approach that builds on your existing data security controls and adds AI‑specific capabilities, unified as **Data Security Posture Management (DSPM) for AI**.

## Data Security Posture Management for AI

DSPM for AI gives security teams visibility and control over how organizational data is accessed during AI interactions. With DSPM, you can:

- Discover which AI tools are being used
- Identify when sensitive content is accessed or referenced by AI tools
- Assess and reduce exposure risks across commonly used data sources

DSPM for AI uses existing Microsoft Purview features such as data classification, sensitivity labels, and data loss prevention (DLP). This means organizations can apply familiar protections to AI scenarios in a consistent way across their environments.

## AI tool categories in Microsoft Purview

Imagine your legal team asks, "Could Copilot expose confidential contracts?" The answer depends on the type of AI tool being used. Microsoft Purview groups AI tools into three categories so you can see which protections apply in each case.

### Copilot experiences

If your users primarily work in Microsoft 365 apps, **Copilot experiences** such as Microsoft 365 Copilot, Security Copilot, or Copilot in Fabric provide the strongest built-in protections. Because these tools run inside Microsoft 365, they automatically respect sensitivity labels, encryption policies, and audit logging. For example, if a file is encrypted with a _Highly Confidential_ label, Copilot won't be able to surface that content in a generated response unless the user has permission to the file.

### Enterprise AI apps

If your organization is building or adopting custom AI apps, like ChatGPT Enterprise or solutions created with Azure OpenAI, you'll need **enterprise AI apps** integrated with Microsoft Entra. These apps usually connect with your identity system, which allows you to:

- Enforce authentication
- Manage scoped access
- Apply Microsoft Purview protections through data locations such as SharePoint, OneDrive, and Exchange
- Extend protections through endpoint and browser DLP where relevant

This category provides flexibility for custom development while still maintaining enterprise-grade security.

### Other AI apps

If employees use unmanaged, browser-based tools such as the public version of ChatGPT or Google Gemini, protections work differently. These **other AI apps** don't integrate with your identity system or security policies. In these cases, Purview relies on endpoint and browser controls, such as:

- Blocking sensitive data from being pasted into a generative AI website
- Warning the user before data is submitted
- Requiring justification if someone attempts to share restricted content

For example, endpoint DLP can step in when a user tries to paste customer data into a public chatbot.

Framing AI tools in categories helps you identify which protections apply natively and where stronger safeguards are required.

## Applying existing controls to secure AI interactions

AI introduces new ways for sensitive data to be shared, but the protections needed aren't new. Microsoft Purview extends the same controls already in place for files, email, and endpoints so they also apply to AI interactions.

Consider a scenario where a user pastes customer data into a Copilot prompt. Purview protections respond in several ways:

- **Sensitivity labels**: If the source document is labeled and encrypted, Copilot honors those permissions. If the prompting user isn't authorized, the content won't be included. Labels keep protections with the data.
- **Data loss prevention (DLP)**: Even if the file isn't labeled, DLP can detect sensitive info as it's typed or pasted into the prompt and block, warn, or allow with justification. You can extend the same policies you use for Exchange or SharePoint to Copilot prompts and browser sessions.
- **Insider risk indicators and policies**: Insider Risk Management can identify repeated risky behavior, and Adaptive Protection can automatically apply stricter label or DLP policies until the user's risk level decreases.

**Rule of thumb:** Use labels to enforce access, DLP to control data in motion, and Insider Risk with Adaptive Protection to address risky behavior patterns over time.

By applying these existing controls, organizations can extend their current data protection strategy to AI interactions. Instead of building a separate set of AI policies, they can ensure consistent safeguards across files, email, endpoints, and now AI tools.
