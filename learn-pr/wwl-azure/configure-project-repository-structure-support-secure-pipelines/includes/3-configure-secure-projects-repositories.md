Organizations often have different development teams working on multiple projects and applications.

In our banking institution example, it would be necessary to configure a project and repository structure that supports secure access and permissions to pipelines.

Here, you'll learn about fundamental concepts for giving access and permissions, the benefits of separating a project, how to separate a project into other projects and repositories, and separate secure files between projects.

## Fundamental concepts for giving permissions

With the creation of an organization, collection, or project—Azure DevOps creates a set of default security groups, which are automatically assigned default permissions. Other security groups are defined with the following actions:

- When you create custom security groups at the following levels:

  - Project-level

  - Organization- or collection-level

  - Server-level (on-premises only)

- When you add a team, a team security group is created

### Project-level permissions

Each team added to a project is automatically added as a project-level group. There are several permissions you can set up at the project level, and you can grant them by adding a user or group to the **Project Administrators** group, or you can grant select project-level permissions to a custom security group or to a user.

To manage permissions or groups at the project level, you must be a member of the **Project Administrators** security group. If you created the project, you're automatically added as a member of this group. Users who wish to get added to this group would need to request permissions from a member of the Project Administrators group. Consider adding users to the Project Administrators group when they're tasked with adding or managing teams, area and iteration paths, repositories, service hooks, and service end points.

There are five possible assignments made to a permission. They grant or restrict access as indicated:

- User or group has permissions to perform a task:

  - **Allow**

  - **Inherited allow**

- User or group doesn't have permission to perform a task:

  - **Deny**

  - **Inherited deny**

  - **Not set**

Here's what you need to know about permission settings:

- **Allow** or **Deny** explicitly grants or restricts users from performing specific tasks, and are inherited from group membership.

- **Not set** implicitly denies users the ability to perform tasks that require that permission, but allows membership in a group that does have that permission set to take precedence, also known as **Allow (inherited)** or **Inherited allow** and **Deny (inherited)** or **Inherited deny**.

- For most groups and almost all permissions, **Deny** overrides **Allow**. If a user belongs to two groups, and one of them has a specific permission set to **Deny**, that user isn't able to perform tasks that require that permission even if they belong to a group that has that permission set to **Allow**.

**When assigning permissions:**

**Do:**

- Use Microsoft Entra ID (former Azure Active Directory), Active Directory, or Windows security groups when managing lots of users.

- When adding teams, consider what permissions you want to assign to team leads, scrum masters, and other team members who may need to create and modify area paths, iteration paths, and queries.

- When adding many teams, consider creating a **Team Administrators** custom group where you allocate a subset of the permissions available to **Project Administrators**.

- Consider granting the [work item query folders Contribute.](https://learn.microsoft.com/azure/devops/boards/queries/set-query-permissions) permission to users or groups that require the ability to create and share work item queries for the project.

> [!NOTE]
> Always try to apply the least privilege security concept that requires that users be granted the minimum permissions necessary to perform their job functions. For example, if you want to grant a user the ability to create and modify work item queries, consider granting the **Contribute** permission to the **Work item query folders** permission instead of the **Edit project-level information** permission.

**Don't:**

- Don't add users to multiple security groups that contain different permission levels. In certain cases, a **Deny** permission level may override an **Allow** permission level.

- Don't change the default assignments made to the valid users groups. If you remove or set the **View instance-level information** permission to **Deny** for one of the Valid Users groups, no users in the group are able to access the project, collection, or deployment, depending on the group you set.

- Don't assign permissions that are noted as 'Assign only to service accounts' to user accounts.

You can change the project-level permissions for any project-level group, except the Project Administrators group. This is by design.

You may also change the project-level permissions for a specific user. To restrict select users, you can enable the **Limit user visibility and collaboration to specific projects** preview feature for the organization. Once that is enabled, any user or group added to the **Project-Scoped Users** group, are restricted from accessing the **Organization Settings** pages except for **Overview** and **Projects**, and are restricted to accessing only those projects to which they’ve been added.

> [!NOTE]
> Changing a permission for a group changes that permission for all users who are members of that group. In other words, depending on the size of the group, you might affect the ability of hundreds of users to do their jobs by changing just one permission. So, make sure you understand the impact before you make a change.

### Repository permissions

You can also grant or restrict access to repositories to lock down who can contribute to your source code and manage other features. You can set permissions across all Git repositories by making changes to the top-level **Git repositories** entry. Individual repositories inherit permissions from the top-level **Git Repositories** entry.

As with project permissions, you must be a member of the **Project Administrators** Group or have your **Manage permissions** set to **Allow** for Git repositories.

You set Git repository permissions from **Project Settings > Repositories**. To set the permissions for all Git repositories, choose **Security**. Otherwise, to set permissions for a specific repository, choose the repository and then choose **Security**. To set permissions for a specific group, choose the group. To set permissions for a specific user, enter the name of the user into the search filter and select from the identities that appear. Also, you may enable or disable inheritance for a specific repository.

> [!NOTE]
> Branches inherit a subset of permissions from assignments made at the repository level. You can set permissions for individual users and groups, and inherit and override permissions as needed. Also, you can only add permissions for users and groups already in your Project.

## Benefits of separating a project

Separating projects in Azure DevOps can help to improve security by restricting access to specific users or groups. This way, you can control who has access to sensitive information and ensure that only authorized users are able to view and modify project resources.

This isolation ensures that any issues or security breaches that occur in one project don't affect other projects. This approach to isolation ensures that each project remains secure, even if other projects on the same platform are compromised.

Separating projects also provides an extra layer of protection for sensitive data. This protection is important when working with confidential data, such as personal information, intellectual property, or financial data such as in the financial institution scenario presented in this module.

## Separate a project into team projects

You can separate a project into multiple team projects to organize work and manage permissions and settings for different teams or departments. When you decide to manage each product and team in a separate project, you prevent lateral exposure because you can isolate resources from one another. This way, you can control who has access to sensitive information and ensure that only authorized users are able to view and modify project resources.

## Separate a project into several repositories

As a project administrator, you have the ability to create, delete and rename repositories to store and manage source code. You can create separate repositories for different components of a single project or different team projects. Multiple repositories allow for more granular control over access and permissions, and you can grant different levels of access to different repositories, depending on the role of each developer.

## Separate secure files between different team projects

Secure files allow you to securely store sensitive data, such as secrets, certificates, or keys, that are required for the deployment and operation of your applications or services. This secure and centralized location for storing such files makes it easier to manage access and ensure confidentiality by reducing the risk of sensitive data being accidentally exposed or leaked.

Secure files can be stored in various secure locations such as Azure Key Vault or a Library, or even on the server without having to commit them to a repository (For example, certificates, or SSH keys).

Using Azure resources, access to the files can be controlled through role-based access control (RBAC) or a shared access signature (SAS) token. The contents of the secure files are encrypted and can only be used when you consume them from a task. You can add approvals and checks to them and set pipeline permissions.

If you want to learn more about project and repository security in Azure DevOps, you can read the following articles:

- [Secure access to Azure Repos from pipelines.](https://learn.microsoft.com/azure/devops/pipelines/security/secure-access-to-repos)
- [Set Git repository permissions.](https://learn.microsoft.com/azure/devops/repos/git/set-git-repository-permissions)
- [Set branch permissions.](https://learn.microsoft.com/azure/devops/repos/git/branch-permissions)
