You deploy the Adventure Works Cycles app by hand, and a mistake in a manual deployment is easy to make. A pipeline makes the process repeatable and puts guardrails around production. This unit describes the parts of a protected deployment workflow and the choices that keep it safe.

## Sign in without a person

A workflow can't complete an interactive browser sign-in. The Rayfin CLI supports service principal sign-in with client credentials, which is the supported way to authenticate from automation:

```bash
npx rayfin login --service-principal --client-id <id> --client-secret <secret> --tenant <tenant-id>
```

The command requires all three values, and the CLI rejects `--client-id` or `--client-secret` without `--service-principal`. The credentials persist for later commands in the same job. Store the client ID, client secret, and tenant ID in the CI secret store, and never in the repository. The service principal needs these prerequisites:

- A client secret on the Microsoft Entra app registration.
- A Fabric tenant setting that allows service principals to use Fabric APIs, enabled by an administrator.
- The Contributor role, or higher, on the target workspace.

A workflow also can't create the workspace. Create each workspace in the Fabric portal and grant the service principal access before the first run.

## Build the workflow from its protections

A protected workflow includes the following protections. Each one prevents a specific failure:

| Protection | What it prevents |
|:------|:-----------------|
| Credentials come from the secret store of a GitHub environment | Credentials in source control, and a development credential that reaches production |
| A `production` environment with required reviewers | A deployment nobody approved |
| A concurrency group per target, with `cancel-in-progress: false` | Two deployments racing on the same workspace, or a half-finished deployment canceled midway |
| `--dry-run` before the deploy | A deployment to the wrong target |
| `--force` behind a manual input that defaults to off | An unreviewed destructive change |
| Node.js 24 | A runtime that the CLI and template don't support |
| `--yes` and an explicit `--workspace-id` | A prompt that hangs the job, or a target that depends on a local default |

## A reference workflow

This workflow uses these protections. A manual run chooses the target environment, and each GitHub environment holds its own workspace ID variable and service principal secrets.

```yaml
name: Deploy Fabric app

on:
  workflow_dispatch:
    inputs:
      target:
        description: Environment to deploy to
        type: choice
        options:
          - development
          - production
        default: development
      force:
        description: Allow destructive schema changes that can lose data
        type: boolean
        default: false

permissions:
  contents: read

concurrency:
  group: fabric-deploy-${{ inputs.target }}
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ inputs.target }}
    env:
      WORKSPACE_ID: ${{ vars.FABRIC_WORKSPACE_ID }}
      FORCE: ${{ inputs.force }}
    steps:
      - name: Check out the repository
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 24

      - name: Install dependencies
        run: npm ci

      - name: Sign in with the service principal
        env:
          CLIENT_ID: ${{ secrets.FABRIC_CLIENT_ID }}
          CLIENT_SECRET: ${{ secrets.FABRIC_CLIENT_SECRET }}
          TENANT_ID: ${{ secrets.FABRIC_TENANT_ID }}
        run: |
          npx rayfin login --service-principal \
            --client-id "$CLIENT_ID" \
            --client-secret "$CLIENT_SECRET" \
            --tenant "$TENANT_ID" \
            --encryption-fallback-enabled

      - name: Preview the deployment
        run: npx rayfin up --workspace-id "$WORKSPACE_ID" --dry-run

      - name: Deploy
        run: |
          EXTRA_ARGS=""
          if [ "$FORCE" = "true" ]; then
            EXTRA_ARGS="--force"
          fi
          npx rayfin up --workspace-id "$WORKSPACE_ID" --yes $EXTRA_ARGS

      - name: Verify the deployment
        run: npx rayfin up status
```

The scaffolded project lists the Rayfin CLI as a dependency, so `npm ci` installs the CLI that `npx rayfin` runs. The `rayfin up` command also runs the frontend build, so the job needs the installed dependencies.

Write your own workflow from the CLI behavior. Check each multi-line command for a `\` at the end of every line except the last. Check that each variable reference starts with `$`. Don't pin an older Node.js version.

## Keep the workflow safe

Pass secrets to steps through `env`, not by interpolating them into the command, and scope them to the one step that needs them. In the workflow, only the sign-in step receives the service principal credentials, so `npm ci` and its install scripts never see them. Keep `permissions` minimal. Create a GitHub environment named `production` with required reviewers, so that a person approves before the job proceeds, and limit that environment to deployments from the `main` branch. Because the `force` input defaults to off, a destructive change needs a person to opt in on that run.

## Next step

In the next exercise, you build this workflow and review its target and sign-in configuration without exposing credentials.
