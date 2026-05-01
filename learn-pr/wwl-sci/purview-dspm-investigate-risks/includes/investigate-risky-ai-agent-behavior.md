AI agents in your organization interact with sensitive data at scale. They access files, respond to prompts, surface content to users, and communicate with other agents and tools. When an agent's behavior deviates from its intended function or accesses data beyond its scope, that's a data security risk worth investigating.

AI observability in DSPM is the surface for this investigation. It shows which agents are active, which ones are flagged as high risk, and what risky activity categories apply to each. The investigative question is whether a flagged agent's behavior represents a genuine risk or normal operation for that agent's purpose.

## AI observability for investigation

AI observability is accessible from **DSPM (preview)** > **AI observability**. The page shows:

- All AI apps and agents with activity in the last 30 days
- How many are classified as high risk, as determined by Insider Risk Management
- Total agents with sensitive interactions
- A breakdown of individual agents with policies governing them

Discovery asks "what agents exist?" Investigation asks "what is this specific agent doing that concerns me, and is it a problem?"

## Drilling into a specific agent

When you select a specific agent from the AI observability page, you see detailed information:

- **Agent details**: Entra-enabled status, created date, owner, agent user ID, and which parent agent it's an instance of
- **Agent activities**: The risk level determined by Insider Risk Management and risky activities from agent interactions
- **Recommendations**: Remediation suggestions based on identified risks

The agent details help you understand context. An agent's owner, creation date, and parent identity tell you who's responsible and what the agent was designed to do. This contextual information is critical when evaluating whether the agent's behavior represents a misconfiguration, intended functionality, or a genuine risk.

## Interpreting agent risk signals

Insider Risk Management determines a risk level for agents based on their interaction patterns. The top risky activity categories for agents include:

- **Oversharing**: The agent shared sensitive data more broadly than appropriate, such as surfacing sensitive content to users who shouldn't access it or sharing beyond its intended scope
- **Exfiltration**: The agent moved sensitive data outside the organization's boundaries through unauthorized channels
- **Unethical behavior**: The agent's interactions violated organizational policies or produced outputs that conflict with data security requirements

Each category points to a different investigation approach. An agent flagged for oversharing requires examining what data it accessed and whom it shared with. An agent flagged for exfiltration requires tracing where data went. An agent flagged for unethical behavior requires reviewing the nature of its outputs.

## Agent-specific signals vs. human user signals

AI agent investigation differs from human user investigation in ways that affect how you interpret what you see:

- **Volume**: Agents can process far more interactions per hour than humans. A "spike" in agent activity might be normal operational behavior, while the same spike for a human would indicate something unusual.
- **Access scope**: Agents often have broader data access than individual users because they're designed to serve multiple people or process data across workloads.
- **Autonomy**: Agents act without real-time human approval for each interaction. Risky behavior can occur at scale before anyone notices.
- **Identity relationship**: An agent has both its own identity and an owner, the human who created or manages it. Risk can originate from the agent's configuration, from the owner's decisions, or from the systems the agent accesses.

These differences mean you can't apply human-investigation patterns directly to agent investigation. An agent accessing 500 sensitive files in an hour might be normal operation or might indicate a misconfiguration. The risk assessment depends on what the agent is designed to do and whether its actual behavior matches that design.

## Agent 365 and AI observability

AI observability includes Agent 365 activity, while the **Discover** > **Apps and agents** page does not. This distinction matters for investigation. If you're looking for agent behavior data, you need to navigate to AI observability to see the complete picture, including Agent 365 interactions.

Agent 365 interactions include agent-to-human, human-to-agent, agent-to-tools, and agent-to-agent communications. These are captured in the audit log and surfaced in the AI activities tab in activity explorer. When investigating a specific Agent 365 instance, you can cross-reference its AI observability risk data with its audit log activity for a complete picture.

## Investigation workflow for a risky agent

When AI observability flags an agent as high risk, a typical investigation follows this pattern:

1. Review the agent's risk level and risky activity categories in AI observability.
1. Examine the agent details to understand its purpose, owner, and configuration context.
1. Check sensitive interactions to see what data the agent accessed and whether those interactions are consistent with its intended function.
1. Cross-reference with the audit log for the chronological record of the agent's activities.
1. Evaluate whether the behavior represents a configuration issue that the owner can fix, an access scope issue that requires policy adjustment, or a genuine security risk that requires immediate response.

The goal is to determine whether the agent's behavior represents an active risk and what the nature of that risk is. Whether the response is a policy change, an access restriction, or an agent reconfiguration depends on what your investigation reveals and which team owns the agent.