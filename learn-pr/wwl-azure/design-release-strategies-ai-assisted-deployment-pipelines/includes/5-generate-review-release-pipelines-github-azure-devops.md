The build module owns restore, compilation, tests, Docker construction, and candidate publication. Delivery starts with its accepted output. Don't copy the build into each release environment: select the same artifact or container digest, then apply the environment's approved configuration and exposure plan.

## Prompt for release behavior, not another build

Give Copilot the candidate contract, approved targets, identity names, environment sequence, readiness and health checks, and recovery constraints. The following brief describes an illustrative EShopOnWeb ZIP release:

```text
Draft a release pipeline for the supplied accepted app-candidate/app.zip.
Use the same selected build output for dev/test, staging, and production.
Do not restore, compile, run a Docker build, or select latest.
Preserve the approved configuration and deployment identities for each target.
Require target readiness before mutation, smoke/acceptance tests afterward,
and applicable health evidence before the next environment or exposure wave.
Prepare the production App Service staging slot, then require independent
authorization and compatibility checks before a blue-green slot swap.
Do not create infrastructure, identities, role assignments, or secret values.
List missing implementation and externally configured protections.
Return a proposal only; do not deploy, change traffic, or queue a run.
```

For canary or early adopters, supply the actual routing/feature-flag mechanism and cohort contract. Ask Copilot to preserve the stop rules, sample requirements, and maximum exposure. Don't ask it to invent traffic-management commands from a generic label such as "canary."

## Compare the orchestration across platforms

Azure Pipelines represents the release with stages and deployment jobs using protected environments. GitHub Actions represents it with dependent jobs and environment references. On either platform, approvals and access protections must be configured independently of the proposed YAML.

| Release concern | Azure Pipelines | GitHub Actions |
| --- | --- | --- |
| Candidate selection | A selected pipeline resource run or explicit approved run ID | An explicit accepted workflow run ID and artifact |
| Sequence | Stage/job `dependsOn` and success conditions | Job `needs` and success conditions |
| Target controls | Environment and service-connection approvals/checks | Environment protection and deployment-branch rules |
| Azure authority | Scoped federated Azure service connection | OIDC federation and scoped Azure RBAC |
| Reuse | Reviewed deployment templates | Reviewed reusable workflows |

The examples below focus on the **production slot boundary**, after dev/test and an independent staging rehearsal. They are illustrative fragments, not supplied runnable labs. Existing slots, scoped identities, approved candidate metadata, applicable release evidence, and protected execution are prerequisites.

The referenced scripts must be implemented and reviewed separately: `check-release-readiness.sh` checks the exact candidate, target/configuration, compatibility and required evidence; `verify-release.sh` checks the deployed identity and required application behavior and health. They must return nonzero on failed, missing, or stale required evidence. A generic HTTP 200 is not enough. They don't exist merely because the YAML names them.

### Azure Pipelines: prepare, verify, and authorize the switch

This release pipeline references an accepted run of the fictional `eshop-ci` build pipeline. Select the approved resource run at queue time and enforce that it succeeded from the trusted branch and expected build definition. The release definition and scripts must also come from an approved revision. Resource selection isn't automatic approval.

```yaml
trigger: none
resources:
  pipelines:
  - pipeline: accepted
    source: eshop-ci
    trigger: none

pool:
  vmImage: ubuntu-latest

stages:
- stage: PrepareProduction
  jobs:
  - deployment: PrepareSlot
    environment: production-slot-preparation
    strategy:
      runOnce:
        deploy:
          steps:
          - download: none
          - checkout: self
            persistCredentials: false
          - download: accepted
            artifact: app-candidate
          - task: AzureCLI@2
            inputs:
              azureSubscription: sc-production-slot
              scriptType: bash
              scriptLocation: inlineScript
              inlineScript: |
                set -euo pipefail
                test -f "$PACKAGE_PATH"
                bash scripts/check-release-readiness.sh
                az webapp deploy --resource-group "$RESOURCE_GROUP" --name "$WEB_APP_NAME" --slot staging --src-path "$PACKAGE_PATH" --type zip
                bash scripts/verify-release.sh staging
            env:
              PACKAGE_PATH: $(Pipeline.Workspace)/accepted/app-candidate/app.zip
              SOURCE_RUN_ID: $(resources.pipeline.accepted.runID)
              RESOURCE_GROUP: $(productionResourceGroup)
              WEB_APP_NAME: $(productionWebApp)

- stage: ReleaseProduction
  dependsOn: PrepareProduction
  condition: succeeded()
  jobs:
  - deployment: SwitchTraffic
    environment: production-traffic
    strategy:
      runOnce:
        deploy:
          steps:
          - download: none
          - checkout: self
            persistCredentials: false
          - task: AzureCLI@2
            inputs:
              azureSubscription: sc-production-traffic
              scriptType: bash
              scriptLocation: inlineScript
              inlineScript: |
                set -euo pipefail
                bash scripts/check-release-readiness.sh
                az webapp deployment slot swap --resource-group "$RESOURCE_GROUP" --name "$WEB_APP_NAME" --slot staging --target-slot production
                bash scripts/verify-release.sh production
            env:
              SOURCE_RUN_ID: $(resources.pipeline.accepted.runID)
              RESOURCE_GROUP: $(productionResourceGroup)
              WEB_APP_NAME: $(productionWebApp)
```

The production-traffic environment needs independent approval and applicable checks. Its readiness check must revalidate the candidate currently in the slot, not just reuse an earlier passed step: another run could have replaced it while this run waited. Serialize the full preparation-to-switch transaction through the approved deployment coordination mechanism; a stage dependency only orders work within one run.

### GitHub Actions: select the exact build and protect each write job

This workflow takes an explicit build run ID. A separate trusted validation job verifies the run's repository, build-workflow identity, successful conclusion, source branch/revision, and required evidence before the write jobs start. Implement that validation rather than treating a user-entered number as acceptance.

```yaml
name: Release accepted candidate
on:
  workflow_dispatch:
    inputs:
      build-run-id:
        required: true
        type: string

permissions:
  contents: read
  actions: read

concurrency:
  group: eshop-production-release
  cancel-in-progress: false

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      - shell: bash
        env:
          SOURCE_RUN_ID: ${{ inputs.build-run-id }}
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          REPOSITORY: ${{ github.repository }}
        run: bash scripts/check-release-readiness.sh

  prepare:
    needs: validate
    runs-on: ubuntu-latest
    environment: production-slot-preparation
    permissions:
      contents: read
      actions: read
      id-token: write
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      - uses: actions/download-artifact@v5
        with:
          name: app-candidate
          path: ${{ runner.temp }}/candidate
          run-id: ${{ inputs.build-run-id }}
          github-token: ${{ secrets.GITHUB_TOKEN }}
      - uses: azure/login@v2
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}
          tenant-id: ${{ vars.AZURE_TENANT_ID }}
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}
      - shell: bash
        env:
          SOURCE_RUN_ID: ${{ inputs.build-run-id }}
          RESOURCE_GROUP: ${{ vars.PRODUCTION_RESOURCE_GROUP }}
          WEB_APP_NAME: ${{ vars.PRODUCTION_WEB_APP }}
          PACKAGE_PATH: ${{ runner.temp }}/candidate/app.zip
        run: |
          set -euo pipefail
          test -f "$PACKAGE_PATH"
          bash scripts/check-release-readiness.sh
          az webapp deploy --resource-group "$RESOURCE_GROUP" --name "$WEB_APP_NAME" --slot staging --src-path "$PACKAGE_PATH" --type zip
          bash scripts/verify-release.sh staging

  release:
    needs: prepare
    runs-on: ubuntu-latest
    environment: production-traffic
    permissions:
      contents: read
      id-token: write
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      - uses: azure/login@v2
        with:
          client-id: ${{ vars.AZURE_CLIENT_ID }}
          tenant-id: ${{ vars.AZURE_TENANT_ID }}
          subscription-id: ${{ vars.AZURE_SUBSCRIPTION_ID }}
      - shell: bash
        env:
          SOURCE_RUN_ID: ${{ inputs.build-run-id }}
          RESOURCE_GROUP: ${{ vars.PRODUCTION_RESOURCE_GROUP }}
          WEB_APP_NAME: ${{ vars.PRODUCTION_WEB_APP }}
        run: |
          set -euo pipefail
          bash scripts/check-release-readiness.sh
          az webapp deployment slot swap --resource-group "$RESOURCE_GROUP" --name "$WEB_APP_NAME" --slot staging --target-slot production
          bash scripts/verify-release.sh production
```

Configure each environment's federation subject, variables, protected branch access, and separate scoped identity. `id-token: write` permits an OIDC request, not Azure authorization by itself. The release job needs only its traffic-change authority. Major action versions are illustrative, mutable references; adopt reviewed immutable references or applicable enforced locks.

The concurrency group avoids overlapping runs of this workflow that use the same group. It is not a cross-platform lock against another pipeline, operator, or deployment system, and it is not a durable release queue. Revalidate slot identity after approval and coordinate every writer to the target.

## Preserve the release contract during review

Inspect candidate identity, artifact paths, environment configuration, ordering, permissions, stop behavior, and the implementation of every named check. Reject a proposal that rebuilds, selects unrelated latest output, weakens evidence rules, or adds a broad role to fix a failure.

A container release replaces ZIP deployment with the target platform's supported digest-based image selection. Don't substitute NuGet feed-view promotion for that operation. Canary or early-adopter releases need reviewed routing or flag steps and cohort-health checks between waves; the blue-green slot example alone doesn't implement those patterns.

Infrastructure can be maintained separately. If the approved scenario combines **Build -> Infrastructure -> Deploy**, reference or reuse the build module's producer and the dedicated IaC implementation, keeping validation and approval at each boundary. Don't make provisioning mandatory for every release.

After deployment, retain source/build and release-definition identities, configuration, approvals, target operations, and observed health. The next unit decides promote, hold, or halt from that evidence. Failure after a traffic switch needs an approved response; an unconditional rollback-on-failure job isn't a compatibility-aware recovery plan.

Learn more about [App Service slot swaps](/azure/app-service/deploy-staging-slots), [Azure pipeline resource artifacts](/azure/devops/pipelines/process/resources?view=azure-devops), [GitHub deployment controls](https://docs.github.com/en/actions/how-tos/deploy/configure-and-manage-deployments/control-deployments), and [GitHub workflow artifacts](https://docs.github.com/en/actions/tutorials/store-and-share-data).
