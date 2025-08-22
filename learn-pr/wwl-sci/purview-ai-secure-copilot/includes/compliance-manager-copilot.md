Microsoft Purview Compliance Manager helps your organization assess how well it's meeting regulatory and industry standards, including emerging AI regulations. This includes guidance tailored to Microsoft 365 Copilot and other supported AI tools.

By using AI-focused assessment templates, you can identify compliance gaps, track remediation progress, and demonstrate readiness for audits or external reviews.

## Use AI regulation templates in Compliance Manager

Compliance Manager provides AI-focused templates that let you evaluate Copilot use against regulatory and industry standards. These templates show which protections are already in place and where gaps remain.

For example, a legal team might be asked to confirm that Copilot use meets regulatory standards. They might need to show that AI-generated content is retained, sensitive data is protected, and controls align with the EU AI Act. In that case, you can select a template, run an assessment, and review the results to see which actions are required.

Available templates include:

- EU Artificial Intelligence Act
- NIST AI Risk Management Framework (RMF)
- ISO/IEC 42001:2023 and 23894:2023

Each template maps regulatory expectations to specific Microsoft Purview controls, such as sensitivity labels, DLP, retention, and audit. The results show your organization's current compliance score and provide recommended actions you can assign to responsible staff.

> [!TIP]
> These templates apply to all supported generative AI tools, including Microsoft 365 Copilot, Security Copilot, ChatGPT Enterprise, and Azure AI services.

## Set up an assessment for Microsoft 365 Copilot

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) and select **Solutions** > **Compliance Manager**.
1. Select **Assessments**, then choose **+ Add assessment**.
1. In the guided flow:

   - Select one of the AI regulation templates
   - Assign the assessment to a new or existing group
   - Choose **Microsoft 365** as the service
   - Review and confirm your settings

      :::image type="content" source="../media/compliance-manager-nist-assessment.png" alt-text="Screenshot showing Compliance Manager with the NIST AI Risk Management Framework selected as a regulation for Microsoft 365 assessments." lightbox=" ../media/compliance-manager-nist-assessment.png":::

This creates an assessment where you can track Microsoft-managed and customer-managed actions that support AI compliance.

## Track Copilot-related controls and actions

Each assessment includes:

- **Controls** that evaluate how your organization governs data, manages AI risks, and applies responsible use practices.
- **Microsoft actions** that document how Microsoft services like Copilot align with the regulation.
- **Your improvement actions**, such as enabling DLP for AI, tagging sensitive data, or documenting review processes.

Use the **Progress**, **Controls**, and **Improvement actions** tabs to review your organization's alignment with each control.

> [!NOTE]
> If you've already implemented a control elsewhere (such as turning on sensitivity labels), you can reuse that action across assessments within the same group.

## Share assessment progress with stakeholders

Compliance Manager gives you several options for sharing or reviewing assessment data with others in your organization. From the assessment details page, select the **...** menu to:

- **Download as report**: Export a full summary of the assessment
- **Export actions**: Share a list of improvement actions in Excel format
- **Download evidence**: Export uploaded documentation for control validation

These exports can help legal, compliance, and audit teams review progress, validate control implementation, and prepare for external assessments. This supports transparency and simplifies compliance reviews.

## Use DSPM for AI to support your assessments

If you're using Data Security Posture Management (DSPM) for AI, the **Recommendations** section can guide you toward key configuration steps that support your AI-related assessments.

One such recommendation is **Get guided assistance to AI regulations**. This recommendation maps to the NIST AI Risk Management Framework (RMF) and provides a checklist of actions that help align your security controls with compliance goals. These include:

- **Reviewing audit logs** for Copilot interactions to detect misuse or unusual behavior
- **Reviewing activity from other AI apps**, such as connected or browser-based tools, and enabling policies to flag sensitive data
- **Creating Communication Compliance policies** that detect risky prompts or responses in Copilot and other AI interactions
- **Using DLP policies** to restrict how sensitive content is used in AI tools like Teams or Copilot
- **Applying retention settings** to manage how long Copilot-related content is preserved and when it's deleted

Each action links to the relevant Microsoft Purview solution, helping you quickly configure protections that contribute to a broader compliance posture. These steps can be completed individually or tracked as part of an AI regulation assessment in Compliance Manager.
