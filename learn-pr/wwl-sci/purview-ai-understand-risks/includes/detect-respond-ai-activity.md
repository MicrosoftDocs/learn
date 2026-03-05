Not all AI activity is safe. Prompts might expose sensitive data, surface regulated information, or suggest behavior that violates organizational policies. Microsoft Purview includes several tools that let you detect these risks and respond in a structured way.

Insider Risk Management and Communication Compliance focus on identifying risky AI interactions, while Adaptive Protection applies stronger controls when a user's behavior raises concern.

## Detect risky prompts with Insider Risk Management

Consider a scenario where a user submits dozens of prompts in a short time, some of which contain confidential contract data. This kind of activity can be difficult to catch manually.

**Insider Risk Management** includes policy templates that help flag risky AI behaviors such as:

- Excessive prompt activity within a short period
- Prompts that include sensitive or confidential information
- Repeated access to high-value files before prompting

The **Risky AI usage** and **Risky browser usage (preview)** templates are designed specifically to identify patterns like these. When thresholds are met, the activity is flagged for review in an alert.

To refine detections, you can combine these policies with **priority user groups**, **notice templates**, and signals from **Microsoft Defender for Endpoint**. This strengthens the signal quality so that alerts focus on activity most likely to represent a real risk.

## Analyze AI interactions for policy violations

AI-generated content should be reviewed with the same level of care as email or Teams messages. **Communication Compliance** allows organizations to evaluate prompts and responses for alignment with policy.

For example, reviewers can be notified when:

- Prompts contain personal data or sensitive business details
- Responses surface confidential or regulated data
- Interactions include offensive or inappropriate content

When a violation is detected, reviewers can tag it, notify the user, escalate it to a manager, or preserve the interaction for investigation. This ensures AI use is governed alongside other communication channels.

## Apply controls with Adaptive Protection

Sometimes detection isn't enough, especially if risky behavior continues. **Adaptive Protection** can help by applying stronger controls when Insider Risk Management raises a user's risk level. For example, a user flagged for risky AI activity could be:

- Blocked from sharing files externally
- Prevented from uploading or pasting content into AI tools by data loss prevention (DLP)
- Restricted from accessing sensitive files with high-sensitivity labels

These restrictions integrate with **Microsoft Entra Conditional Access** and **Purview DLP policies**, so controls scale with behavior. Once the user's risk level decreases, stricter policies can be lifted.
