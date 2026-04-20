
Microsoft Sentinel integrates with Microsoft Security Copilot to bring AI-assisted capabilities directly into security operations workflows. Rather than replacing analyst judgment, the integration surfaces relevant context faster—so your team can investigate and respond to threats more efficiently.

## How the integration works

The integration between Microsoft Sentinel and Security Copilot works across two experiences:

- **The embedded experience in the Microsoft Defender portal**: Because Microsoft Sentinel incidents are unified with Microsoft Defender XDR incidents in the Defender portal, Security Copilot can assist with any incident—including those that originate in Microsoft Sentinel. Analysts can request an incident summary, get guided response suggestions, or generate a report, all without leaving the incident view.
- **The standalone Security Copilot experience**: Security Copilot can connect to Microsoft Sentinel as a data source through plugins. This allows analysts to ask questions about Microsoft Sentinel incidents and data in a conversational, chat-based interface.

:::image type="content" source="../media/copilot-incident-summary.png" lightbox="../media/copilot-incident-summary.png" alt-text="Screen capture of the Security Copilot incident summary for a Microsoft Sentinel incident, shown in the Microsoft Defender portal.":::

## What the integration enables

### Incident investigation

When you open a Microsoft Sentinel incident in the Defender portal, Security Copilot can generate a natural-language summary of the incident—describing what happened, which entities are involved, and what the likely impact is. This helps analysts quickly understand the scope of a threat without having to manually review every alert, log entry, and entity record.

Security Copilot also provides **guided response** recommendations—suggested next steps based on the incident details. These aren't automated actions; they're AI-generated suggestions that help analysts decide how to proceed, especially useful for less experienced team members or during high-volume periods.

For deeper investigations, the **Microsoft Sentinel incident investigation promptbook** in the standalone experience assembles a sequence of prompts automatically—retrieving the incident report, related alerts, reputation scores for associated entities, and details about users and devices involved. It gives analysts a structured starting point that would otherwise require multiple manual queries.

:::image type="content" source="../media/sentinel-promptbook.png" alt-text="Screen capture showing the Microsoft Sentinel incident investigation promptbook in the standalone Security Copilot experience.":::

### Natural language to KQL for threat hunting

Threat hunting in Microsoft Sentinel typically requires writing queries in Kusto Query Language (KQL), which has a learning curve. The **natural language to KQL** capability lets analysts describe what they're looking for in plain language, and Security Copilot generates a ready-to-run KQL query against Microsoft Sentinel data.

For example, an analyst can ask "Show me sign-in attempts from unfamiliar locations in the last 48 hours" and receive a KQL query they can run immediately or refine. This capability is available in both the standalone Security Copilot experience and the advanced hunting section of the Microsoft Defender portal.

:::image type="content" source="../media/advanced-hunting.png" lightbox="../media/advanced-hunting.png" alt-text="Screen capture of Security Copilot generating a KQL hunting query in the advanced hunting section of the Microsoft Defender portal.":::

This lowers the barrier to proactive threat hunting, allowing analysts who aren't KQL experts to search for suspicious activity across Microsoft Sentinel data without needing to know query syntax.

## Why this integration matters

Security operations teams deal with high volumes of alerts, complex investigations, and time pressure. The integration of Microsoft Sentinel with Security Copilot helps address those challenges by:

- **Reducing investigation time**: AI-generated summaries and guided responses help analysts understand incidents faster and act with more confidence.
- **Making hunting more accessible**: Natural language queries remove a technical barrier, enabling more analysts to participate in proactive threat detection.
- **Keeping humans in control**: Security Copilot provides suggestions and surfaces information—analysts make the final decisions.
