Implementing GitHub repository permissions in an optimal manner involves finding a proper balance between facilitating collaboration and protecting codebases from abuse and misuse. GitHub supports fine-grained access controls which allow teams to efficiently interact with each other, while maintaining the principles of data privacy, security, and integrity.

The permission model differs depending on the GitHub account type. There are five types of accounts that individuals and organizations can create:

 -  **GitHub Free for personal accounts:** free for individual use, including unlimited collaborators on unlimited public repositories with a full feature set, and on unlimited private repositories with a limited feature set, such as<br>issues and pull requests.
 -  **GitHub Pro:** for professional developers, including unlimited public and private repositories, unlimited collaborators, and advanced code review tools.
 -  **GitHub Free for organizations:** free for organizations, including unlimited collaborators on unlimited public repositories with a full feature set, and on unlimited private repositories with a limited feature set. In addition to the features available with GitHub Free for personal accounts, GitHub Free for organizations offers higher limits of GitHub Actions minutes per month and higher GitHub Packages storage.
 -  **GitHub Team:** for teams, including all the features of GitHub Pro, as well as team and user permissions, code review tools, and advanced tools and features in private repositories.
 -  **GitHub Enterprise:** for enterprise-level organizations, including all the features of GitHub Team, as well as enterprise-level security features such as single sign-on, audit logs, and compliance controls. This plan is self-hosted and can be run on-premises or in a cloud environment (GitHub Enterprise Cloud).

## Repo permissions in GitHub Free for personal accounts

**GitHub Free for personal accounts:** For public repositories, anyone can view and fork the repository. For private repositories, the repository owner has full control over who can access and contribute to the repository, with up to three collaborators allowed. There can be only one owner so ownership permissions can't be shared with another personal account. In addition, in a private repository, repository owners can only grant write access to collaborators. In other words, collaborators can't have read-only access to repositories owned by a personal account.

## Repo permissions in GitHub Pro

GitHub Pro includes all the same repository permission levels as GitHub Free for personal accounts, but with more advanced collaboration features, such as protected branches and code owners.

## Repo permissions in GitHub Free for organizations

GitHub Free for organizations includes the ability to create teams, which can be granted access to specific repositories with different permission levels. Teams can be granted write access or admin access, and custom roles can be created to grant specific permissions to different users or groups.

The default, non-administrative role for users in an organization is the organization member. By default, organization members have a few permissions, including the ability to create repositories.

Other organization roles have elevated permissions to repositories, such as:

 -  **Organization moderators:** hiding comments in public repositories owned by the organization.
 -  **Security managers:** reading all repositories in the organization.
 -  **Owners:** all repository-related permissions, including adding collaborators, as well as writing to and deleting repositories.

Organization owners can set base permissions that apply to all members of an organization when accessing any of its repositories. Base permissions don't apply to outside collaborators. Granting a higher level of access for individual repositories overrides the base permission.

Customized access to repositories can be implemented by assigning built-in repository roles to organization members and outside collaborators. These roles include:

 -  **Read:** Recommended for non-code contributors who want to be able to review the content of the repository.
 -  **Triage:** Recommended for contributors who need to proactively manage issues, discussions, and pull requests without write access.
 -  **Write:** Recommended for contributors who actively push to the repository.
 -  **Maintain:** Recommended for project managers who need to manage the repository without access to sensitive or destructive actions.
 -  **Admin:** Recommended for people who need full privileges, including sensitive and destructive actions like managing security or deleting the repository.

## Repo permissions in GitHub Team

GitHub Team includes all the same repository permission levels as GitHub Free for organizations, with the addition of support for teams and more advanced security features such as authorized IP ranges and enterprise-grade authentication. Teams are groups of organization members. Organization owners and team maintainers can grant teams permission to repositories.

## Repo permissions in GitHub Enterprise Cloud

GitHub Enterprise Cloud is designed for enterprise-level organizations and includes all the features of GitHub Team, as well as enterprise-leve

l security features such as single sign-on, audit logs, and compliance controls. GitHub Enterprise Cloud supports very granular control over repository permissions, including the ability to manage permissions at the branch level.Organization owners can also create custom roles to grant more granular permissions to different users or teams than those available with the built-in read, triage, write, maintain, and admin roles.
