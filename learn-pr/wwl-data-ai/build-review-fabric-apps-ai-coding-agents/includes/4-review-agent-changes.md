The Adventure Works Cycles agent produced a diff, and the build passes. A passing build says the code compiles, not that it's safe. This unit gives you a checklist for reading an agent's diff, so you catch what the compiler doesn't.

## Review the diff, not the summary

An agent's final message describes what it intended. The diff shows what it did. Open the source control view and read every changed file. Review in this order, because the highest-risk items come first.

## Check permissions on every entity

Every entity needs an explicit permission decorator: `@authenticated()`, `@anonymous()`, or `@role()`. Look for:

- **Entities with no decorator.** An entity without one doesn't become inaccessible. It silently receives `authenticated: *`, which is full create, read, update, and delete access for any signed-in user with no row-level restriction. Add an explicit decorator.

- **Overly broad rules.** `@authenticated('*')` with no policy lets any signed-in user change any row. Owner data needs a policy such as `claims.sub.eq(item.user_id)`.

- **Anonymous access.** Any `@anonymous()` rule needs a deliberate reason, and it needs the tenant setting that a Fabric administrator controls.

- **Missing owner fields.** A policy that compares to `user_id` needs the field. Policies check ownership but don't fill in the owner field, so the code must set it on create, from the session in the frontend or from `ctx.user.id` in a function.

## Check schema and deployment risk

Look for changes that could destroy data or widen what's deployed:

- **Destructive schema operations.** Dropped columns, narrowed types, and renamed tables can destroy data. The CLI blocks them and describes the impact unless you use `--force`.

- **`--force` in commands or scripts.** Treat every `--force` as a decision for you, not the agent.

- **Changes in `rayfin/rayfin.yml`.** Check enabled services, anonymous access settings, `allowedRedirectUris` (keep it scoped to the app's own origins), and `services.staticHosting.assetAccess` (`protected` unless the app must be public).

- **Unbounded text.** A `@text()` field with no `max` becomes `NVARCHAR(MAX)` on MSSQL and can break the API after a deployment that reports success. This also applies to `@email()`.

## Check secrets and dependencies

- **Secrets in frontend code.** Only publishable keys (`pk-*`) belong there. Search the diff for API keys, connection strings, tokens, and values that look like credentials.

- **Committed local files.** Generated and local files such as `rayfin/.env`, `rayfin/.deployments.json`, and `.env.local` stay out of source control. Confirm that the diff doesn't add them.

- **New dependencies.** Check what the agent added and why.

- **Mixed Rayfin versions.** Every `@microsoft/rayfin-*` package must use one exact version. Mixed versions produce type errors or two copies of the data package.

## Check for common anti-patterns

The agent rules list mistakes that agents repeat. Look for the left column and expect the right column:

| Agent mistake | Expected pattern |
|:--------------|:-----------------|
| Raw `fetch()` or hand-built GraphQL for data | The typed `client.data.<Entity>` |
| `new RayfinClient(...)` | `RayfinClient.create({ ... })` |
| `findById()` followed by reading other fields | `select([...]).where(...).findFirst()` |
| `onAuthStateChange` | `onSessionChange` |
| An empty `catch` around sign-in | Render `error.message` |
| Hard-coded data in a screen | Data from the client |

## Treat review as a gate

For each finding, decide to fix it, send it back to the agent with a precise instruction, or stop the release. Fix permission gaps yourself instead of asking the agent to guess. After you fix a problem, check whether the same pattern appears in other files.

## Next step

In the next exercise, you review a supplied patch that has seeded defects, and you fix the permission gap.
