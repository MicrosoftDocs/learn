Copilot can help prepare a focused contribution, but a request such as "fix the search bug" leaves scope, evidence, and write authority unclear. Supply a bounded change contract and review its output before it enters the contribution workflow.

## Give repository assistance useful context

For the illustrative EShopOnWeb search correction, provide the approved acceptance criteria, relevant code and tests, contribution guidance, and known non-goals. Identify files explicitly rather than assume an open editor supplies the full repository.

```text
Explain the smallest source change for the supplied search acceptance criteria.
Use only the relevant search code, tests, and approved repository guidance.
Identify assumptions and missing requirements before proposing a change.
Suggest regression cases that would reject a plausible incorrect implementation.
Draft a concise commit message and PR description based on the actual diff.
Do not add dependencies, change repository policies, commit, push, approve,
or merge. Do not claim that tests ran unless I supply their results.
```

The request describes the intended task. Actual repository and tool permissions determine whether the session can write. Keep write tools unavailable during a read-and-propose task when that is the approved boundary.

For a follow-up, supply the current diff and ask for a minimal correction rather than an unrelated rewrite. Verify that suggested file paths and APIs exist, inspect staged changes, and use the normal branch and PR route for accepted edits.

## Bring GitHub repository evidence into Copilot with MCP

The GitHub MCP server can supply current repository, issue, PR and other supported platform information to Copilot in the IDE. It complements the Azure DevOps MCP workflow introduced earlier; it doesn't make Azure Repos and GitHub share tool names, identities, or policy enforcement.

For a read-and-propose contribution workflow:

1. Follow GitHub's current server setup for the supported IDE. Confirm organizational MCP policy, the approved server source and authentication method.
2. In Copilot Chat's Agent mode, inspect **Configure tools** and the GitHub server's available tools. Select only the repository/PR/issue reads needed for the task; keep mutation and terminal execution unavailable for this boundary.
3. Specify the owner/repository, PR or issue identifier, target branch, source revision and question. Retrieve current metadata and the relevant diff rather than ask the agent to guess from a repository name.
4. Ask for a proposal with evidence links and missing-context statements. Verify the returned repository/revision and compare findings with the actual contribution.
5. If later writes are justified, authorize the specific operation separately and verify its actual outcome. A drafted comment or issue isn't proof that it was posted.

For example:

```text
For the specified repository and PR, read the current diff, linked requirement
and check results using only the selected GitHub read tools.
Identify changes unrelated to the search acceptance criteria and missing evidence.
Cite the PR revision and supporting records. State inaccessible information.
Do not post comments, create work, edit files, rerun workflows, push or merge.
```

Tool names and available features depend on the server/host and account access. Selecting a read tool in chat doesn't independently constrain every credential or external execution path; the server's supported read-only configuration and platform permissions provide additional boundaries. Never copy credentials into prompts or committed MCP configuration.

## Choose identity for the actor, not for the model

An interactive Copilot session and an unattended repository integration are different actors. Do not assume that signing into Copilot authenticates every connected tool or grants Azure access.

| Identity | Typical use | Boundary to verify |
| --- | --- | --- |
| Approved interactive sign-in | IDE/MCP operations on behalf of the engineer | Actual user access, organizational authorization and selected tool scope |
| GitHub App installation token | A team-owned integration acting on installed repositories | Installation repository selection and endpoint permissions; installation tokens expire after one hour and cannot exceed the installation's granted access |
| `GITHUB_TOKEN` | GitHub Actions operations within the workflow's repository | Explicit workflow/job permissions and event restrictions; not a generic interactive MCP credential |
| PAT, where approved | A supported tool integration requiring user-associated token access | Selected resources/scopes, expiry, storage and revocation ownership; not a default substitute for every identity |
| Azure workload federation/service connection | Approved automation accessing Azure | Separate Azure trust/RBAC and connection scope; a GitHub repository token doesn't confer Azure permissions |

A GitHub App can make automation ownership clearer than a maintainer's personal token, but installation isn't blanket access. Match the required endpoint permissions and issue short-lived tokens through the approved integration. Keep registration/private-key administration out of an ordinary source-editing task.

The useful optimization is current, bounded context and a recognizable actor, not giving an agent every available tool so it can find its own route.

## Maintain review instructions on each platform

Repository instructions help Copilot focus on the team's conventions and the requirement. They are not branch protection or a replacement for review.

| Concern | GitHub | Azure Repos |
| --- | --- | --- |
| Repository code-review guidance | `.github/copilot-instructions.md` | `.azuredevops/copilot-instructions.md` |
| Guidance revision | Review can use instructions from the PR head branch | Repository instructions are read from the PR target branch |
| Merge enforcement | Independently configured repository rules and required checks | Independently configured branch policies and permissions |

For Azure Repos, put approved guidance on the target branch through the appropriate configuration contribution before relying on it for feature review. Adding guidance only to a feature PR doesn't establish that it applies to that PR's hosted review.

For GitHub, inspect changes to review instructions in the same PR as code. An author can propose weakening those instructions, so independently protected acceptance controls must not depend solely on their wording.

An example of platform-neutral guidance is:

```markdown
Review against the linked requirement and actual changed source.
Keep feedback limited to correctness, relevant risks, and missing evidence.
Identify the revision assessed and distinguish assumptions from observations.
Do not invent application files, product behavior, or executed test results.
Suggestions do not authorize a merge or a change to repository controls.
```

Adapt it to the real repository rather than use generic text to override team policy. Keep credentials, user data, and unnecessary private logs out of instructions and Copilot context.

## Evaluate proposals and review feedback

Compare each suggestion with the requirement, current files, and evidence. Accept a correct, relevant proposal; revise one with incomplete context; reject one that broadens scope or weakens controls.

For example, a suggestion to remove an availability test because it fails doesn't resolve the search defect. A new dependency also doesn't become necessary because an agent recommends it. Keep a short human-authored explanation of the decision with the PR.

If the assistant produces no actionable findings, record that without treating silence as proof of correctness. After applying changes, update the same PR and confirm whether fresh native review and validation are required.

## Preserve the contribution boundary

Editor assistance, native PR review, and a runtime agent in automation are separate capabilities. They don't share identical credentials, tool permissions, or approval state. Native review gives feedback on a repository-hosted contribution; it doesn't require a custom pipeline agent.

Runtime Agentic Workflows, direct Copilot CLI jobs, and agent/runner isolation belong to the build module. Keep this unit focused on preparing and reviewing repository changes. The next unit brings together repository ownership, protected controls, and the accepted contribution record.

Learn more about [the GitHub MCP server in your IDE](https://docs.github.com/en/copilot/how-tos/copilot-in-your-ide/copilot-for-common-tasks/use-the-github-mcp-server), [GitHub App installation authentication](https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/authenticating-as-a-github-app-installation), [custom instructions for Copilot code review](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/request-a-code-review/configure-coding-guidelines), and [Copilot review in Azure Repos](/azure/devops/repos/git/copilot-code-reviews?view=azure-devops).
