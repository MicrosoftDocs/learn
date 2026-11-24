You have a working issue-reporting tool for Adventure Works Cycles and need a safe path to production. This unit explains how separate workspaces and the Rayfin CLI provide that path, and how Fabric Git integration and deployment pipelines offer a different one.

## Separate development from production

Use one workspace for development and another for production. Each holds its own copy of the app item, its own database, and its own data. Changes reach production only when you deliberately deploy them there. This separation keeps experiments, test data, and half-finished schema changes away from the people who use the app.

The Rayfin CLI records each deployment in `rayfin/.deployments.json`, and it merges the active deployment's public values into `rayfin/.env`. These files are a local pointer, not a source of truth, and the CLI doesn't commit them to source control. They don't replace knowing which workspace you deploy to.

## Deploy to a target with the CLI

`rayfin up` deploys to a workspace you choose with `--workspace` (a display name) or `--workspace-id` (a GUID). Pass at most one workspace selector. The first deployment to a workspace creates a separate app item there, and later deployments update that item.

```bash
npx rayfin up --workspace "Adventure Works Dev"
npx rayfin up --workspace "Adventure Works Prod" --dry-run
npx rayfin up --workspace "Adventure Works Prod"
```

Three related commands manage targets:

| Command | Purpose |
|:--------|:--------|
| `npx rayfin up list` | Lists the deployments recorded for this project. |
| `npx rayfin up switch <workspace>` | Makes a recorded deployment active and rewrites `rayfin/.env`. Add `--list` to list the recorded deployments instead of switching. |
| `npx rayfin up status` | Reports the health of the active deployment. It verifies management access to the app item, not every route or function. |

## Preview and protect production

`--dry-run` validates local inputs and resolves the target workspace without deploying, applying schema, or uploading anything. It signs in and makes read-only requests to resolve the workspace, then prints the planned operations and the target. Use it before every production deployment. Reserve `--force` for reviewed cases, because it permits destructive schema changes and removal of non-empty Storage folders. To deploy, you need Edit permission on the item.

## Compare with Fabric Git integration and deployment pipelines

Fabric also offers two workspace-level lifecycle tools:

- **Git integration** connects a Fabric workspace to a branch in a Git repository. You commit supported item definitions to track their version history and update the workspace with changes from that branch.

- **Deployment pipelines** organize workspaces into stages, such as development, test, and production. You compare supported items between stages and deploy selected items from one stage's workspace to another.

Both support Fabric apps, but they're a different lifecycle from the CLI path.

| Aspect | Rayfin CLI | Git integration | Deployment pipelines |
|:--|:-----------|:----------------|:---------------------|
| Scope | One app deployment, chosen with `--workspace` | The whole workspace, connected by a workspace Admin | Stages that contain workspaces |
| What moves | Your source, built during the deployment | The built definition, not your source | The built definition, with no rebuild |
| Typical use | Developer-driven releases and automation | Version history for workspace items | Promotion through stages |

Because deployment pipelines move the built definition without a rebuild, the client must resolve configuration at runtime. Apps call `resolveRayfinConfig()` from `@microsoft/rayfin-client` before they create the client, and then pass the result to `RayfinClient.create`. A promoted bundle then reads the stage's generated `rayfin.config.json` instead of values baked in from the source stage. Don't call `RayfinClient.create` with `VITE_RAYFIN_API_URL` and `VITE_RAYFIN_PUBLISHABLE_KEY` directly in deployed code, because that bakes the source stage into the bundle.

Promotion copies definitions, not everything the app holds:

- Secret values, data rows, and storage objects aren't promoted. Git integration and deployment pipelines copy secret names, so set the values in each stage.
- Connector workspace and item IDs, and any absolute redirect URIs, need review in each stage.
- Importing a definition applies database schema changes to the target, so review removals or changes to entities and fields before you deploy.

In this module, the CLI and GitHub Actions paths are the hands-on labs. Treat Git integration and deployment pipelines as options to compare, not additions to the CLI path, and pick one lifecycle per app so that stages don't conflict.

## Next step

In the next exercise, you deploy to a development workspace, preview and deploy to production, and compare the CLI path with promotion by deployment pipelines.
