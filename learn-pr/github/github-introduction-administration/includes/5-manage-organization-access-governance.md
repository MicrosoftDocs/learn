In the previous unit, you explored how repository and team permissions work in GitHub and how users are granted access at those levels. In this unit, you'll learn how to manage permissions and access at a broader scale across organizations and enterprises:

- Organization permissions  
- Enterprise permissions  
- Internal vs. external collaborators  
- Least privilege strategies  
- Security and governance best practices  

## Organization permission levels
GitHub organizations provide a centralized way for teams to collaborate on projects while maintaining controlled access to repositories and sensitive data. Organization permissions determine what members and teams can do within the organization, ensuring that each user has the appropriate level of access.

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

Recall from earlier that enterprise accounts are collections of organizations. By extension, each individual user account that is a member of an organization is also a member of the enterprise. You can control various settings related to authentication from this higher level.

There are three levels of permission at the enterprise level:

| **Permission level**  | **Description**                                                                                                                    |
|:----------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| Owner                 | Enterprise owners have complete control over the enterprise and can take every action, including: <br> - Managing administrators. <br> - Adding and removing organizations to and from the enterprise. <br> - Managing enterprise settings. <br> - Enforcing policies across organizations. <br> - Managing billing settings.                |
| Member                | Enterprise members have the same set of abilities as organization members. |
| Billing manager       | Enterprise billing managers can only view and edit your enterprise's billing information and add or remove other billing managers.  |
| Guest collaborator       | Can be granted access to repositories or organizations, but has limited access by default (Enterprise Managed Users only)|

In addition to these three levels, you can also set a policy of default repository permissions across all your organizations:

:::image type="content" source="../media/enterprise-base-permissions.png" alt-text="Screenshot of the policies screen with the default permissions dropdown displayed.":::

For improved management and security, you can give default read permissions to all members of your enterprise and adjust their access to repositories on a case-by-case basis. In a smaller enterprise, such as one with a single, relatively small organization, you might prefer to trust all members with write permissions by default.

To further streamline enterprise-scale access control:

- **Nested Teams:** Enterprise accounts can use nested team structures to reflect departmental hierarchies. A parent team’s permissions cascade down to child teams, simplifying complex access management.
- **Automation & Auditing:** You can use GitHub’s API or GitHub Actions to automate team creation and permission assignments, and audit access via organization or enterprise audit logs.

## 4.3.4 Difference Between Organization Members and Outside Collaborators

Understanding the distinction between an organization member and an outside collaborator is crucial for managing access and permissions effectively within GitHub. Here are the key differences:

- **Organization Member:**
  - Included in the organization’s internal directory.
  - Can be assigned to one or more teams with varying levels of repository access.
  - May inherit organization-wide settings, such as SSO requirements or policies.

- **Outside Collaborator:**
  - Not an official member of the organization.
  - Has explicit access to specific repositories only.
  - Does not appear in the organization’s internal member list.
  - Lacks broader visibility into private repositories and organization settings.

## 4.3.5 Downsides of a User’s Membership in an Instance or Organization

When a user becomes a member of a GitHub organization, several implications come into play that affect their access, visibility, and responsibilities within the organization. These consequences are important to understand for effective management and collaboration.

- **Access to Private Repositories:** Organization members can view, clone, and contribute to private repos if granted the necessary permissions.
- **Visibility:** Members appear in the organization’s people directory, which may affect discoverability.
- **Policy Enforcement:** Security and compliance rules (e.g., SAML SSO, 2FA) apply to all organization members.
- **Billing Implications:** Each member may count toward your organization’s license or billing plan.
- **Team Collaboration:** Members can be grouped into teams, streamlining repository permissions and communication.

## 4.3.6 Assigning Least Privilege to a User for Repository, Organization or Team

Applying the Principle of Least Privilege ensures that users have only the permissions necessary to fulfill their roles:

- **Repository Access:**
  - Assign the Read permission to most contributors.
  - Grant Write or Admin only if they need to commit code or manage settings.

- **Organization Access:**
  - Start with Member and only elevate to Owner for those who need administrative control.
  - Use Billing Manager for financial responsibilities without granting code access.

- **Team Access:**
  - Team Maintainer can manage team membership and settings.
  - Team Member is suitable for contributors who only need to participate in repository and team discussions.

## 4.3.7 Benefits and Drawbacks of Creating a New Organization

Creating a new organization within GitHub can help you manage projects, teams, and resources more effectively. Here are some benefits and drawbacks to consider:
### Benefits and drawbacks of creating a new organization

| Benefits                                                                 | Drawbacks                                                                 |
|--------------------------------------------------------------------------|---------------------------------------------------------------------------|
| **Clear Separation:** Keep projects, teams, and billing separate from other organizations. | **Administrative Overhead:** Managing multiple organizations can be more complex. |
| **Custom Policies:** Apply specific security or compliance policies for different projects. | **Billing Complexity:** Each organization may need separate billing. |
| **Scalability:** Avoid making a single organization too complex.         | **Fragmented Collaboration:** Users might need to switch between organizations. |

Consider these points to decide if creating a new organization is the right choice for your needs.

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

By adding a [CODEOWNERS](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners#codeowners-syntax) file to your repository, you can assign team members or entire teams as code owners who are responsible for code in the repository. When someone opens a pull request that modifies code that belongs to a code owner, the code owner is automatically requested as a reviewer.

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
