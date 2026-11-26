Source control supplies a reviewed change; continuous integration (CI) turns the intended revision into a tested build candidate. For the illustrative EShopOnWeb search fix, this module owns the build workflow: restore dependencies, compile, run requirement-linked checks, package once, and retain identified outputs. Repository review doesn't establish that these steps ran.

## Connect PR validation to main-branch integration

PR validation provides evidence before integration. A build on `main` validates the integrated revision and can produce the candidate for subsequent use. These examples are related events, not the same event. Opening a PR, approving it, and completing its merge don't automatically trigger identical jobs or grant identical credentials.

A platform can validate the source revision or a generated test-merge revision, depending on its configuration. Squash and rebase-based completion can also produce a different commit on the target branch. You therefore record what each result validates and how the resulting candidate links to the integrated change. A passing result from an earlier PR update doesn't validate a later conflict resolution.

For **Azure Repos**, PR validation uses a branch build-validation policy. Adding a YAML `pr:` section doesn't configure it. For **GitHub**, required status checks work with the selected workflow events and repository rules. Azure Pipelines connected to GitHub has different PR-trigger support from Azure Repos. You check the repository host before asking Copilot to translate triggers.

### Example: validate a feature branch before merging

Suppose the branch `feature-fix` contains the search fix and its PR targets `main`. The following examples run validation when the PR opens or receives new commits. They don't run a separate build when you push to `feature-fix` without a PR, or when the PR merges into `main`.

The build commands assume a .NET solution at the repository root and an available compatible SDK. Adapt the SDK setup and test selection to your repository. These examples build and test only; they don't publish or deploy.

#### Azure DevOps: Azure Pipelines with Azure Repos

Example of a YAML snippet in an Azure Pipeline:

```yaml
trigger: none

pool:
  vmImage: ubuntu-latest

steps:
- checkout: self
- script: dotnet build --configuration Release
  displayName: Build
- script: dotnet test --configuration Release --no-build
  displayName: Test
```

In Azure Repos, open **Branches**, select **Branch policies** for `main`, and add a **Build validation** policy. Select this pipeline, set the trigger to **Automatic**, and make the policy **Required**. With no path filter, the policy applies to all changes in PRs targeting `main`.

The policy on `main` queues the build for the PR from `feature-fix`. It tests a temporary merge commit combining the source and target branches, without changing `main`. `trigger: none` disables push-based CI, not this policy-driven validation. Draft PRs don't trigger policy builds until published.

#### GitHub: GitHub Actions

Sample snippet of this workflow under the repository's `.github/workflows` directory:

```yaml
name: PR validation

on:
  pull_request:
    branches:
      - main
    types: [opened, synchronize, reopened, ready_for_review]

permissions:
  contents: read

jobs:
  build-and-test:
    name: Build and test
    if: github.event.pull_request.draft == false
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          persist-credentials: false
      - name: Build
        run: dotnet build --configuration Release
      - name: Test
        run: dotnet test --configuration Release --no-build
```

Here, `pull_request.branches` filters the **target** branch, not the source branch. A PR from `feature-fix` into `main` matches. New commits on `feature-fix` generate the `synchronize` event. By default, checkout retrieves the PR's test-merge revision rather than checking out `main` alone. Merge conflicts must be resolved before a `pull_request` workflow can run.

Configure a branch protection rule or ruleset for `main` to require a PR and the **Build and test** status check before merging. The workflow defines when validation runs; the rule makes its result a merge requirement. The draft guard skips the job until the PR is ready for review.

With these settings, the automatic behavior is:

| Event | Azure Pipelines with the policy | GitHub Actions with the workflow |
| --- | --- | --- |
| Push to `feature-fix` without an open PR | No build | No build |
| Open a nondraft PR from `feature-fix` into `main` | Validate the PR merge commit | Validate the PR test-merge revision |
| Push another commit to `feature-fix` while that PR is open | Validate the updated PR | Validate the updated PR |
| Approve the PR without changing code | No new build | No new build |
| Merge the PR into `main` | No push-triggered build | No push-triggered build |

For feedback **before opening a PR**, replace `trigger: none` in Azure Pipelines with `trigger: { branches: { include: [feature-fix] } }`. In GitHub Actions, add `push: { branches: [feature-fix] }` alongside `pull_request` under `on`, and remove the PR-only draft guard or change it to `if: github.event_name == 'push' || github.event.pull_request.draft == false`. These push filters refer to the branch receiving commits. Keeping both push and PR validation can create two runs for a push while a PR is open. Neither example includes `main` in a push trigger; add it separately if you also need a post-merge integration build.

## Design pipeline dependencies and data flow together

A **pipeline dependency graph** describes the stages or jobs and the dependencies between them. It shows which work waits for other work and which work can run in parallel. You define these relationships in YAML; the platform can display them visually.

A useful illustrative build flow is **Build -> Verify -> Package candidate (Artifact)**. Here, each arrow means the next phase depends on the preceding phase. Build resolves the reviewed inputs and produces compiled outputs. Verify evaluates those outputs and the relevant source-level checks. Package candidate prepares the accepted output for later use. A production deployment isn't part of this build decision.

In Azure Pipelines, stages contain jobs and jobs contain steps. Stage dependencies use `dependsOn`. Stages run sequentially by default, but an explicit dependency graph makes the intended relationship easier to review. A custom condition can replace the default success behavior, so branch filtering alone doesn't necessarily preserve successful completion of upstream stages.

GitHub Actions uses jobs, steps, and job dependencies such as `needs`. It doesn't provide an identical top-level Azure Pipelines stage abstraction. A migration therefore preserves the execution and trust boundaries rather than translating each stage into one job mechanically. A group of jobs might represent the same conceptual phase, with separate identities and dependencies.

Running jobs in order doesn't automatically share files between them. The Build job publishes its output as a pipeline artifact, and later jobs download that artifact when they need it. Keep the artifact linked to its source commit and build run so you can trace where it came from. For the search fix, test the same application build that you package for later use, rather than rebuild it and assume the earlier test results still apply.

## Make verification behavior-focused and complete

Derive expected results from the approved requirement, not the generated implementation. For the search change, specify which matching items remain visible, the expected availability presentation, and permitted purchase behavior before generating tests. Don't assume that hiding every unavailable item is correct. Include positive, negative, mixed-result, empty-result, and applicable boundary cases. A hidden purchase control doesn't replace server-side authorization.

Choose the lowest test boundary that observes the risk accurately:

| Risk | Useful evidence |
| --- | --- |
| Incorrect availability decision or rendering | Focused unit/component assertions for the approved item states |
| Query filtering differs from an in-memory mock | Integration results against representative data-store behavior |
| Assembled user journey or dependency contract changes | A small set of end-to-end or contract tests at the affected boundary |

Add load or resilience checks when the diff changes latency, dependency calls, caching, or failure behavior. Don't add every test category to every build. Coverage reports show executed lines or branches, not whether assertions establish the business outcome. A high percentage can accompany a test that checks only a nonempty collection.

Use known synthetic data, representative runtime/configuration, and isolated mutable state. Parallel shards need independent data and complete result aggregation; a missing shard isn't a smaller passing suite. Retain the first flaky failure when allowing a bounded diagnostic rerun. Quarantine requires an owner, repair issue, expiry, and an alternative control for critical behavior, not retry-until-green acceptance.

Check expected test discovery, required-suite execution, report presence, and publication failures explicitly. Azure Pipelines' Publish Test Results task has separate failure controls for failed tests, publication errors, and missing reports; its defaults don't make every missing-report condition fatal. In either platform, a green aggregate check doesn't prove that a required suite ran. Keep the report, test selection, environment, commit, run, and attempt linked to the candidate.

## Reuse build logic

Shared build logic helps teams use the same build and test process without copying YAML into every pipeline. Each platform provides its own way:

- **Azure Pipelines:** Use YAML templates to share steps, jobs, or stages. Pass parameters for choices such as the build configuration. Keep credentials in protected resources such as secret variables or service connections, not in ordinary template parameters.
- **GitHub Actions:** Use reusable workflows to share a workflow containing jobs and steps. The calling job references the workflow with `uses`, passes inputs with `with`, and passes permitted secrets with `secrets`. Limit its `GITHUB_TOKEN` permissions to the access it needs.

For either platform, identify who maintains the shared definition and review updates before adopting them. Reference a specific version or commit when you need repeatable behavior; a branch reference can change between runs.

Copilot can help extract repeated build steps into the appropriate template or reusable workflow. Review the result to confirm that it preserves the required checks and doesn't add unnecessary permissions, secret access, or publishing steps.

## Choose execution boundaries and measure the constraint

Azure Pipelines agents and GitHub Actions runners execute repository-controlled code. A PR test job doesn't need the publishing credentials or private network reach of a trusted publication job. You separate those workloads through effective identities, network policy, and pool or runner access, not just descriptive labels.

Hosted execution reduces machine maintenance. Persistent self-hosted workers offer environment control but can retain files, processes, and credentials between jobs. Ephemeral workers reduce carried state when their lifecycle genuinely ends. A container describes a tool environment; it doesn't automatically erase host state or block private-network access.

Concurrency needs to respect the constrained resource. Parallel unit tests can help, while two jobs changing one shared test database can interfere. A matrix also consumes execution capacity. GitHub concurrency groups and Azure Pipelines protected-resource locks offer different controls; an ordinary stage or job dependency within one run isn't a lock against work in another run. Dependency caches likewise need input-aware keys and appropriate trust boundaries. They aren't substitutes for versioned output artifacts.

You measure queue time separately from execution time and compare like-for-like runs. Useful signals include critical-path duration, first-attempt failures, compute consumption, and cache behavior. Retention also determines how long the team can inspect original results. In the search scenario, removing a required test can look as fast as genuine parallelization, so the accepted optimization preserves the verification contract. The next unit develops Docker packaging and dependency sources. Later, you use the build contract to evaluate Copilot-generated YAML and publication proposals.

Learn more about [Azure Pipelines stages and dependencies](/azure/devops/pipelines/process/stages?view=azure-devops), [Azure Repos pipeline triggers](/azure/devops/pipelines/repos/azure-repos-git?view=azure-devops), [test-result publication controls](/azure/devops/pipelines/tasks/reference/publish-test-results-v2?view=azure-pipelines), and [agent execution models](/azure/devops/pipelines/agents/agents?view=azure-devops).
