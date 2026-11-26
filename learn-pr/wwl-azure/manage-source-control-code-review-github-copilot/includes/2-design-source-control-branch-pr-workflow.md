The EShopOnWeb search fix needs a clear route from a developer's checkout to a reviewed change on the shared branch. You might already know the Git commands, or know how to review and commit code changes from within your development tool integration. This unit connects them into an actual agentic collaboration workflow, before introducing the build that validates it.

## Choose the repository and branching strategy

Start with the authoritative remote repository. This is the shared GitHub or Azure Repos repository that accepts contributions. For a new project, its owner chooses visibility (public or private) and controls access. The owner defines the default branch and adds a README and an appropriate `.gitignore`. They also define line-ending rules in `.gitattributes` and provide contribution guidance. The owner establishes protection for the integration branch. Creating a repository doesn't automatically require PRs or prevent direct pushes. For larger project repositories or as part of a larger organizational decision, several of the repository settings can be defined through rules.

For an existing project, you clone that repository rather than create another unrelated repository and copy its files. A clone provides local history and a remote reference, usually called `origin`. A branch in your local clone and a branch on the server are different references. A local commit doesn't reach your teammates until you push it.

For the illustrative search fix in the EShopOnWeb project, a short-lived branch from `main` fits a small, independently reviewable change. GitHub flow is a lightweight Git-based workflow built around feature branches, pull requests, review, and integration into the default branch. Unlike Gitflow, it doesn't require a separate long-lived `develop` branch. Despite its name, you can implement the same GitHub flow workflow in Azure Repos using pull requests and branch policies. 

Release branches make sense when you maintain supported versions or need a defined stabilization line. They also create more places to propagate fixes. If a hotfix changes a supported release, the team identifies where the same correction belongs in ongoing development. More permanent branches doesn't automatically mean having or enforcing more control.

For an experienced team, the agentic question isn't which Git command creates a branch. It is which branching model keeps delegated work small, current, and independently reviewable:

| Model | Expert refresh | Implication for Copilot-assisted work |
| --- | --- | --- |
| Trunk-based development | Integrate frequently into a protected, ready mainline; use very short-lived branches where required | Bound each delegated change and review quickly; don't let parallel agent tasks accumulate into a long-lived integration queue |
| GitHub flow | Short-lived feature branches, PR review and integration into the default branch | A clear contribution record for one task; implementation can use GitHub or Azure Repos |
| Gitflow | Separate long-lived `develop` and `main` lines with feature, release and hotfix paths | Specify the exact target and propagation obligations; an agent must not infer that every change belongs on `main` |
| Supported release branches | Maintain selected versions with deliberate fix propagation | Evaluate compatibility and backport tests per branch rather than blindly replay the generated patch |

These are not mutually exclusive labels for every team practice. Choose the simplest model that meets actual release obligations; AI assistance doesn't remove integration latency or multiply safe reviewer capacity.

Another contribution method besides cloning a repo, is using a fork. A fork is a separate server-side repository, not another name for a local clone. It supports contributions when the contributor doesn't have write access to the authoritative repository and repository policy permits forks. In that strategy, `origin` commonly points to the fork and an `upstream` remote to the authoritative repository. The collaboration and contribution happens by committing your code changes to your local forked version of the repo, to then raise a PR to suggest changes from `origin` to `upstream`. It's up to the owner or admins of the authoritative upstream repository, to accept and merge your changes.

## Isolate concurrent assistance with Git worktrees

A Git worktree is another working directory attached to the same local repository. It has its own checked-out branch and working files, but shares repository objects and most references. It is neither a server-side fork nor a security sandbox.

For two independent Copilot tasks, assign separate worktrees and branches, owners, acceptance criteria, and file boundaries. This prevents one session from casually editing another session's uncommitted checkout. It doesn't prevent changes to shared services, external files, credentials, or common repository metadata.

The following PowerShell excerpt is illustrative and assumes the existing checkout has the approved remote and a clean starting state:

```powershell
git status --short
git fetch origin
git worktree list
git worktree add -b fix/search-stock-agent ..\EShopOnWeb-search origin/main
git -C ..\EShopOnWeb-search status --short
```

Review each command's result before continuing. Use a new branch name and unused directory; Git normally prevents checking out the same branch in multiple worktrees. Open the intended worktree in the assistant's editor session and confirm its path, branch, base revision, and actual tool boundaries.

Let independent tasks run concurrently, but serialize integration where they share behavior or files. Rebase/merge against current accepted work under the team's rules and rerun affected checks. Two individually green PRs don't establish that their combined behavior is correct.

After the task is accepted and retained work is verified, use ordinary `git worktree remove` cleanup for that specific clean worktree. A refusal because work remains is a reason to inspect it, not to force removal.

## Connect local work to a published feature branch

The following PowerShell excerpt illustrates a checkout, not a lab step. `$repositoryUrl` represents the approved clone URL copied from GitHub or Azure Repos. Authentication follows your organization's approved method.

```powershell
git clone $repositoryUrl EShopOnWeb
Set-Location EShopOnWeb
git remote -v
git switch main
git pull --ff-only
git switch -c fix/search-stock
```

The sequence verifies the destination, starts from current `main`, and creates the working branch. `git pull --ff-only` stops if updating the local branch requires a merge rather than silently introducing one. In an existing checkout, you first inspect `git status` and preserve unfinished work before switching branches.

The developer now changes the stock-filter behavior and adds focused tests. In this illustrative checkout, `SearchFilter.cs` and `SearchFilterTests.cs` stand for example files. The important sequence is inspect, stage the intended files, inspect the staged diff, commit, and publish:

```powershell
git status --short
git diff
git add -- SearchFilter.cs SearchFilterTests.cs
git diff --cached
git diff --cached --check
git commit -m "Fix search stock filtering and add regression coverage"
git push -u origin fix/search-stock
```

The staged diff is what the commit contains, which isn't necessarily every edited file. You exclude unrelated changes - usually defined in the `.gitignore` file in the root of the repo - generated outputs, local settings, specific environment variables and secrets, and run the project's relevant tests before publishing. 

Each line in the above example flow, represents a decision point, not an unattended script: a failed check stops the commit or push until you understand and fix it. The upstream setting on the first push connects the local working branch to its remote counterpart. Later commits on that branch use the same contribution route.

Copilot helps explain an unfamiliar diff, propose a focused commit description, or identify a missing test case. You compare its explanation with the actual staged changes. An assistant's summary doesn't establish what Git commits, and a suggested command still needs the correct repository and branch context.

## Make the PR the collaboration record

After the branch is published, a PR requests integration from the **source branch** `fix/search-stock` into the **target branch** `main`. In GitHub, the target is also called the base branch. Opening the PR doesn't automatically merge the code. Likewise, pushing another commit updates the existing PR's source branch rather than creating a separate integration request. 

The description explains the problem, the behavioral change, relevant tests, and remaining risk. For "Search results showing out-of-stock items", useful context identifies which items remain visible and how the regression cases establish that behavior. Link the work item through the repository's configured integration rather than assume that an arbitrary issue number creates Azure Boards traceability.

A draft PR supports early discussion while the implementation is incomplete. When the contribution is ready, reviewers - which used to be humans only, but now a perfect candidate for an AI assistant - inspect the actual diff and required checks. They don't rely only on a generated description or a green badge from another revision. Feedback leads to additional edits, tests, commits, and pushes on the same source branch. This is the normal review loop, not a failed handoff. The final approval to merge should be done by humans, even if an AI assistant like GitHub Copilot would be able to do it. 

For GitHub, repository rules can require PR approvals and named status checks. For Azure Repos, branch policies can require reviewers, linked work, comment resolution, and build validation. The platforms share collaboration goals, not identical configuration. Repository administrators also control if and who can bypass those requirements.

## Complete integration and return to current main

Once conflicts are resolved and the applicable review and validation requirements pass, an authorized person completes the PR using an allowed merge method:

| Merge method | History outcome | Decision to make |
|---|---|---|
| Merge commit | Retains branch commits with an integration commit | Preserve the contribution's individual commit history |
| Squash merge | Produces one combined commit on the target | Represent a small reviewed change as one integration unit |
| Rebase-based merge | Replays commits with new identities | Follow the team's linear-history and shared-branch rules |

Merge choice doesn't replace review or testing. With squash or rebase-based integration, the commit on `main` can differ from the feature commit reviewed earlier. The team retains the PR link and validates the appropriate integrated revision.

After server-side completion, you update the local default branch:

```powershell
git switch main
git pull --ff-only
git fetch --prune
```

The team can then remove the completed remote feature branch according to its policy. A squash merge can leave Git unable to recognize the original local branch as fully merged, so a failed local deletion isn't a reason to force-delete it without checking the PR and retained work.

This closes the ordinary contribution loop. The next unit examines its difficult middle: reconciling overlapping changes and using Copilot review without confusing suggestions with permission to merge.

## Migrate the repository without losing its delivery contract

Moving Azure Repos to GitHub is a platform transition, not just a file copy. An ordinary Git transfer can preserve selected commit history, branches and tags; it doesn't automatically transfer Azure Boards links, PR discussions, branch policies, pipelines, service connections, package feeds or permissions.

Use Copilot to draft a migration inventory from approved repository metadata: required refs and Git LFS objects, default branch, contribution controls, work-item links, consumers, submodules, webhooks and automation identities. Ask it to identify unsupported mappings and manual decisions rather than invent equivalent settings.

Before transferring, choose the approved migration/import mechanism and define:

1. The authoritative source, destination visibility, write-freeze and cutover owner.
2. Which history/refs and LFS content must be preserved, and how their commit/object identities will be verified.
3. Replacement GitHub rules, integrations and workflows, tested before normal contribution resumes.
4. How old PR/work links remain discoverable, and which consumers still use Azure Artifacts or other external services.
5. A rollback plan that keeps the old repository available under the agreed access policy without permitting competing authoritative writers.

Verify representative branches/tags, required objects, a checkout/build, and the destination's actual contribution controls. Don't use an unreviewed mirror push against a populated destination: mirroring can overwrite or delete destination refs. Changing a developer's `origin` URL isn't proof that the team or automation has migrated.

## Recover or remove only the intended change

An agent can explain history and propose recovery commands, but recovery needs the exact repository, branch, commit/path, and retained-work decision:

| Situation | Appropriate reasoning |
| --- | --- |
| Unwanted staged file | `git restore --staged -- <path>` removes it from the proposed commit without discarding working-file edits |
| Tracked file no longer belongs in the project | Review `git rm -- <path>` as a deliberate deletion in a normal contribution |
| Bad change already shared | Prefer a reviewed `git revert <commit>` contribution; it creates compensating history rather than rewriting teammates' refs |
| Lost local branch/commit reference | Inspect `git reflog`, verify the desired commit, and create a recovery branch before changing other refs |
| Selected fix needed on a supported branch | Review `git cherry-pick <commit>` with that branch's compatibility and tests; patch application alone isn't acceptance |

The table uses command forms, not executable placeholders or an unattended recovery script. Reverting a merge commit needs an explicitly chosen mainline. Reflogs are local and expire; they aren't a cloud backup. Source reversion also doesn't undo deployed state or external effects.

Distinguish unstaging from discarding edits. Avoid broad resets, force pushes, history rewriting or forced cleanup as a default assistant response. Preserve unfinished work and make the recovery/removal diff reviewable.

Learn more about [GitHub flow](https://docs.github.com/en/get-started/using-github/github-flow), [Git worktrees](https://git-scm.com/docs/git-worktree), [Git revert](https://git-scm.com/docs/git-revert), and [Azure Repos branch policies](/azure/devops/repos/git/branch-policies?view=azure-devops).
