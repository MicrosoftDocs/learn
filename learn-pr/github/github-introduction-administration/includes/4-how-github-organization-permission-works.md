In the previous unit, you explored the different ways in which users can authenticate themselves to GitHub.  Next, you learn about permissions at each hierarchical level as well as repository permissions.

## Permissions levels determine administrative authority

Permission levels allow users to perform administrative tasks unrelated to the content of repositories.  There are three permission levels:

- Organization permission levels
- Team permission levels
- Enterprise permission levels

### Organization permission levels

There are three permission levels at the Organization level:

- Owner
- Member
- Billing manager

Each user, as an organization member, is assigned a permission level that gives them the ability to create new teams, change the team roster, and so on. Users with the Billing Manager permission level can only view and edit billing information. Users with the Member permission level can create and manage organization repositories and teams. Users with the Owner permission level can do everything members can, and can add or remove others users to and from the organization.

For a complete list of actions for each permission level, see the GitHub docs article ["Permission levels for an organization"](https://docs.github.com/en/free-pro-team@latest/github/setting-up-and-managing-organizations-and-teams/permission-levels-for-an-organization#permission-levels-for-an-organization?azure-portal=true).

### Team permission levels

There's one permission level at the team level: the team maintainer permission. An organization owner can promote any member of the organization to team maintainer for a team, giving them a subset of privileges available to organization owners.  A team maintainer can:

- Change the team's name, description, and visibility
- Request that the team change parents and children teams
- Edit and delete team discussions
- Add and remove organization members to the team
- Promote team members to also have the team maintainer permission
- Remove the team's access to repositories
- Manage code review assignment for the team
- Manage scheduled reminders for pull requests

### Enterprise permission levels

Recall from earlier that enterprise accounts are collections of organizations.  By extension, each individual user account who is a member of an organization is also a member of the enterprise, and various settings related to authentication can be controlled from this higher level.

There are three permission levels at the enterprise level:

- Owner
- Member
- Billing manager

When a user creates an enterprise account, they are assigned the role of enterprise owner. Each user, as an enterprise owner, can add and remove organizations to and from the enterprise account. They can manage other administrators, enforce security policies across organizations, and so on.

## Repository permission levels

Each user, as a team member, is assigned a permission for a given repository. There are five repository permission levels with an increasing degree of control over the repository: read, triage, write, maintain, admin.

You can customize access to each repository in your organization with granular permission levels, giving people access to the features and tasks they need.

You can give organization members, outside collaborators, and teams of people different levels of access to repositories owned by an organization. Each permission level progressively increases access to a repository's content and settings. Choose the level that best fits each person or team's role in your project without giving people more access to the project than they need.

From least access to most access, the permissions for an organization repository are:

- **Read** - Recommended for non-code contributors who want to view or discuss your project
- **Triage** - Recommended for contributors who need to proactively manage issues and pull requests without write access
- **Write** - Recommended for contributors who actively push to your project
- **Maintain** - Recommended for project managers who need to manage the repository without access to sensitive or destructive actions
- **Admin** - Recommended for people who need full access to the project, including sensitive and destructive actions like managing security or deleting a repository

For a detailed look at what users can do with each repository permission, see the GitHub Docs article titled ["Repository permission levels for an organization"](https://docs.github.com/free-pro-team@latest/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization#repository-access-for-each-permission-level?azure-portal=true).

### Teams and repository permissions

Teams provide an easy way to assign repository permissions to all users in a team at once. Furthermore, members of a child team inherit the permission settings of the parent Team, providing an easy way to cascade permissions through the natural structure of the company.