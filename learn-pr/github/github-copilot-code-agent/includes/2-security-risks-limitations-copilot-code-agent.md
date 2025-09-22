The GitHub Copilot coding agent is designed from the ground up with security and governance in mind. While it unlocks new ways of delegating work to an autonomous agent, it operates inside your organization's existing guardrails and adds its own protections. This unit explains how the agent enforces your security policies, highlights the risks and mitigations you should be aware of, and sets expectations about its current limitations.

By the end of this unit, you will be able to:

- Describe the security model and built-in protections of the Copilot coding agent.
- Identify the main risks associated with using the agent and the mitigations GitHub applies.
- Recognize the known limitations of the agent's workflow and compatibility to plan your usage accordingly.

### Security model and built-in protections

Security is foundational to the Copilot coding agent. It respects your existing controls and applies its own guardrails to keep your workflows safe:

- **Subject to governance** - Organization and enterprise settings govern availability; all your security policies continue to apply to the agent.
- **Restricted environment** - The agent runs inside a sandbox on GitHub Actions with firewalled internet access and read-only access to your repository.
- **Branch limits** - It can only create and push to branches beginning with copilot/, and all branch protections and required checks still apply.
- **Permission-aware** - The agent only responds to users with write permission. Comments from others are ignored.
- **Outside-collaborator rules** - Draft PRs from the agent require approval by a user with write permission before Actions run. The person who requested the PR cannot approve it.
- **Compliance and attribution** - All commits are co-authored with the developer who assigned the task or requested the PR, so attribution is clear. Existing "required approvals" rules remain intact.

### Risks and mitigations

Although the Copilot coding agent is built with security in mind, there are still risks you should plan for. GitHub applies mitigations to reduce them:

- **Risk: Agent pushes code**

  **Mitigations:** Only users with write access can trigger agent work. Pushes are restricted to `copilot`/ branches (not main/master). The agent's credentials allow simple push only (no direct `git push`). GitHub Actions workflows won't run until a write-permission user clicks "**Approve and run workflows"**. The requestor cannot approve the agent's PR, maintaining required approvals.

- **Risk: Access to sensitive information**

  **Mitigation:** The agent's internet access is firewall-restricted by default; you can customize or disable the firewall per policy.

- **Risk: Prompt injection**

  **Mitigation:** Hidden characters (such as HTML comments) are filtered before passing user input to the agent. This reduces the chance of hidden harmful instructions in comments or issues.

These controls give you a secure baseline for using the agent, but you should still review outputs carefully-just as you would code written by any team member.

### Known limitations

**Workflow limitations**

- Can only make changes in the same repository as the assigned issue or PR.
- Context scope is limited to the assigned repository by default (can be broadened via MCP).
- Opens exactly one pull request per task.
- Cannot modify an existing PR it didn't create (add it as a reviewer if you need feedback instead by leveraging [GitHub Copilot code review](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/request-a-code-review/use-code-review)). 

**Compatibility limitations**

- Does not sign commits. If you require signed commits, you must rewrite the commit history before merging.
- Requires GitHub-hosted Ubuntu x64 runners. Self-hosted runners are not supported.
- Not available for personal repositories owned by managed user accounts (runners unavailable).
- Does not honor content exclusions; the agent can see and update excluded files.
- The "Suggestions matching public code" policy isn't enforced by the agent; references may not be provided.
- Works only with GitHub-hosted repositories.
- You cannot change the AI model used by the agent; it's selected by GitHub.

With guardrails and boundaries clear, you're ready to start delegating work, following progress, and iterating on results using your standard PR workflow.