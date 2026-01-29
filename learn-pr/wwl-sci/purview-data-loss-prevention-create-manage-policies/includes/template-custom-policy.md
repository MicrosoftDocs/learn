Once policy intent and boundaries are clear, the next decision is how to begin. In Microsoft Purview, creating a data loss prevention (DLP) policy doesn't start with rules. It starts with choosing the right entry point.

That choice affects how much control you have, how quickly you can move, and how easily the policy can evolve over time.

## Choose between templates and custom policies

DLP policies can be created from prebuilt templates or built as custom policies from the start. Neither option is universally better. Each serves a different purpose.

:::image type="content" source="../media/template-custom-start-page.png" alt-text="Screenshot of the Microsoft Purview DLP policy creation page showing options to start with a template or create a custom policy." lightbox="../media/template-custom-start-page.png":::

Templates are useful when:

- The risk scenario is common and well understood
- You need to move quickly
- Consistency matters more than precision

Custom policies make more sense when:

- Risk scenarios are specific to how your organization works
- Enforcement needs to vary by location, user group, or action
- You expect the policy to evolve as you learn more

Choosing the right starting point helps avoid rework later.

### Compare template and custom policies

Reviewing how template-based and custom policies differ in practice can help clarify which approach fits best.

| Consideration | Template-based policy | Custom policy |
| ----- | ----- | ----- |
| Setup effort | Faster to create | Takes more time to design |
| Assumptions | Includes predefined scope and actions | Assumptions are defined explicitly |
| Precision | Good for common scenarios | Better for specific or nuanced scenarios |
| Flexibility over time | Limited by template structure | Easier to refine as needs change |
| Best fit | Known, repeatable risks | Scenarios that evolve or vary by context |

## Define intent before configuration

Regardless of how you start, it's important to carry policy intent into creation. The goal isn't to turn on protections as quickly as possible. It's to ensure the policy reflects the risk you're trying to reduce.

Before configuring conditions or actions, be clear about:

- The behavior you want to influence
- The scenarios you care about most
- What success looks like for this policy

That clarity makes later decisions easier and more consistent.

## Name policies and rules with purpose

How policies and rules are named affects long-term manageability. Names should reflect intent and scope, not just the data type involved.

Clear naming helps:

- Distinguish similar policies
- Understand why a rule exists
- Troubleshoot unexpected behavior later

This matters even more as policies grow in number and complexity.

The starting point defines how much freedom you have, but detection determines whether the policy actually reflects risk.
