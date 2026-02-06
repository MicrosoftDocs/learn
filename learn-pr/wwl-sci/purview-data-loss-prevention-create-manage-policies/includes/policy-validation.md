Creating a data loss prevention (DLP) policy doesn't end when conditions, scope, and actions are defined. Before enforcement is enabled, policies should be validated against real activity to confirm they behave as intended.

Validation helps ensure policies reduce risk without disrupting normal work. It also provides the confidence needed to move from planning into enforcement.

## Use simulation mode as a design feedback loop

Simulation mode allows a policy to evaluate activity without taking enforcement actions. Instead of blocking activity, the policy records what _would_ have happened.

A DLP policy can be **off**, run in **simulation**, or run in **enforcement**, and the selected mode applies at the policy level, not per rule.

All rules within a policy run under the same mode. You can't simulate one rule while enforcing another.

This makes simulation a design tool, not just a safety check.

Simulation helps you:

- Confirm detection logic triggers as expected
- Observe how scope affects real users and workflows
- Evaluate whether selected actions are appropriate

While simulation doesn't enforce restrictions, users might still see policy tips or guidance. This allows organizations to observe not only how policies would trigger, but also how users respond to messaging before enforcement is enabled.

Treating simulation as feedback encourages deliberate refinement before enforcement.

### Understand simulation constraints

Simulation has built-in limits that affect how results should be interpreted.

Constraints to keep in mind:

- **Simulation duration**: Simulation typically runs for up to 15 days, and results are retained for 30 days after simulation ends. Reviewing findings during the validation window is important.

- **Location behavior**: Not all locations are evaluated the same way. Locations that store content at rest are evaluated against existing and new items, while event-based locations are evaluated as new activity occurs.

Understanding these constraints helps set realistic expectations when reviewing simulation results.

## Review results to understand real-world behavior

Simulation results show how a policy interacts with actual work patterns. Reviewing these results helps distinguish between intended enforcement and unexpected noise.

:::image type="content" source="../media/simulation-mode-review.png" alt-text="Screenshot of Microsoft Purview DLP simulation results with matched files and rule details." lightbox="../media/simulation-mode-review.png":::

When reviewing results, look for:

- Where and how often the policy would trigger
- Whether activity aligns with expected risk scenarios
- Patterns that suggest legitimate work are being affected

The goal isn't zero activity. It's predictable, understandable activity.

## Make targeted tuning adjustments

Simulation often reveals small adjustments that improve policy quality.

Common tuning changes include:

- Narrowing or expanding scope
- Refining detection conditions
- Adjusting actions to better match observed risk

These changes are easier to make before enforcement, when users aren't yet affected.

## Identify when a policy is ready for enforcement

A policy is typically ready for enforcement when:

- Triggers align with expected scenarios
- False positives are limited and explainable
- Actions match the organization's risk tolerance
- Users can understand why enforcement occurs

Readiness is about confidence, not perfection. Policies can continue to evolve after enforcement begins.

## Recognize validation as the start of the policy lifecycle

Validation isn't the final step. It marks the transition from design to ongoing management.

Once enforced, policies should continue to be reviewed and refined as:

- Business workflows change
- Data usage evolves
- New risks emerge

Viewing validation as the beginning of a lifecycle helps keep policies relevant and effective over time.

Validation confirms readiness, but real environments continue to change once enforcement begins.
