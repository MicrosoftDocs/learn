The EShopOnWeb candidate has passed its search-behavior tests, but an image scan reports a vulnerable component. The team needs to decide whether to replace a dependency, refresh the runtime image, or investigate further. Making the pipeline green isn't the goal; producing an acceptable, traceable replacement is.

The process stays within the build lifecycle: **understand the finding -> propose the smallest correction -> build and validate a replacement -> approve controlled sharing -> retain the decision**. Copilot can assist with investigation and proposals without receiving authority to approve or publish them.

## Locate the problem before changing packages

First connect the finding to the exact candidate digest and scan time. Then ask where the component comes from:

| Finding in the fictional store build | Likely place to investigate | Why it matters |
| --- | --- | --- |
| Vulnerable library declared by the storefront | Direct dependency and lockfile | A supported fixed version might require a targeted update |
| Vulnerable library introduced by another package | Transitive dependency path | Updating the parent might be preferable to forcing a conflicting version |
| Vulnerable operating-system component in the runtime image | Base-image version and digest | Updating an application package won't fix the base image |
| Vulnerable build-only tool | SDK or build-tool configuration | It might not ship, but it can execute where source and credentials are available |

Suppose this finding comes from the storefront's runtime base image, not `EShopOnWeb.Catalog.Contracts` version `1.4.0`. Updating the contracts package would add risk without addressing the finding. The focused proposal is to select a supported, compatible runtime image containing the fix and rebuild the storefront.

Severity helps prioritize the work, but also check exposure, exploit prerequisites, available fixes, and business impact. Keep licensing and security findings separate: a clean vulnerability scan doesn't resolve missing license terms.

Copilot can explain a dependency path or compare an advisory with the current configuration. Require links to the relevant evidence and mark uncertainty. Its suggestion that a vulnerable path is unused isn't proof; verify that claim before accepting the risk.

## Delegate a correction, not the approval

Give an agent a bounded task, such as:

> Propose an update to the storefront runtime base image for this finding. Preserve the target-framework compatibility and blocking search tests. Explain the current and proposed image identities and the checks needed. Don't change package sources, publishing permissions, approval rules, or scanner settings. Stop if no supported compatible fix is available.

The agent can prepare a branch or pull request within its authorized scope. It doesn't need package-publish, feed-promotion, registry-write, or approval permissions. Repository and tool controls enforce those limits.

The roles then remain clear:

1. **Copilot or the remediation agent proposes** the smallest relevant diff and explains the expected effect.
2. **Isolated validation automation checks** the reviewed inputs, builds the replacement, runs tests, and generates fresh evidence.
3. **An independent reviewer decides** whether that evidence supports acceptance.
4. **An authorized publication job shares** the approved output using its narrowly scoped identity.

Validation isn't harmless just because it precedes publication. Restores and builds can execute package-supplied logic. Keep untrusted proposals away from publishing credentials and privileged runners. If validation fails, the agent doesn't gain permission to disable a check, ignore a finding, or broaden its own access.

For the runtime refresh, validate that the finding is addressed, required runtime libraries remain available, and the search correction still behaves correctly. Generate the SBOM and scans for the replacement image and record its new digest. An old image doesn't acquire patched contents through retagging or a new approval comment.

If a fix isn't currently viable, stop the automatic remediation. A temporary exception needs an accountable owner, exact affected versions or digests, rationale, compensating controls, and an expiry. Missing evidence remains unresolved rather than becoming an automatic exception.

## Share the replacement without losing its identity

The replacement follows the same platform-specific boundaries as the original candidate.

With **Azure Artifacts**, if a fix actually changes the fictional contracts package, publish a new version, such as `1.4.1`. Version `1.4.0` remains reserved even after deletion; don't overwrite it. Validate the new package, then promote that existing version to the appropriate view. Promotion isn't rebuilding, and Azure Artifacts doesn't support demotion. If consumers need to return to a previous acceptable version, change their references and retain that version and its evidence.

With **GitHub Packages**, publish an explicitly versioned replacement when package contents change, retain the previous decision, and update consumers through reviewed references. Don't invent a release-view operation. Check package access and the publishing workflow's token permissions.

For the current **container-only fix**, the contracts package stays at `1.4.0`; only the storefront image changes. Record the replacement digest in the approved-output record. A mutable tag can help people find an image, but it isn't the approval identity. Broader consumer access depends on actual registry permissions and workflow controls, not on naming a tag `approved`.

This distinction avoids unnecessary package releases and preserves a clear answer to "what changed?" Copilot can draft the change summary; compare it with the executed diff and resulting output identities before accepting it.

## Govern build workers and publication identities

Azure Pipelines agents and GitHub Actions runners execute repository-controlled scripts and dependency hooks. Use unprivileged validation workers for untrusted PR content, and a separate, narrowly authorized publication boundary for accepted candidates. A runner label or pool name is not an access control by itself.

Hosted workers reduce machine management; persistent self-hosted workers can retain files, processes, and credentials. Ephemeral execution reduces carried state only when the worker lifecycle actually ends. Running a job in a container doesn't automatically isolate its host, Docker socket, or private-network access.

The publisher needs access to its approved feed or registry, not a deployment environment or permission to administer branch policies. Keep cloud deployment credentials out of CI. In GitHub, privileged events such as `pull_request_target` or downstream `workflow_run` must not become a route for executing untrusted code or artifacts with publishing credentials.

Inspect both the proposed automation and the effective identity, network policy, input trust, cache sources, and destination. Bound retries and resource consumption; a failed job must not broaden its own authority.

## Bound runtime agents without replacing deterministic checks

AI-generated YAML can execute ordinary deterministic commands. Agentic automation additionally interprets evidence or selects permitted tools at runtime. Branches and retries in a script alone don't make it agentic.

On GitHub, Agentic Workflows uses Markdown instructions with YAML frontmatter and compiled Actions output. Its declared safe outputs and execution controls differ from native Copilot PR review. Evaluate both the source definition and compiled workflow, input trust, network access, permitted tools, output destinations, and effective identity.

For a failed EShopOnWeb test run, an advisory workflow could read the selected failure report, relevant diff, and linked requirement, then produce an evidence-linked diagnostic summary. Record the run attempt and source revision. Distinguish a failed assertion, a missing suite, and an unavailable report. Don't execute untrusted application code merely to summarize it, approve a candidate, or mark its checks successful.

In Azure Pipelines, a separate diagnostic job can use an approved direct Copilot CLI invocation to interpret selected logs. Direct CLI integration is also possible in GitHub Actions, but it doesn't automatically inherit Agentic Workflows isolation or safe-output handling. Review installation/authentication, tool permissions, resource limits, and output validation separately.

```text
Explain only the supplied build/test evidence for this run attempt.
Cite the failing assertion or missing report and the relevant source context.
Return facts, uncertainty, and the smallest proposed follow-up.
Do not alter code, execute package hooks, publish, deploy, approve, or change
test selection, scanner settings, thresholds, credentials, or runner access.
```

The prompt describes the task; tool availability and permissions enforce authority. Diagnostic work doesn't need a feed-publishing token, registry-write identity, or production network access. Validate generated reports before posting even an advisory comment, and bound destination, volume, and duplicate outputs.

Keep deterministic test and scan results as the acceptance evidence. A model's diagnosis neither repairs the build nor authorizes remediation.

Learn more about [GitHub Agentic Workflows](https://docs.github.com/en/copilot/concepts/agent-capabilities/agent-powered-workflows-and-operations/about-github-agentic-workflows) and [programmatic Copilot CLI](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/run-cli-programmatically).

## Retain enough evidence to explain the decision later

Imagine a reviewer asks why the original candidate was withheld and its replacement accepted. A useful record connects:

- **Purpose and change:** the search work item, remediation finding, pull request, reviewed commit, and final executed revision.
- **Inputs and execution:** manifest and lockfile, package sources and versions, base-image digest, build-definition revision, run and attempt IDs, platform, and tool versions.
- **Output and checks:** package version or image digest, tests, scans and their dates or advisory snapshots, license evidence, SBOM, provenance, and verification results.
- **Decision and sharing:** policy revision, reviewer, rationale, any exception and expiry, publication destination, and operation record.

Protect these records from unauthorized modification and retain them for the required lifetime. Build logs might expire before a package does. Keep secrets out of retained reports and restrict sensitive evidence rather than copying all raw logs into an unrestricted summary.

Three later activities use this record differently:

| Activity | Practical question | Treatment |
| --- | --- | --- |
| Audit replay | Why did the team accept this candidate then? | Read the historical inputs, evidence, policy, and approval; no republishing is needed |
| Validation rerun | Does the same output meet today's checks? | Record a new attempt; updated advisory data can reveal a new finding in unchanged bytes |
| Rebuild | Do the recorded inputs produce identical output? | Compare output hashes and account for toolchains, timestamps, platforms, and external downloads |

Lockfiles and image digests help identify inputs; they don't guarantee byte-identical rebuilds. Preserve the original report when new evidence changes the decision.

Copilot is useful for assembling a timeline and identifying missing links. The retained system records remain the source of truth. The build process ends with a clearly identified output and an explainable sharing decision, not an agent's assurance that the store is safe.
