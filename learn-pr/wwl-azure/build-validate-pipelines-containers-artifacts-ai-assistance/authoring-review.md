# Authoring review

## Current build-pipeline boundary: November 24, 2026

Status: draft-for-review. The module is titled **Build and validate pipelines, containers, and artifacts with AI assistance**. The approved naming follow-up aligns its folder and module/unit/badge UID prefixes with the title. The subsequent unit-title audit retains every display title and aligns units 2-5's filenames/UID suffixes with CI verification, tested containers/dependencies, Copilot build/publication, and worker/agent governance. The eight-unit order, lesson bodies, content status and 60-minute trainer/practical reservations remain unchanged; earlier identity-preservation statements refer to the pre-alignment revision.

| Unit | Revision and lineage |
| --- | --- |
| 1 | Establish accepted source -> CI -> verified package/image -> controlled publication; delivery owns exposure. |
| 2 | Move former Build 2.1/4 architecture, PR/main CI semantics, test evidence, templates, explicit file transfer, and worker tradeoffs into this unit. |
| 3 | Combine existing container/evidence instruction with former unit 2 dependency/feed/version controls. Add tested Dockerfile dependencies, runtime image, build context, and container-job versus application-image distinctions. |
| 4 | Move former Build 2.1/5 Copilot build-only generation here; retain package publication alternatives. Align the ZIP producer with delivery's app.zip consumer, and add container archive transfer plus Azure registry/GHCR publication fragments. |
| 5 | Retain scoped remediation and audit replay; move and condense runtime Agentic Workflows/CLI material from former Build 2.1/6 around failed-build diagnosis and separate worker/publisher identities. |
| 8 | Hand the accepted output and evidence to release without rebuilding. |

Six instructional units are authored for review. Exercise/assessment assets remain unchanged and deferred. Governance is now explicitly build execution, input/output trust, and publication; source-control policies and merge authority are owned by 2.1.

New Docker, ZIP, YAML, and publication examples are illustrative, not supplied application assets. They require compatible SDK/runtime inputs, approved registry/feed access, validation, and external approval. A Docker test stage does not prove suite discovery, image archives and registry digests have different identities, and Azure Artifacts is not a container registry.

Current first-party grounding: [Docker multi-stage builds](https://docs.docker.com/build/building/multi-stage/), [GitHub container publication](https://docs.github.com/en/actions/tutorials/publish-packages/publish-docker-images), and existing source-adaptation evidence recorded below. No image is built, scanned, restored, or published during authoring. Trainer delivery should use one packaging route and one platform as the worked example; paired alternatives are companion material. Self-paced reading estimates are not trainer durations.

## Historical supply-chain-only revisions

The following records earlier unit scope, word counts, preservation checks, and source mappings. Current placement is defined above and in the CSV.

## Practical rewrite - November 19, 2026

Status remains **draft-for-review**. This revision replaces instructional includes 3-5 and refreshes their unit descriptions and dates. Unit UIDs, titles, include references, reading estimates, module order, and deferred exercise/assessment assets remain unchanged. Other units and the tagged validation-module file are untouched.

The revised teaching thread is reviewed source -> approved dependencies -> build and test -> identified output -> controlled sharing. It places supply-chain decisions inside the larger build lifecycle without expanding into deployment implementation.

- **Unit 3** starts with package/artifact/feed vocabulary through a fictional EShopOnWeb catalog-contracts package and storefront image. It then explains candidate identity, blocking container tests, cache and credential boundaries, and what each evidence type establishes.
- **Unit 4** turns a bounded Copilot review into concrete Azure Artifacts and GitHub Packages alternatives. It includes a credential-free NuGet source configuration and two short publication fragments. Azure feed roles, upstream intake, views, and same-organization authentication are contrasted with GitHub NuGet sources, package access, token permissions, and reviewed consumer selection.
- **Unit 5** follows a runtime-base-image finding through diagnosis, bounded remediation, independent validation, and replacement publication. It explains why a container-only fix doesn't require a contracts-package release, and distinguishes historical replay, fresh validation, and rebuilds.

Copilot assistance appears at concrete handoffs: mapping build inputs/outputs, reviewing stage relationships, comparing dependency changes, drafting a narrow fix, and assembling the decision timeline. Deterministic checks, enforced permissions, independent review, and publication authority remain separate.

All new package identities and outputs are explicitly fictional. The publication fragments assume Windows agents/runners, PowerShell, a configured SDK, successful prior checks and approval, and the approved package already present. They are illustrative fragments, not complete executable workflows or evidence that controls are configured. No lab procedures or new exercise/assessment content are added.

### Documentation and validation

Product behavior was checked on November 19, 2026 against:

- [Azure Artifacts NuGet publication](https://learn.microsoft.com/azure/devops/artifacts/nuget/dotnet-exe?view=azure-devops), including source endpoints, `NuGetAuthenticate@1`, and the nonsecret API-key argument.
- [Azure Artifacts feed views](https://learn.microsoft.com/azure/devops/artifacts/feeds/views?view=azure-devops), including base-feed publication, promotion permissions, and lack of demotion.
- [Azure Artifacts upstream sources](https://learn.microsoft.com/azure/devops/artifacts/concepts/upstream-sources?view=azure-devops), including controlled search order.
- [GitHub Packages NuGet registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-nuget-registry), including workflow authentication, API-key publication, repository association, and package access.
- [Docker multi-stage builds](https://docs.docker.com/build/building/multi-stage/), including dependency-based BuildKit execution.

Validation passed: PyYAML parsing of all three updated unit manifests and both publication fragments; preserved UID/include-reference checks; NuGet XML parsing; PowerShell syntax parsing of both folded publication commands; balanced fences and four H2 sections per unit. No packages were restored or published, and no live builds, permissions, approvals, or classroom timing were validated.

Using the historical prose-count method below, the revised counts are:

| Unit | Prose words | Reading minutes at 140 words/minute | Existing YAML estimate |
| --- | ---: | ---: | ---: |
| 3 | 980 | 7 | 8 |
| 4 | 930 | 7 | 7 |
| 5 | 1,117 | 8 | 8 |

These are prose-only estimates; time to interpret the code examples remains provisional.

## Historical baseline - November 16, 2026

The remainder records the original authoring pass. Its word counts, code-sample omissions, and quality findings describe that earlier version; the revision above supersedes them for units 3-5.

Status: **draft-for-review**. Checked November 16, 2026. This is not finalized, publication-ready, or validated for classroom delivery.

## Scope and design

This pass authors the six instructional Markdown includes, refreshes their six unit YAML files and the module index, and creates this review: **14 changed files**. The module remains a standalone, advanced DevOps-engineer lesson with its original eight units. All module, unit, and badge UIDs, YAML filenames, and include filenames remain unchanged.

The teaching thread follows traditional engineering decisions first: dependency necessity and resolution, feed access, immutable version promotion, container-stage execution, and output-bound evidence. It then applies that contract to Copilot-assisted evaluation and bounded agentic remediation. A single illustrative EShopOnWeb dependency/container-build change connects to the sample work item **Search results showing out-of-stock items**. The dependency update is not an asserted cause of the business defect.

The application structure, package choice, Dockerfile, pipeline, registry, candidate outputs, controls, and review outcomes are conceptual and illustrative. The Azure Boards lab supplies no application codebase, pipeline, or registry. Nothing in this pass executes a build, publishes a package, creates resources, runs a lab, or demonstrates a live outcome. The worked review uses a decision table rather than an executable diff with invented application paths.

## Source-unit-to-target reuse mapping

All nine source units below are read before adaptation. Reuse consists of selected concepts rewritten for the target decision, not wholesale copying or endorsement of source procedures. Source paths are relative to `wwl-azure`.

| Source unit | Target instructional unit | Reused concept and adaptation |
| --- | --- | --- |
| `understand-package-management\includes\3-understand-package-feeds.md` | 2 | Centralized consumption, versioned storage, public/private access, and feed roles. Corrects single-ecosystem and universal anonymous-access assumptions. |
| `understand-package-management\includes\7-consume-packages.md` | 2 and 4 | Dependency selection, package-source configuration, upstream resolution, authentication, and source-graph complexity. Adds resolved-graph comparison and rejects universal sequential client-source behavior. |
| `implement-versioning-strategy\includes\4-examine-release-views.md` | 2 | Version identity versus quality/audience metadata, default views, and SemVer suffix distinction. Removes contradictory automatic `@prerelease` membership claims. |
| `implement-versioning-strategy\includes\5-promote-packages.md` | 2 and 5 | Explicit promotion of existing versions and retention/recovery considerations. Omits unsupported CLI examples and distinguishes replacement candidates from promotion. |
| `design-container-build-strategy\includes\5-examine-multi-stage-dockerfiles.md` | 3 and 4 | Named stages, stage inheritance, cross-stage copy, build/runtime separation, and test integration. Replaces obsolete concrete images with framework-compatible selection criteria and corrects test-graph assumptions. |
| `design-container-build-strategy\includes\6-examine-considerations-multiple-stage-builds.md` | 3 | Required runtime dependencies and base-image selection. Keeps compatibility and maintenance reasoning, omits application topology, storage, and scaling tangents. |
| `implement-open-source-software-azure\includes\4-explore-corporate-concerns-components.md` | 3, 4, and 5 | Direct/transitive exposure, maintenance, compatibility, security, licensing, and exception ownership. Avoids incident anecdotes and unsupported numerical prevalence claims. |
| `implement-open-source-software-azure\includes\7-examine-license-implications-ratings.md` | 3, 4, and 5 | Version-specific inventory, notices, contextual license review, and continuing risk monitoring. Treats organizational ratings as routing aids, not universal legal verdicts. |
| `introduction-github-packages\includes\2-publish-packages.md` | 2 and 4 | Native package tooling, package metadata, authenticated publication, and workflow-based distribution. Refreshes registry-specific permissions, `GITHUB_TOKEN` use, and package Actions access instead of defaulting to a PAT. |

The introduction and summary synthesize this thread. Other skeleton source candidates are not claimed as reused. No absent dependency-discovery or composition-analysis source unit is reconstructed.

## Corrections and deliberate omissions

- Azure Artifacts feeds support multiple ecosystems. A feed's package-format validation does not certify vulnerability absence or license compliance.
- Azure Artifacts versions remain reserved after deletion. Feed-view promotion associates an existing immutable version with a view, without rebuilding or renumbering it. A SemVer prerelease suffix does not populate `@prerelease` automatically.
- Upstream intake requires Collaborator or higher. Reader access to saved packages, upstream saving, publishing, and feed administration remain distinct operations. Feed and view access both matter.
- Azure Artifacts does not support package demotion. Recovery selects a previously acceptable consumer version or a new candidate. The target does not repeat `az artifacts universal promote` or mislabel a package publication task as view promotion.
- GitHub Packages permissions differ by registry. Granular and repository-scoped models are not interchangeable. `GITHUB_TOKEN` requires the appropriate repository/package access and workflow permissions. Public package visibility does not universally imply anonymous access.
- Pipeline artifacts, ecosystem package versions, and container digests have separate identities. Tags remain mutable. Multi-platform index and per-platform manifest identities need appropriate scan coverage.
- BuildKit follows the selected dependency graph. A declared test stage alone is not proof of test execution. No obsolete .NET Core 3.1 image references or invented current image digests appear.
- SBOMs inventory contents, provenance describes origin, and verified signatures bind claims to identity under a trust model. None alone proves safety, behavioral correctness, or license compliance.
- Current GitHub guidance favors workflow dependency lockfiles for covered action dependencies, including transitive dependencies. Full-length verified commits remain the fallback for uncovered actions. The caller's lockfile does not pin reusable-workflow calls. No action versions, setup tutorial, or fabricated lockfile is introduced.
- Agent authority stops at the minimal justified dependency, Dockerfile, or publication-definition proposal. Isolated deterministic validation, independent approval, and authorized publication remain separate.
- Audit replay, validation reruns, and rebuild reproducibility remain distinct. The record includes lockfiles, digests, tool versions, policy revisions, outputs, and approvals. Pinning alone does not promise identical bytes.
- No quiz questions, exercise instructions, Try-it-yourself activities, other-module handoffs, or administrative source notes appear in authored learner includes. A reflective statement reinforces independent verification without assigning an assessment task.

## Official documentation checks

Check date for every entry: **November 16, 2026**. Documentation is retrieved directly using Microsoft documentation search/fetch and official-site web fetch. Queries contain only generic public product topics, not local course content. Fetched documentation grounds product behavior. Scenario-specific governance controls are illustrative engineering recommendations, not claims of built-in parity.

| Official URL | Claims checked and target relevance |
| --- | --- |
| https://learn.microsoft.com/azure/devops/artifacts/artifacts-key-concepts?view=azure-devops | Multi-ecosystem feeds, upstream search order and saving, views, and permanently reserved immutable versions. Unit 2. |
| https://learn.microsoft.com/azure/devops/artifacts/feeds/feed-permissions?view=azure-devops | Reader, Collaborator, Contributor, Owner, pipeline identities, feed/view access, and project-scoped access considerations. Units 2 and 4. |
| https://learn.microsoft.com/azure/devops/artifacts/feeds/views?view=azure-devops | Existing-version promotion, base-feed publication, view membership, promotion permissions, and no demotion. Units 2 and 5. |
| https://learn.microsoft.com/azure/devops/pipelines/artifacts/artifacts-overview?view=azure-devops | Pipeline file artifacts versus ecosystem packages. Unit 2. |
| https://learn.microsoft.com/azure/devops/pipelines/tasks/reference/nuget-authenticate-v1?view=azure-pipelines | NuGet tool authentication before restore/push, build credentials, and additional cross-project access requirements. Unit 2. |
| https://docs.github.com/en/packages/learn-github-packages/about-permissions-for-github-packages | Granular versus repository-scoped registries, package Actions access, token access, public-container anonymous pulls, and authentication differences. Units 2 and 4. |
| https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions | Workflow authentication and `GITHUB_TOKEN` permissions for package operations. Units 2 and 4. |
| https://docs.docker.com/build/building/multi-stage/ | Stage naming, inheritance, cross-stage copies, targets, and BuildKit dependency-graph execution. Units 3 and 4. |
| https://docs.docker.com/build/building/best-practices/ | Build/runtime separation, supported minimal bases, build context, cache behavior, mutable tags, digest pinning, and update tradeoffs. Units 3 and 4. |
| https://docs.docker.com/build/building/secrets/ | Secret mounts versus persistent build arguments/environment and credential-bearing layers. Unit 3. |
| https://docs.docker.com/build/building/multi-platform/ | Manifest lists and platform-specific manifests, supporting digest and scan-scope distinctions. Unit 3. |
| https://docs.github.com/en/actions/concepts/security/artifact-attestations | Provenance, signed claims, verification, and the explicit limitation that attestation is not a guarantee of artifact security. Units 3 and 5. |
| https://docs.github.com/en/actions/how-tos/secure-your-work/use-artifact-attestations/use-artifact-attestations | Binary/image and SBOM attestations, digest subjects, generation permissions, and consumer verification. Unit 3. |
| https://docs.github.com/en/actions/reference/security/secure-use | Least-privilege tokens, untrusted checkout, secret exposure, action dependency controls, and federation only for supported targets. Units 3 and 4. |
| https://docs.github.com/en/actions/concepts/security/workflow-dependency-lockfiles | Transitive action coverage, source identity checks, coverage limits, SHA fallback, and separately pinned reusable workflows. Unit 4. |
| https://semver.org/ | Intended compatibility meaning of major, minor, patch, and prerelease identifiers. Unit 2. |
| https://calver.org/ | Date-based release versioning and the need for an explicitly chosen scheme. Unit 2. |

All eight unique documentation links present in learner Markdown are among the pages retrieved successfully. Learn destinations use root-relative links in learner Markdown. External documentation uses absolute URLs. Full URLs above are intentional review references.

## Objective alignment

| Measurable module objective | Teaching evidence | Alignment limitation |
| --- | --- | --- |
| Design dependency resolution, feed permissions, and immutable package-promotion decisions | Unit 2 compares resolved inputs, source consolidation, permissions, version schemes, views, and platform-specific distribution. | Exercise and assessment validation remain deferred. |
| Evaluate container build graphs and digest-bound evidence | Unit 3 analyzes bypassed tests, runtime contents, cache/credential boundaries, and evidence limitations. | Actual application builds and scanner coverage require an implementation review. |
| Critique Copilot-generated dependency, Dockerfile, and publication changes | Unit 4 follows one narrowed proposal through necessity, identity, compatibility, graph, and publication review. | Worked outcomes are illustrative, not executed results. |
| Define bounded remediation and retained evidence for reruns and audit replay | Unit 5 separates proposal/validation/approval/publication authority and distinguishes replay from rerun and rebuild. | Enforceability depends on actual repository, runner, identity, and retention controls. |

Prerequisites describe knowledge of Git/review, multi-stage CI, package manifests/resolution/lockfiles, Dockerfile stages, registries, and build identities. No account, license, resource, prior course, or supplied pipeline is required by the conceptual lesson.

## Word counts and reading estimates

Counting method: remove fenced ```...``` blocks with DOTALL matching, replace Markdown `[label](destination)` links with their visible label, and count matches of `\b\w+(?:['-]\w+)*\b`. Heading text, table-cell prose, and link labels remain included. Code and link destinations are excluded. There are no fenced code samples. Reading time is `ceil(prose words / 140)`.

| Unit | Learner-facing title | Prose words | Reading minutes | H2 count |
| --- | --- | ---: | ---: | ---: |
| 1 | Introduction | 284 | 3 | 2 |
| 2 | Design dependencies, feeds, and immutable promotion | 968 | 7 | 4 |
| 3 | Secure container builds and supply-chain evidence | 1,010 | 8 | 4 |
| 4 | Evaluate generated dependency, container, and publishing changes | 968 | 7 | 4 |
| 5 | Govern supply-chain remediation and audit replay | 1,025 | 8 | 4 |
| 8 | Summary | 232 | 2 | 2 |
| Authored total | Six instructional units | 4,487 | 35 | 20 |

Each authored unit stays within its requested word range and the 10-minute reading ceiling. The protected exercise remains **60 minutes** and the protected knowledge check remains **5 minutes**, both unchanged. The full manifest therefore still sums to **100 minutes**. That is not an approved reading-only duration or validated classroom allocation. The retained exercise exceeds the generic 10-minute unit guideline, and the manifest exceeds the generic 60-minute module guideline. Preservation takes precedence in this pass. A later authorized exercise/assessment and delivery-design review needs to resolve those constraints.

## Six-dimension quality findings

| Dimension | Finding | Review items |
| --- | --- | --- |
| Technical Accuracy | Meets criteria with caveats | Product behaviors are grounded in the retrieved references. SME verification of implementation-specific permissions, scanner coverage, attestation availability, and legal interpretation remains necessary. |
| Instructional Design and Alignment | Meets criteria with caveats | Four measurable objectives map to units 2–5. Protected exercise and knowledge-check placeholders do not yet demonstrate assessment alignment. |
| Cohesion and Flow | Meets criteria | One explicitly illustrative business change connects traditional input/output reasoning to Copilot evaluation and bounded remediation. The summary closes that thread without a cross-module handoff. |
| Technical Writing Craft | Meets criteria | Every authored include has two to four H2 sections and no H1. Short paragraphs, two comparison tables, and one evidence list support the decisions without fabricated code or UI procedures. |
| Voice, Tone, and Style | Meets criteria with caveats | Direct second-person, simple-present reasoning replaces skeleton/admin notes and marketing language. Docker, Dockerfile, and BuildKit names remain because the explicitly requested technical scope requires them. |
| Scope Discipline | Meets criteria with caveats | Advanced analytical depth focuses on supply-chain decisions, not setup, full pipeline architecture, legal advice, or deployment implementation. Frozen activity estimates prevent whole-module duration sign-off. |

### Technical Accuracy

The official-source table traces the major product claims and the corrections to the reused material. The target avoids volatile action versions, unsupported promotion commands, implicit test-stage execution, universal authentication assumptions, and claims that inventory or provenance proves safety. No executable code sample requires a compilation claim.

### Instructional Design and Alignment

The module moves from dependency justification to output evidence, then applies the same contract to generated changes and agent boundaries. Titles and objectives use observable design, evaluation, critique, and definition outcomes. Introductory and summary promises match the authored content, but assessment effectiveness is not evaluated because both assessment-related units remain protected.

### Cohesion and Flow

Each core opener connects to the preceding decision and the same illustrative EShopOnWeb proposal. Terms such as candidate, digest, promotion, proposal, approval, rerun, and replay retain distinct meanings. No prerequisite or transition assumes completion of another module.

### Technical Writing Craft

The content explains engineering reasoning before compact comparison tables or evidence lists. Tables compare claims and limitations rather than replace the lesson with a checklist. All authored includes meet the requested word/heading ranges, contain no em dashes, and use documentation links instead of source-candidate lists.

### Voice, Tone, and Style

The style pass removes ambiguous temporal actors, an unnecessary rhetorical question, and administrative reflection wording. Automated scans find no future-tense or present-perfect warning patterns, marketing terms, cross-module handoffs, assessment prompts, or unrelated third-party company/tool names. Required container technology terminology is retained deliberately rather than obscured.

### Scope Discipline

The worked example is a review outcome, not a lab, supplied environment, or approved implementation. No new unit, quiz, exercise, workflow setup, registry, image reference, or root tracking update is introduced. Human review still needs to judge delivery timing and the deferred practice/assessment design.

## Validation and preservation results

- Parse all nine YAML files with the existing PyYAML installation and a duplicate-key-rejecting loader: pass.
- Confirm eight ordered unit references, unique UIDs, exact original module/unit/badge UIDs, unchanged filenames, and all eight include targets: pass.
- Check author/date/topic/AI usage on the module and six authored unit YAMLs, useful descriptions, matched titles, module-only `ms.service`, and no learner-facing draft/day/status wording in refreshed metadata: pass.
- Check authored word ranges, `ceil(words/140)` estimates, 10-minute authored-unit ceiling, H2 counts, no H1, no marketing/tense warning patterns, no other-module references, no exercise/quiz prompts, and root-relative Learn/absolute external link format: pass.
- Scan specifically for unrelated vendor/tool names, including OpenAI, Meta, Google, Salesforce, ServiceNow, WhatsApp, Mistral, Anthropic, LangChain, FOSSA, Snyk, and Black Duck: no matches in authored learner content.
- Compare SHA-256 manifests before and after authoring for all four protected exercise/knowledge-check YAML and Markdown files: byte-identical.
- Compare SHA-256 manifests for every file in all five reused source module folders, not only the nine selected units: byte-identical.
- Make manual edits only through `apply_patch` and only in this module's allowlist. No root layout, CSV, workbook, course-flow, `C:\learn-pr`, or `C:\learning-lab-agents` file is edited.
- Run no publishing-system build, live cloud build, package publication, lab, or classroom pilot. No new dependency installation or temporary validation file is needed.

Preservation manifest SHA-256 values use sorted relative filenames plus each file's SHA-256:

- Protected exercise/KC files: `c13724938db73bcb4f3129f97cdd0b6cd63d5c01f52e690c854c869c6e76909f`.
- Five complete source module folders: `1e31ef9a8b7b45915e1985812353749c5c80580a979f35137ed9e8faf1262497`.

## Human review and deferred work

| Review item | Required follow-up |
| --- | --- |
| Exercise and knowledge check | Both YAML/Markdown pairs remain exactly as supplied. Author and align them only under separate authorization. Their placeholder content and metadata are not marked complete. |
| Timing | Reconcile the 60-minute protected exercise, 100-minute full manifest, publication constraints, and real classroom budget without confusing reading estimates with presentation time. |
| Product freshness | Recheck GitHub lockfile coverage, package access, action identities, attestation plan/repository availability, and Azure DevOps Services versus Server capabilities before implementation or publication. |
| Authorization enforcement | Validate real build identities, service connections, view permissions, runner isolation, approval separation, and evidence retention. Conceptual boundaries are not proof of enforcement. |
| Dependency and license judgment | Review actual package/version identities, distribution context, notices, security exposure, and legal obligations. Organizational license ratings are not legal advice. |
| Actual application and build | Supply and review an authorized application/Dockerfile/pipeline before testing any implementation. Validate behavioral tests, selected stage graph, runtime compatibility, scanning scope, and digest/evidence binding. |
| Publishing and editorial validation | Run the actual Learn publishing/schema/link validation process and a human pass across all six dimensions. Local parsing and content checks do not replace that process. |

Human technical, instructional, editorial, and delivery review remains required. This review records persistent authored outputs and checks, not publication approval.
