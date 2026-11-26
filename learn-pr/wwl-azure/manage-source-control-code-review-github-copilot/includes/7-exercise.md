> [!IMPORTANT]
> To complete this exercise, you need:
> - A browser, Git, and Visual Studio Code.
> - Access to an approved GitHub Copilot Chat client.
> - For the GitHub option, a GitHub account with permission to create and administer a public lab repository, access to native Copilot code review, and available Copilot usage allowance.
> - For the Azure DevOps option, an approved Azure DevOps Services organization, the permissions needed to create or use a private lab project and configure repository policies, and PowerShell. An administrator must enable native Copilot code review at the required scopes and approve billing through a linked Azure subscription.
>
> Copilot Chat access alone doesn't enable hosted pull-request code review. Confirm the selected lab's access, administration, and billing requirements before you start. AI review requests can incur charges.

In this exercise, you follow a source-control contribution from a local clone through a feature branch, commits, a pull request (PR), Copilot code review, and merge. You give Copilot a bounded explanation task, evaluate its review against the linked requirement and actual source changes, and update the same PR before requesting a fresh review. You remain responsible for verification and the merge decision.

## Choose your DevOps platform

Choose the option that matches your preferred DevOps platform. Both options practice the contribution and review workflow covered in this module. You can complete both if you want to learn how the workflow differs between GitHub and Azure DevOps.

Allow approximately **45 minutes per option**, excluding administrator setup for Azure DevOps. Completing both takes approximately **90 minutes**, plus any setup time.

### Option 1: GitHub source control and Copilot code review

Use a GitHub repository containing a copy of the Spoon-Knife sample. You create an issue and feature branch, update the collaboration page's HTML and CSS in VS Code, and open a PR. You request native Copilot code review, evaluate its suggestions, correct an intentionally incomplete revision, and request another review. Before merging, you inspect the source and preview the page locally.

[![Illustration of the button to launch the GitHub code review exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390312)

### Option 2: Azure Repos source control and Copilot code review

Use a private Azure DevOps lab project containing an imported copy of eShopOnWeb. You link an Azure Boards work item to a feature branch and PR, configure the lab's contribution policies, and request native Copilot code review in Azure Repos. You compare feedback with the catalog-filter source and requirement, correct an intentionally incorrect revision, and request a fresh review before completing the PR.

[![Illustration of the button to launch the Azure Repos code review exercise.](../media/launch-exercise.png)](https://go.microsoft.com/fwlink/?LinkId=2390311)

> [!IMPORTANT]
> Both options use isolated sample repositories and deliberately introduce an incomplete or incorrect first revision. Don't merge that revision or change the public source repository. These are solo exercises, not demonstrations of independent team approval. Copilot feedback doesn't replace your verification or your team's approval policies.
>
> This exercise focuses on source control and code review. Neither option requires pipeline configuration or application deployment. The GitHub option includes a local page preview; the Azure Repos option uses source inspection without running the application. AI feedback and source inspection aren't proof of application correctness.

When you select either launch exercise button, your browser opens a public GitHub page containing the instructions for that option.

When you finish your selected exercise, return here to continue with the module's knowledge check and summary.
