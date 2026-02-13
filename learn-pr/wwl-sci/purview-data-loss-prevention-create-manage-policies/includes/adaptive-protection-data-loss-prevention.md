Up to this point, policy design has focused on defining detection, scope, actions, and validation. That model works well when risk is clear and usage patterns are predictable.

In some environments, risk isn't static. The same action can carry different levels of risk depending on who performs it, how often it occurs, or what other signals are present. Risk-based behavior allows data loss prevention (DLP) enforcement to adapt based on context rather than relying only on fixed rules.

## Know when content-based controls are sufficient

For many scenarios, content-based policies provide the right level of protection.

They work well when:

- Risk scenarios are clearly defined
- Usage patterns are consistent
- Enforcement decisions don't need additional context

In these cases, adding risk-based behavior doesn't improve outcomes. It increases complexity without addressing a real need.

Before extending policies, confirm that simpler controls can't already meet the requirement.

## Identify scenarios where added context improves decisions

Risk-based behavior becomes useful when context changes how risk should be evaluated.

This includes scenarios where:

- The same action is acceptable for some users but risky for others
- Behavior escalates gradually rather than occurring as a single event
- Repeated activity signals increasing risk over time

In these situations, static rules often feel either too permissive or too restrictive.

## Use risk signals to adjust enforcement dynamically

Risk-based DLP behavior incorporates signals beyond content alone. These signals allow enforcement to respond differently as conditions change.

Rather than enforcing a fixed action in all cases, policies can:

- Apply stricter controls as risk increases
- Reduce enforcement when risk is low
- Focus protection where it's most needed

For example, a low-risk user might receive a warning for an action, while the same action performed by a higher-risk user results in blocking.

A safe first use of risk-based behavior is to vary guidance rather than blocking. Starting with warnings for lower-risk users and stronger actions only at higher risk levels helps validate assumptions without introducing unnecessary disruption.

## Understand how adaptive protection fits into DLP

Adaptive Protection extends DLP policies by adjusting enforcement based on user risk.

At a high level:

- Adaptive Protection is configured **within DLP rules**
- Detection conditions remain unchanged
- Enforcement behavior adjusts based on user risk signals

The image shows where Adaptive Protection settings appear within a DLP rule. These settings control how enforcement changes based on user risk, while detection conditions remain the same.

:::image type="content" source="../media/adaptive-protection-conditions.png" alt-text="Screenshot showing the DLP rule conditions pane with Insider risk level for Adaptive Protection and selectable risk levels." lightbox="../media/adaptive-protection-conditions.png":::

A common misuse of adaptive behavior is applying it broadly before static policies are stable, which makes enforcement outcomes harder to interpret.

User risk can change over time as behavior changes. When risk increases or decreases, the same rule can produce different enforcement outcomes without redefining detection or scope.

This is why a policy might warn a user in one situation and block the same action later, even though the rule itself hasn't changed.

## Keep complexity aligned with actual risk

Risk-based behavior should solve a specific problem. If risk can be addressed with clear, static rules, those rules are usually the better choice.

Extending DLP with adaptive behavior makes sense when:

- Enforcement decisions need to change over time
- User context meaningfully alters risk
- Static policies no longer scale with real usage patterns

If enforcement outcomes can't be clearly explained based on risk signals, adaptive behavior is adding complexity without value and should be reconsidered.

When applied intentionally, risk-based behavior extends DLP capabilities without sacrificing clarity.
