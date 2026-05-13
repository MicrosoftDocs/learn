Microsoft Purview Data Security Posture Management for AI gives Contoso Financial Services' security team what they were missing: visibility into how AI tools interact with organizational data, which SharePoint sites expose sensitive content to Copilot grounding, and which interactions involve classified data that requires follow-up.

## Review what you accomplished

You configured DSPM for AI in the Microsoft Purview portal, enabling the posture management dashboard that continuously monitors AI tool interactions across your Microsoft 365 environment. The configuration required Microsoft Purview Audit to be enabled and Microsoft 365 Copilot licenses assigned to users—the two primary prerequisites that unlock interaction monitoring. Sensitivity labels aren't a hard requirement to enable DSPM for AI, but they're the highest-value next step: without them, the dashboard surfaces only pattern-based detection such as credit card numbers and SSNs. With labels applied, you gain full risk prioritization, label-scoped remediation actions, and the ability to restrict Copilot access by classification.

With the dashboard active, you assessed SharePoint overexposure by reviewing which sites are being used as AI grounding sources and how many sensitive files they contain. The overexposure view prioritizes sites by label severity, giving you a clear starting point for restricting access or applying more protection. In the Contoso scenario, the quarterly earnings SharePoint site—broadly shared and unlabeled—moved immediately to the top of the remediation queue.

You also reviewed interaction risks, which surface instances where Copilot or AI applications referenced content classified by Microsoft Purview sensitivity labels. Each risk entry links to the label policy, the SharePoint location, and the relevant DLP configuration—so DSPM for AI doesn't just show you problems, it connects you to the controls that address them.

In this module, you learned how to:

- Configure Microsoft Purview Data Security Posture Management (DSPM) for AI
- Assess SharePoint data overexposure risks that affect AI grounding data
- Identify sensitive data risks in Copilot and AI application interactions
- Interpret DSPM for AI dashboards and prioritize remediation actions

## What's next

Data risk visibility is your foundation. The next step is securing the identities that AI agents use to act on that data. In the next module, you'll configure Conditional Access policies for agent identities in Microsoft Entra Agent ID—controlling when and how agents can authenticate to Microsoft services.
