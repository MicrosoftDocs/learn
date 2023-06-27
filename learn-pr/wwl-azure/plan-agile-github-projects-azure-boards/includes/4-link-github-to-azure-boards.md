
## Use GitHub, track work in Azure Boards

Use Azure Boards to plan and track your work and GitHub as source control for software development.

Connect Azure Boards with GitHub repositories, enabling linking GitHub commits, pull requests, and issues to work items in Boards.

:::image type="content" source="../media/board-view-github-links-1914d559-1c89b671-048672dd.png" alt-text="Screenshot of GitHub and Azure Boards integration.":::


## Azure Boards App

The integration is created using the Azure Boards App, acting as a bridge between Azure Boards and GitHub.

To install the app, you must be an administrator or owner of the GitHub repository or the GitHub organization.

The app is installed from the GitHub Marketplace. [Azure Boards App](https://github.com/marketplace/azure-boards)

:::image type="content" source="../media/azure-boards-app-b8c1f43c-c1570da0-de81d1b3.png" alt-text="Screenshot of Azure Boards App integration.":::


## Authenticating to GitHub

Azure Boards can connect to GitHub. For GitHub in the cloud, when adding a GitHub connection, the authentication options are:

 -  Username/Password
 -  Personal Access Token (PAT)

For a walkthrough on making the connection, see: [Connect Azure Boards to GitHub](/azure/devops/boards/github/connect-to-github).

You can configure other Azure Boards/Azure DevOps Projects, GitHub.com repositories, or change the current configuration from the Azure Boards app page.

Once you've integrated Azure Boards with GitHub using the Azure Boards app, you can add or remove repositories from the web portal for Azure Boards.

## Supported integration scenarios

Azure Boards-GitHub integration supports the following connections:

 -  From GitHub:
    
    
     -  Support integration for all repositories for a GitHub account or organization or select repositories.
     -  Add or remove GitHub repositories participating in the integration and configure the project they connect to.
     -  Suspend Azure Boards-GitHub integration or uninstall the app.
 -  From Azure Boards:
    
    
     -  Connect one or more GitHub repositories to an Azure Boards project.
     -  Add or remove GitHub repositories from a GitHub connection within an Azure Boards project.
     -  Completely remove a GitHub connection for a project.
     -  Allow a GitHub repository to connect to one or more Azure Boards projects within the same Azure DevOps organization or collection.

Azure Boards-GitHub integration supports the following operational tasks:

 -  Create links between work items and GitHub commits, pull requests, and issues based on GitHub mentions.
 -  Support state transition of work items to a Done or Completed state when using GitHub mention by using fix, fixes, or fixed.
 -  Support full traceability by posting a discussion comment to GitHub when linking from a work item to a GitHub commit, pull request, or issue.
 -  Show linked to GitHub code artifacts within the work item Development section.
 -  Show linked to GitHub artifacts as annotations on Kanban board cards.
 -  Support status badges of Kanban board columns added to GitHub repositories.

The following tasks aren't supported at this time:

 -  Query for work items with links to GitHub artifacts. However, you can query for work items with an External Link Count greater than 0.

> [!NOTE]
> Reference: [Azure Boards-GitHub integration](/azure/devops/boards/github).

For more information, see:

 -  [Change GitHub repository access, or suspend or uninstall the integration](/azure/devops/boards/github/change-azure-boards-app-github-repository-access).
 -  [Add or remove GitHub repositories](/azure/devops/boards/github/add-remove-repositories).
 -  [Link GitHub commits, pull requests, and issues to work items for details on linking to work items](/azure/devops/boards/github/link-to-from-github).
