Use Copilot Chat before delegation to evaluate whether backlog items are ready for AI-assisted execution. This step improves quality and reduces churn in pull requests.

## What to analyze first

Ask Copilot to review a set of candidate stories, bugs, and tasks and classify them by delegation readiness.

Strong candidates usually have:

- Clear problem statements.
- Localized code impact.
- Testable acceptance criteria.
- Minimal dependency on external approvals.

Low-readiness items often include ambiguous requirements, major architecture decisions, or external credential dependencies.

## Prompt patterns that work well

Use prompts that ask for explicit evaluation dimensions, such as:

- Complexity and technical risk.
- Requirement clarity and missing detail.
- Dependencies requiring human action.
- Suggested task decomposition for delegation.

## Expected outputs from analysis

Copilot responses are most useful when they provide:

- A ranked list of work items by delegation suitability.
- A gap list showing what each item still needs.
- Recommended sequence for implementation.
- A list of tasks that should remain human-led.

## Practical review rule

Treat Copilot analysis as planning support, not final truth. Confirm suggestions against team context, release priorities, and architecture constraints before delegation.
