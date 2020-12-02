GitHub administrators undertake several important tasks in an effort to keep everything working smoothly for their users.  Here you learn about the different types of administration tasks for the various organizational structures in GitHub.

## Overview of GitHub accounts

In order to understand the different kinds of administration tasks that administrators need to perform, you need to have a firm understanding of the basic hierarchy of account types and their purpose:

- Personal user accounts
- Organization accounts
- Enterprise accounts

Each user has a personal user account with their own private repositories.

Personal user accounts can join a GitHub organization, which can be used to control membership and permissions to shared repositories.  The organization account represents the organization, and each personal user account is given one of three roles in the organization: member, owner, and billing manager of the organization account.  Organizations control organizational repositories.

Furthermore, each personal user account can be added to a team, which should be used to reflect the actual structure of the organization that each user belongs to.  A team is used to refine repository permissions on a more granular level and enable communication and notification for organizational repositories.

An enterprise account can be created to provide overarching control across multiple organizations that belong to the same company.  Each personal user account is given one of three roles in the enterprise: member, administrator, or owner of the enterprise account.

Before we discuss administrative tasks at each level, consider the *purpose* of organizations, teams, and enterprises.

### The purpose of organizations

Organizations are shared accounts where businesses and open-source projects can collaborate across many projects at once. Owners and administrators can manage member access to the organization's data and projects with sophisticated security and administrative features.

Organizations include:

- A free option, GitHub Free, with unlimited collaborators on unlimited public repositories with full features and unlimited private repositories with limited features.
- The option to upgrade to GitHub Team or GitHub Enterprise Cloud for additional features, including sophisticated user authentication and management, and escalated support options.
- Unlimited membership with a variety of roles that grant different levels of access to the organization and its data.
- The ability to give members a range of access permissions to your organization's repositories.
- Nested teams that reflect your company or group's structure with cascading access permissions and mentions.
- The ability for organization owners to view members' two-factor authentication (2FA) status.
- The option to require all organization members to use two-factor authentication.

### The purpose of teams

Teams are groups of organization members that reflect your company or group's structure with cascading access permissions and mentions.

Organization owners and team maintainers can give teams admin, read, or write access to organization repositories. Organization members can send a notification to an entire team by mentioning the team's name. Organization members can also send a notification to an entire team by requesting a review from that team. Organization members can request reviews from specific teams with read access to the repository where the pull request is opened. 

You can reflect your group or company's hierarchy within your GitHub organization with multiple levels of nested teams. A parent team can have multiple child teams, while each child team only has one parent team. You cannot nest secret teams.

Child teams inherit the parent's access permissions, simplifying permissions management for large groups. Members of child teams also receive notifications when the parent team is at-mentioned (using the ampersand symbol `@`), simplifying communication with multiple groups of people.

### The purpose of enterprises

Enterprise accounts allow owners to centrally manage policy and billing for multiple GitHub.com organizations.

## Overview of typical GitHub administration tasks

Now that you understand the purpose of each hierarchical structure, you can better understand the administrative tasks that are within the purview of Organizations, Teams, and Enterprises.

GitHub administration tasks fall into one of three categories:

- Organization level administration tasks
- Team level administration tasks
- Enterprise level administration tasks

### Organization level administration tasks

At the organization level, members of an organization with the *owner* permission can perform a wide range of activities.  A few of the most important include:

- Invite users to join the organization, as well as remove members from the organization.
- Organize users into a Team, and grant "team maintainer" permissions to organization members.
- Grant repository permission levels to members, and set the base (default) permission level for a given repository.
- Setting up organization security.
- Manage SAML single sign-on for the Organization.
- Set up billing or assign a billing manager for the organization

There are dozens of additional administrative tasks that Organization owners can perform.  For a comprehensive list with links into documentation for each task, see the GitHub Docs article ["Setting up and managing organizations and teams"](https://docs.github.com/free-pro-team@latest/github/setting-up-and-managing-organizations-and-teams?azure-portal=true).

### Team level administration tasks

At the Team level, members of an Organization with the *owner* or *team maintainer* permissions can:

- Create a new team, as well as select or change its parent team.
- Delete or rename a team.
- Add or remove organization members to a team, or synchronize a GitHub team's membership with an Identify Provider group.
- Enable or disable team discussions, where the team can plan together, update one another, or talk about any topic in discussion posts on the team's page in an organization.
- Change the visibility of the team within the organization.
- Manage automatic code review assignment for pull requests, utilizing GitHub's review assignment routing algorithm.

### Enterprise level administration tasks

At the Enterprise level, members of an Enterprise with the *owner* permissions can:

- Enable SAML single sign-on for your enterprise account, allowing each enterprise member to link their external identity on your identity provider (IdP) to their existing GitHub account.
- Add or remove organizations to the Enterprise.
- Set up billing or assign a billing manager for all Organizations in the Enterprise.
- Setup repository management policies, project board policies, team policies, and other security settings that apply to all the Organizations, repositories, and members in the Enterprise.