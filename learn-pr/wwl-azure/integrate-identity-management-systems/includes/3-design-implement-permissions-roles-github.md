In GitHub personal accounts, organizations, and enterprises, roles play an essential role in managing access to repositories, projects, and settings. The roles facilitate efficient collaboration and effective governance. Personal accounts have a single user having full control over all repositories, while organizations and enterprises offer a more granular model that facilitates delegation of responsibilities aligned with the typical structure of information technology departments.

## Personal GitHub accounts

Personal GitHub accounts have two roles: owner and collaborator. The owner has full control over the account's repositories and can invite collaborators to grant them access to individual private repositories. Accepting an invitation grants both read and write access to the corresponding repository, effectively allowing completing the pull and push tasks. Collaborators can also perform several other repository-related actions such as creating, editing, and deleting comments on commits, submitting pull requests, merging, and closing pull requests, as well as creating and editing releases. It isn't possible to limit private repository permissions assigned to collaborators to read-only.

## GitHub organizations

GitHub organizations offer several built-in roles that provide means for delegating operational responsibilities to individuals and teams. These roles, assigned by organization owners, determine the level of permissions required to perform specific actions within the organization's GitHub ecosystem:

 -  **Organization owners**: Have complete administrative access to the organization. They're responsible for managing all aspects of the organization, including its repositories, teams, settings, and member permissions. It's recommended to limit the number of organization owners but ensure there are at least two for redundancy and contingency reasons.
 -  **Organization members**: Constitute the default non-administrative role for individuals in an organization. By default, they have limited permissions, including the ability to create repositories and projects, without broader, organization-wide privileges.
 -  **Organization moderators**: Are organization members with additional permissions, allowing them to block and unblock non-member contributors, set interaction limits, and hide comments in public repositories owned by the organization. They assist in managing community interactions and maintaining order within the organization's repositories.
 -  **Billing managers**: Are users who have permission to manage the billing settings for the organization, including payment information. This role is intended for scenarios in which organization members don't have access to billing resources.
 -  **Security managers**: Designate an organization-level role that grants permissions to view security alerts, manage code security settings, and access read permissions for all repositories in the organization. This role is beneficial for organizations with dedicated security teams. As of March 2024, Security Managers role is in public beta and subject to change.
 -  **GitHub app managers**: GitHub App managers, typically organization owners, are responsible for managing the settings of GitHub App registrations owned by the organization. They can grant additional users GitHub App manager permissions to manage specific GitHub App registrations' settings. This role doesn't grant users access to install and uninstall GitHub Apps on the organization.
 -  **Outside collaborators**: Outside collaborators are individuals who have access to one or more organization repositories but aren't formal members of the organization. They may include consultants, temporary employees, or external contributors. Outside collaborators have limited access to organization resources and repositories, ensuring data security while allowing necessary access for collaboration.

## GitHub Enterprise organizations

GitHub Enterprise introduces additional roles beyond those available in standard GitHub personal accounts and organizations. These roles are geared within enterprise-level functionality:

 -  **Enterprise owners**: Have full control over the enterprise, including managing administrators, adding or removing organizations, enforcing policies, and managing billing settings.
 -  **Enterprise members**: Are automatically included in organizations owned by the enterprise and can collaborate within these organizations. However, they lack access to enterprise settings and are limited to accessing repositories with the internal visibility within the enterprise.
 -  **Guest collaborators**: Are intended to provide restricted access to the organization’s internal repositories by external vendors and contractors. The restrictions are based on the organization's permission policy.<br>
