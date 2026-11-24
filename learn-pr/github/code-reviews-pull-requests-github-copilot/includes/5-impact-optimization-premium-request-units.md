Copilot code review helps teams review more code consistently, but each review has a cost. Understanding that cost helps you decide when to request reviews and how to plan your budget.

## Learning objectives

By the end of this unit, you'll be able to:

- Explain how Copilot code review consumes AI credits and contributes to GitHub Actions compute usage.
- Measure the impact of Copilot reviews on your workflow.
- Apply strategies to manage usage of AI credits.

## Understanding AI credits

Copilot code review has two usage components:

- **AI credits:** Each review consumes AI credits for model interactions. Usage depends on the model and the number of tokens processed.
- **GitHub Actions compute usage:** On pull requests, agentic capabilities, such as gathering context from your repository, use GitHub Actions runners by default. In private repositories, runner costs draw on included GitHub Actions compute usage, with additional usage billed separately when applicable. Standard GitHub-hosted runners are free in public repositories, and self-hosted runners don't draw on included compute usage.

Across Copilot, code completions and next edit suggestions don't consume AI credits. Usage generally increases with the size of the pull request.

**Example scenario:**

A developer pushes a massive refactor touching dozens of files. Copilot, assigned as a reviewer, uses AI credits to apply the repository's security and style guidelines to the entire change, flags several unsafe string interpolations, and even drafts Markdown comments explaining the issue. Instead of spending hours doing manual checks, human reviewers can now focus on the architectural impact of the refactor.


## Why AI credits matter for teams

Knowing what reviews consume helps you weigh that cost against the value they provide. With Copilot code review, you can:

- **Get deeper analysis:** Spot subtle vulnerabilities, duplicated logic, or style violations across large diffs before they reach production.
- **Enforce consistency:** Apply the same security, readability, or style checks across every pull request automatically.
- **Handle bursts of activity:** During busy release cycles, rely on Copilot reviews to keep quality steady while human reviewers handle complex design decisions.

**Example scenario:**

Your team maintains a microservices architecture in Go, Python, and TypeScript. During a pre-release crunch, Copilot uses AI credits to review each service for language-specific best practices, flagging a risky `eval()` call in JavaScript and recommending a safer parser, while also catching a missing error check in a Go handler. This lets your team merge fixes quickly across all services without missing critical details.


## Measuring the impact of Copilot reviews

To understand the impact of Copilot reviews, track metrics such as:

- **PR lead time:** How quickly pull requests go from open to merged after adding Copilot reviews.
- **Quality indicators:** Reduction in post-merge security or style issues flagged by other tools.
- **Developer experience:** Feedback on whether Copilot makes reviews faster or clearer.

**Example metric:**

Before using Copilot reviews, large PRs took an average of three days to merge and frequently triggered style fixes after release. After enabling Copilot reviews, the same PRs merged in one day with far fewer follow-up commits.

## Managing usage of AI credits

Manage usage of AI credits to control costs:

- **Plan ahead:** Set a budget and enable alerts at 75%, 90%, and 100% of it.
- **Use reviews strategically:** Use the Balanced effort level for large changes and Lite for simple edits.
- **Keep pull request small:** Smaller pull requests are easier for Copilot to review efficiently, reducing AI credit consumption and speeding up the review process.
- **Scale up if needed:** After your team uses all its included AI credits, additional usage is billed separately if your organization allows it. If your team regularly needs more, consider a plan with a larger AI credit allowance.

**Example scenario:**

A team notices that trivial documentation changes consume many AI credits. They update their workflow to use Lite for small edits and keep Balanced for code that affects production. As a result, their monthly usage of AI credits drops by 30% without losing quality.

Track and manage AI credits and GitHub Actions compute usage to balance Copilot code review coverage and costs. Human reviewers retain final judgment.