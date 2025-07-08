In the previous unit, you explored the different ways that users can authenticate themselves with GitHub. In this unit, you'll learn about permissions for each hierarchical level:

- Repository permissions
- Team permissions
- Organization permissions
- Enterprise permissions

## Repository permission levels

You can customize access to a given repository by assigning permissions. There are five repository-level permissions:

- **Read**: Recommended for non-code contributors who want to view or discuss your project. This level is good for anyone that needs to view the content within the repository but doesn't need to actually make contributions or changes.
- **Triage**: Recommended for contributors who need to proactively manage issues and pull requests without write access. This level could be good for some project managers who manage tracking issues but don't make any changes.
- **Write**: Recommended for contributors who actively push to your project. Write is the standard permission for most developers.
- **Maintain**: Recommended for project managers who need to manage the repository without access to sensitive or destructive actions.
- **Admin**: Recommended for people who need full access to the project, including sensitive and destructive actions like managing security or deleting a repository. These people are repository owners and administrators.

You can give organization members, outside collaborators, and teams different levels of access to repositories owned by an organization. Each permission level progressively increases access to a repository's content and settings. Choose the level that best fits each person or team's role in your project without giving more access to the project than necessary.

After you create a repository with the correct permissions, you can make it a template so that anyone who has access to the repository can generate a new repository that has the same directory structure and files as your default branch. To make a template:

1. On GitHub.com, go to the main page of the repository.
1. Under the repository name, select **Settings**. If you can't see the **Settings** tab, open the dropdown menu, and then select **Settings**.

    :::image type="content" source="../media/repository-actions-settings.png" alt-text="Screenshot showing where to locate the settings button in your GitHub repository.":::

1. Select **Template repository**.

## Ways Users Receive Repository Access

### Actions of a User Given a List of Their Repository Permissions
A user’s effective permissions in a repository are influenced by various factors, including:

- **Repository Role:** (e.g., Admin, Write, Read)
- **Team Membership:** (e.g., inherited permissions from a team)
- **Organization Membership:** (e.g., default organization permissions, SSO requirements)

When you combine these different permission sources, GitHub applies the highest level of access granted to the user. For example, if a user has Read access through a team but also has Write access directly assigned as a collaborator, they will effectively have Write permissions.

### Repository Membership Options

When granting access to a repository, there are several ways a user can become a collaborator:

| Membership Type             | Description                                                                                     |
|-----------------------------|-------------------------------------------------------------------------------------------------|
| **Direct Collaborator**     |  Added explicitly to the repository with a specific role (Read, Triage, Write, Maintain, or Admin). <br>  Recommended for external contributors or small teams. |
| **Team Membership**         |  A user inherits repository access via their team membership. <br>  Team permissions are often set at the organization level for consistent, scalable management. |
| **Organization Default Permissions** |  If the repository is part of an organization, there may be a default permission level for all organization members (e.g., None, Read). <br>  Owners can override these defaults for specific teams or users. |
| **Outside Collaborator**    |  A user who is not a member of the organization but has explicit access to a repository. <br>  Useful for contractors, freelancers, or open-source contributors needing limited access. |

## Monitoring and Auditing Repository Access

Regularly auditing who has access to a repository ensures proper security and compliance. Here are some recommended steps and tools:

- **View Access in Repository Settings:**
  - Navigate to Settings > Manage access (for the repository).
  - Review the list of users and teams, along with their permission levels.

- **Organization Audit Log (GitHub Enterprise or Organization-level):**
  - Organization owners can view changes to membership, repository access, and permissions in the Audit log.
  - Filter events by repository name or access changes for a more focused view.

- **Enterprise Audit Log (GitHub Enterprise):**
  - If you manage multiple organizations, use the Enterprise account’s audit log to track changes across all organizations and repositories.
  - This is especially valuable for compliance reporting or large-scale security reviews.

- **Automated Scripting:**
  - Use the GitHub REST API or GraphQL API to programmatically list collaborators, teams, and permissions.
  - Integrate scripts with your CI/CD pipeline or security dashboards to continuously monitor and flag anomalies.

**Tip:** Set up branch protection rules and required reviews to add another layer of security and accountability for all code changes.

## Team permission levels
A team in a GitHub organization is a group of users who collaborate on shared repositories. Teams help streamline access management and communication by applying consistent permissions across multiple repositories at once. Key benefits include:

- **Centralized Access Control:** Assign repository permissions (e.g., Read, Write) to the entire team instead of managing each user individually.
- **Structured Collaboration:** Organize members by department, project, or role for more efficient collaboration.
- **Visibility & Communication:** Each team can have its own discussion board, making it easier to share updates and coordinate efforts.

Teams provide an easy way to assign repository permissions to several related users at once. Members of a child team also inherit the permission settings of the parent team, providing an easy way to cascade permissions based on the natural structure of a company.

There are two levels of permissions at the team level:

| **Permission level**  | **Description** |
|:----------------------|:----------------|
| Member                | Team members have the same set of abilities as organization members |
| Maintainer            | Team maintainers can do everything team members can, plus: <br> - Change the team's name, description, and visibility. <br> - Request that the team change parent and child teams. <br> - Set the team profile picture. <br> - Edit and delete team discussions. <br> - Add and remove organization members from the team. <br> - Promote team members to also have the team maintainer permission. <br> - Remove the team's access to repositories. <br> - Manage code review assignment for the team. <br> - Manage scheduled reminders for pull requests. |

An organization owner can also promote any member of the organization to be a maintainer for a team.

To audit access to a repository that you administer, you can view a combined list of teams and users with access to your repository in your settings:

:::image type="content" source="../media/manage-access-overview.png" alt-text="Screenshot of the manage access screen.":::

GitHub offers several permission levels that can be assigned to teams. When you grant a team access to a repository, you can choose from the following permission models:
### Permission Models

| Permission Level | Description                                                                 | Best For                                                                 |
|------------------|-----------------------------------------------------------------------------|--------------------------------------------------------------------------|
| **Read**         | Users can view and clone the repository. Can open and comment on issues and pull requests. | Individuals who need read-only or review access.                         |
| **Triage**       | Users can manage issues and pull requests (e.g., label, assign, comment). Cannot push changes to the repository. | Project managers or contributors who need to triage and organize issues without contributing code. |
| **Write**        | Users can push to branches (except protected branches). Can manage issues and pull requests. | Active contributors who need to commit code or update documentation.     |
| **Maintain**     | Users can manage repository settings, issues, and pull requests. Cannot delete or transfer the repository. | Project maintainers who handle routine repository management but don’t require full admin rights. |
| **Admin**        | Users have full control over the repository, including setting permissions, deleting the repository, and managing all settings. | Those who need top-level administrative access.                          |

**Tip:** Always follow the Principle of Least Privilege—assign the lowest permission level necessary for each team to perform its tasks effectively. This approach reduces the risk of accidental or unauthorized changes.


