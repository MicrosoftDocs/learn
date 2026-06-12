::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=17ad0ac9-fa24-4e8e-b36f-7575f419d2ac]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

A Bicep template sitting in a repository with no deployment pipeline is incomplete infrastructure as code. The template defines the desired state, but without automation, someone still has to manually run `az deployment group create` from their local machine. This reintroduces the human-error problems that IaC was meant to eliminate.

CI/CD pipelines close that gap. They enforce a consistent deployment process: the template is validated before deployment, changes go through staging before production, and no one can bypass the process by pushing directly to a shared resource group. The pipeline is the governance layer on top of the template.

GitHub Copilot significantly reduces the time to write these pipelines. Pipeline YAML is verbose, highly structured, and follows patterns that repeat across projects, making it an ideal target for AI-assisted generation.

## Azure DevOps pipeline structure

An Azure DevOps YAML pipeline is organized into stages, jobs, and steps. For infrastructure deployment, a well-structured pipeline typically has four stages:

1. **Validate:** compile and lint the template, run a what-if
2. **Deploy Staging:** deploy to a staging environment, run smoke tests
3. **Approve and Deploy Production:** require a human approval, then deploy
4. **Rollback (conditional):** redeploy the previous version if production fails

### Generating a multi-stage ADO pipeline

```
Generate an Azure DevOps multi-stage YAML pipeline for deploying a Bicep template.
The pipeline should:

Trigger:
- On pushes to the main branch
- Only when files under the infra/ folder change (path filter)
- On pull requests to main (for the Validate stage only)

Variables:
- Use variable groups: "vg-iaclab-staging" for staging values
  and "vg-iaclab-production" for production values

Stage 1 - Validate:
- Run on ubuntu-latest
- Steps: az bicep build (lint check), then az deployment group what-if
  against the staging resource group using service connection "sc-iaclab-staging"
- Publish the what-if output as a pipeline artifact named "whatif-report"

Stage 2 - Deploy Staging:
- Depends on Validate passing
- Deploy the Bicep template to resource group "rg-iaclab-staging"
  using service connection "sc-iaclab-staging"
- Pass environment=staging and costCenter from the variable group

Stage 3 - Deploy Production:
- Depends on Deploy Staging passing
- Requires a manual approval from the "iaclab-approvers" group
  before the stage starts
- Deploy to "rg-iaclab-production" using "sc-iaclab-production"
- Pass environment=production and costCenter from the variable group

Stage 4 - Rollback:
- Only runs if Stage 3 fails (condition: failed())
- Downloads the previous successful Bicep artifact and re-deploys it
  to the production resource group

All stages run on ubuntu-latest. Use AzureCLI task for deployments.
```

### Key concepts to verify in Copilot's output

**Service connections:** ADO uses service connections to authenticate to Azure. The `azureSubscription` parameter in the `AzureCLI` task references the service connection name. Confirm the service connection names match what exists in your ADO project.

**Variable groups:** Variable groups are referenced with `group:` syntax under `variables`. Confirm Copilot uses `$(variableName)` syntax for runtime values, not `${{ variables.variableName }}` which is evaluated at compile time.

**Environment approvals:** In ADO, approvals are configured in the `environment:` resource in the portal, not in the pipeline YAML. The YAML references the environment by name. The actual approval rule is set up separately in ADO for that environment.

**Artifact download for rollback:** The rollback stage needs to download a specific artifact. Copilot generates the `DownloadPipelineArtifact` task, but you may need to adjust the `artifactName` and `path` parameters to match what the Validate stage actually publishes.

### Adding a policy compliance gate

```
Add a step to the Validate stage that runs az policy state summarize
against the staging resource group and fails the pipeline if any resources
are in a "NonCompliant" state. Parse the JSON output and fail with a clear
message listing the non-compliant resources.
```

Policy gates prevent deploying to an environment that is already out of compliance. This is a useful guardrail before applying new infrastructure changes.

## GitHub Actions workflows

GitHub Actions use a different YAML structure but covers the same concepts: triggers, jobs, steps, environments, and secrets. The key differences from ADO pipelines are:

- Jobs replace stages as the top-level unit, with dependency expressed through `needs:`
- Environments in GitHub handle approvals and protection rules
- OIDC federation (not service principals with passwords) is the recommended authentication method
- Reusable workflows in `.github/workflows/` replace ADO pipeline templates

### Generating a GitHub Actions workflow

```
Generate a GitHub Actions workflow for deploying a Bicep template to Azure.

Trigger:
- On push to main branch when files under infra/ change
- On pull_request to main (validate job only)

Authentication:
- Use OIDC federation via azure/login action
- Secrets: AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID

Jobs:

validate:
- Runs on ubuntu-latest
- Steps: checkout, azure login, az bicep build, az deployment group what-if
  against rg-iaclab-staging
- Upload the what-if output as an artifact

deploy-staging:
- Depends on validate succeeding
- Runs in GitHub Environment "staging"
- Steps: checkout, azure login (staging credentials), deploy Bicep to rg-iaclab-staging

deploy-production:
- Depends on deploy-staging succeeding
- Runs in GitHub Environment "production"
  (production environment has a required reviewer protection rule)
- Steps: checkout, azure login (production credentials), deploy Bicep to rg-iaclab-production

rollback:
- Runs if deploy-production fails
- Downloads the artifact from validate, re-deploys to rg-iaclab-production

Use ubuntu-latest for all jobs.
```

### OIDC authentication

Traditional Azure service principals use a client secret that must be stored in GitHub Secrets, rotated periodically, and can be leaked. OIDC (OpenID Connect) federation eliminates the password. GitHub's identity provider issues a short-lived token that Azure trusts directly.

The setup requires:
1. Creating a Managed Identity or App Registration in Azure with a federated credential
2. Configuring the federated credential to trust tokens from your specific GitHub repo and branch
3. Granting the identity the necessary Azure RBAC role
4. Storing only the nonsecret values (CLIENT_ID, TENANT_ID, SUBSCRIPTION_ID) in GitHub Secrets

Use this prompt to generate the setup script:

```
Generate an Azure CLI script that:
1. Creates an App Registration named "gh-actions-iaclab"
2. Creates a federated credential on the registration trusting GitHub Actions
   from the repo "myorg/iaclab" on the main branch and on pull requests
3. Assigns the "Contributor" role on resource group "rg-iaclab-staging"
   and "rg-iaclab-production"
4. Outputs the CLIENT_ID, TENANT_ID, and SUBSCRIPTION_ID values to add to GitHub Secrets
```

### Reusable workflows

Reusable workflows let you define a deployment job once and call it from multiple workflows. Eliminating repetition when deploying to multiple environments with the same steps.

```
Refactor this GitHub Actions workflow so the deployment job is a reusable
workflow in .github/workflows/deploy-bicep.yml.
The reusable workflow should accept inputs for:
- resource_group (string)
- environment_name (string)
- bicep_file (string, default: main.bicep)
- parameters (string, JSON format)
And secrets for: AZURE_CLIENT_ID, AZURE_TENANT_ID, AZURE_SUBSCRIPTION_ID.
Update the main workflow to call the reusable workflow for both staging
and production deployments, passing different inputs each time.
```

## Translating between ADO and GitHub Actions

Teams migrating between platforms frequently need to translate pipelines. Copilot handles this process well when you tell it explicitly how to map concepts:

```
Translate this Azure DevOps YAML pipeline to a GitHub Actions workflow.
Map the following concepts:
- ADO stages → GitHub Actions jobs with needs: dependencies
- ADO variable groups → GitHub Actions environments and secrets
- ADO service connections → GitHub Actions OIDC credentials
- ADO manual approval (environment) → GitHub Actions environment protection rules
- AzureCLI task → azure/login + run: az ... steps
Preserve all logic. Do not add features that are not in the original pipeline.

[paste ADO pipeline YAML here]
```

The explicit mapping instruction matters. Without it, Copilot may miss the conceptual equivalence between ADO and GitHub Actions constructs.

The following table shows the concept mapping between the two platforms:

| Azure DevOps | GitHub Actions |
|---|---|
| Stage | Job (with `needs:`) |
| Job | Steps group within a job |
| Variable group | Environment secrets / `vars` context |
| Service connection | OIDC credentials in GitHub Secrets |
| Environment (with approval) | GitHub Environment with protection rule |
| `AzureCLI` task | `azure/login` action + `run: az ...` |
| `PublishPipelineArtifact` | `actions/upload-artifact` |
| `DownloadPipelineArtifact` | `actions/download-artifact` |
| `$(variableName)` | `${{ vars.VARIABLE_NAME }}` |
| `${{ variables.name }}` | `${{ inputs.name }}` (reusable workflows) |

## IaC pipeline patterns

### Validate before deploy

Always run `az bicep build` and `az deployment group what-if` in a dedicated Validate stage before any deployment stage. The what-if output should be published as an artifact so reviewers can inspect it before approving production deployment.

### Staged promotion with approvals

Deploy to staging first. Only promote to production after a human reviews the staging deployment and explicitly approves. In ADO, this flow is configured through environment approval rules. GitHub Actions uses environment protection rules with required reviewers.

### Conditional rollback

A rollback stage should only trigger when the production deployment fails. Both ADO and GitHub Actions support conditional execution. In ADO, use `condition: failed()` on the rollback stage. In GitHub Actions, use `if: failure()` on the rollback job. The rollback stage redeploys the last known-good artifact rather than the current template.

### Path-filtered triggers

Trigger the pipeline only when infrastructure files change, not on every commit to the repository. Use path filters (`paths:` in GitHub Actions, `include:` under `trigger.paths` in ADO) to scope the trigger to the `infra/` directory or wherever your Bicep files live. Preventing unnecessary pipeline runs when only application code changes.

::: zone-end
