After policies are in place, DSPM's outcome metrics reflect the current protection state regardless of where the policies were created. What matters now is whether the gap actually closed.

## How outcome metrics reflect policy effectiveness

After you apply a policy or complete a remediation action, Data Security Posture Management (DSPM) reflects the resulting change through outcome metrics on each objective's outcome card. These metrics update as protection takes effect:

- **Coverage percentage** shows how much of the relevant data is covered by at least one policy of the type the objective recommends.
- **Trend direction** indicates whether coverage is improving, stable, or declining over time.
- **Remaining gap** quantifies what portion of the data estate still lacks the specific protection type.

Reviewing these metrics validates that a policy is working as intended and reveals whether further remediation is needed.

:::image type="content" source="../media/objective-oversharing-trend-metrics.png" alt-text="Screenshot showing the Prevent oversharing objective with stable trend lines and key metrics showing no change over 30 days.":::

## Evaluate whether policies achieve their intent

An improvement in outcome metrics confirms the policy is active and covering data. But "active and covering" doesn't always mean the protection gap is closed. Consider these evaluation questions:

- **Does the coverage improvement match what the impact prediction estimated?**

  A significant discrepancy suggests the policy scope doesn't match the actual data conditions.

- **Are risk indicators for the objective still elevated despite the improvement?**

  Some risk indicators reflect conditions that a single policy can't fully address, such as inherited sharing permissions that data loss prevention (DLP) policies don't retroactively change.

- **Has the objective's trend stabilized at an acceptable level, or is ongoing attention needed?**

  A trend that continues declining after the activation window might indicate the policy isn't reaching the right content.

The impact prediction you reviewed before submitting the policy is your baseline. The outcome card is the result. When those two visuals don't align, the gap between them tells you what to investigate next.

## Identify when further action is needed

Several conditions signal that a policy alone didn't resolve the protection gap:

:::image type="content" source="../media/objective-exfiltration-metrics-elevated.png" alt-text="Screenshot showing elevated exfiltration metrics with a 200 percent increase and users not covered by policies.":::

- **Minimal or no improvement after the activation window**: The policy scope likely doesn't match the actual risk conditions. Revisit the objective's risk indicators and narrow or broaden the policy conditions to align with what's exposed.
- **Improvement plateaus below the target**: The policy addressed part of the gap, but the remaining portion is a different kind of problem. A DLP policy prevents future sharing violations, but items already overshared need item-level remediation through a data risk assessment.
- **New risk indicators appear**: Changes in the data estate introduced risks the current policy doesn't cover. Reassess the objective to determine whether the new gap needs a separate policy or a different remediation type entirely.

## Repeat the cycle

Protection in DSPM isn't a one-time action. Each objective requires periodic reassessment:

1. Review risk indicators for current gaps.
1. Apply or adjust remediation.
1. Review results.
1. Decide whether further action is needed.

An organization might have one objective fully addressed while another still requires multiple rounds.

You'll also see remediation actions listed under **Tasks and actions** > **Remediation actions**. Most of these originated from the earlier DSPM for AI experience. Some create policies directly, others provide guided steps you mark as complete. They operate independently from objectives, which means they don't connect to risk indicators or outcome metrics the way objective-based remediation does. The objectives workflow gives you the same protection capabilities with the added context of why a policy is needed and whether it worked. If you encounter a remediation action that doesn't map to an active objective, it's likely from that earlier experience.
