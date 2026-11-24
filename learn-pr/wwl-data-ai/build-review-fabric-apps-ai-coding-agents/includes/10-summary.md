You directed a coding agent to build and deploy a Fabric app, and you reviewed what it generated before release. The Adventure Works Cycles scenario shows that the agent is a fast collaborator while you remain the reviewer who decides what ships.

## What you learned

- `rayfin init ai-files install` installs and refreshes the managed agent files, `rayfin init ai-files status` reports drift, and the platform rules list the constraints that agents must follow.

- Strong prompts name the outcome, tell the agent to run commands, and set approval gates for deployment and destructive flags.

- Reviews check permission decorators, schema changes, `rayfin.yml` settings, secrets, dependencies, raw data access, and mixed versions. An entity without a permission decorator isn't locked down. It receives full access for any signed-in user.

- Evidence comes in layers: build, tests, `rayfin up --dry-run`, `rayfin up status`, and deployed-app checks for ownership and sign-in. A passing build or client test doesn't prove that the backend enforces permissions.

## Clean up resources

Delete lab-only entities such as `VendorProbe` and its test component, and discard test records. If you don't plan to reuse the project, delete the app item and any remaining child items from your Fabric workspace.

## Learn more

- [Create an app with GitHub Copilot](/fabric/apps/create-app-with-github-copilot)
- [Develop Fabric apps with AI coding agents in your organization](/fabric/apps/ai-agent-development-for-apps)
- [Rayfin CLI reference](/fabric/apps/cli-reference)
- [Apply and verify schema changes in Fabric Apps](/fabric/apps/apply-schema-changes)
- [Rayfin: Rules for coding agents](https://rayfin.ai/docs/reference/agent-rules)
- [Rayfin: Known limitations](https://rayfin.ai/docs/reference/known-limitations)
- [Rayfin: Testing a Rayfin app](https://rayfin.ai/docs/recipes/testing)
