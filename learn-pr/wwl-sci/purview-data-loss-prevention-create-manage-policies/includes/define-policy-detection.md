Once you decide how to start a policy, the next step is defining what the policy should detect. Detection choices shape how accurate a policy is, how often it triggers, and how much noise it generates over time.

Good detection isn't about catching everything. It's about identifying the situations that matter most and responding consistently when they occur.

## Ensure detection matches the risk

In Microsoft Purview, detection is defined at the **rule level**, not at the policy level. A data loss prevention (DLP) policy can contain one or more rules, and each rule defines its own detection conditions and response behavior.

When a policy includes multiple rules, those rules are evaluated independently. Each rule determines whether its conditions are met and what action to take when they are.

These signals generally fall into three categories:

- **Content-based signals** focus on what the data contains, like identifying specific patterns or content types.

  These signals are useful when detection needs to be driven by the data itself rather than prior classification. They work well when patterns, keywords, or content structure matter more than how the data was labeled.

- **Classification-based signals** rely on prior classification decisions, like labels applied by users or automation.

  These signals are useful when protection should follow the data consistently, regardless of where it appears or how it's used.

- **Context-based signals** describe how data is handled, like the action being taken or where the data is sent.

  These signals focus on actions, destinations, and user context, and they help narrow enforcement to situations that actually represent risk.

Effective policies often combine signals from more than one category. Choosing the right mix depends on how reliably data is classified and what behavior the policy is meant to address.

## Combine conditions to improve accuracy

Single detection conditions can work for simple scenarios, but they often lack context. Combining conditions helps narrow enforcement to situations that actually represent risk.

For example, combining content-based detection with:

- A specific action
- A destination or location
- A user or group scope

Can significantly reduce unnecessary triggers.

Detection should favor clarity over complexity. If adding conditions makes results harder to explain, refinement has likely gone too far.

## Balance coverage with precision

Broad detection increases coverage, but it also increases the chance of false positives. Narrow detection improves precision, but it can miss edge cases.

Early in policy creation, it's often better to favor clarity over completeness. A policy that triggers reliably in fewer scenarios is easier to validate and refine than one that fires constantly with mixed results.

Refinement stops helping when additional conditions reduce understanding more than they reduce noise. Detection can always be expanded later. Noise is harder to undo.

## Define what "good enough" detection looks like

Detection doesn't have to be perfect on day one. What matters is whether it reliably identifies the behavior you care about without disrupting normal work.

"Good enough" detection usually means:

- The policy triggers when expected
- Results are understandable
- False positives are limited and explainable

When detection consistently highlights the same types of activity considered risky, further refinement is unlikely to add value. This provides a strong foundation for validation and tuning.

## Account for how detection choices affect false positives

Detection decisions made early often determine where false positives appear later. Overly broad conditions, weak context, or reliance on unreliable signals can all contribute to unnecessary enforcement.

Being intentional about detection upfront reduces the need for heavy tuning after deployment.

## Consider scenarios where data is reused or transformed

Some scenarios are more complex than simple sharing or copying. When sensitive data is reused or transformed, detection plays a larger role in distinguishing real risk from incidental use.

This includes workflows where:

- Content is rewritten or summarized
- Data is combined with other inputs
- Sensitive information appears in generated responses

In these scenarios, adding contextual conditions is often more effective than tightening content patterns. Clear, accurate detection helps ensure policies respond to meaningful risk without over-enforcing acceptable use.

With detection defined, scope becomes the deciding factor for whether those signals create insight or noise.
