Source control supplies an understood, reviewed contribution before a build runs. In this module, you follow a change through repository setup or clone, a feature branch, staged commits, push, pull-request review, conflict resolution, merge, and synchronization.

## What you learned

- Choose a repository and contribution route, distinguish clone from fork, and preserve the intended change through integration.
- Threat-model application and engineering boundaries early and reconcile overlapping source changes without losing either requirement.
- Compare Copilot review in GitHub and Azure Repos, checking which revision it assesses and how review differs from merge authority.
- Define a change contract and evaluate code and tests against independent requirements.
- Maintain platform-specific repository instructions while protecting the policies, permissions, and ownership used to accept a contribution.

For the illustrative EShopOnWeb search correction, your record links the work item, PR, reviewed evidence, and integrated source commit. Copilot assists with explanation and proposals; the repository's protected controls and authorized reviewers determine acceptance.

The next module owns CI pipeline architecture, Docker builds, package feeds, artifact publication, and runtime-agent boundaries. Its input is this accepted source and verification contract, not an assumption that a successful merge already produced a deployable candidate.

## Learn more

- [GitHub flow](https://docs.github.com/en/get-started/using-github/github-flow).
- [Copilot review in Azure Repos](/azure/devops/repos/git/copilot-code-reviews?view=azure-devops).
- [GitHub Copilot code review](https://docs.github.com/en/copilot/concepts/agent-capabilities/agent-powered-workflows-and-operations/code-review).
