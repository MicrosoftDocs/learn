In the previous unit, you explored the different ways that users can authenticate themselves with GitHub. In this unit, you'll learn about permissions for each hierarchical level:

- Repository permissions
- Team permissions
- Organization permissions
- Enterprise permissions

## Repository permission levels

You can customize access to a given repository by assigning permissions. There are five repository-level permissions:

- **Read** - Recommended for non-code contributors who want to view or discuss your project. This level is good for anyone that needs to view the content within the repository but doesn't need to actually make contributions or changes.
- **Triage** - Recommended for contributors who need to proactively manage issues and pull requests without write access. This level could be good for some project managers who manage tracking issues but don't make any changes.
- **Write** - Recommended for contributors who actively push to your project. Write is the standard permission for most developers.
- **Maintain** - Recommended for project managers who need to manage the repository without access to sensitive or destructive actions.
- **Admin** - Recommended for people who need full access to the project, including sensitive and destructive actions like managing security or deleting a repository. These people are repository owners and administrators.

You can give organization members, outside collaborators, and teams different levels of access to repositories owned by an organization. Each permission level progressively increases access to a repository's content and settings. Choose the level that best fits each person or team's role in your project without giving more access to the project than necessary.

After you create a repository with the correct permissions, you can make it a template so that anyone who has access to the repository can generate a new repository that has the same directory structure and files as your default branch. To make a template:

1. On GitHub.com, go to the main page of the repository.
1. Under the repository name, select **Settings**. If you can't see the **Settings** tab, open the dropdown menu and then select **Settings**.

    :::image type="content" source="../media/repository-actions-settings.png" alt-text="Screenshot showing where to locate the settings button in your GitHub repository.":::

1. Select **Template repository**.

## Team permission levels

Teams provide an easy way to assign repository permissions to several related users at once. Members of a child team also inherit the permission settings of the parent team, providing an easy way to cascade permissions based on the natural structure of a company.

There are two levels of permissions at the team level:

| **Permission level**  | **Description** |
|:----------------------|:----------------|
| Member                | Team members have the same set of abilities as organization members |
| Maintainer            | Team maintainers can do everything team members can, plus: <br> - Change the team's name, description, and visibility <br> - Request that the team change parent and child teams <br> - Set the team profile picture <br> - Edit and delete team discussions <br> - Add and remove organization members from the team <br> - Promote team members to also have the team maintainer permission <br> - Remove the team's access to repositories <br> - Manage code review assignment for the team <br> - Manage scheduled reminders for pull requests |

An organization owner can also promote any member of the organization to be a maintainer for a team.

To audit access to a repository that you administer, you can view a combined list of teams and users with access to your repository in your settings:

:::image type="content" source="../media/manage-access-overview.png" alt-text="Screenshot of the manage access screen.":::

## Organization permission levels

There are multiple levels of permissions at the organizational level:

| **Permission level**  | **Description**                                                                                                                 |
|:----------------------|:--------------------------------------------------------------------------------------------------------------------------------|
| Owner                 | Organization owners can do everything that organization members can do, and they can add or remove other users to and from the organization. This role should be limited to no less than two people in your organization.  |
| Member                | Organization members can create and manage organization repositories and teams.                                                 |
| Moderator       | Organization moderators can block and unblock nonmember contributors, set interaction limits, and hide comments in public repositories that the organization owns.                                                |
| Billing manager       | Organization billing managers can view and edit billing information.                                                        |
| Security managers       | Organization security managers can manage security alerts and settings across your organization. They can also read permissions for all repositories in the organization.                                        |
| Outside collaborator      | Outside collaborators, such as a consultant or temporary employee, can access one or more organization repositories. They aren't explicit members of the organization.                                                |

In addition to these levels, you can also set default permissions for all members of your organization:

:::image type="content" source="../media/org-base-permissions.png" alt-text="Screenshot of the member privileges screen with the base permissions dropdown displayed.":::

For improved management and security, you might also consider giving default read permissions to all members of your organization and adjusting their access to repositories on a case-by-case basis. If you have a relatively small organization with a low number of users, a low number of repositories, or a combination of the two, this level of restriction might be unnecessary. If you trust everyone with pushing changes to any repository, you might prefer to give all members write permissions by default.

## Enterprise permission levels

Recall from earlier that enterprise accounts are collections of organizations. By extension, each individual user account that is a member of an organization is also a member of the enterprise, and you can control various settings related to authentication from this higher level.

There are three levels of permission at the enterprise level:

| **Permission level**  | **Description**                                                                                                                    |
|:----------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| Owner                 | Enterprise owners have complete control over the enterprise and can take every action, including: <br> - Managing administrators <br> - Adding and removing organizations to and from the enterprise <br> - Managing enterprise settings <br> - Enforcing policies across organizations <br> - Managing billing settings                |
| Member                | Enterprise members have the same set of abilities as organization members |
| Billing manager       | Enterprise billing managers can only view and edit your enterprise's billing information and add or remove other billing managers  |

In addition to these three levels, you can also set a policy of default repository permissions across all your organizations:

:::image type="content" source="../media/enterprise-base-permissions.png" alt-text="Screenshot of the policies screen with the default permissions dropdown displayed.":::

For improved management and security, you can give default read permissions to all members of your enterprise and adjust their access to repositories on a case-by-case basis. In a smaller enterprise, such as one with a single, relatively small organization, you might prefer to trust all members with write permissions by default.

## Repository security and management

You can oversee the security and management of your repositories in several ways.

### Create protection rules

To manage changes to content within your repository, you can create [branch protection rules](https://docs.github.com/github/administering-a-repository/defining-the-mergeability-of-pull-requests/managing-a-branch-protection-rule) to enforce certain workflows for one or more branches. Protection rules that can be applied to a branch include:

- Require a pull request before merging.
- Require status checks to pass before merging.
- Require conversation resolution before merging.
- Require signed commits.
- Require linear history.
- Require merge queue.
- Require deployments to succeed before merging.
- Lock the branch by making it read-only.
- Restrict who can push to matching branches.

Additionally, you can set branch rules that apply to everyone, including administrators. For example, you can allow force pushes to matching branches and allow deletions from users who have push access.

### Add a CODEOWNERS file

By adding a [CODEOWNERS](https://docs.github.com/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/about-code-owners#codeowners-syntax) file to your repository, you can assign team members or entire teams as code owners who are responsible for code in the repository. When someone opens a pull request that modifies code that belongs to a code owner, the code owner is automatically requested as a reviewer.

You can create the CODEOWNERS file in either the root of the repository or in the `docs` or `.github` folder.

### View traffic by using Insights

Anyone who has push access to a repository can [view its traffic](https://docs.github.com/en/repositories/viewing-activity-and-data-for-your-repository/viewing-traffic-to-a-repository). In the traffic graph, they can view full clones (not fetches), visitors from the past 14 days, referring sites, and popular content.

To access the traffic graph:

1. On GitHub.com, go to the main page of the repository.
1. Under your repository name, select **Insights**.

    :::image type="content" source="../media/repository-navigation-insights-tab.png" alt-text="Screenshot showing where to locate the Insights button in GitHub.":::

1. On the left, select **Traffic**.

    :::image type="content" source="../media/traffic-tab.png" alt-text="Screenshot showing the Traffic tab highlighted in GitHub.":::

1. Optionally, you can select **Clones** or **Views** to see the traffic graph for clones or views.
