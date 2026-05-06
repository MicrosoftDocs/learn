Contoso Financial Services' external facing Copilot Studio agents were operating without any runtime inspection. User interactions passed directly between agents and their connected data sources—no visibility, no record, no ability to detect or block suspicious behavior. This module changed that.

## Review what you accomplished

You explored the three capability pillars of Microsoft Defender for Cloud Apps AI agent protection:

- discovery and hunting to find agents and query their activity.
- audit and alerts to surface policy violations.
- real-time runtime protection to inspect and intercept interactions before they complete.

Understanding these pillars matters. Each pillar has different setup requirements and provides different types of value—discovery is automatic, while real-time protection requires explicit configuration.

You configured real-time protection by navigating to **System** > **Settings** > **Security for AI agents** in the Microsoft Defender portal, registering the target Copilot Studio agent by App ID, and coordinating with the Power Platform admin to configure the Defender App ID in the Power Platform admin center. The two-admin coordination requirement is by design—runtime protection requires changes on both the security and platform administration sides, and the Connected status indicator in the Security for AI settings page confirms when both steps are complete.

You also explored agent identity—how Copilot Studio automatically assigns each agent a Microsoft Entra Agent ID (a Microsoft Entra service principal with an "Agent" subtype) that enables Conditional Access policies, centralized audit logging, and Zero Trust lifecycle management. This identity is distinct from the proxy App ID exchanged during real-time protection setup.

You then verified protection outputs across three surfaces:

- the AI assets inventory in Microsoft Defender XDR (confirming the agent appears with Connected status and connector data).
- the Incidents view (confirming alerts flow and correlate).
- Advanced Hunting (confirming agent interaction data is queryable).
 
Verification isn't optional—Connected status confirms the proxy is in place, but checking the outputs confirms data is flowing end-to-end.

In this module, you learned how to:

- Describe the AI agent protection capabilities available in Microsoft Defender for Cloud Apps
- Enable real-time protection for Copilot Studio agents in the Microsoft Defender portal
- Verify that agent protection outputs appear in the Microsoft Defender XDR inventory, alerts, and Advanced Hunting
