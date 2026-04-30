Once you've identified the right pathway for a gap, you can create data loss prevention (DLP), sensitivity label, and Insider Risk Management (IRM) policies directly from within the Data Security Posture Management (DSPM) objective. You don't need to switch to each solution's configuration interface. Instead, you review preconfigured settings, evaluate predicted impact, and confirm.

## How one-click policies differ from manual policy creation

When you create a policy from within a DSPM objective, DSPM preconfigures the policy based on the objective's context. The conditions, scope, and enforcement settings reflect the specific risk the objective addresses. You still review and can modify these settings before submission, but the starting configuration is already aligned to the gap.

This is different from building a policy manually within DLP, Information Protection, or Insider Risk Management. Manual creation starts from a blank or template configuration. DSPM-guided creation starts from the risk context and recommends settings that match the objective's risk indicators.

The term "one-click" refers to the guided simplification, not a literal single click. You review the proposed configuration, evaluate the impact prediction, and confirm before the policy is created.

:::image type="content" source="../media/one-click-policy-copilot-remediation-plan.png" alt-text="Screenshot showing the remediation plan for the Copilot interactions objective with preconfigured policy recommendations, default protections checklist, and estimated impact on risk pattern chart.":::

## Create a policy from an objective

Regardless of policy type, you want to confirm that the preconfigured conditions match your specific gap and evaluate the impact prediction before you commit. Using a DLP policy as an example:

1. Open the Microsoft Purview portal and navigate to **DSPM (preview)**.
1. Select the objective that addresses the protection gap you identified, such as **Prevent exfiltration to risky destinations**.
1. Review the objective's risk indicators to confirm which condition the policy should address.
1. Select the recommended policy action within the objective's workflow.
1. Review the preconfigured settings, including conditions, sensitive information types, locations, and enforcement actions.
1. Evaluate the impact prediction visual to understand the expected scope.
1. Modify conditions if the predicted scope doesn't match the specific gap you're trying to close.
1. Confirm and submit the policy.

Sensitivity label policies and Insider Risk Management policies follow the same general flow. The difference is in what gets configured: autolabeling policies define which conditions trigger label application and which label to apply, while IRM policies define triggering events and behavioral indicators. In each case, DSPM prepopulates the configuration based on the objective's risk context.

> [!NOTE]
> Creating policies from objectives requires the same roles as creating them from their associated solutions. DSPM simplifies the workflow but doesn't change the underlying permission requirements.

## Evaluate impact predictions

Before applying any one-click policy, DSPM shows an impact prediction visual estimating:

- How many items or users the policy would affect
- Which locations fall within scope
- The expected coverage improvement for the objective's outcome metric

This prediction is where you validate that the policy matches the gap:

- If the predicted scope closely matches the gap identified by risk indicators, the policy is well-aligned.
- If the predicted scope is broader than the identified gap, consider whether narrowing conditions would avoid unnecessary disruption.
- If the predicted scope is narrower than expected, the policy conditions might need adjustment to address the full extent of the risk.

The impact prediction is based on current data state and might not account for newly created content. Treat it as a planning tool rather than a guarantee.

## What to review before you submit

Even though DSPM preconfigures settings, two decisions are worth deliberate attention:

- **Enforcement mode**: Starting with "audit only" lets you validate policy behavior before full enforcement. This is especially useful for policies with broad scope where you want to confirm the conditions match real-world content before blocking or restricting access.
- **User notifications**: Policy tips notify users when they trigger a policy condition. Decide whether visibility into the policy helps user behavior or creates confusion in your environment.

## How Copilot-specific policies differ

When you create a DLP policy from the **Prevent data exposure in Microsoft 365 Copilot and Microsoft Copilot interactions** objective, the policy uses a dedicated location that only applies to Copilot interactions. This location is separate from traditional DLP locations like Exchange, SharePoint, or endpoints, and you can't combine it with those in the same policy.

These policies address two risks that traditional DLP doesn't cover:

- **Block labeled content from responses.** Copilot won't process files or emails that carry specific sensitivity labels. Even if the user has direct access to the file, its content won't appear in generated answers. The item might still show up in citations, but nothing from it gets used in the response.
- **Block sensitive information in prompts.** When a user types sensitive data into a Copilot prompt, the policy can either stop Copilot from responding at all or prevent it from using external web search for that prompt. You choose which action to configure in the rule.

The difference from traditional DLP matters here. A standard DLP policy stops a user from sharing or moving a file. A Copilot-scoped policy stops AI from processing content the user can already access. A user with legitimate access to a labeled file can still open it directly, but Copilot won't summarize it or pull from it when generating responses.

## The activation delay

After you submit a one-click policy, there's approximately a 24-hour delay before the policy becomes fully active. During this window:

- The policy appears in the relevant solution's policy list in DLP, Information Protection, or Insider Risk Management
- Configuration is finalized and propagated across locations
- No enforcement actions occur until propagation completes

Plan for this delay when addressing urgent risks. If an immediate gap requires protection now, consider whether complementary manual actions can bridge the gap until the policy activates.
