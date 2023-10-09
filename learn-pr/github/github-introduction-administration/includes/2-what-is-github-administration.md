As a GitHub administrator, your goal is to keep everything working smoothly for your users. In this unit, you'll learn about the different levels in the GitHub organizational hierarchy and the administration tasks associated with each level.

## Administration at team level

:::image type="content" source="../media/teams.png" alt-text="Screenshot of the organization screen with the Teams tab highlighted.":::

In GitHub, each user is an organization member that you can add to a team. You can create teams in your organization with cascading access permissions and mentions to reflect your company or group's structure. Teams are useful for refining repository permissions on a more granular level and enabling communication and notification between team members.

Additionally, GitHub allows you to sync your teams with identity provider (IdP) groups such as Azure Active Directory (Azure AD). When you synchronize a GitHub team with Azure AD, you can replicate changes to GitHub automatically, which reduces the need for manual updates and custom scripts. You can use Azure AD with team synchronization to manage administrative tasks such as onboarding new members, granting new permissions, and removing member access to the organization.

Members of a team with *team maintainer* or repository *admin* permissions can:

- Create a new team, and select or change the parent team.
- Delete or rename a team.
- Add or remove organization members from a team, or synchronize a GitHub team's membership with an IdP group.
- Add or remove outside collaborators (people who aren't explicitly members of your organization, such as consultants or temporary employees) from team repositories.
- Enable or disable team discussions on the team's page.
- Change the visibility of the team within the organization.
- Manage automatic code review assignment for pull requests, utilizing GitHub's review assignment routing algorithm.
- Schedule reminders.
- Set the team profile picture.

### Best practices for team-level administration 

Creating teams in your organization enables greater flexibility for collaboration and can make it easier to separate repositories and permissions. The following are some best practices for setting up teams on GitHub:

- Create nested teams to reflect your group or company's hierarchy within your GitHub organization.
- Create teams based on interests or specific technology (JavaScript, data science, etc.) to help streamline PR review processes. Individuals can choose to join these teams according to their interests or skills.
- Enable team synchronization between your identity provider (IdP) and GitHub to allow organization owners and team maintainers to connect teams in your organization with IdP groups. When you synchronize a GitHub team with an IdP group, you can replicate changes to GitHub automatically, reducing the need for manual updates and custom scripts. You can use an IdP with team synchronization to manage administrative tasks such as onboarding new members, granting new permissions, and removing member access to the organization.

## Administration at organization level

In GitHub, organizations are shared spaces enabling users to collaborate across many projects at once. Owners and administrators can manage member access to the organization's data and repositories with sophisticated security and administrative features.

Members of an organization with the *owner* permission can perform a wide range of activities at the organization level including:

- Invite users to join the organization and remove members from the organization.
- Organize users into a team, and grant "team maintainer" permissions to organization members.
- Add or remove outside collaborators (people who aren't explicitly members of your organization, such as consultants or temporary employees) to organizational repositories.
- Grant repository permission levels to members, and set the base (default) permission level for a given repository.
- Set up organization security.
- Set up billing or assign a billing manager for the organization.
- Extract various types of information about repositories via the use of custom scripts.
- Apply organization-wide changes such as migrations via the use of custom scripts.

We recommend setting up only one organization for your users and repositories. If specific constraints in your company require you to create multiple organizations, be aware that:

- It isn't possible to duplicate an organization or share configurations between two organizations. This means that you must set up everything from scratch every time you create an organization, which increases the risk of errors in your settings.
- Depending on your software providers' policies, you might incur extra costs if you need to install some applications in multiple organizations.
- Managing multiple organizations is generally more difficult!

## Administration at enterprise level

Enterprise accounts include GitHub Enterprise Cloud and Enterprise Server instances and enable owners to centrally manage policy and billing for multiple organizations.

At the enterprise level, members of an enterprise with the *owner* permissions can:

- Enable SAML single sign-on for their enterprise account, allowing each enterprise member to link their external identity on your identity provider (IdP) to their existing GitHub account.
- Add or remove organizations from the enterprise.
- Set up billing or assign a billing manager for all organizations in the enterprise.
- Set up repository management policies, project board policies, team policies, and other security settings that apply to all the organizations, repositories, and members in the enterprise.
- Extract various types of information about organizations via the use of custom scripts.
- Apply enterprise-wide changes such as migrations via the use of custom scripts.

## Learn more

Read more about [nested teams](https://docs.github.com/organizations/organizing-members-into-teams/about-teams#nested-teams)in GitHub Docs.

