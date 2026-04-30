Objectives tell you that AI risk exists. AI observability shows which apps and agents are driving it, how risky they are, and whether any policies already apply. Knowing that Copilot interacted with sensitive data 4,000 times last month is a starting point. Knowing which three agents account for most of those interactions, and that none of them are governed, is what you actually act on.

## Assess AI risk at the agent level

The AI observability page opens with summary metrics covering the last 30 days: total AI apps and agents, agents by risk level, and agents with sensitive interactions broken down by risk type, including oversharing, exfiltration, and unethical behavior. These give you a quick read on whether AI risk is broad or concentrated, and what type of risk dominates.

:::image type="content" source="../media/discover-ai-observability.png" alt-text="Screenshot showing the AI observability page with summary metrics at top and an agent list showing risk level, policy count, and activity trend.":::

The more important assessment happens at the individual agent level. Two signals matter most:

**Policy coverage per agent:** An agent showing "0 Policies" with a high risk level and active oversharing is ungoverned risk. The agent interacts with sensitive data, is flagged as high risk, and nothing restricts its behavior. Compare that to an agent with the same risk profile but policies in place. The governed agent still carries risk, but controls exist to limit exposure. The presence or absence of policies changes what "high risk" means in practice.

**Activity trend per agent:** A high-risk agent with an increasing activity trend is a higher priority than one with stable or declining activity. The risk level tells you the severity. The trend tells you the urgency. Combine both to decide where to investigate first.

Agents showing "No data available" under risk types don't have enough signal for assessment. That doesn't mean they're safe. It means they aren't assessed yet, which is itself a gap worth noting.

## Where to find Agent 365

Data Security Posture Management (DSPM) includes two places to view AI apps and agents, and they don't show the same data.

- **AI observability** includes Microsoft Agent 365 along with all other AI apps and agents.
- **Discover > Apps and agents** shows AI apps and their agents used across the organization, but doesn't include Agent 365.

If your organization uses Agent 365, the AI observability page is where that coverage appears.

> [!IMPORTANT]
> For a complete inventory of AI apps and agents including Agent 365, use the **AI observability** page rather than **Discover > Apps and agents**.

## Connect findings to objectives

AI observability adds specificity to the priority judgments you formed from objectives. If a data protection objective flagged Copilot interactions as high risk, AI observability shows which agents are responsible and whether they're governed. If most high-risk agents already have policies applied, the objective's urgency might be lower than the count alone suggests. If most show "0 Policies," the gap is confirmed and the risk is unmitigated.
