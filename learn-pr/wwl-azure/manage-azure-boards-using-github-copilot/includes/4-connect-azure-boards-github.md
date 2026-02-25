After prerequisites are in place, connect Azure Boards to GitHub so commits and pull requests can be linked to work items.

## Connect the platforms

At a high level, the setup sequence is:

1. Install and authorize the Azure Boards GitHub app for the required repositories.
2. Authenticate from Azure DevOps to the GitHub connection.
3. Select the Azure DevOps organization and project that should track linked work.
4. Validate the connection in project settings.

## Scope and repository selection strategy

Use selective repository access by default, then expand intentionally as adoption grows.

Recommended approach:

- Start with one pilot repository and one team.
- Confirm end-to-end linking and review experience.
- Add repositories by value stream, not all at once.
- Reassess permissions each time scope expands.

## Validate the connection

A successful connection should enable:

- Linking work items to commits and pull requests.
- Visibility of development links in Azure Boards work items.
- Better sprint and board transparency for delivery progress.

## Troubleshooting basics

If links don't appear as expected, check:

- Repository authorization scope for the app.
- Identity and access permissions in both platforms.
- Whether users are working in the connected repository.
- Whether work item references are included consistently in workflow practices.
