AI agents access sensitive data at scale across workloads. When their behavior deviates from intended use or scope, you need to determine whether it's a misconfiguration, a policy gap, or an active security risk.

AI observability in Data Security Posture Management (DSPM) is the surface for this. It shows which agents are active, which are flagged as high risk, and what risky activity categories apply to each.

## AI observability for investigation

AI observability is accessible from **DSPM (preview)** > **AI observability**. The page shows all AI apps and agents with activity in the last 30 days, how many are classified as high risk by Insider Risk Management, and a breakdown of individual agents with the policies governing them.

Discovery asks "what agents exist?" Investigation asks "what is this specific agent doing that concerns me, and is it a problem?"

:::image type="content" source="../media/ai-observability-metrics.png" alt-text="Screenshot showing the AI observability landing page with key metrics for total agents, high risk agents, and agents with sensitive interactions." lightbox="../media/ai-observability-metrics.png":::

## Drilling into a specific agent

When you select a specific agent from the AI observability page, you see:

- **Agent details**: Entra-enabled status, name, created date, owner, agent user ID, policies applied, and which agent it's an instance of
- **Agent activities**: The risk level determined by Insider Risk Management, active insider risk alerts, and a count of risky activities from agent interactions
- **Recommendations**: Remediation suggestions based on identified risks

An agent with zero policies applied and no owner listed is a different risk conversation than one with 17 data protection policies and a known team behind it. The details section tells you which conversation you're having.

From the activities section, you can navigate directly to the insider risk alerts driving the agent's risk score. This lets you see whether triage agents have already categorized those alerts and whether their categorization matches what you're observing in the agent's behavior patterns.

:::image type="content" source="../media/ai-observability-app-detail.png" alt-text="Screenshot showing the agent detail page in AI observability with agent details, risk level, active insider risk alerts, and risky activities count." lightbox="../media/ai-observability-app-detail.png":::

## Interpreting agent risk signals

Insider Risk Management determines a risk level for agents based on their interaction patterns. The top risky activity categories are:

- **Oversharing**: The agent shared sensitive data more broadly than appropriate, such as surfacing content to users who shouldn't have access
- **Exfiltration**: The agent moved sensitive data outside the organization's boundaries through unauthorized channels
- **Unethical behavior**: The agent's interactions violated organizational policies or produced outputs that conflict with data security requirements

Each category leads to a different investigation path. Oversharing means examining access scope and audience. Exfiltration means tracing where data went. Unethical behavior means reviewing outputs and policy configuration.

## Agent-specific signals vs. human user signals

Agents process more interactions per hour, have broader data access, and act without real-time human approval. This means you can't apply human-investigation patterns directly. A spike for a human is unusual, but the same spike for an agent might be normal operation.

Agents also have a dual identity: the agent itself and its owner. Risk can originate from the agent's configuration, from the owner's decisions, or from the systems the agent accesses. An agent doing what it's designed to do but with overly broad access is a policy gap. An agent doing things it wasn't designed to do is a configuration or security issue. Identifying which you're looking at determines the response.

> [!NOTE]
> AI observability includes Agent 365 activity. The **Apps and agents** page doesn't. Use AI observability when investigating agent behavior.

## Investigation workflow for a risky agent

When AI observability flags an agent as high risk, a typical investigation follows this pattern:

1. Review the agent's risk level and risky activity categories in AI observability.
1. Examine the agent details to understand its purpose, owner, and configuration context.
1. Check sensitive interactions to see what data the agent accessed and whether those interactions are consistent with its intended function.
1. Cross-reference with the audit log for the chronological record of the agent's activities.
1. Evaluate whether the behavior represents a configuration issue, an access scope issue, or a security risk. The answer determines whether the owner fixes it, a policy needs adjustment, or immediate response is required.
