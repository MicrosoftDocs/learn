Deploying security controls isn't enough—organizations also need continuous monitoring to detect when those controls are being tested, bypassed, or failing. AI systems generate unique telemetry signals that, when properly monitored, can reveal attacks in progress and help security teams respond before damage occurs.

## Why AI-specific monitoring matters

Traditional application monitoring tracks metrics like response times, error rates, and resource utilization. While these metrics are still valuable for AI systems, they don't capture the AI-specific threats covered in this learning path. An AI system that's being actively attacked through prompt injection may show normal response times and zero application errors—the attack happens within the content of the interaction, not in the infrastructure.

AI-specific monitoring fills this gap by analyzing the content and behavior patterns of AI interactions, not just the infrastructure metrics.

## Key monitoring capabilities

### Prompt and response analysis

Monitor the content of AI interactions for signs of attack:

- **Jailbreak attempt detection**: Track prompts that match known jailbreak patterns (DAN prompts, crescendo sequences, encoding tricks). Even unsuccessful attempts provide intelligence about attacker techniques and intent.
- **Prompt injection indicators**: Monitor for inputs that contain instruction-like patterns, especially in fields that should contain data rather than commands. Watch for sudden changes in model behavior that might indicate a successful injection.
- **Content filter trigger rates**: Track how often content filters block inputs or outputs. A sudden increase in blocked content may indicate a targeted attack campaign.

### Agent behavior monitoring

For AI systems that use agents with tool-calling capabilities, monitor agent actions:

- **Tool call patterns**: Establish baselines for normal tool usage (which tools are called, how often, with what parameters). Alert on deviations—for example, an agent suddenly accessing a database it hasn't queried before.
- **Data access volumes**: Monitor the volume of data accessed per interaction. An unusually large data retrieval might indicate a data exfiltration attempt.
- **Action sequence analysis**: Track sequences of agent actions. Unexpected sequences—such as retrieving sensitive data immediately followed by formatting it for external transmission—may indicate compromise.

### Model behavior drift

Monitor the AI model's output characteristics over time:

- **Groundedness scores**: Track the percentage of grounded versus ungrounded responses. A decline in groundedness may indicate that grounding data has been tampered with or that the model is being manipulated.
- **Refusal rates**: Monitor how often the model refuses requests. A sudden drop in refusals could mean safety controls have been bypassed.
- **Output characteristics**: Track metrics like average response length, topic distribution, and sentiment. Significant shifts may indicate that the model's behavior has been altered through poisoning or manipulation.

## Building an AI security monitoring strategy

### Define what to log

At minimum, capture these data points for every AI interaction:

- User identity (or session identifier)
- Agent identity (if applicable)
- Input prompt (or a hash of it, if privacy requirements prevent storing full prompts)
- Content filter results (both input and output)
- Tool calls made and their parameters
- Data sources accessed
- Model response metadata (groundedness score, confidence indicators)
- Timestamps and session identifiers for correlation

### Set up alerting rules

Create alerts for conditions that indicate potential security incidents:

- Multiple content filter triggers from the same user or session in a short time period
- Successful responses to prompts that closely resemble known attack patterns
- Agent tool calls that access data outside the expected scope
- Sudden changes in model behavior metrics (groundedness, refusal rate, response patterns)

### Establish response procedures

Define how your team responds when monitoring detects a potential AI security incident:

- **Triage**: Determine whether the alert represents an actual attack, an attempted attack, or a false positive
- **Contain**: If an attack is confirmed, consider temporarily restricting the affected user's access or increasing content filter sensitivity
- **Investigate**: Analyze the full interaction history to understand the attack technique and assess whether any data was compromised
- **Remediate**: Update security controls (metaprompts, content filters, access policies) to prevent similar attacks
- **Report**: Document the incident and share lessons learned with the broader security team

:::image type="content" source="../media/ai-incident-response-flow.png" alt-text="Flowchart showing the AI security incident response procedure from monitoring alert through triage, containment, investigation, remediation, and reporting.":::

## Continuous improvement

AI security monitoring should be treated as an ongoing program, not a one-time setup:

- Regularly review alert effectiveness and tune thresholds to reduce false positives
- Update detection rules as new attack techniques emerge
- Conduct periodic reviews of monitoring coverage to ensure new AI features and capabilities are being tracked
- Use monitoring data to prioritize which security controls need strengthening

