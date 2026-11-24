In this exercise, you build the deployment workflow in a GitHub repository, configure its secrets and production approval, and review it for safe handling of credentials and destructive changes.

## Prerequisites

You need a GitHub repository that holds your Fabric Apps project, and a Microsoft Entra app registration with a client secret to use as a service principal. A Fabric administrator must allow service principals to use Fabric APIs, and the service principal needs the Contributor role on the development and production workspaces from the previous exercise. Never paste a secret value into a file, a prompt, or an issue.

If you don't already have an app registration, use the following commands to create one. You need the Azure CLI installed and permission to register applications in your tenant. Run the commands in the same Bash terminal session.

1. Sign in to the tenant that contains your Fabric workspaces. Replace `<tenant-id>` with that tenant's ID. An Azure subscription isn't required for these commands.

      ```bash
      az login --tenant "<tenant-id>" --allow-no-subscriptions
      ```

1. Create a single-tenant app registration, and save its application ID in a shell variable.

      ```bash
      APP_ID=$(az ad app create \
         --display-name "adventure-release-lab-deploy" \
         --sign-in-audience AzureADMyOrg \
         --query appId --output tsv)
      ```

1. Create the service principal that represents this application in your tenant.

      ```bash
      az ad sp create --id "$APP_ID"
      ```

1. Create a client secret that expires after one year. The `--append` option preserves existing credentials.

      ```bash
      az ad app credential reset \
         --id "$APP_ID" \
         --append \
         --display-name "github-actions" \
         --years 1 \
         --query password --output tsv
      ```

      This command prints the secret value. Enter it directly into the GitHub environment secrets when you configure them later in this exercise. Don't share the terminal output or save it in the repository. Use the application ID stored in `APP_ID` for `FABRIC_CLIENT_ID`, the printed secret for `FABRIC_CLIENT_SECRET`, and the tenant ID from your sign-in command for `FABRIC_TENANT_ID`.

1. In the Fabric portal, grant **adventure-release-lab-deploy** the **Contributor** role on both workspaces. Ask your Fabric administrator to enable service principal access to Fabric APIs if it isn't already enabled. Creating the app registration doesn't grant these permissions.

## Create the workflow

1. In the repository, create `.github/workflows/deploy.yml`.
1. Add the workflow from the previous unit.
1. Confirm each protection:
   - `workflow_dispatch` is the only trigger, and the `force` input defaults to `false`.
   - The `concurrency` group includes `inputs.target`, and `cancel-in-progress` is `false`.
   - `environment: ${{ inputs.target }}` selects a GitHub environment.
   - `actions/setup-node` uses Node.js 24.
   - Only the sign-in step reads the three service principal secrets.
      - The sign-in command includes `--encryption-fallback-enabled` for the disposable GitHub-hosted Ubuntu runner. Your security policy permits unencrypted local token storage, and the workflow doesn't cache or upload authentication files.
   - The sign-in command has a `\` at the end of every line except the last, and each variable reference starts with `$`.

## Configure environments, secrets, and variables

1. In the repository settings, create two GitHub environments named `development` and `production`.
1. In the `production` environment, add required reviewers, and limit deployments to the `main` branch.
1. In each environment, add the secrets `FABRIC_CLIENT_ID`, `FABRIC_CLIENT_SECRET`, and `FABRIC_TENANT_ID`. Enter the values in the GitHub interface only.
1. In each environment, add a variable named `FABRIC_WORKSPACE_ID` with that environment's workspace GUID. It's an identifier, not a secret.

The `production` environment now requires an approval before any job that targets it starts, and each environment resolves its own workspace.

## Review the workflow

Review the file without running it. Answer each question in a sentence.

1. Which setting prevents two deployments from running against production at the same time, and why doesn't it block a development deployment?
1. Which step stops a deployment that targets the wrong workspace?
1. What must a person do before a destructive schema change can deploy to production?
1. Where could a secret leak if you moved the service principal values from the sign-in step to the job `env`?

Compare your answers with these:

1. The `concurrency` group serializes runs per `inputs.target`, so production runs queue behind each other while development runs use a different group.
1. The dry-run step prints the resolved target before the deploy step changes anything.
1. A person must set the `force` input to true and approve the `production` environment.
1. The values would reach every step, including `npm ci` and its install scripts, and a mistake could write them into logs.

## Run the workflow safely

If your tenant is ready, run the workflow manually with **target** set to `development` and `force` cleared. In the run log, confirm that the sign-in step succeeds, the preview names the development workspace, and the verify step reports a healthy deployment. Don't run it against production in this exercise. If your tenant isn't ready for service principal sign-in, skip the run.

## Explain the result

- Why does the workflow use `--yes` and `--workspace-id`?
- Why is `force` a manual input and not a default?

A workflow can't answer prompts, and the explicit target prevents it from depending on a local default. A destructive change needs a conscious decision on each run.
