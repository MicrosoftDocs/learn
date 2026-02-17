Microsoft 365 Copilot accesses organizational data based on each user's existing permissions, which means any gaps in your data security controls are amplified when Copilot surfaces content that users can technically access but shouldn't see. As a security architect, you need to evaluate the data security and compliance controls that govern how Copilot interacts with your organization's data, and design solutions that prevent oversharing, protect sensitive information, and meet regulatory obligations.

## Evaluate the Copilot data access model

Microsoft 365 Copilot operates within the user's identity and tenant context. It only returns data that the individual user has at least view permissions to access, enforced through Microsoft Entra ID and existing Microsoft 365 access controls. The [semantic index](/microsoftsearch/semantic-index-for-copilot) respects identity-based access boundaries during the grounding process, which means Copilot never retrieves content the user isn't authorized to view.

This permission-based model means your existing access control weaknesses become Copilot's weaknesses. If SharePoint sites have overly broad sharing settings or if sensitivity labels aren't applied consistently, Copilot can surface that content in responses. Evaluating your data access posture before or alongside Copilot deployment is essential.

[Microsoft Purview Data Security Posture Management (DSPM) for AI](/purview/dspm-for-ai) serves as the central hub for assessing and managing data risks related to Copilot. DSPM for AI automatically runs weekly data risk assessments across the top 100 SharePoint sites used in your organization, identifying potential oversharing issues. Key capabilities include:

- **Data risk assessments** that identify sites where sensitive data is exposed through Copilot interactions, with recommendations to remediate oversharing.
- **One-click policies** that create preconfigured Purview policies for sensitivity labels, risky AI usage detection, and DLP enforcement specific to Copilot.
- **Activity reports** that show total interactions, sensitive interactions per AI app, top sensitivity labels referenced in Copilot responses, and insider risk severity metrics.

## Evaluate data protection controls

Several Microsoft Purview capabilities provide layered data protection for Copilot interactions. Evaluate each control to determine how it fits your organization's risk profile.

### Sensitivity labels

[Sensitivity labels](/purview/sensitivity-labels) add protection beyond the basic permission model. When Copilot processes labeled content:

- Labels with encryption require the user to have both the **VIEW** and **EXTRACT** [usage rights](/purview/ai-m365-copilot-considerations) for Copilot to return the data. Without the EXTRACT right, Copilot can't process the content even if the user can open it manually.
- Microsoft 365 Copilot Chat displays the highest-priority sensitivity label from all data used in a response, educating users about the sensitivity of the information they're working with.
- When users create new content with Copilot in Word or PowerPoint from a labeled source file, the sensitivity label is **automatically inherited** by the new document, including its protection settings.

Items encrypted with [Double Key Encryption (DKE)](/purview/double-key-encryption) are excluded from Copilot processing entirely, because Microsoft can't access the content without the customer's key.

### Data loss prevention

[DLP policies for the Microsoft 365 Copilot and Copilot Chat location](/purview/dlp-microsoft365-copilot-location-learn-about) provide two protection mechanisms:

| DLP capability | How it protects Copilot interactions |
|---|---|
| **Block sensitive information types in prompts** | Prevents Copilot from responding when a user's prompt contains sensitive data, such as credit card numbers or Social Security numbers. Copilot doesn't process the prompt for internal or web searches. |
| **Block files and emails with sensitivity labels** | Prevents Copilot from processing items with specific sensitivity labels in response summaries. The item might appear in citations, but its content isn't used in the response. |

These DLP controls apply across Microsoft 365 Copilot, Copilot Chat, Copilot in Word, Excel, and PowerPoint, and extend to prebuilt agents in Copilot.

### Insider Risk Management

The [risky AI usage policy template](/purview/insider-risk-management-policy-templates#risky-ai-usage) in Microsoft Purview Insider Risk Management detects anomalous AI interactions, including prompt injection attempts and attempts to access protected materials. Signals from these detections integrate with Microsoft Defender XDR to provide a unified view of AI-related user risks. Combined with [Adaptive Protection](/purview/insider-risk-management-adaptive-protection), high-risk users can be automatically blocked from accessing sensitive content through Copilot.

## Evaluate compliance controls

Beyond data protection, security architects must evaluate controls for auditability, retention, legal discovery, and regulatory compliance.

### Auditing

[Microsoft Purview Audit](/purview/audit-copilot) captures all Copilot interactions in the unified audit log, including prompts, responses, referenced files, the Microsoft 365 service where the interaction occurred, and any sensitivity labels applied to referenced content. These audit events flow into DSPM for AI activity explorer, where compliance administrators can review interaction details.

### eDiscovery

Because Copilot stores prompt and response data in the user's mailbox, [Microsoft Purview eDiscovery](/purview/edisc) can identify, preserve, and export these interactions. You can use the query condition **Type** > **Contains any of** > **Copilot activity** to search for all Copilot interactions across user mailboxes. This capability supports legal hold, investigation, and regulatory response scenarios.

### Data Lifecycle Management

[Retention policies](/purview/retention-policies-copilot) for the **Microsoft Copilot Experiences** location let you automatically retain or delete Copilot interaction data based on your organization's retention schedule. Additionally, autoapply retention label policies can retain the exact version of files referenced in Copilot interactions by selecting the cloud attachments option that includes Copilot.

### Communication compliance

[Communication compliance policies](/purview/communication-compliance-copilot) can monitor Copilot prompts and responses for regulatory violations, business conduct issues, or inappropriate content. This control is particularly relevant for regulated industries where AI-generated content must meet the same compliance standards as other business communications.

### Compliance Manager

[Microsoft Purview Compliance Manager](/purview/compliance-manager) provides regulatory templates specifically for AI use cases, helping you assess, implement, and track compliance controls for generative AI applications against frameworks such as the EU AI Act and NIST AI Risk Management Framework (AI RMF). The DSPM for AI recommendation **Get guided assistance to AI regulations** connects directly to these templates.

## Design considerations for security architects

When you evaluate data security and compliance controls for Microsoft 365 Copilot, consider the following approaches:

- **Assess oversharing before deployment.** Use DSPM for AI data risk assessments and SharePoint Advanced Management data access governance reports to identify sites with overly broad permissions. Remediate critical oversharing issues before enabling Copilot for affected user groups.
- **Implement sensitivity labels with EXTRACT controls.** Ensure your most sensitive content has labels that require the EXTRACT usage right. This prevents Copilot from processing highly confidential data even when users have view access.
- **Layer DLP policies for Copilot.** Create separate DLP rules for blocking sensitive information types in prompts and for excluding files with specific sensitivity labels from Copilot processing. These conditions can't be combined in a single rule but can coexist in the same policy.
- **Enable Insider Risk Management for AI.** Activate the risky AI usage template to detect anomalous Copilot behavior. Pair it with Adaptive Protection to dynamically restrict high-risk users from accessing sensitive content through Copilot.
- **Establish retention and audit policies early.** Configure retention policies for Copilot interactions and confirm that auditing is enabled before deployment. This ensures you have a complete record of AI interactions from the start for compliance and incident response.
- **Use DSPM for AI as your central dashboard.** Consolidate your monitoring through the DSPM for AI Microsoft 365 Copilot view, which provides a single pane for oversharing assessments, policy recommendations, and activity reporting.


