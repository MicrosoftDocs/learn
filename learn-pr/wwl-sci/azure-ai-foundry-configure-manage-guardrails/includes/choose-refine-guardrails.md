
Effective security requires more than simply deploying controls. It involves choosing the right ones and validating that they work as intended. In **Azure AI Foundry**, guardrails let you design protections that fit the sensitivity, scale, and purpose of each workload.

## Select appropriate controls

Every AI workload carries different levels of risk depending on where data comes from, who uses it, and how results are consumed.

Consider this guidance when selecting controls for your workloads:

- **Content filters**: Best for broad classification and harm detection across large or public-facing workloads. They provide real-time evaluation of input and output content.
- **Blocklists**: Ideal for precise policy enforcement, like blocking project names, code tokens, or regulated identifiers.
- **Prompt Shields**: Essential when models are exposed to end users or connected systems where prompt injection and jailbreak risks are higher.
- **Groundedness detection**: Useful for workloads that depend on verified data sources, like analytics or knowledge retrieval scenarios.
- **Protected material detection**: Important for environments that generate or reuse text and code to ensure no confidential or non-Microsoft content is returned.

Selecting the right combination helps make sure each workload has controls tailored to its risk profile rather than a one-size-fits-all approach.

## Balance safety and usability

Guardrails protect your organization, but they also need to support productivity. Overly strict filters or blocklists can create friction, limit experimentation, or generate false positives that slow teams down.

When tuning guardrails:

- Start with **moderate thresholds**, then increase enforcement based on testing and feedback.
- Use **annotations** where possible before blocking outright, especially during early rollout.
- Review logged events to understand which content is being blocked and why.
- Collaborate with product or development teams to make sure policies reflect practical use, not just theoretical risk.

Balancing safety and usability helps build trust in your governance model and ensures that security controls become part of everyday practice rather than an obstacle to innovation.

## Review guardrail effectiveness

Once your guardrails are active, review their performance using the observability data available in Azure AI Foundry.
Logs and insights show which rules are triggered most often, which content categories are being blocked, and how frequently users encounter annotations or warnings.

Use this information to refine your configurations:

- Identify categories that produce excessive false positives or negatives.
- Tune thresholds and detection actions to maintain protection without unnecessary disruption.
- Cross-reference activity with incident data or security alerts to confirm alignment between policy intent and real-world behavior.

Regular review ensures your guardrails remain relevant and aligned with evolving risk.

## Maintain continuous assurance

AI security isn't static. As models, data, and user behavior evolve, guardrail configurations should be reviewed regularly to confirm they still meet organizational standards.

- Schedule periodic audits of configurations and logs.
- Review detections in the **Guardrails + controls** workspace for signs of new or emerging risk patterns.
- Update blocklists, thresholds, and detection settings to respond to new findings or regulatory changes.

**Azure AI Foundry** integrates with **Microsoft Defender for Cloud** to surface **security recommendations** related to your AI resources. These insights highlight platform-level risks like missing diagnostic logs, open network access, or local authentication settings. Addressing them helps ensure that both your AI-layer guardrails and the underlying Azure environment remain secure and compliant.

Maintaining continuous assurance builds confidence that your controls are implemented effectively, measurable over time, and adaptable as risks evolve. By selecting the right mix of guardrails and balancing safety with usability, you create a protection framework that grows with your AI environment and keeps every workload, whether experimental or production, operating securely and in line with your organization's risk posture.
