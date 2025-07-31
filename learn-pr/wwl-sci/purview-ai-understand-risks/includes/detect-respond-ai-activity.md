Not all AI activity is safe or appropriate. Prompts might expose sensitive data, violate organizational policies, or indicate unsafe user behavior. To manage these risks, Microsoft Purview provides tools to help detect risky interactions and respond with appropriate actions.

Insider Risk Management and Communication Compliance help identify potentially risky AI activity, while Adaptive Protection applies dynamic controls based on user risk levels.

:::image type="content" source="../media/detect.svg" alt-text="Illustration of DSPM for AI shield showing environment coverage, sensitivity labels, DLP enforcement, and user risk mitigation." border = "false":::

## Detect risky prompts with Insider Risk Management

**Insider Risk Management** in Microsoft Purview helps detect potentially harmful user behavior, including misuse of AI tools. It includes built-in policy templates designed to flag potentially risky AI activity based on defined policy thresholds, such as:

- Excessive prompt activity within a short period
- Prompts that include sensitive or confidential information
- Repeated access to high-value files before submitting prompts

Examples include the **Risky AI usage (preview)** and **Risky browser usage (preview)** policy templates. These templates are designed to detect specific patterns of AI tool usage that might indicate risk. When conditions are met, the policy flags the activity for review in an alert.

You can combine these detections with **priority user groups**, **notice templates**, and **Microsoft Defender for Endpoint signals** to enhance the signal quality and take informed action.

## Analyze AI interactions for policy violations

**Communication Compliance** helps organizations evaluate how AI tools like Microsoft 365 Copilot are being used, with a focus on ensuring prompts and responses align with organizational policies. This includes detecting when interactions involve:

- Inappropriate or offensive content
- Confidential or regulated data being surfaced in responses
- Prompts that include personal data or sensitive business details

AI-generated content can be reviewed just like any other form of communication, such as email or Teams messages. When a policy violation is detected, reviewers can take actions like tagging, notifying the user, escalating to a manager, or preserving the message for further investigation.

:::image type="content" source="../media/respond.svg" alt-text="Illustration of DSPM for AI shield showing environment coverage, sensitivity labels, DLP enforcement, and user risk mitigation." border = "false":::

## Apply controls with Adaptive Protection

**Adaptive Protection** uses Microsoft Purview signals to adjust user access dynamically. When Insider Risk Management assigns a higher risk level to a user, Adaptive Protection can enforce stronger restrictions, including:

- Blocking users from sharing files externally
- Preventing file uploads or pasting into AI tools using data loss prevention (DLP)
- Restricting access to sensitive content based on label sensitivity

These protections integrate with **Microsoft Entra Conditional Access** and **Purview DLP policies** to ensure that controls scale with user behavior. Users flagged for risky AI usage can be automatically placed under stricter policies until their risk level returns to normal.
