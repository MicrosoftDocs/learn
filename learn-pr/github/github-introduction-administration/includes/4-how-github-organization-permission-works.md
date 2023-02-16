In the previous unit, you explored the different ways that users can authenticate themselves with GitHub. In this unit, you'll learn about permissions for each hierarchical level:

- Repository permissions 
- Team permissions
- Organization permissions
- Enterprise permissions

## Repository permission levels

As an organization member, each user is assigned a permission for a given repository. There are five repository-level permissions:

- **Read** - Recommended for non-code contributors who want to view or discuss your project. This level is good for anyone that needs to view the content within the repository but doesn't need to actually make contributions or changes. 
- **Triage** - Recommended for contributors who need to proactively manage issues and pull requests without write access. This level could be good for some project managers who manage tracking issues but won't make any changes. 
- **Write** - Recommended for contributors who actively push to your project. Write is the standard permission for most developers. 
- **Maintain** - Recommended for project managers who need to manage the repository without access to sensitive or destructive actions.
- **Admin** - Recommended for people who need full access to the project, including sensitive and destructive actions like managing security or deleting a repository. These people are repository owners and administrators. 

You can give organization members, outside collaborators, and teams different levels of access to repositories owned by an organization. Each permission level progressively increases access to a repository's content and settings. Choose the level that best fits each person or team's role in your project without giving more access to the project than necessary.

## Team permission levels

Teams provide an easy way to assign repository permissions to several related users at once. Members of a child team also inherit the permission settings of the parent team, providing an easy way to cascade permissions based on the natural structure of a company.

There are two levels of permissions at the team level:

| **Permission level**  | **Description** |
|:----------------------|:----------------|
| Member                | Team members have the same set of abilities as organization members |
| Maintainer            | Team maintainers can do everything team members can, as well as: <br> - Change the team's name, description, and visibility <br> - Request that the team change parent and child teams <br> - Set the team profile picture <br> - Edit and delete team discussions <br> - Add and remove organization members from the team <br> - Promote team members to also have the team maintainer permission <br> - Remove the team's access to repositories <br> - Manage code review assignment for the team <br> - Manage scheduled reminders for pull requests |

An organization owner can also promote any member of the organization to be a maintainer for a team.

To audit access to a repository that you administer, you can view a combined list of teams and users with access to your repository in your settings:

:::image type="content" source="../media/manage-access-overview.png" alt-text="Screenshot of the manage access screen.":::

## Organization permission levels

There are three levels of permissions at the organizational level:

| **Permission level** | **Description**                                                                                                                 |
|:---------------------|:--------------------------------------------------------------------------------------------------------------------------------|
| Owner                | Organization owners can do everything organization members can, and can add or remove other users to and from the organization  |
| Member               | Organization members can create and manage organization repositories and teams                                                  |
| Billing manager      | Organization billing managers can only view and edit billing information                                                        |

In addition to these three levels, you can also set default permissions for all members of your organization:

:::image type="content" source="../media/org-base-permissions.png" alt-text="Screenshot of member privileges screen with base permissions dropdown displayed.":::

For improved management and security, you might also consider giving default read permissions to all members of your organization and adjusting their access to repositories on a case-by-case basis. On the other hand, if you have a relatively small organization (with a low number of users and/or low number of repositories) and trust everyone with pushing changes to any repository, you might want to give all members of your organization write permissions by default.

## Enterprise permission levels

Recall from earlier that enterprise accounts are collections of organizations. By extension, each individual user account that is a member of an organization is also a member of the enterprise, and various settings related to authentication can be controlled from this higher level.

There are three levels of permission at the enterprise level:

| **Permission level**  | **Description**                                                                                                                    |
|:----------------------|:-----------------------------------------------------------------------------------------------------------------------------------|
| Owner                 | Enterprise owners have complete control over the enterprise and can take every action, including managing administrators, adding and removing organizations to and from the enterprise, managing enterprise settings, enforcing policies across organizations and managing billing settings                |
| Member                | Enterprise members have the same set of abilities as organization members |
| Billing manager       | Enterprise billing managers can only view and edit your enterprise's billing information and add or remove other billing managers  |

In addition to these three levels, you can also set a policy of default repository permissions across all your organizations:

:::image type="content" source="../media/enterprise-base-permissions.png" alt-text="Screenshot of policies screen with default permissions dropdown displayed.":::

For improved management and security, you might want to give default read permissions to all members of your enterprise and adjust their access to repositories on a case-by-case basis. On the other hand, if your enterprise has a single, relatively small organization (with a low number of users and/or low number of repositories) and you trust everyone with pushing changes to any repository, you might want to give all members of your enterprise write permissions by default.
