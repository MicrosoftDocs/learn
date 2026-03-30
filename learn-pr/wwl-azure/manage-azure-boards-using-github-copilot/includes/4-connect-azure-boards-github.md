After prerequisites are in place, connect Azure Boards to GitHub so commits and pull requests can be linked to work items.

## Connect the platforms

Establishing a connection between Azure Boards and GitHub requires a structured approach that ensures secure authentication and proper platform integration. This process involves installing an authorized GitHub app and configuring Azure DevOps to recognize and communicate with your GitHub repositories.

At a high level, the setup sequence is:

1. Install and authorize the Azure Boards GitHub app for the required repositories.
2. Authenticate from Azure DevOps to the GitHub connection.
3. Select the Azure DevOps organization and project that should track linked work.
4. Validate the connection in project settings.

## Scope and repository selection strategy

Starting small and scaling gradually reduces risk and allows your team to learn the integration workflow before expanding across your organization. This phased approach gives you time to refine processes and permissions before managing larger integrations.

- Start with one pilot repository and one team.
- Confirm end-to-end linking and review experience.
- Add repositories by value stream, not all at once.
- Reassess permissions each time scope expands.

## Validate the connection

Once connected, your platforms should work together seamlessly to provide traceability across your development lifecycle. A successful integration bridges the gap between code changes and work tracking, giving your team complete visibility into delivery progress.

- Linking work items to commits and pull requests.
- Visibility of development links in Azure Boards work items.
- Better sprint and board transparency for delivery progress.

## Troubleshooting basics

When integration issues arise, systematic checks of your configuration and permissions typically identify the root cause quickly. Start with the most common issues before investigating more complex scenarios.

- Repository authorization scope for the app.
- Identity and access permissions in both platforms.
- GitHub Copilot license subscription is active and valid.
- Whether users are working in the connected repository.
- Whether work item references are included consistently in workflow practices.

> [!NOTE]
> The Free GitHub Copilot subscription is not compatible with the Azure Boards integration.

## Summary

Connecting Azure Boards to GitHub enables seamless traceability between your work items and code changes. By following a structured approach—installing the GitHub app, configuring authentication, and validating the connection—you establish a foundation for effective collaboration. Starting with a pilot repository and scaling gradually helps your team adopt the integration confidently while maintaining security and permissions best practices. With proper setup and troubleshooting, your team gains complete visibility into development progress and can link commits and pull requests directly to work items, streamlining your delivery workflow.