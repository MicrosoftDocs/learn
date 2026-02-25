Use Copilot Chat before delegation to evaluate whether backlog items are ready for AI-assisted execution. This step improves quality and reduces churn in pull requests.

## What to analyze first

Before assigning work to Copilot, start by checking whether each backlog item is clear, scoped, and implementable. In practice, this means asking Copilot to review a small set of user stories, bugs, and tasks and then classify them by readiness for delegation. For new learners, think of this as a "triage" step: you are deciding which work is immediately actionable versus which work still needs clarification from product, architecture, or operations teams.

Strong candidates usually have:

- Clear problem statements.
- Localized code impact.
- Testable acceptance criteria.
- Minimal dependency on external approvals.

Low-readiness items often include ambiguous requirements, major architecture decisions, or external credential dependencies.

## Prompt patterns that work well

Good prompts are specific and structured. Instead of asking "Can Copilot do this?", ask Copilot to evaluate the item against concrete dimensions. This makes the response easier to compare across multiple work items and helps your team make repeatable decisions. A strong prompt often asks Copilot to explain not only what is ready, but also why certain items are risky or blocked.

Use prompts that ask for explicit evaluation dimensions, such as:

- Complexity and technical risk.
- Requirement clarity and missing detail.
- Dependencies requiring human action.
- Suggested task decomposition for delegation.

## Expected outputs from analysis

The analysis is most useful when it produces practical planning outputs that your team can act on immediately. You want to leave this step with a short, prioritized list of items that can be delegated now, a second list of items that need refinement, and a clear reason for each decision. This turns Copilot Chat into a planning accelerator rather than just a brainstorming tool.

Copilot responses are most useful when they provide:

- A ranked list of work items by delegation suitability.
- A gap list showing what each item still needs.
- Recommended sequence for implementation.
- A list of tasks that should remain human-led.

## Practical review rule

Treat Copilot analysis as planning support, not final truth. Always validate recommendations against your real delivery context, such as release deadlines, architecture standards, and team skill distribution. If an item looks technically feasible but depends on approvals, secrets, or policy changes, keep it human-led until those constraints are resolved.

## Summary

Copilot Chat helps you evaluate backlog readiness faster, but the goal is decision quality, not automation for its own sake. By using structured prompts and reviewing outputs critically, you can select better delegation candidates, reduce rework, and prepare your team for smoother AI-assisted implementation.
