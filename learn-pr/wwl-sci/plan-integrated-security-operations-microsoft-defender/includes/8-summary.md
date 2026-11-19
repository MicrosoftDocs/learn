You can describe a phased adoption approach for Integrated Security Operations Center (ISOC) in Microsoft Defender. Your approach connects security operations needs to capabilities, preview requirements, and governance decisions.

## What you learned

- **Explain the operating model.** You connect XDR, SIEM, threat intelligence, automation, and AI while retaining human responsibility for response decisions.
- **Assess preview readiness.** You check eligible licenses, tenant state, permissions, and operational readiness before selecting capabilities.
- **Choose capabilities and a workspace approach.** You distinguish built-in capabilities from those that require an ISOC workspace.
- **Plan data and governance.** You separate native Defender data from connector-based ingestion, compare retention with requirements, and define scoped access, ownership, and costs.
- **Describe adoption phases.** You connect outcomes to owners, dependencies, validation measures, decision gates, and fallback criteria.

## Revisit the planning scenario

The team from the introduction needs shared investigation context, consistent case ownership, reporting, and repeatable workflows. For an eligible tenant without an active Microsoft Sentinel workspace, the plan starts with built-in case management and workbooks. A workspace and additional data enter the plan only when an approved outcome justifies their dependencies and costs.

The result is a planning approach, not deployed resources. Each phase has an owner, evidence of readiness, and a decision to proceed, adjust, pause, or stop. Existing Sentinel customers continue using their current experience rather than disconnect a production workspace to qualify. You revalidate preview eligibility and capability requirements before implementation and expansion.

## Learn more

- [ISOC in Microsoft Defender (preview)](/defender-xdr/isoc-overview)
- [Create an ISOC workspace in the Microsoft Defender portal (preview)](/defender-xdr/onboard-isoc-workspace)
- [Data ingestion and billing for ISOC in Microsoft Defender (preview)](/defender-xdr/integrated-security-operations-data-billing-retention)
- [Case management in the Microsoft Defender portal](/defender-xdr/siem-defender-case-management)
- [Create and manage workbooks with ISOC in Microsoft Defender (preview)](/defender-xdr/siem-defender-workbooks)

For an optional 18-minute overview, [watch the skilling session: Modernize SOC Operations with Microsoft Sentinel in Defender](https://aiskillsnavigator.microsoft.com/en-us/skillingsession/skillingsession-23d333709b958695cedbefac44cdd85647af336e5a977729261d16d7aaa17157). The session covers broader Sentinel-in-Defender scenarios, including workspace-based configurations. Use this module's preview-specific eligibility and capability guidance for ISOC planning. The session isn't required to complete this module and isn't included in its estimated duration.
