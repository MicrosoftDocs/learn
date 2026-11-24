The Fabric Apps documentation, templates, and quickstarts are written for coding agents as much as for people. You can ask an agent to scaffold an app, change the data model, and deploy it. The agent is fast, but it follows the guidance it's given, and you remain accountable for permissions, identity choices, and destructive operations that the agent can introduce.

You ask a coding agent to add a vendor-tracking feature to the issue-reporting app at Adventure Works Cycles. The agent proposes new entities, an updated UI, and a deployment. Before you approve the release, a review of the diff finds an entity without a permission rule and a schema change that needs a `--force` flag. A passing build didn't reveal either problem.

In this module, you explore how to prepare a project for agents, how to write prompts that direct work and set approval gates, and how to review what an agent produces. You learn which mistakes agents make most often and how to verify an agent's work with builds, a deployment preview, and checks against the deployed app. Hands-on exercises in your own Fabric tenant use GitHub Copilot in agent mode, a supplied patch with seeded defects, and a final follow-up task.

By the end of this module, you're able to direct a coding agent to build and deploy a Fabric app, and review what it generates before release.
