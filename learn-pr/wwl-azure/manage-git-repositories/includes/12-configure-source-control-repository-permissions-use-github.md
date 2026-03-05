Setting up GitHub repository permissions properly means finding the right balance between helping teams collaborate and protecting code from misuse. GitHub supports detailed access controls that allow teams to work together efficiently while maintaining data privacy, security, and integrity.

The permission model is different depending on what type of GitHub account you have. There are five types of accounts that individuals and organizations can create:

- **GitHub Free for personal accounts** - Free for individual use, including unlimited collaborators on unlimited public repositories with all features, and on unlimited private repositories with limited features like issues and pull requests
- **GitHub Pro** - For professional developers, including unlimited public and private repositories, unlimited collaborators, and advanced code review tools
- **GitHub Free for organizations** - Free for organizations, including unlimited collaborators on unlimited public repositories with all features, and on unlimited private repositories with limited features. Also includes higher limits for GitHub Actions minutes per month and GitHub Packages storage than personal accounts
- **GitHub Team** - For teams, including all GitHub Pro features, plus team and user permissions, code review tools, and advanced tools for private repositories
- **GitHub Enterprise** - For enterprise-level organizations, including all GitHub Team features, plus enterprise-level security features like single sign-on, audit logs, and compliance controls. This plan can be self-hosted on-premises or in a cloud environment (GitHub Enterprise Cloud)

## Repository permissions in GitHub Free for personal accounts

**GitHub Free for personal accounts:** For public repositories, anyone can view and fork the repository. For private repositories, the repository owner has full control over who can access and contribute to the repository, with up to three collaborators allowed. There can be only one owner, so ownership permissions can't be shared with another personal account. Also, in a private repository, repository owners can only give write access to collaborators. In other words, collaborators can't have read-only access to repositories owned by a personal account.

## Repository permissions in GitHub Pro

GitHub Pro includes all the same repository permission levels as GitHub Free for personal accounts, but with more advanced collaboration features, such as protected branches and code owners.

## Repository permissions in GitHub Free for organizations

GitHub Free for organizations includes the ability to create teams, which can be given access to specific repositories with different permission levels. Teams can be given write access or admin access, and custom roles can be created to give specific permissions to different users or groups.

The default, non-administrative role for users in an organization is the organization member. By default, organization members have a few permissions, including the ability to create repositories.

Other organization roles have elevated permissions to repositories, such as:

- **Organization moderators** - Can hide comments in public repositories owned by the organization
- **Security managers** - Can read all repositories in the organization
- **Owners** - Have all repository-related permissions, including adding collaborators, writing to and deleting repositories

Organization owners can set base permissions that apply to all members of an organization when accessing any of its repositories. Base permissions don't apply to outside collaborators. Giving a higher level of access for individual repositories overrides the base permission.

You can customize access to repositories by assigning built-in repository roles to organization members and outside collaborators. These roles include:

- **Read** - Recommended for non-code contributors who want to be able to review the content of the repository
- **Triage** - Recommended for contributors who need to manage issues, discussions, and pull requests without write access
- **Write** - Recommended for contributors who actively push to the repository
- **Maintain** - Recommended for project managers who need to manage the repository without access to sensitive or destructive actions
- **Admin** - Recommended for people who need full privileges, including sensitive and destructive actions like managing security or deleting the repository

## Repository permissions in GitHub Team

GitHub Team includes all the same repository permission levels as GitHub Free for organizations, with the addition of support for teams and more advanced security features such as authorized IP ranges and enterprise-grade authentication. Teams are groups of organization members. Organization owners and team maintainers can give teams permission to repositories.

## Repository permissions in GitHub Enterprise Cloud

GitHub Enterprise Cloud is designed for enterprise-level organizations and includes all the features of GitHub Team, as well as enterprise-level security features such as single sign-on, audit logs, and compliance controls. GitHub Enterprise Cloud supports very detailed control over repository permissions, including the ability to manage permissions at the branch level. Organization owners can also create custom roles to give more detailed permissions to different users or teams than those available with the built-in read, triage, write, maintain, and admin roles.
