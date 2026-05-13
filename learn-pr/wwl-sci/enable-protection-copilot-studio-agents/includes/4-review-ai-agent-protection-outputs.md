After enabling real-time protection for Copilot Studio agents, you verify that the protection is active by reviewing outputs in three key areas of the Microsoft Defender portal. These outputs confirm that agent discovery is complete, alerts are flowing into the incident queue, and interaction data is available for threat hunting. Here, you learn how to verify each output area and confirm that protection is functioning end-to-end.

:::image type="content" source="../media/agent-protection-verification-outputs.png" alt-text="Three Defender portal panels showing AI Agent Inventory, Incidents and Alerts, and Advanced Hunting used to verify agent protection is active." lightbox="../media/agent-protection-verification-outputs.png":::

## Verify agent inventory in AI assets

The AI agent inventory provides the first confirmation that discovery and protection are active. Navigate to **Assets** > **AI assets** in the Microsoft Defender portal. This inventory displays all discovered Copilot Studio agents across your Power Platform environment.

> [!NOTE]
> The navigation label appears as **AI assets** or **AI Agents** depending on your Defender portal version. Both paths open the same AI agent inventory.

For each protected agent, the inventory shows:

- **Agent name** and the environment where it's deployed
- **Connection status**—Connected indicates real-time protection is active
- **Associated connectors**—SharePoint, Dataverse, external APIs, and other data sources
- **Risk signals**—Access to sensitive data, external exposure, or policy violations

The protected agent you configured in the previous unit should appear in this inventory with **Connected** status. If the agent shows **Disconnected**, return to the Security for AI settings to verify that the Power Platform administrator completed their configuration steps and that the App ID matches across both portals.

The inventory also lists the data sources each agent accesses. Verify that the agent's connectors align with your security policies. For example, if the agent is intended for external customer interactions, it shouldn't have access to internal SharePoint libraries containing confidential business data.

Agent makers can also verify protection status directly inside Copilot Studio without accessing the Defender portal. On the **Agents** page in Copilot Studio, a **Protection status** column shows one of three values for each published agent:

| Status | Meaning |
|--------|---------|
| **Protected** (green shield) | Threat detection is active and no policy violations detected |
| **Needs review** | Agent policies are violated or authentication is inadequate |
| **Unknown** | Protection status can't be determined |

This maker-visible status gives agent builders immediate feedback on protection health and surfaces issues—such as inadequate authentication or policy violations—that security engineers want to investigate.

## Review alerts and incidents in Defender XDR

Real-time protection generates alerts when suspicious interactions are blocked or when agent activity violates organizational policies. These alerts correlate into Microsoft Defender XDR incidents, giving security teams full context for investigation.

Navigate to **Incidents & alerts** > **Incidents** in the Microsoft Defender portal. Filter for incidents related to AI agents or Defender for Cloud Apps to see agent-related security events.

Each incident includes:

- The alert title and severity level
- The agent that triggered the alert
- The user or entity that initiated the interaction
- The blocked or suspicious action that generated the alert
- Related security signals from identity, endpoints, or cloud apps

> [!NOTE]
> If you don't see AI agent alerts immediately after enabling protection, a delay is expected. Alerts are generated when suspicious activity occurs or policies are violated. You need to wait for agent activity to trigger detections, or you can generate a test interaction to verify alert flow.

When reviewing incidents, look for alert categories specific to AI agents:

| Alert category | Description | Example scenario |
|----------------|-------------|------------------|
| Prompt injection detected | User input contains patterns consistent with prompt manipulation | External user attempts to override agent instructions with crafted prompts |
| Data exfiltration risk | Agent retrieves large volumes of sensitive content | Agent accesses more than 100 files from a confidential SharePoint library |
| Policy violation | Agent action violates organizational security policy | Agent attempts to execute a blocked connector or access restricted data |

These alerts confirm that Defender is actively monitoring and blocking threats in real time.

## Query Advanced Hunting for interaction data

Advanced Hunting provides the most granular view of agent activity. Navigate to **Hunting** > **Advanced Hunting** in the Microsoft Defender portal to access the query editor.

Agent interaction data appears in dedicated Advanced Hunting tables that log every tool invocation, data retrieval, and user interaction. Use KQL queries to search this data for suspicious patterns, compliance verification, or threat investigation.

Run this sample query to verify that agent interaction data is flowing:

```kusto
CloudAppEvents
| where Application == "Microsoft Copilot Studio"
| where Timestamp > ago(1h)
| project Timestamp, AccountDisplayName, ActivityType, ActivityObjects
| take 10
```

This query uses the `CloudAppEvents` table, which captures Agent 365 observability data including Copilot Studio agent actions, tool invocations, and data access events routed through the Microsoft 365 app connector.

For agent inventory and posture queries, use the companion `AIAgentsInfo` table, which contains configuration details for each discovered agent—including its name, tools, knowledge sources, authentication settings, and whether it's blocked by an administrator. For example:

```kusto
AIAgentsInfo
| summarize arg_max(Timestamp, *) by AIAgentId
| project AIAgentName, Platform, CreatorAccountUpn, AgentToolsDetails, IsBlocked
```

Use `CloudAppEvents` to investigate what an agent *did* at runtime, and `AIAgentsInfo` to assess how an agent is *configured* and whether it represents a posture risk.

If the `CloudAppEvents` query returns results, protection is active and logging agent interactions. If the query returns no results, verify that:

- Sufficient time passed since enabling protection (allow at least 30 minutes for initial data ingestion)
- The agent received user interactions that generate activity logs
- The Microsoft 365 app connector is connected in the Defender portal

Advanced Hunting enables proactive threat detection beyond automated alerts. Security teams create custom queries to identify emerging patterns such as:

- Agents accessing sensitive data sources outside normal business hours
- Repeated failed authentication attempts to agent-connected resources
- Unusual tool invocation sequences that indicate reconnaissance

## Confirm end-to-end protection for Contoso

After completing the configuration steps in the previous unit, Contoso's security engineer verified protection by reviewing all three output areas.

**AI agent inventory**: The customer service agent appeared in the AI assets inventory with **Connected** status. The inventory listed the SharePoint library connector and the Dataverse connection used for customer account lookups. The risk signal panel flagged the sensitive SharePoint library access, confirming that discovery identified the misconfiguration.

**Incidents and alerts**: Within hours of enabling protection, an alert appeared in the incident queue. A test interaction where an external user attempted to access the sensitive SharePoint library was blocked, and Defender generated a low-severity alert titled "AI agent policy violation." The incident included the blocked SharePoint request and the user who initiated the conversation.

**Advanced Hunting**: The security engineer ran a query against agent interaction data and confirmed that tool invocations from the customer service agent were being logged. The query returned results showing successful Dataverse lookups for customer account balances and the blocked SharePoint access attempt.

With all three verification steps complete, Contoso confirmed that real-time protection is active and functioning end-to-end. The agent continues to serve legitimate customer inquiries while Defender blocks attempts to access sensitive data that shouldn't be exposed through the agent interface.
