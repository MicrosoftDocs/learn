AI agents and copilots can introduce risk if they're used to access or share sensitive data in unsafe ways. Prompt injection, inappropriate use, and unauthorized sharing are all possible concerns—especially in environments where users are working with sensitive or regulated information.

Microsoft Purview includes several tools that allow you to investigate and respond to risky activity across AI interactions. Insider Risk Management, Communication Compliance, and Audit each provide visibility into different aspects of AI usage so you can assess behavior and take appropriate action.

## Use Insider Risk Management to detect unsafe behavior

Insider Risk Management helps detect risky patterns based on user behavior. When users repeatedly try to extract sensitive data or engage in suspicious AI activity, risk signals can trigger alerts for review.

You can configure insider risk policies to look for AI-specific activity, such as:

- Attempting to bypass safeguards using prompt injection techniques
- Interacting with large amounts of high-sensitivity content
- Submitting prompts that indicate potential data misuse

AI-specific signals appear as **AI interactions** in policy conditions and in the activity timeline. Alerts are generated when users meet risk thresholds and show signs of intent to violate policy. From there, analysts can review the event timeline, investigate the context, and decide on escalation or corrective action.

> [!NOTE]
> To detect AI interactions in Insider Risk Management, logging must be enabled for the agents in use, and users must be included in the policy scope.

## Use Communication Compliance to detect and assess prompt risks

Communication Compliance helps identify prompts that may violate organizational policies or present potential risks. It allows compliance reviewers to analyze prompt content and surface patterns of concern before they escalate.

You can use Communication Compliance policies to detect:

- Prompts that include abusive, offensive, or discriminatory language
- Attempts to use AI to generate misleading, harmful, or inappropriate responses
- Input that includes sensitive personal or financial information

When policy conditions are met, the interaction is flagged for review. Reviewers can evaluate the context, determine whether the prompt presents a risk, and take appropriate action, such as tagging the item, sending a notice, or escalating the case.

To analyze AI-related prompt content using Communication Compliance, configure a policy with **AI interactions** as the communication source.

## Use Audit to investigate AI usage

Microsoft Purview Audit includes event logs that show when and how AI was used across your Microsoft 365 environment. These events don't capture prompt content, but they do provide important metadata that can support investigations.

Audit logs can show:

- Which user interacted with an agent or copilot
- When the interaction occurred
- Which app or service was involved

Audit search filters let you isolate AI activity by time range, user, and event type. This supports investigation timelines and allows you to validate whether other tools, such as Insider Risk Management or eDiscovery, need to be used.
