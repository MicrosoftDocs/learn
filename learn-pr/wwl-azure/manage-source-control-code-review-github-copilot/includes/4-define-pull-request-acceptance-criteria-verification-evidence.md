A small PR can satisfy its stated implementation plan and still miss the business requirement. Before accepting the EShopOnWeb search correction, define what reviewers must be able to establish from its code, tests, and linked evidence. This is a source-control decision: what constitutes a reviewable contribution?

## Turn the work item into a change contract

The work item **"Search results showing out-of-stock items"** identifies a problem, not every detail of its solution. Clarify the expected visibility, availability presentation, and permitted purchase behavior with the requirement owner. Don't infer that every unavailable item must disappear simply because that is an easy filter to implement.

The PR contract identifies:

- The user outcome and acceptance criteria.
- The intended files and behavior changes, including explicit non-goals.
- The risks identified during early threat modeling.
- The verification expected for those risks.
- The reviewer or owner for application code, tests, configuration, and repository instructions.

For example, the illustrative change might alter stock-filter behavior but not inventory synchronization or authentication. A dependency upgrade proposed alongside it needs its own justification. Scope limits let you recognize an unrelated change even when Copilot supplies a convincing explanation.

Keep the requirement in a traceable issue or Azure Boards work item and link the PR through the configured integration. A generated PR description is a navigation aid, not the authoritative requirement.

## Review tests against independent expectations

Tests belong with the source change because they explain and protect its behavior. Review their assertions as carefully as the implementation. A test that merely checks for a nonempty result can pass with the wrong products. A fixture containing only available stock never challenges the reported defect.

Use examples agreed independently of the implementation:

| Review question | Evidence to look for |
| --- | --- |
| What happens for a matching available item? | An assertion on the expected item and availability behavior |
| What happens for an unavailable item? | The explicitly approved visibility and purchase rules |
| What happens for mixed or empty results? | Assertions that reject omitted, extra, or unauthorized outcomes |
| Does concurrent catalog work still behave correctly? | Regression coverage for both changes after conflict resolution |
| Does a test reproduce production logic to calculate its expectation? | An independent expected result rather than the same helper called twice |

Ask whether a plausible incorrect implementation would fail the proposed test. Copilot can suggest counterexamples or a missing assertion, but agreement between generated code and generated tests isn't independent verification. Compare the proposal with the requirement, inspect the diff, and execute the repository's relevant tests through the approved route.

The build module develops test boundaries, environments, discovery, reports, and failure behavior. Here, reviewers establish *what must be verified* without treating pipeline syntax as part of source-control instruction.

## Keep evidence tied to the PR revision

Record the source/head commit assessed by review and the target revision used for validation. A push following review, conflict resolution, or a test correction can invalidate earlier evidence. Squash or rebase completion can produce a different integrated commit; preserve the PR link and identify the resulting revision on `main`.

On GitHub, a required check depends on the workflow event and repository rules. On Azure Repos, build validation is configured through a branch policy. A green badge doesn't prove that a particular critical suite executed, and a resolved comment doesn't prove that the latest revision preserves its fix.

When required evidence is missing, stale, or linked to another revision, hold integration and surface the gap to its owner. Don't select an unrelated successful run or rewrite the requirement to match the result.

## Hand the accepted source to the build process

The source-control output is a linked requirement, reviewed PR, integrated commit, and verification contract. It also records unresolved risks and any separately approved exception.

The next module uses these inputs to create an identified build candidate. It owns compilation, pipeline structure, container construction, package feeds, and artifact publication. Source control establishes the accepted input; the build establishes what actually executes and which output the evidence covers.

Learn more about [GitHub pull-request reviews](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews) and [Azure Repos branch policies](/azure/devops/repos/git/branch-policies?view=azure-devops).
