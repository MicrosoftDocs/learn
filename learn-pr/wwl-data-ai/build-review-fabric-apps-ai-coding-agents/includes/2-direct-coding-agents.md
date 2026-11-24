You want an agent to add vendor tracking to the Adventure Works Cycles app, but an agent only works well with the right context and a clear brief. This unit shows how to give an agent the platform rules and how to write prompts that direct work while keeping you in control.

## Give the agent the platform rules

Rayfin manages a small set of files that coding agents read. The CLI installs them when you scaffold a project:

- `AGENTS.md`, with project guidance. Refreshing the managed files never overwrites this file, so your edits stay.
- `.mcp.json`, with an entry that points agents at the Rayfin documentation.
- `.agents/skills/rayfin/SKILL.md`, the Rayfin skill, which carries guidance that matches the installed version.

The command `npx rayfin init ai-files install` installs or refreshes these files in an existing project. It's idempotent and preserves your configuration, and the `--dry-run` option reports the changes without writing files. The command `npx rayfin init ai-files status` prints the state of each managed file, such as `up-to-date`, `update-available`, `user-modified`, or `missing`. Keep the files in source control, and refresh them when you upgrade Rayfin so that the guidance matches your package versions.

Documentation pages also have raw Markdown mirrors that agents can fetch. The Rayfin documentation has a short **Rules for coding agents** page that lists the constraints that change whether generated code works, and the `rayfin docs` command queries documentation that matches the installed packages. Point agents at these sources when they guess at an API.

## Know the rules agents must follow

Agents make predictable mistakes. These rules from the condensed guidance cover the most common ones:

- Build the client with `RayfinClient.create`, never `new RayfinClient(...)`.
- Add an explicit permission decorator to every entity. An entity without one silently receives `authenticated: *`, which is full create, read, update, and delete access for any signed-in user.
- Set `max` on every `@text()` field.
- Keep every `@microsoft/rayfin-*` package on one exact version.
- Keep secrets out of frontend code. Only publishable keys (`pk-*`) are safe there.
- Use the typed client for data, not raw `fetch()` or hand-built GraphQL.
- Use `npx rayfin` so the CLI matches the installed packages.

> [!NOTE]
> Templates, prompts, and skills are guidance. They're not security boundaries. The platform enforces permissions, and your review decides what ships.

## Write prompts that direct work

A strong prompt names the outcome, tells the agent to run commands itself, names the review points, and sets approval gates. Compare these two approaches:

| Weak prompt | Strong prompt |
|:------------|:--------------|
| Add vendors to the app. | Names the entity, fields, permission model, and UI, and requires a type-check and build. |
| Leaves deployment open. | Requires a `--dry-run` first, and approval before any deployment. |
| Says nothing about destructive changes. | Forbids `--force` unless you confirm. |

When you want the agent to build and deploy, tell it to run the workflow `rayfin login`, `rayfin up`, `rayfin up status`, and not to print steps for you. Interactive sign-in is still yours: you complete the browser sign-in and then tell the agent to continue. Some commands are long-running, such as `rayfin dev`, so the agent should start them as background processes.

GitHub Copilot in agent mode also asks for approval before it runs terminal commands. Read each command before you approve it. That prompt is a second approval gate, and it doesn't replace the gates you write into the prompt.

## Set approval gates

An agent can run commands that change your Fabric workspace. Decide which actions need your approval and write them into the prompt:

- Any `--force` flag or destructive schema change.
- Deploying with `rayfin up`.
- Changes to `rayfin.yml` services, including anonymous access.
- New dependencies.

The review unit that follows describes what to look for at each gate.

## Next step

In the next exercise, you install the agent files and direct GitHub Copilot in agent mode to add a vendor entity and its UI.
