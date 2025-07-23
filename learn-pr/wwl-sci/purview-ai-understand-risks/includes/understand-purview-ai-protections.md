After identifying the security and compliance risks introduced by AI tools, the next step is to understand how Microsoft Purview helps address those risks.  Microsoft Purview uses a layered approach that builds on existing data security tools while introducing new capabilities designed specifically for AI. These capabilities are unified under **Data Security Posture Management (DPSM) for AI**.

## Data Security Posture Management for AI

DSPM for AI provides centralized visibility and control over how organizational data is accessed during AI interactions. It helps security teams:

- Discover which AI tools are being used
- Identify how sensitive content is accessed or referenced by AI tools
- Assess and reduce exposure risks in commonly used data sources

Instead of requiring new infrastructure, DSPM for AI builds on existing Microsoft Purview tools like data classification, sensitivity labels, and data loss prevention (DLP). This approach allows organizations to apply consistent protections across AI interactions without needing to deploy new security infrastructure.

## AI tool categories in Microsoft Purview

To apply the appropriate protections, Microsoft Purview classifies AI tools into three main categories. Understanding these categories helps determine which policies and controls are supported.

### Microsoft Copilot experiences

These are Microsoft-managed AI solutions that operate within the Microsoft 365 ecosystem. Examples include:

- Microsoft 365 Copilot
- Security Copilot
- Copilot Studio
- Copilot in Microsoft Fabric

Because these tools are integrated with Microsoft 365, they can honor sensitivity labels, respect encryption policies, and be included in audit and compliance reporting.

### Enterprise AI apps

These apps are built or managed by the organization and typically support identity integration using Microsoft Entra ID. Examples include:

- ChatGPT Enterprise
- Custom apps registered in Microsoft Entra
- AI solutions developed using Azure OpenAI services

Enterprise AI apps offer more control than browser-based tools, including options for scoped access, authentication, and monitoring through Microsoft Entra integration.

### Browser-based AI tools

These tools are accessed outside of the Microsoft 365 environment and typically don't offer identity integration or built-in security controls. Common examples include:

- ChatGPT (consumer version)
- Google Gemini
- Other web-based generative AI apps

Because browser-based tools often lack built-in governance, Microsoft Purview relies on controls like endpoint DLP and browser-specific monitoring to apply protections.

## Applying existing controls to secure AI interactions

Microsoft Purview doesn’t require organizations to start from scratch. Instead, it extends familiar security controls to address AI-specific scenarios. These include:

- **Sensitivity labels**: Labels applied to content can restrict how AI tools access or summarize data. For example, content marked as "Highly Confidential" with encryption and restricted extract rights can prevent Copilot from including that content in responses.

- **Data loss prevention (DLP)**: DLP policies can be configured to detect when sensitive data is being input into AI tools or copied to unsecured locations. These policies apply across locations, including Exchange, SharePoint, endpoints, and browser sessions.

- **Indicators and policies**: DSPM for AI works with Insider Risk Management and Adaptive Protection to flag potentially risky AI behaviors, such as excessive prompt activity or repeated access to confidential documents.

This integrated model allows organizations to extend their existing data protection strategy to AI interactions without creating separate policy silos.
