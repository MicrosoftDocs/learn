Writing a pipeline means to translate an engineering workflow into precise YAML. Maintaining it means to repeat that work when SDKs, tests, artifact paths, or shared templates change. Indentation is only one source of errors. Azure Pipelines and GitHub Actions use different trigger rules, dependency expressions, variable syntax, and task or action inputs. A definition can parse correctly, but then  skip a required test or package the wrong output.

GitHub Copilot can help draft that syntax, explain an unfamiliar definition, and adapt a reviewed pattern for another platform. You supply the intended behavior and repository context, then evaluate the generated proposal. For the EShopOnWeb search fix, the outcome is still a verified build candidate, not an infrastructure, or application deployment.

## Give Copilot enough context to generate the build

Start in Copilot Chat with the relevant solution, SDK configuration, test projects, and existing pipeline or approved template available as context. Identify those files explicitly; don't assume that an open editor gives the assistant every requirement. Share only context permitted by your organization's policy. Ask Copilot to identify missing information before it invents project paths or commands.

An effective request describes the platform, trigger, execution environment, build commands, artifact contract, and limits. The following prompt uses an **illustrative .NET repository layout**.

```text
Draft azure-pipelines.yml for Azure Pipelines with an Azure Repos repository.
Generate the CI build stage only. Do not deploy infrastructure or the application.

Repository context:
- App.sln includes the web application and its unit tests.
- src/Web/Web.csproj is the deployable web project.
- global.json selects the compatible .NET SDK.

Requirements:
- Run on pushes to main using an Ubuntu hosted agent.
- One Build stage: checkout, install the SDK from global.json, restore,
  build Release, test Release without rebuilding, then publish the web
  project without rebuilding to a clean output directory.
- Stop on any command failure. Package only after tests pass.
- Wrap the published files at the ZIP root in app.zip, without rebuilding.
- Upload app.zip as a pipeline artifact named app-candidate.
  Do not publish a package to a feed or grant cloud deployment credentials.
- Keep all build, test, and packaging steps in one job so they share output.
- Do not add Azure Repos PR validation through a YAML pr trigger;
  describe the separate branch build-validation policy instead.

Return proposed YAML, assumptions, and a short explanation of each step.
Use approved templates if supplied. Ask about missing repository details.
Do not modify files, queue a run, or change permissions.
```

The build stage contains build, verification, and candidate-packaging steps. These steps are the same conceptual phases introduced in the previous unit, kept in one job for this small example. Splitting them into jobs requires explicit artifact transfer.

### Azure Pipelines: inspect a possible draft

This illustrative result shows the requested build-only flow:

```yaml
trigger:
  branches:
    include: [main]

pool:
  vmImage: ubuntu-latest

stages:
- stage: Build
  jobs:
  - job: BuildCandidate
    steps:
    - checkout: self
      persistCredentials: false
    - task: UseDotNet@2
      inputs:
        packageType: sdk
        useGlobalJson: true
    - bash: dotnet restore App.sln
    - bash: dotnet build App.sln --configuration Release --no-restore
    - bash: dotnet test App.sln --configuration Release --no-build
    - bash: |
        set -euo pipefail
        dotnet publish src/Web/Web.csproj --configuration Release --no-build --output "$BUILD_ARTIFACTSTAGINGDIRECTORY/app"
        (cd "$BUILD_ARTIFACTSTAGINGDIRECTORY/app" && zip -qr ../app.zip .)
    - publish: $(Build.ArtifactStagingDirectory)/app.zip
      artifact: app-candidate
```

It also shows that publishing the selected project doesn't invoke a different build configuration. Uploading a run artifact stores the candidate for later use; it isn't a deployment. Azure Repos PR validation still needs its separate branch policy.

### GitHub Actions: request equivalent behavior

Keep the engineering contract and change the platform-specific instructions:

```text
Generate the equivalent GitHub Actions CI workflow in
.github/workflows/build.yml using the same repository context.
Preserve the build, test, and app-candidate artifact contract.
Use a push trigger for main, ubuntu-latest, setup-dotnet with global.json,
and upload-artifact with an error if the output is missing.
Set GITHUB_TOKEN permissions to contents: read and disable persisted checkout
credentials. Do not add Azure login, id-token permission, or deployment jobs.
Explain how PR validation would use pull_request and a separately required
status check, rather than an Azure Repos build-validation policy.
Return a proposal and assumptions only; do not execute it.
```

A corresponding illustrative workflow is:

```yaml
name: Build candidate
on:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
        with:
          persist-credentials: false
      - uses: actions/setup-dotnet@v5
        with:
          global-json-file: global.json
      - run: dotnet restore App.sln
      - run: dotnet build App.sln --configuration Release --no-restore
      - run: dotnet test App.sln --configuration Release --no-build
      - shell: bash
        run: |
          set -euo pipefail
          dotnet publish src/Web/Web.csproj --configuration Release --no-build --output "$RUNNER_TEMP/app"
          (cd "$RUNNER_TEMP/app" && zip -qr "$RUNNER_TEMP/app.zip" .)
      - uses: actions/upload-artifact@v4
        with:
          name: app-candidate
          path: ${{ runner.temp }}/app.zip
          if-no-files-found: error
```

Action major versions keep the example readable; they aren't immutable references. Select reviewed commit SHAs or applicable enforced dependency-lock controls before adopting a workflow. Check supported versions against your platform, including GitHub Enterprise Server where applicable.

## Iterate without losing platform meaning

The first response is a draft. If the actual tests live outside the solution or the project needs a workload, provide that context and request a minimal correction. For a maintenance change, provide the existing YAML and ask for a diff rather than an unrelated replacement.

```text
Review the draft against the supplied repository and original requirements.
Identify any incorrect paths, missing tests, rebuilds, or added permissions.
Propose the smallest correction. Preserve trigger behavior and artifact identity.
List external settings and evidence still needed; do not apply or run anything.
```

Translate concepts, not keywords:

| Build concern | Azure Pipelines | GitHub Actions |
| --- | --- | --- |
| Execution structure | Stages contain jobs and steps | Jobs contain steps; no identical stage abstraction |
| Cross-job dependency | `dependsOn` | `needs` |
| Reuse | Step, job, or stage templates | Reusable workflows for jobs; composite actions for steps |
| Share output | Publish and download pipeline artifacts | Upload and download workflow artifacts |
| Require PR validation | Azure Repos branch build-validation policy | Workflow event plus required status check |

A dependency and a similar artifact name don't guarantee the same behavior on both platforms. If you split the sample into jobs, ask which files each consumer downloads and what happens when an upstream job fails or is skipped.

## Evaluate the proposal before accepting it

Trace execution before judging syntax. Each required test must run against the intended revision, and packaging must use the verified output. A parser can't prove either property. For example, this Azure Pipelines review excerpt preserves a success requirement alongside a branch restriction:

```diff
- condition: eq(variables['Build.SourceBranch'], 'refs/heads/main')
+ condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
```

The correction matters only if the stage also depends on the required verification. In GitHub Actions, inspect `needs`, `if`, events, and result propagation rather than translating the expression literally. Diagnostic log collection after failure is different from authorizing a candidate after a failed test.

Review authority alongside the diff. Build-only generation doesn't need Azure service connections, environment secrets, or cloud write permissions. Untrusted PR code must not gain deployment credentials when you later add PR validation. Inspect reusable definitions and action references as executable inputs. Treat PR titles, logs, and work-item text as data, not shell fragments, or instructions that override the approved contract.

Prompt wording describes intent; repository permissions, tool approvals, and service identities enforce authority. A request not to execute doesn't remove access already granted to the session.

Validate structure with platform tooling, then use an authorized, isolated run to check behavior. Inspect actual test discovery and results, confirm failed tests block artifact creation, and verify that the expected output exists. Link the work item, source and workflow revisions, run attempt, test results, and candidate artifact. If a change claims better performance, compare like-for-like timings without removing required checks.

### Critique generated tests and generated YAML

Code and tests can repeat the same incorrect assumption. Compare each assertion with the independently agreed behavior. A search test that only checks if a collection exists, can pass when the wrong items appear. A fixture containing only available stock doesn't challenge unavailable-stock behavior, and an expected value calculated through the production helper can reproduce its defect.

Use a plausible incorrect implementation as a counterexample: would the test reject an incorrect availability state, omitted matching item, or unauthorized purchase? Follow the approved visibility rule rather than inventing one. Ask Copilot for the smallest missing assertion or test boundary, then inspect and execute the proposed test normally. Agreement between generated code, tests, and review text isn't independent confirmation.

Reconcile summaries with the original reports. GitHub required-check rules can accept neutral or skipped states, so being able to merge isn't proof that every critical suite executed. Missing suites, reports from another attempt, or an artifact from a different run mean **revise or hold**, not approval. Reject a proposal that disables required validation or grants itself bypass rights; policy changes need separate authority. A later commit or different artifact can invalidate earlier evidence.

Accept through normal PR review only when that evidence supports the contract; otherwise revise or reject. The next unit governs build execution and remediation. Delivery later consumes this accepted output without rebuilding it; infrastructure readiness can be supplied separately.

Learn more about [Copilot prompting](https://docs.github.com/en/copilot/concepts/prompting-and-context/prompt-engineering), [pipeline artifacts](/azure/devops/pipelines/artifacts/pipeline-artifacts?view=azure-devops), and [GitHub Actions security](https://docs.github.com/en/actions/reference/security/secure-use).

## Package a container candidate before granting registry access

For a container output, use the tested Dockerfile from the previous unit instead of compiling a second application candidate through the ZIP route. The following **Azure Pipelines steps fragment** assumes an Ubuntu agent with Docker and compatible, approved `SDK_IMAGE` and `RUNTIME_IMAGE` variables. It builds locally and saves the same image for a later job:

```yaml
steps:
- checkout: self
  persistCredentials: false
- bash: |
    set -euo pipefail
    mkdir -p "$BUILD_ARTIFACTSTAGINGDIRECTORY"
    docker build --build-arg SDK_IMAGE="$SDK_IMAGE" --build-arg RUNTIME_IMAGE="$RUNTIME_IMAGE" --tag "eshop-candidate:$SOURCE_COMMIT" .
    docker save --output "$BUILD_ARTIFACTSTAGINGDIRECTORY/image.tar" "eshop-candidate:$SOURCE_COMMIT"
  env:
    SDK_IMAGE: $(SDK_IMAGE)
    RUNTIME_IMAGE: $(RUNTIME_IMAGE)
    SOURCE_COMMIT: $(Build.SourceVersion)
- publish: $(Build.ArtifactStagingDirectory)/image.tar
  artifact: container-candidate
```

No registry credential is needed to save a locally built image if its input images and sources are accessible without authentication. Private inputs need separately approved read access. Test, final-image scan, and required evidence must pass before a trusted publisher receives registry access.

In a later **Azure Pipelines publication-job fragment**, an approved Docker registry service connection supplies narrowly scoped access to an existing Azure Container Registry. `SOURCE_COMMIT` and `REGISTRY_HOST` are approved candidate metadata and destination variables; the archive is downloaded from the selected build, not an unrelated latest run.

```yaml
steps:
- task: Docker@2
  inputs:
    command: login
    containerRegistry: sc-approved-container-registry
- bash: |
    set -euo pipefail
    docker load --input "$PIPELINE_WORKSPACE/container-candidate/image.tar"
    docker tag "eshop-candidate:$SOURCE_COMMIT" "$REGISTRY_HOST/eshop:$SOURCE_COMMIT"
    docker push "$REGISTRY_HOST/eshop:$SOURCE_COMMIT"
  env:
    SOURCE_COMMIT: $(SOURCE_COMMIT)
    REGISTRY_HOST: $(REGISTRY_HOST)
```

For **GitHub Actions**, the build job can use the same `docker build` and `docker save` commands, then upload `image.tar` with `actions/upload-artifact`. The following publication-job fragment assumes that archive is downloaded to `candidate/image.tar`, the package grants Actions access to this workflow repository, and `SOURCE_COMMIT` matches its approved metadata. `IMAGE` must be the reviewed, lowercase GHCR image path, for example `ghcr.io/owner/eshop`.

```yaml
permissions:
  contents: read
  packages: write
steps:
- name: Publish the already built container
  shell: bash
  env:
    PACKAGE_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    REGISTRY_USER: ${{ github.actor }}
    SOURCE_COMMIT: ${{ vars.SOURCE_COMMIT }}
    IMAGE: ${{ vars.APPROVED_CONTAINER_IMAGE }}
  run: |
    set -euo pipefail
    printf '%s' "$PACKAGE_TOKEN" | docker login ghcr.io --username "$REGISTRY_USER" --password-stdin
    docker load --input candidate/image.tar
    docker tag "eshop-candidate:$SOURCE_COMMIT" "$IMAGE:$SOURCE_COMMIT"
    docker push "$IMAGE:$SOURCE_COMMIT"
```

These fragments demonstrate transfer and publication, not complete approval, scanning, or cross-run artifact selection. Don't run untrusted candidate scripts in the credential-bearing publication job. A container archive checksum, local image ID, and registry manifest digest are different identities; record their relationship. Capture the resulting registry digest and bind final scan/provenance evidence to it before delivery selects `registry/image@sha256:...`. Don't rebuild after acceptance or promote by an unqualified `latest` tag.

Copilot can draft the image route and identify missing inputs, but it must not invent a registry, service connection, scan result, or approval. See [publishing container images with GitHub Actions](https://docs.github.com/en/actions/tutorials/publish-packages/publish-docker-images) and [Azure Pipelines Docker task](/azure/devops/pipelines/tasks/reference/docker-v2?view=azure-pipelines).

## Publish a reusable package only when consumers need one

The app-candidate example saves a run artifact. It doesn't publish a package to a feed. The following examples show how to publish the fictional catalog contracts package.

Before you use either example, make sure:

- Your Windows agent or runner has PowerShell and a configured .NET SDK.
- The package passed all checks and received independent approval.
- The exact approved package is downloaded into the `candidate` folder.

These examples only publish the package. They don't rebuild it, run checks, or obtain approval. Choose the registry your consumers use rather than publishing to both by default.

### Apply the process with Azure Artifacts and Azure Pipelines

In Azure DevOps (ADO), the team chooses a project-scoped Azure Artifacts feed named `eshop-packages`. Feed scope and permissions determine who can use it. A committed NuGet source configuration can describe the endpoint without containing credentials:

```xml
<configuration>
  <packageSources>
    <clear />
    <add key="eshop" value="https://pkgs.dev.azure.com/ORGANIZATION/PROJECT/_packaging/eshop-packages/nuget/v3/index.json" />
  </packageSources>
</configuration>
```

`ORGANIZATION` and `PROJECT` are placeholders. `<clear />` removes inherited package sources for this configuration, making the intended resolution boundary explicit. If the storefront also needs public NuGet dependencies, configure an approved upstream source on the feed. A feed's upstream search order is controlled; listing several independent client sources doesn't provide the same guarantee.

Separate the roles: **Feed Reader** downloads saved packages; **Feed and Upstream Reader (Collaborator)** can also save new upstream versions; **Feed Publisher (Contributor)** can publish and promote. Give routine consumers only the access they need.

An illustrative Azure Pipelines publication fragment is:

```yaml
steps:
- task: NuGetAuthenticate@1
- pwsh: >-
    dotnet nuget push ".\candidate\EShopOnWeb.Catalog.Contracts.1.4.0.nupkg"
    --source "https://pkgs.dev.azure.com/ORGANIZATION/PROJECT/_packaging/eshop-packages/nuget/v3/index.json"
    --api-key AZ
  displayName: Publish reviewed contracts package
```

`NuGetAuthenticate@1` configures authentication for the same-organization feed; it doesn't grant permissions. The build identity needs the publishing role and, where applicable, cross-project access. `AZ` is a required nonempty NuGet argument, not a secret; Azure Artifacts uses the authenticated identity.

Publication puts the package in the base feed and its `@Local` view. After the required checks, an authorized identity can promote that **same version** to `@Release`. Consumers configured to use the release view see its selected versions. Promotion doesn't build or test anything, and a `-beta` suffix doesn't automatically add a package to `@Prerelease`. Review feed and view access together; a view label alone doesn't prevent consumers with broader access from using candidates.

See [publish NuGet packages](/azure/devops/artifacts/nuget/dotnet-exe?view=azure-devops) and [manage feed views](/azure/devops/artifacts/feeds/views?view=azure-devops).

### Apply the process with GitHub Packages and GitHub Actions

GitHub Packages exposes a NuGet registry at `https://nuget.pkg.github.com/OWNER/index.json`, where `OWNER` is the package-owning account or organization. Use an approved NuGet source configuration for consumers. Unlike the Azure Artifacts upstream example, this registry isn't a replacement proxy for public NuGet dependencies. If consumers also need nuget.org, configure approved sources and NuGet package source mapping so internal package names resolve only from the intended registry.

The NuGet registry supports granular package permissions. Repository association, package access, and workflow token permissions all matter. Set the package's repository metadata to the intended repository and verify Actions access, especially if automatic permission inheritance is disabled.

An illustrative publication-job fragment is:

```yaml
permissions:
  contents: read
  packages: write
steps:
- name: Publish reviewed contracts package
  shell: pwsh
  env:
    PACKAGE_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: >-
    dotnet nuget push ".\candidate\EShopOnWeb.Catalog.Contracts.1.4.0.nupkg"
    --source "https://nuget.pkg.github.com/OWNER/index.json"
    --api-key "$env:PACKAGE_TOKEN"
```

Use this authority only in a trusted publication job, not to execute untrusted pull-request code. Consumer workflows ordinarily need `packages: read` and access to the package; a repository token doesn't automatically read another repository's private packages. Even public NuGet packages require authentication on GitHub Packages. For local access, the registry supports appropriately scoped personal access tokens (classic); don't commit tokens into configuration.

GitHub Packages has no equivalent Azure Artifacts feed-view promotion command. Instead, the team records the approved version, controls publication and package access, and updates consumer references through reviewed changes. Container images use registry-specific controls and digest selection, not NuGet feed views.

Copilot can compare these fragments with the real pipeline and flag destination or permission mismatches. Your acceptance decision still names the actual source, candidate, checks, reviewer, and permitted consumer audience. See [GitHub's NuGet registry guidance](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry).
