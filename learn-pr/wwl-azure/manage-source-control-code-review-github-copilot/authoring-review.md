# Repository-to-build authoring review

## Current source-control boundary: November 24, 2026

Approved coverage follow-up: units 2 and 5 now assume an experienced DevOps engineer and deepen the transition to Copilot-assisted work. Unit 2 adds trunk-based/GitHub flow/Gitflow trade-offs, separate worktree boundaries, migration cutover/evidence and selective Git recovery. Unit 5 adds a bounded GitHub MCP read-and-propose workflow and user/app/workflow/Azure identity distinctions. GitHub App installation-token expiry and current GitHub MCP usage were checked against first-party documentation.

These are instructional extensions, not new lab steps. Existing exercise/assessment assets, launch buttons, identities, unit order and classroom reservations remain unchanged. Migration, MCP sign-in and hosted review aren't executed. Reading estimates increase independently of classroom allocations.

Status: draft-for-review. The learner-facing module title is **Manage source control and code review with GitHub Copilot**. The approved naming follow-up aligns the module folder and module/unit/badge UID prefixes with that title. The subsequent unit-title audit renames units 4 and 5 to identify PR acceptance/evidence and context-led repository assistance, and aligns filenames/UID suffixes for units 4-6. Local references are updated without changing content approval, lesson bodies or unit order.

| Unit | Revision |
| --- | --- |
| 1-3 | Keep repository/branch/PR mechanics, early threat modeling, conflict resolution, and native Copilot review; align the introduction and handoffs with source-control scope. |
| 4 | Replace pipeline architecture with change contracts, independent source/test expectations, and revision-linked review evidence. Move the original architecture/verification instruction to Build 2.2/2. |
| 5 | Replace build YAML with bounded repository assistance and GitHub/Azure Repos review instructions. Move original build-generation examples to Build 2.2/4. |
| 6 | Focus on repository ownership, protected controls, contribution/merge authority, and source traceability. Move runner/runtime-agent detail to Build 2.2/5. |
| 7 | Preserve the user-edited GitHub/Azure Repos lab introduction and both launch buttons. |
| 9 | Hand accepted source and verification expectations to build, not an already produced artifact. |

Seven instructional units are drafts; the exercise introduction is separately draft-for-review and knowledge check remains deferred. Unit sequence, the 60-minute trainer/practical reservations, and retained source assets are unchanged. Earlier identity-preservation statements refer to the pre-alignment authoring revision. Reading estimates are independent of trainer time.

Repository-instruction behavior is checked against [GitHub repository instructions](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions) and the supplied Azure Repos companion lab. No hosted review, repository policy change, lab run, or classroom timing is executed.

## Historical repository-to-build revision

The following records the earlier scope. Its unit placements, preservation statements, estimates, and status totals are superseded by the current revision above.

Status: draft-for-review. Repository/PR revision checked on November 16, 2026; pipeline-generation extension and validation consolidation checked on November 19, 2026.

## Approved revision and boundaries

The user requests a condensed contribution story based on the existing Git module, assumes basic Git knowledge rather than full workflow fluency, and approves replacing the repeated MCP investigation with repository/PR coverage.

The revised five content units follow:

1. Repository setup or clone -> branch strategy -> local edits -> stage/commit/push -> PR -> merge -> synchronization.
2. Early threat modeling -> conflict reconciliation -> Copilot assistance -> native PR review -> integration decision.
3. Reviewed revision -> reusable graph -> behavior-focused tests and environments -> artifact flow -> execution boundaries.
4. Build-only Copilot prompting -> paired platform drafts -> generated-test critique -> complete candidate-linked evidence.
5. Repository and automation permissions -> bounded runtime agents -> retained contribution record.

This deliberately integrates AI assistance at the relevant lifecycle handoffs rather than force all traditional content ahead of all AI content. Two dedicated repository/PR units receive 30 trainer minutes. Runner detail is consolidated into architecture; no MCP investigation or setup is repeated.

The nine-unit count, module title/UID, badge UID, and three retained substantive unit UIDs remain unchanged. Two unpublished unit identities are replaced:

| Retired unit identity | Treatment |
|---|---|
| `design-runner-isolation-and-concurrency` | Originally consolidate its execution/isolation/capacity decisions into the architecture unit; that instruction now belongs to [Build 2.2/2](../build-validate-pipelines-containers-artifacts-ai-assistance/includes/2-design-ci-pipelines-build-verification.md). |
| `inspect-pipeline-runs-and-logs-with-mcp` | Remove the repeated investigation story. Add the repository contribution and Copilot PR-review units instead. |

The new unit identities are `design-source-control-branch-pr-workflow` and `review-pull-requests-resolve-conflicts-with-copilot`. Retained architecture, YAML-evaluation, and governance files are renumbered to positions 4, 5, and 6; their UIDs remain stable. Course tracking must resolve the manifest rather than reconstruct identities from old file numbers.

The seven instructional units are authored. The exercise introduction now links to the GitHub and Azure Repos companion code-review labs, as recorded in the November 23 follow-up below. Knowledge-check YAML/Markdown remain unchanged and deferred.

The EShopOnWeb work item is still "Search results showing out-of-stock items". The concurrent catalog change, example file names, commands, and controls are illustrative. No application checkout or working repository is claimed as a Boards-lab asset. No source folders or agent/skill sources are edited.

## Condensed reuse of the Git module

| Source actually read | Target and retained reasoning | Refresh or omission |
|---|---|---|
| [Workflow types](../manage-git-branches-workflows/includes/2-explore-branch-workflow-types.md) | Unit 2: choose short-lived contribution branches, release lines, or forks based on the team's work. | Omit exhaustive selection matrices, unsupported team-size ratings, and assertions that one workflow is universally best. |
| [Feature branches](../manage-git-branches-workflows/includes/3-explore-feature-branch-workflow.md) | Unit 2: branch, coherent commits, push, PR discussion, merge choices, and cleanup. | Condense the long procedure into an explained command transcript. Stage named files rather than indiscriminately adding the whole checkout. Don't require deployment for every PR. |
| [Continuous-delivery branch model](../manage-git-branches-workflows/includes/4-explore-git-branch-model-for-continuous-delivery.md) | Units 2-3: supported-release fixes, concurrent development, and reconciling changes on the feature branch. | Omit the CLI lab and its setup. Clarify that textual merge success isn't behavioral correctness and that conflict labels depend on the operation. |
| [GitHub flow](../manage-git-branches-workflows/includes/5-explore-github-flow.md) | Unit 2: a small branch/PR contribution loop and return to current main. | GitHub flow doesn't imply mandatory automatic production deployment or an inherently linear commit history. |
| [Fork workflow](../manage-git-branches-workflows/includes/6-explore-fork-workflow.md) | Unit 2: distinguish server-side fork, local clone, origin, and upstream. | Forks aren't necessarily public. Isolation and validation requirements still apply to contributed code. |
| [Merge restrictions](../manage-git-branches-workflows/includes/7-implement-branch-merging-restrictions.md) | Units 2, 3, 6: platform-specific branch enforcement, human review, and controlled bypass. | Remove exact-parity and automatic-compliance implications. Current Copilot approval behavior differs by platform. |

## Other source reuse retained

- Architecture adapts [stage design](../create-release-pipeline-devops/includes/6-examine-considerations-for-deployment-to-stages.md), [Actions jobs](../introduction-to-github-actions/includes/7-explore-jobs.md), [artifact transfer](../learn-continuous-integration-github-actions/includes/4-share-artifacts-between-jobs.md), [variables](../manage-modularize-tasks-templates/includes/3-explore-variables-release-pipelines.md), and [runner tradeoffs](../introduction-to-github-actions/includes/8-explore-runners.md).
- YAML evaluation adapts the constraint-rich generation, iteration, and platform-comparison approach from [Copilot pipeline generation](https://github.com/petender/az400-az401-mapping-analysis/blob/249b94e9ae96027d9fb1d9b7ad39ef2f4f5181ad/wwl-azure/use-github-copilot-cloud-operations/includes/6-cicd-pipeline-generation.md) to application CI builds, not infrastructure deployments or its older trigger/approval simplifications.
- Assessed but unavailable source candidates aren't claimed as reused. Native review product behavior comes from current official documentation, not the older Git module.

## Current product verification

| Official reference checked | Claims used |
|---|---|
| [GitHub flow](https://docs.github.com/en/get-started/using-github/github-flow) | Branch, commit/push, PR, iterative feedback, merge, and branch cleanup. |
| [Conflict resolution](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requests/resolving-a-merge-conflict-using-the-command-line) | Conflicting edits require an explicit resolution, staging, commit, and updated review. Local examples merge main into a feature branch without rewriting shared history. |
| [Copilot code-review overview](https://docs.github.com/en/copilot/concepts/agent-capabilities/agent-powered-workflows-and-operations/code-review) and [requesting review](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/use-code-review) | Native GitHub review, configurable automatic/new-push review, agentic context gathering, and public-preview cloud-agent follow-up. Optional GitHub Copilot approvals can count; new commits dismiss a Copilot approval. Instructions/skills can come from the PR head branch. |
| [Azure Repos Copilot review](https://learn.microsoft.com/azure/devops/repos/git/copilot-code-reviews?view=azure-devops) | Azure DevOps Services public preview, administrator enablement, linked Azure billing, Request UI, comments/suggestions, separate automatic-request branch policy, mergeable PR requirement, and manual re-request after new commits. Comment-only review doesn't satisfy required-reviewer policies. |
| [Azure Repos branch policies](https://learn.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops) and [Azure Repos pipeline behavior](https://learn.microsoft.com/azure/devops/pipelines/repos/azure-repos-git?view=azure-devops) | PR branch enforcement and build-validation policy, not YAML `pr:` for Azure Repos. |
| [Stages](https://learn.microsoft.com/azure/devops/pipelines/process/stages?view=azure-devops), [agents](https://learn.microsoft.com/azure/devops/pipelines/agents/agents?view=azure-devops), and [checks](https://learn.microsoft.com/azure/devops/pipelines/process/approvals?view=azure-devops) | Dependencies, explicit data transfer, custom success conditions, self-hosted persistence, and approvals configured outside YAML. |
| [Actions security](https://docs.github.com/en/actions/reference/security/secure-use) and [GitHub Agentic Workflows](https://docs.github.com/en/copilot/concepts/agent-capabilities/agent-powered-workflows-and-operations/about-github-agentic-workflows) | Least privilege, protected execution contexts, locked/reviewed dependencies, and bounded runtime outputs. Agentic Workflows is distinct from native PR review. |

Known documentation discrepancy: the Azure Repos review how-to and [Sprint 279 release notes](https://learn.microsoft.com/azure/devops/release-notes/2026/sprint-279-update) disagree on some pool support and automatic/draft-review behavior. The instruction doesn't assert disputed pool or draft support. Recheck preview behavior before delivery; don't generalize GitHub features to Azure Repos.

The independent human approval requirement is the illustrative team's policy, not a universal product limitation. No live Copilot review, platform policy change, or application pipeline is executed during authoring.

## Objectives, scope, and estimates

Prose counts exclude fenced code and link destinations, counting words with internal apostrophes/hyphens. Reading estimates round up at 140 words per minute.

| Unit | Capability | Words | Reading minutes | YAML estimate | Trainer minutes |
|---|---|---:|---:|---:|---:|
| 1 | Recognize the repository-to-build decision | 271 | 2 | 2 | 3 |
| 2 | Explain and follow the contribution lifecycle | 1200 | 9 | 8 | 16 |
| 3 | Threat-model early, reconcile conflicts, and evaluate PR feedback | 1185 | 9 | 9 | 14 |
| 4 | Connect architecture to tests, environments, and complete reports | 1709 | 13 | 13 | 10 |
| 5 | Generate YAML and critique tests against independent requirements | 1000 | 8 | 8 | 6 |
| 6 | Govern the shared repository/build boundary | 1482 | 11 | 6 | 4 |
| 9 | Reconnect the workflow to its outcome | 224 | 2 | 2 | 2 |

Instructional YAML estimates total 48 minutes; current prose rounds to 54 minutes. Units 2 and 6 retain their pre-consolidation provisional estimates and user-authored material. Only changed substantive units 3-5 receive recalculated estimates here. Knowledge check retains its five-minute trainer reservation and the exercise its 60-minute practical reservation. Total trainer allocation is still 60 minutes. Use selective discussion and companion reading rather than presenting every paragraph; these are not pilot-validated timings.

## Six-dimension review

| Dimension | Evidence and remaining review |
|---|---|
| Technical accuracy | Compare platform-specific review behavior with official sources above. Validate Git mechanics in an isolated repository, not a supplied application. Human review remains necessary for preview capabilities and the final runnable implementation. |
| Instructional design | Basic Git knowledge is the prerequisite, while the full contribution lifecycle is taught. Each content unit supports one handoff in the same change story. Assessment alignment remains deferred. |
| Cohesion and flow | Repository collaboration precedes pipelines. One search change and one concurrent catalog edit connect conflict resolution, review, integration, and validation. No other-module completion is assumed. |
| Writing craft | Bounded substantive sections, explained command excerpts, compact platform comparisons, and no new exercise or quiz content. |
| Voice and style | Second person, simple present, learner-facing prose, and no marketing claims. The source module's promotional framing isn't retained. |
| Scope discipline | Two source/PR units replace redundant investigation and standalone runner detail without adding units or contact time. Governance is shared repository/build reasoning, not another MCP walkthrough. |

The earlier repository/PR pass validated YAML/UID/include resolution, all five path references, the then-current 124 units, and tracking consistency. The consolidation below supersedes those course totals. All 13 official reference URLs resolve. Hash comparisons preserve other module/source files, unrelated manifests, and deferred exercise/knowledge-check assets.

An isolated local Git fixture validates clone, branch, stage/commit/push, an actual textual conflict, merge abort, resolution, simulated accepted integration, and synchronization. This validates Git mechanics only, not application behavior, hosted PR policy, or a live Copilot review.

The recommended Markdown flow reflects this revision. Native Word automation cannot open the suggested-flow document, so that document remains unchanged; its overview still needs synchronization. Learn rendering, technical SME sign-off, and classroom delivery also remain outstanding.

## Build-to-deployment progression: November 19, 2026

Unit 5 starts with the cost and complexity of maintaining pipeline YAML, supplies concrete Copilot context and generation prompts, and compares build-only Azure Pipelines and GitHub Actions output before review. Its title, UID, six-minute trainer reservation, build artifact boundary, and deferred exercises/assessment remain. The later validation consolidation revises its prose estimate to eight minutes. Use one platform example in the presentation and the paired implementation as companion reading; code interpretation and classroom timing still need piloting.

The `.NET` paths and pipeline outputs are illustrative, not supplied EShopOnWeb lab assets. The examples intentionally keep restore/build/test/publish in one job and don't assume files cross job boundaries. They stop at run-artifact upload without Azure authentication or deployment.

Delivery units 2 and 5 in [delivery controls](../design-release-strategies-ai-assisted-deployment-pipelines/authoring-review.md) distinguish separately supplied infrastructure readiness from an optional Build -> Infrastructure -> Deploy illustration. The original cloud-operations source, video, finalized exercises, and assessments remain unchanged. The integrated three-stage lab has not been authored and has no invented URL.

## Change-validation consolidation: November 19, 2026

The former `validate-ai-assisted-changes` module is removed, not archived. Its seven instructional drafts are condensed into existing units across Build and Deploy; no unit identities, ordering, or remaining reservations change. Its exercise and knowledge-check placeholders are removed without transferring their time or claiming a replacement lab. The released 60 trainer-led plus 60 practical minutes stay unallocated.

| Retired coverage | Existing destination and treatment |
| --- | --- |
| Unit 2: tests, environments, and coverage | [Unit 4](includes/4-define-pull-request-acceptance-criteria-verification-evidence.md): independent requirement oracle, test boundaries, negative cases, representative isolated data, complete shards, bounded retries/quarantine, coverage limits, and report-failure behavior. |
| Unit 5: threat modeling | [Unit 3](includes/3-review-pull-requests-resolve-conflicts-with-copilot.md): early application/engineering assets, trust boundaries, STRIDE questions, context tampering, sensitive reads, mitigation ownership, and enforceable access. |
| Unit 6: generated-test and evidence critique | [Unit 5](includes/5-guide-copilot-repository-assistance-context-tools-instructions.md): counterexamples, shared-assumption failures, report reconciliation, skipped checks, revision/run/attempt/artifact provenance, and approve/revise/reject. |
| Unit 4: identities and approvals | Existing units 2, 3, and 6 plus delivery unit 3 already distinguish branch policies, review, scoped automation, and independent authority. Retain these instead of repeating product setup. |
| Units 3 and 6: release gates and evidence | [Delivery units 4 and 6](../design-release-strategies-ai-assisted-deployment-pipelines/authoring-review.md): security/composition/quality criteria, missing evidence, baselines, controlled exceptions, and candidate-linked promotion. |
| Introduction and summary | Existing introductions/objectives/summaries carry the lifecycle outcomes; don't recreate another transition unit. |

Inherited conceptual lineage from the removed draft remains explicit: [functional-test design](../configure-provision-environments/includes/4-configure-automated-integration-functional-test-automation.md) and [shift-left testing](../configure-provision-environments/includes/5-understand-shift-left.md) support test selection/isolation; [threat modeling](../introduction-to-secure-devops/includes/7-understand-threat-modeling.md) supplies assets/flows/STRIDE; [validation points](../introduction-to-secure-devops/includes/5-explore-key-validation-points.md) and [MCP governance](../manage-ado-mcp-server/includes/11-apply-governance-security-practices.md) support independent checks and bounded tools. These are inherited adaptation sources, not newly copied procedures or edited source files.

Do not import the removed draft's conflicting assumption about whether unavailable search items stay visible. Tests follow the separately approved requirement; generated implementation isn't the oracle. Detailed vendor onboarding, repeated identity setup, source images/videos, and specialist security procedures remain outside scope.

New checks use official [STRIDE guidance](https://learn.microsoft.com/azure/security/develop/threat-modeling-tool-threats), [Publish Test Results controls](https://learn.microsoft.com/azure/devops/pipelines/tasks/reference/publish-test-results-v2?view=azure-pipelines), and [GitHub protected-branch check semantics](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches). Structural validation isn't test execution, security sign-off, or a delivery pilot. The active course is now 12 modules and 115 units: 72 finalized, 20 instructional drafts, and 23 skeletons.

Consolidation validation passes: 133 active YAML documents parse; the 115-unit CSV matches unit order, UIDs, includes, durations, statuses, and retained reservations; all 116 checked local links resolve. Four core paths contain 3/2/4/3 modules. Allocated course totals are 660 trainer-led plus 660 practical minutes, with 60 plus 60 explicitly unallocated. The retired folder is absent and only these two authoring reviews retain its name as historical lineage. Delivery units 2 and 5 still match their earlier preservation hashes. No application or hosted pipeline execution is claimed.

Additional pipeline-generation references checked on November 19, 2026:

| Reference | Claim checked and source implication |
| --- | --- |
| [Copilot prompt engineering](https://docs.github.com/en/copilot/concepts/prompting-and-context/prompt-engineering) | Explicit context, requirements, examples, and smaller iterations support generation; a prompt isn't an enforced permission limit. |
| [Pipeline artifacts](https://learn.microsoft.com/azure/devops/pipelines/artifacts/pipeline-artifacts?view=azure-devops) | Publish/download and current-run artifact paths; dependencies don't transfer files automatically. |
| [GitHub workflow artifacts](https://docs.github.com/en/actions/tutorials/store-and-share-data) | Upload/download for cross-job output; a run artifact isn't a deployment or package-feed publication. |
| [GitHub workflow syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax) | Push filters, jobs, dependencies, and permission scoping; don't mechanically equate Azure stages with GitHub jobs. |

Validation is structural and instructional, not an executed application build or hosted pipeline. Recheck action versions, SDK compatibility, and immutable-reference policy during lab production. The Excel map is an encrypted Office container and couldn't be synchronized with the available file tooling; preserve it and use the updated CSV for this revision.

## Source-control exercise introduction: November 23, 2026

The user requested the guided-exercise introduction pattern from the finalized MCP module, with a choice between companion labs [09: GitHub flow](https://github.com/MicrosoftLearning/mslearn-devops/blob/main/Instructions/agentic/09-integrate-copilot-code-review-github-flow.md) and [10: Azure Repos contribution flow](https://github.com/MicrosoftLearning/mslearn-devops/blob/main/Instructions/agentic/10-integrate-copilot-code-review-azure-repos.md). Learners choose their preferred platform or complete both.

The introduction distinguishes the GitHub Spoon-Knife page preview from Azure Repos eShopOnWeb source inspection, and states each platform's hosted review access and billing prerequisites. Neither lab configures a pipeline or deploys an application. The former pipeline-diagnosis exercise skeleton is replaced; pipeline/agentic-workflow lab introductions are outside this request.

The unit title, metadata description, layout title, and CSV exercise row now reflect source-control review. The UID, unit sequence, provisional 60-minute YAML estimate, and 60-minute practical reservation remain unchanged. Each published lab estimates 45 minutes; completing both needs approximately 90 minutes plus setup, not the existing reservation. No classroom reallocation or live lab execution is claimed. The CSV now records this exercise introduction as draft-for-review rather than skeleton-only; earlier status totals in this review are historical. Excel synchronization and knowledge-check authoring remain deferred.
