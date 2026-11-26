The EShopOnWeb contribution now has a requirement, a reviewable diff, and a verification contract. Governance at this point means controlling who can change source, assess it, and integrate it. Build-worker permissions and publication are separate responsibilities developed in the next module.

## Separate proposal, review, and integration

A contributor can edit code, request Copilot feedback, and apply a suggestion. Those actions don't establish permission to merge. Repository owners define the required reviews, current checks, and specialist ownership through protected settings.

| Role | Responsibility | Authority not implied |
| --- | --- | --- |
| Contributor or authorized coding assistant | Propose a focused source change and respond to feedback | Approve its own exception or weaken branch protection |
| Reviewer | Inspect requirements, source, tests, and relevant risks | Administer unrelated repository settings |
| Repository administrator | Maintain access, branch policies, ownership, and bypass rules | Substitute configuration changes for application verification |
| Authorized integrator | Complete a PR when the applicable conditions pass | Publish packages or deploy production simply because the PR merged |

Where product settings allow an AI approval to count, this illustrative team's additional human-authorization requirement still applies. It is a team policy, not a claim that the product cannot approve.

## Protect the controls used to accept changes

In GitHub, inspect rulesets or branch protection, required checks, and bypass actors. In Azure Repos, inspect branch policies, repository permissions, and policy-bypass rights. A visible requirement that every contributor can bypass doesn't provide the intended independent check.

Review changes to repository instructions, ownership files, test selection, and automation definitions with the appropriate maintainers. An application PR must not quietly remove the rule or test that would reject it. Keep exceptional bypass use independently authorized, scoped, logged, and reviewed afterward.

The same Git contribution route applies to shared templates or Dockerfiles stored in the repository, but reviewing their execution semantics belongs to the build owner. Repository review controls access to the change; it doesn't prove the resulting build or deployment is correct.

## Limit assistant access to the contribution task

A read-and-propose session needs the relevant code and requirements, not secrets or administrative access. A separately authorized coding session may write a feature branch within its scope; it still uses the normal PR route.

Treat issue text, comments, retrieved files, and tool results as untrusted evidence. They must not override the approved requirement, request secret disclosure, or authorize a merge. Local approval of a tool call doesn't automatically authorize a cloud agent operating in another session.

If the proposal needs additional access, stop and obtain a scoped decision from the owner. Don't broaden rights as an automatic response to a failed command.

## Retain the accepted contribution record

Keep the linked work item, PR discussion, reviewed source revision, conflict decisions, test expectations, reviews, applicable check results, merge method, and final integrated commit. A later engineer should be able to distinguish what was proposed, what was assessed, and what reached the shared branch.

Generated summaries help navigate this record, but original diffs and system results remain authoritative. Missing evidence stays unresolved rather than becoming assumed success.

Measure source-control improvement using review waiting time, repeated conflict work, and the clarity of acceptance criteria. Pipeline duration is a different constraint. Adding automated reviewers doesn't fix an unclear requirement or unavailable owner.

Your handoff is accepted source with traceable requirements. The build module turns it into a tested package or image and governs execution, publishing credentials, and bounded runtime agents.

Learn more about [Azure Repos branch policies](/azure/devops/repos/git/branch-policies?view=azure-devops) and [GitHub protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches).
