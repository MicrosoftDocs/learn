Some agents only need to be added to existing policies. Others need policy redesigns to account for behavioral differences. Some are already covered and need no changes. For each agent and capability, check whether your current policy already covers agent interactions or whether you need agent-specific configuration.

## Evaluate each agent type

For each active agent type you found during discovery, work through these questions against your existing policies:

1. **Is the capability available for this agent type?** Check the coverage matrix. If the agent's parent app doesn't support data loss prevention (DLP), no DLP configuration will help.
1. **Is the agent instance explicitly included in existing policies?** Most capabilities require you to include agent instances in policies as you would a user. If your policy scopes to specific users or groups, check whether agent instances are in scope.
1. **Do Agent 365 behavioral differences affect how the policy works?** For Agent 365 instances, even when you add them to a policy, the behavioral differences might change whether the policy achieves its intended outcome.

Work through each available capability for each high-priority agent. Each agent-capability combination usually falls into one of these categories:

- **Already covered**: The policy already includes the agent instance or scopes broadly enough to capture it, and no behavioral differences undermine effectiveness.
- **Needs agent instance inclusion**: The capability is available and your policy logic is correct, but the agent instance isn't in scope. Adding it to the policy or a security group resolves the gap.
- **Needs design changes**: The capability is available and the agent is in scope, but Agent 365 behavioral differences mean the policy won't work as designed without further changes.

## Check coverage capability by capability

For each high-priority agent, verify coverage across DLP, Insider Risk Management (IRM), and communication compliance:

| Capability | What to verify | Agent-specific consideration |
| --- | --- | --- |
| DLP | Agent instance or group is in policy scope. Both directions covered (agent-to-human and human-to-agent). | Agent 365 doesn't receive block notifications. Set up alert review for the agent owner. |
| IRM | Agent instances included in policy scope with appropriate template. | Risky AI usage template covers Agent 365. Confirm agent instance is explicitly included. |
| Communication compliance | Policy includes generative AI app locations: Microsoft Copilot experiences, Enterprise AI apps, Other AI apps. | Without these locations, agent interactions with inappropriate content go undetected. |

Policies that only target human users miss agent interactions entirely, even when the agent is behaving in ways that would trigger alerts for a human user.

## How Agent 365 handles policies differently

Agent 365 supports the full range of Purview capabilities, but introduces behaviors that change whether policies achieve their intended outcome. These differences apply even when Agent 365 instances are correctly added to policies.

- **Files must be explicitly shared with agent instances.** Agent 365 instances don't automatically have access to files that users can reach. Factor this into your access planning alongside DLP and label configurations.

- **Encryption requires explicit usage rights.** Sensitivity labels with encryption must grant Agent 365 instances VIEW and EXTRACT rights. Content encrypted without a sensitivity label is inaccessible to Agent 365 entirely.

- **Newly created content doesn't inherit sensitivity labels.** A summary of a "Highly Confidential" document carries no label. Decide whether this gap requires autolabeling rules or a downstream labeling process.

- **Agent instances are unaware of DLP block actions.** The agent continues operating without notification. The agent owner must check DLP alerts to identify broken workflows.

## When protection falls short, use detection

When protection can't fully prevent data exposure for an agent type, detection must catch the residual risk. Use this relationship to prioritize:

- If DLP can block an agent's access to sensitive content, detection is an oversight layer.
- If DLP is available but limited in effectiveness due to Agent 365 block-action unawareness, detection becomes the primary control for understanding what's happening.
- If DLP is unavailable for an agent type, like Security Copilot or Facilitator, detection through IRM or communication compliance is the only signal available.

After working through each agent, you should know which policies to configure, what type of change each one needs, and where detection substitutes for protection.

Some agent types won't have full coverage regardless of what you configure. Security Copilot has no DLP. Facilitator has no IRM. ChatGPT Enterprise has no sensitivity labels. When you encounter one of these limits, document the gap, check whether detection covers the residual exposure, and surface whatever's left to whoever needs to formally accept it.
