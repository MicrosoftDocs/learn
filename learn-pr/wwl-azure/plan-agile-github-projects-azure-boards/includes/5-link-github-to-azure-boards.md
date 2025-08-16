## Strategic integration: GitHub development + Azure Boards planning

The integration between GitHub and Azure Boards creates a powerful hybrid approach that combines GitHub's developer-friendly environment with Azure Boards' enterprise planning capabilities. This connection enables organizations to maintain centralized project governance while allowing development teams to work in their preferred GitHub environment.

**Business benefits of integration:**

- **Unified visibility**: Stakeholders can track development progress without accessing GitHub directly
- **Compliance and audit**: Maintain formal project tracking while preserving developer workflows
- **Cross-functional collaboration**: Bridge the gap between project managers and development teams
- **Automated synchronization**: Reduce manual overhead in keeping project status current

:::image type="content" source="../media/board-view-github-links-1914d559-1c89b671-048672dd.png" alt-text="Screenshot showing Azure Boards work items with integrated GitHub links, displaying commits, pull requests, and issues directly within the work item interface.":::

## Azure Boards App: The integration foundation

The Azure Boards App serves as the technical bridge enabling seamless data flow between GitHub and Azure Boards. This marketplace application provides secure, authenticated access while maintaining the integrity of both platforms.

**Key integration capabilities:**

- **Bidirectional linking**: Connect Azure Boards work items with GitHub commits, PRs, and issues
- **Automated state transitions**: Complete work items when GitHub mentions include keywords like "fixes"
- **Real-time synchronization**: Changes in GitHub immediately reflect in Azure Boards
- **Flexible scope control**: Choose organization-wide or selective repository integration

:::image type="content" source="../media/azure-boards-app-b8c1f43c-c1570da0-de81d1b3.png" alt-text="Screenshot of the Azure Boards App installation page in GitHub Marketplace, showing configuration options and permissions required for integration.":::

### Installation requirements and permissions

**GitHub prerequisites:**

- **Repository access**: Administrator or owner permissions for target repositories
- **Organization permissions**: Owner role for organization-wide installations
- **Marketplace access**: Ability to install applications from GitHub Marketplace

**Azure DevOps prerequisites:**

- **Project collection administrator**: Required for initial connection setup
- **Project permissions**: Stakeholder access or higher to view linked work items
- **Authentication credentials**: PAT or OAuth for secure API access

## Authentication and security considerations

Secure authentication is critical for maintaining data integrity and access control across both platforms. Azure Boards supports multiple authentication methods, each with specific security implications and use cases.

**GitHub authentication options:**

| **Method**                | **Security Level** | **Best For**                   | **Considerations**                    |
| ------------------------- | ------------------ | ------------------------------ | ------------------------------------- |
| **Personal Access Token** | High               | Automated integrations, CI/CD  | Requires careful scope management     |
| **Username/Password**     | Medium             | Individual user connections    | Less secure, not recommended for prod |
| **OAuth Apps**            | High               | Organization-wide integrations | Centralized access management         |

**Security best practices:**

- **Principle of least privilege**: Grant only necessary permissions for integration functionality
- **Token rotation**: Regularly update PATs and review access permissions
- **Audit logging**: Monitor integration activity for unusual access patterns
- **Repository isolation**: Connect only repositories that require Azure Boards integration

**Step-by-step connection process:**

1. **Install Azure Boards App** from GitHub Marketplace
2. **Configure repository access** (all repos or selective)
3. **Authenticate with Azure DevOps** using preferred method
4. **Map repositories to projects** in Azure Boards
5. **Test integration** with sample links and commits

For detailed implementation guidance, see: [Connect Azure Boards to GitHub](/azure/devops/boards/github/connect-to-github)

### Configuration flexibility and management

**GitHub-side management capabilities:**

- **Repository scope control**: Add or remove specific repositories from integration
- **Project mapping**: Configure which Azure Boards projects connect to each repository
- **Integration suspension**: Temporarily disable without losing configuration
- **Complete removal**: Uninstall app and remove all connections

**Azure Boards-side management capabilities:**

- **Multi-repository connections**: Link multiple GitHub repositories to single projects
- **Cross-project linking**: Allow repositories to connect to multiple Azure Boards projects
- **Connection health monitoring**: Track integration status and resolve connectivity issues
- **Permission management**: Control which users can modify GitHub connections

## Supported integration scenarios

Azure Boards-GitHub integration supports the following connections:

- From GitHub:

  - Support integration for all repositories for a GitHub account or organization or select repositories.
  - Add or remove GitHub repositories participating in the integration and configure the project they connect to.
  - Suspend Azure Boards-GitHub integration or uninstall the app.

- From Azure Boards:

  - Connect one or more GitHub repositories to an Azure Boards project.
  - Add or remove GitHub repositories from a GitHub connection within an Azure Boards project.
  - Completely remove a GitHub connection for a project.
  - Allow a GitHub repository to connect to one or more Azure Boards projects within the same Azure DevOps organization or collection.

Azure Boards-GitHub integration supports the following operational tasks:

- Create links between work items and GitHub commits, pull requests, and issues based on GitHub mentions.
- Support state transition of work items to a Done or Completed state when using GitHub mention by using fix, fixes, or fixed.
- Support full traceability by posting a discussion comment to GitHub when linking from a work item to a GitHub commit, pull request, or issue.
- Show linked to GitHub code artifacts within the work item Development section.
- Show linked to GitHub artifacts as annotations on Kanban board cards.
- Support status badges of Kanban board columns added to GitHub repositories.

The following tasks aren't supported at this time:

- Query for work items with links to GitHub artifacts. However, you can query for work items with an External Link Count greater than 0.

> [!NOTE]
> Reference: [Azure Boards-GitHub integration](/azure/devops/boards/github).

For more information, see:

- [Change GitHub repository access, or suspend or uninstall the integration](/azure/devops/boards/github/change-azure-boards-app-github-repository-access).
- [Add or remove GitHub repositories](/azure/devops/boards/github/add-remove-repositories).
- [Link GitHub commits, pull requests, and issues to work items for details on linking to work items](/azure/devops/boards/github/link-to-from-github).
