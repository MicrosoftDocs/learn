This unit explains what the agent is, how it differs from traditional AI coding assistants, what plans and repositories support it, and how to enable and budget for it-including Premium Request Units (PRUs) and GitHub Actions minutes.

By the end of this unit, you'll be able to:

- Explain what Copilot in the cloud does, who can use it, and where you can start it.
- Describe the tasks it can perform and how to delegate work.
- Distinguish it from IDE-only assistants and Copilot's "agent mode."
- Enable the agent at the organization or repository level.
- Understand how GitHub Actions minutes and Premium Request Units (PRUs) are used and manage them effectively.

### How can you use Copilot in the cloud

When you run Copilot in the cloud, it works as an autonomous development assistant inside GitHub. Rather than pairing with you only in your IDE, the agent acts like a background teammate. You give it a clearly scoped task—such as a bug fix, an incremental feature, or documentation update—and it creates a branch, explores the codebase, generates an implementation plan, and drafts code while keeping you in control of when and whether to open a pull request.

### Availability and plans

- **Plans:** Available on Copilot Pro, Copilot Pro+, Copilot Business, Copilot Enterprise.
- **Repositories:** Works in all GitHub-hosted repositories except those owned by managed user accounts or where the agent is explicitly disabled.

### What Copilot in the cloud does

Copilot in the cloud can take on a wide range of development tasks:

- Fix bugs and regressions.
- Implement incremental new features.
- Improve test coverage or generate missing tests.
- Update or create documentation.
- Address technical debt and "nice-to-have" backlog items.

You can delegate work to the agent in two primary ways:

- **Assign an issue** to Copilot - on GitHub.com, GitHub Mobile, or via API/CLI.
- **Ask Copilot to make code changes** - from the Agents panel on GitHub, Copilot in GitHub, your IDE or other agentic tool with MCP support, or Raycast on macOS.

When the agent finishes, it requests your review. You can mention @copilot in a pull-request comment to ask it to iterate on its work.

### How it differs from traditional IDE assistants

Traditional AI assistants in IDEs help you write code locally but leave manual steps to you: creating branches, pushing commits, writing PR descriptions, and iterating. Those decisions happen in a private session and aren't visible to your team.

When you run Copilot in the cloud:

- All work happens as commits on GitHub.
- The agent automates branch creation, commit messages, and code drafting, while letting you decide if and when to open a PR.
- Work is visible in session logs and PR history for traceability.
- You steer via PR review comments rather than synchronous local sessions.

This creates transparency and collaboration opportunities-your teammates can see each step and jump in as needed.

### Copilot in the cloud vs. agent mode in your IDE

It's important to distinguish Copilot in the cloud, which this module covers, from the agent mode feature in Visual Studio and Visual Studio Code:

- **Copilot in the cloud:** Runs autonomously in a GitHub Actions-powered environment to complete development tasks you assign through issues or Copilot in GitHub.
- **Agent mode (Copilot Edits):** Performs autonomous local edits directly in your IDE session.

### Enabling Copilot in the cloud

Before assigning tasks to Copilot, ensure the agent is enabled:

- **Organization-owned repositories:** Availability is managed by organization or enterprise administrators.
- **Personal repositories:** Configure availability in your account settings.

**Usage Costs: GitHub minutes + AI credits**
Copilot in the cloud uses two main resources:

- **GitHub Actions minutes** for the ephemeral build/test environment where the agent works.
- **AI credits** for the AI models that power its work. Each plan includes an allowance of AI credits. The cost depends on the model and the number of tokens it uses.

> [!NOTE]
> For usage allowances and costs, see [GitHub Copilot billing and usage](https://docs.github.com/en/copilot/concepts/billing-and-usage).

> [!TIP]
> Cost depends on the model you choose. Save the more capable models for tasks where they add value, like multi-file edits, test generation, and broader diffs that need deeper reasoning.

With the agent enabled and costs understood, let's confirm how it adheres to your security posture, what risks to anticipate, and which limitations to account for as you plan real work.
