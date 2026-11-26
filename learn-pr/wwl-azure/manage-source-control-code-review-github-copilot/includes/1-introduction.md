> [!NOTE]
> Throughout this module, **Copilot** refers to **GitHub Copilot**, not Microsoft 365 Copilot or any other Microsoft Copilot product, unless explicitly mentioned.

A reliable build starts with a trustworthy source-control contribution. Your team needs a shared way to contribute a change, review it, reconcile competing edits, and identify the revision that subsequent automation validates.

Consider an illustrative EShopOnWeb workload scenario, representing an online retail business order application. The codebase, bugs, issues and alike are managed in your DevOps platform.

Imagine a reported issue influencing a required code change for **Search results showing out-of-stock items**. You start from the team's repository, create a focused branch, and open a PR. Another contributor changes catalog visibility while your fix is under review. You need to preserve both requirements, address feedback, complete the merge, and establish that the resulting candidate comes from the intended source.

**GitHub Copilot** helps at several points: explaining a diff, proposing a conflict resolution, reviewing a PR, and drafting a pipeline change. Those are different kinds of assistance. A review comment doesn't necessarily authorize a merge, and a passing test result doesn't necessarily describe the latest revision. Copilot assists, you keep control.

In this module, you follow a repository-to-merge workflow and compare native **Copilot code review** in GitHub and Azure Repos. You turn the work item into a reviewable change contract, evaluate code and test proposals, and protect repository instructions, review requirements, and write permissions. Build checks appear as evidence required by source control; their YAML, agents or runners, Docker packaging, and publication are developed in the next module.

By the end of the module, you can explain and evaluate an AI-assisted contribution from repository setup or clone through PR review, merge, and synchronization. Your handoff is the integrated source revision and its acceptance requirements, not a deployed application or an already published build artifact.
