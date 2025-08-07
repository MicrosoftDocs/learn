Many non-Microsoft and enterprise AI apps aren't governed directly by IT. Even when an app is formally approved, it can introduce risk if sensitive data is involved or if safeguards aren't in place. Before applying controls, it's important to understand how these tools are used and whether they meet your organization's security and compliance requirements.

Microsoft Purview includes two capabilities that support this stage of the process:

- **Data Security Posture Management (DSPM) for AI**: Detects which AI apps are in use and how they interact with sensitive data.
- **Compliance Manager**: Offers regulatory templates that help you assess whether your controls are aligned with relevant AI regulations and internal policies.

Together, these tools give your team visibility into AI activity and a way to evaluate whether usage meets your security and compliance standards.

## Discover AI interactions with DSPM for AI

DSPM for AI shows how users interact with AI tools across your Microsoft 365 environment. It can detect AI-generated prompts and responses, highlight when sensitive data is used, and surface usage trends across individuals, apps, and data.

You can use DSPM for AI to:

- Identify which AI tools are being used
- Detect prompts that reference sensitive files or overshared data
- View which users and data are most involved in AI interactions
- Review suggested protections based on how data is used

For non-Microsoft tools to appear in DSPM, they typically need to be registered through Microsoft Entra ID or integrated using a supported connector.

## Assess compliance readiness with Compliance Manager

Compliance Manager includes **premium templates** for assessing your compliance with AI-related regulations, such as:

- EU Artificial Intelligence Act
- ISO/IEC 23894:2023
- ISO/IEC 42001:2023
- NIST AI Risk Management Framework (RMF) 1.0

   :::image type="content" source="../media/compliance-manager-ai-regulations.png" alt-text="Screenshot showing a list of premium AI compliance templates, including NIST AI Risk Management Framework and ISO/IEC standards." lightbox="../media/compliance-manager-ai-regulations.png":::

These assessments help your organization evaluate how sensitive data is handled, how AI interactions are governed, and what safeguards are in place.

To create an assessment, you first assign it to a **group**. Groups let you organize assessments by regulation, business unit, or year. Controls can be shared across assessments in the same group, which lets you track common actions more efficiently.

> [!TIP]
> These templates apply to all supported generative AI tools, including Microsoft 365 Copilot, Security Copilot, ChatGPT Enterprise, and Azure AI services.

## Create an assessment using an AI regulation template

These assessments help you evaluate whether your organization' s use of AI tools aligns with regulatory expectations and internal policies.

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) and select **Solutions** > **Compliance Manager**.
1. Select **Assessments**, then choose **+ Add assessment**.
1. In the guided flow:

   - Select one of the AI regulation templates
   - Assign the assessment to a new or existing group
   - Review and confirm your settings

This creates an assessment where you can track Microsoft-managed and customer-managed actions that support AI compliance.

## Use DSPM for AI to support your assessments

If you're using **Data Security Posture Management (DSPM) for AI**, the **Recommendations** section can guide you through steps that align with regulatory requirements for AI usage.

One recommendation, **Get guided assistance to AI regulations**, maps to frameworks such as the NIST AI Risk Management Framework (RMF). It outlines a set of actions that support compliance and reduce risk across supported generative AI tools. These include:

- **Reviewing audit logs** to identify potentially inappropriate or sensitive interactions with AI apps
- **Monitoring activity in external AI tools**, such as browser-based or connected apps, and turning on policies to flag sensitive content
- **Creating Communication Compliance policies** to detect risky prompts or responses across generative AI tools
- **Using DLP policies** to restrict sensitive data from being shared in AI-enabled environments, such as Teams chat or non-Microsoft tools
- **Applying retention policies** to define how long AI interaction content is preserved and when it's deleted

Each action links directly to the relevant Microsoft Purview solution. You can configure these steps individually or use them as part of an AI regulation assessment in **Compliance Manager**.
