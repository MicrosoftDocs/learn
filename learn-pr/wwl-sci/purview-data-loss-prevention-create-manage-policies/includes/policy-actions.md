Once detection and scope are defined, the final decision is how the policy should respond when risky activity occurs. Actions determine whether a policy quietly observes behavior, guides users in the moment, or actively prevents data loss.

Choosing the right action is about aligning protection with business tolerance. Stronger enforcement isn't always better. In many cases, the goal is to reduce risk without disrupting legitimate work.

## Understand the range of available actions

Data loss prevention (DLP) policies can take different actions when conditions are met. Each action represents a different balance between visibility, guidance, and restriction.

In Microsoft Purview, these actions generally fall into a few enforcement categories:

- **Audit**, where activity is logged without interrupting users
- **Warn**, where users receive guidance but can continue their action
- **Block with override**, where users can proceed with justification
- **Block**, where the action is prevented entirely

Not every enforcement category is available in every location. Available actions depend on where the policy applies and the type of activity being evaluated. Actions are configured at the **rule level**, not at the policy level, so each rule defines its own enforcement behavior.

## Match actions to business tolerance

Effective policies reflect how much risk an organization is willing to accept in exchange for productivity.

Lower-risk or newly understood scenarios often benefit from:

- Audit or warning actions
- Opportunities for user education
- Gradual increases in enforcement over time

Higher-risk scenarios might justify:

- Blocking actions
- Limited or no override options
- Consistent enforcement across users and locations

For many scenarios, starting with nonenforcing actions and validating behavior through simulation helps confirm assumptions before stronger enforcement is applied.

## Use policy tips and notifications as guidance

Policy tips and notifications play an important role in shaping behavior. They explain why an action is risky and what users can do instead.

Well-designed guidance:

- Appears at the moment of risk
- Uses clear, neutral language
- Helps users make better decisions without feeling punished

Policy tips can also point users to internal guidance or training resources, reinforcing expectations without relying solely on enforcement.

In many cases, guidance reduces risk more effectively than enforcement alone.

## Use overrides thoughtfully

Overrides allow users to proceed when there's a valid business reason. They can reduce disruption, but they also weaken protection if overused.

Overrides are most effective when:

- The scenario is generally acceptable but occasionally risky
- Justification is required and reviewed
- Override patterns are used to refine detection and scope

If most users override a policy, it's often a signal that the policy doesn't align with real workflows.

## Pay attention to what override justifications reveal

Override justifications are valuable feedback. They reveal where detection might be too broad, scope might be misaligned, or enforcement might be too strong.

Patterns in justifications can help answer questions like:

- Are users encountering the policy during normal work?
- Is the policy triggering in unexpected scenarios?
- Does the action match the actual level of risk?

Using this feedback helps improve policy quality over time.

Any action choice carries assumptions, and those assumptions need to be tested before enforcement.
