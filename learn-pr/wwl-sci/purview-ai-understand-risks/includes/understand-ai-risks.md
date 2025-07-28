AI tools are changing how organizations work with data, but they also introduce new security and compliance challenges. Traditional security controls weren't designed to track how AI is used or what data it accesses. Without proper visibility and enforcement, organizations risk data exposure, compliance violations, and security gaps.

Managing AI-related risks requires visibility into how organizational data is accessed and used during AI interactions, along with protections for sensitive content and policies that prevent unauthorized sharing. The following sections explain key risks organizations face when employees interact with AI tools.

## Key AI security risks

### Limited visibility into AI usage

Many organizations lack visibility into:

- Who is using AI tools
- What data is being shared
- How AI-generated content is used or stored

Without insight into these areas, it becomes difficult to apply protections or assess risks.

AI tools generally fall into three categories:

- **Copilot experiences**: Microsoft-managed Copilots integrated into Microsoft 365, such as Microsoft 365 Copilot, Security Copilot, Copilot Studio, and Copilot in Fabric
- **Enterprise AI apps**: Organizationally connected AI apps like ChatGPT Enterprise or Azure AI services, which may integrate through Microsoft Entra, data connectors, or Azure AI Foundry
- **Other AI apps**: Browser-based generative AI tools like ChatGPT (consumer) and Gemini, which operate outside the Microsoft 365 environment

   :::image type="content" source="../media/ai-app-risk-category.png" alt-text="Table showing three AI app categories—Copilot experiences, Enterprise AI apps, and Other AI apps—alongside examples and associated risks for each category." lightbox="../media/ai-app-risk-category.png":::

Understanding the type of AI tool helps determine what protections are available and how to configure them.

### Data exposure in AI interactions

AI interactions can lead to unintentional data exposure through:

- Sensitive content being entered into prompts
- AI-generated responses including confidential data
- Summarization or referencing of overshared or unprotected content
- Access to files shared too broadly, such as anonymous links or large group permissions

Organizations need controls in place to prevent these exposures before they happen.

### Compliance and regulatory risks

AI-generated content might include:

- Regulated data that isn't properly controlled
- Information shared with external tools that bypass compliance safeguards
- Activity that lacks audit trails, complicating reporting

These gaps create risks under data protection laws and internal compliance standards.

### Risks from AI-generated content

Beyond analyzing data, AI tools produce content that might introduce new risks, such as:

- Generation of confidential or sensitive information
- Creation of inappropriate or noncompliant text
- Storage of content outside protected systems

Without oversight, AI-generated content can create new security and compliance issues.

## Addressing security gaps in AI usage

AI interactions operate differently than traditional file sharing or communication. Organizations need to:

- Identify which AI tools are in use and how they interact with organizational data
- Track what data is shared or generated
- Apply policies that prevent unauthorized access or misuse

Understanding these risks sets the foundation for configuring protections using Microsoft Purview.
