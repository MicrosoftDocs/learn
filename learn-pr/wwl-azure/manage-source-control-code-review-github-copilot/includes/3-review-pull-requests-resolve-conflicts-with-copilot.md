The search-fix PR now has a source branch, a target branch, and reviewers. You examine what happens when another change reaches `main` during review, and how Copilot helps resolve and assess the resulting diff on GitHub and Azure Repos.

## Threat-model the change before generating a resolution

Start risk analysis while the change is still easy to reshape, not after deployment. Identify assets, data flows, trust boundaries, threats, mitigations, and how to validate those mitigations. For the search fix, examine both the application path from search input to purchase authorization and the engineering path from repository content through Copilot, tools, and build execution.

Use STRIDE to structure questions, not as a substitute for concrete controls. Could a changed test or instruction tamper with acceptance evidence? Could a retrieved log disclose sensitive data? Could untrusted PR content influence a tool with repository or cloud write access? Assign each relevant mitigation an owner and an observable check.

Repository instructions, comments, PR descriptions, and tool output can contain prompt-injection attempts. Treat them as evidence to assess, not authority to change requirements or skip checks. Review instruction-file and tool-configuration changes alongside code. Minimize retrieved logs and redact sensitive content; read-only access can still disclose information. Local client approvals don't automatically authorize a separate cloud session.

Copilot can suggest overlooked threats, but you validate its claims against the actual design and independent requirements. A prompt doesn't revoke an overprivileged identity. Keep untrusted execution away from privileged credentials and protect the policies that decide acceptance. Revisit this model when the diff introduces a new dependency, data flow, or permission.

## Reconcile changes without losing either intent

Suppose another contributor changes catalog visibility while your branch changes stock filtering. If both changes affect the same lines, Git can stop with a textual conflict. Even without conflict markers, the combined changes can introduce a behavioral conflict. A clean merge means Git combines the text, not that the combined application behaves correctly. It's also why in a later stage, PR changes are often accompanied by a pipeline run to validate the code changes are successful and not breaking the app.

A straightforward team convention merges current `main` into the feature branch without rewriting the existing feature commits. In the illustrative checkout, with a clean working tree, the author examines:

```powershell
git switch fix/search-stock
git status
git fetch origin
git merge origin/main
```

If Git reports conflicts, the author stops and inspects them rather than running a commit command automatically. A three-way merge editor shows the common base and the two changed versions. For this merge operation, the current side is the feature branch and the incoming side is `origin/main`. Those labels aren't universal: a rebase changes the operation and how the versions appear.

The intended result preserves the catalog visibility correction and the stock-filter requirement. Accepting both sides can duplicate conditions or retain contradictory logic. Accepting only the incoming side can discard the feature. You inspect the relevant code and tests, remove conflict markers, and verify both behaviors.

After resolution and relevant tests, the author stages the resolved files, checks the staged result, completes the merge commit, and pushes:

```powershell
git add -- SearchFilter.cs SearchFilterTests.cs
git diff --cached --check
git diff --cached
git commit -m "Reconcile catalog visibility and stock filtering"
git push
```

If the intended resolution isn't clear, `git merge --abort` abandons this merge attempt; the clean starting tree makes that recovery easier to reason about. A team that uses rebase follows its separate replay-and-continue workflow. You don't rebase a shared branch or force-push it merely to clear the PR conflict indicator.

## Use Copilot to prepare a resolution and a review

Copilot Chat helps explain the two intents, propose a minimal combined change, and identify regression cases. It doesn't know the business answer merely because both versions are available. For example, the following review brief keeps the task tied to the scenario:

```text
Compare the stock-filter change with the catalog visibility change on main.
Explain the intent of each side and propose the smallest compatible resolution.
Identify regression cases for visible in-stock and out-of-stock search results.
State missing requirements rather than inventing the expected behavior.
Do not commit, push, approve, or merge.
```

You inspect any proposed resolution as an ordinary diff and run the relevant tests. Clearing conflict markers isn't the acceptance criterion. The updated PR also needs fresh review and validation because its source changes.

Editor assistance and repository-hosted review are separate capabilities. A local conversation can help before you push. Native Copilot code review posts feedback on the PR for the team to evaluate. The latter doesn't inherit the exact conversation or approval state from your editor. You provide sufficient requirements, repository guidance, and PR context for each review.

## Request native review on each repository platform

On **GitHub**, you request Copilot in the PR's **Reviewers** area, or administrators configure automatic review. Automatic review of new pushes depends on the configured settings; it isn't guaranteed after every commit. After a conflict resolution or another substantive update, you check which revision the review covers and request re-review when needed.

GitHub Copilot code review includes agentic repository-context gathering. Where enabled, you can also pass feedback to Copilot cloud agent through **Fix with Copilot**, a public-preview capability at the time of this content. Depending on the supported flow, the agent proposes follow-up work against the branch or applies a new commit. That is another source change requiring review and tests, not automatic acceptance of the original suggestion.

For **Azure Repos**, GitHub Copilot code review is available in **Azure DevOps Services public preview** at the time of creating this content. Administrators enable access at organization level and configure project/repository participation or inherited settings. 

Once enabled for your repo, **GitHub Copilot** appears in the Azure Repos PR's **Reviewers** list. You select **Request**, examine the line comments and suggested changes, and decide which suggestions to apply. Enabling the feature and configuring a branch policy to then request reviews automatically, are separate steps. Making sure you keep granular control of what Copilot can review, and keeping humans-in-the-loop.

## Distinguish feedback from merge authorization

Copilot feedback helps you find mistakes, but it can miss requirements or propose an incorrect fix. In the search example, a suggestion that hides every out-of-stock item might look plausible while violating a requirement that allows some catalog entries to remain visible. You compare suggestions with the linked requirement, code, tests, and human reviewer judgment.

The approval behavior also differs:

| Platform | Default Copilot review effect | Important qualification |
|---|---|---|
| GitHub Repositories | Feedback doesn't count as a required approval | Optional Copilot approvals can count when enabled by the applicable settings |
| Azure Repos | A **Comment** review, not an approving or change-requesting vote | It doesn't satisfy required-reviewer policies |

On GitHub, new commits dismiss a Copilot approval. You then obtain a review for the revised change as required. This illustrative team's policy additionally requires independent human authorization, even where GitHub configuration permits an AI approval to count. That human requirement is the scenario's governance choice, not a claim that the product cannot approve.

Custom instructions help focus review on the stock-filter rule and relevant tests. They aren't branch protection: GitHub code review can read instructions and skills from the PR's head branch, so the proposed change can also alter that guidance. Actual merge requirements need independently protected repository controls.

The contribution is ready for integration when its conflicts, substantive comments, required reviews, and current checks are resolved under the repository policy. The next unit makes the requirement and verification expectations explicit so reviewers can distinguish a successful review from an untested assumption.

Learn more about [STRIDE threat modeling](/azure/security/develop/threat-modeling-tool-threats), [GitHub Copilot code review](https://docs.github.com/en/copilot/concepts/agent-capabilities/agent-powered-workflows-and-operations/code-review), [Copilot review in Azure Repos](/azure/devops/repos/git/copilot-code-reviews?view=azure-devops), and [command-line conflict resolution](https://docs.github.com/en/pull-requests/how-tos/merge-and-close-pull-requests/resolving-a-merge-conflict-using-the-command-line).
