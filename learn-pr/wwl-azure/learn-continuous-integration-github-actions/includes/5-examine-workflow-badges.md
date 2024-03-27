
Badges can be used to show the status of a workflow within a repository.

They show if a workflow is currently passing or failing. While they can appear in several locations, they typically get added to the README.md file for the repository.

Badges are added by using URLs. The URLs are formed as follows:

https://github.com/&lt;OWNER&gt;/&lt;REPOSITORY&gt;/actions/workflows/&lt;WORKFLOW\_FILE&gt;/badge.svg

Where:

 -  AAAAA is the account name.
 -  RRRRR is the repository name.
 -  WWWWW is the workflow name.

:::image type="content" source="../media/badge-failing-12fd7192.png" alt-text="Screenshot of the Badge failing in a color to represent an error.":::


They usually indicate the status of the default branch but can be branch-specific. You do this by adding a URL query parameter:

?branch=BBBBB

where:

 -  BBBBB is the branch name.

For more information, see: [Adding a workflow status badge](https://docs.github.com/actions/monitoring-and-troubleshooting-workflows/adding-a-workflow-status-badge).
