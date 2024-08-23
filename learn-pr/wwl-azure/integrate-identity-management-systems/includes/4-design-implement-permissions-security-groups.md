Azure DevOps access control model offers highly customizable and granular protection against unauthorized use, suitable to accommodate the principle of least privilege. It relies on several interconnected functional areas including membership in built-in and custom security groups, inherited and explicit permissions assigned at organizational, project, and object scope, and access levels. Understanding these functional areas and their dependencies is essential for efficiently designing and implementing permissions within Azure DevOps.

## Access control model

The effective permissions are derived through a combination of three main authorization mechanisms:

 -  **Membership management**: Involves adding security principals to built-in or custom Azure DevOps groups, each associated with specific set of permissions. Azure DevOps groups can include users, other Azure DevOps groups, and (in Azure DevOps organizations integrated with Microsoft Entra ID), Entra groups.
 -  **Permission management**: Controls access to specific functional tasks at various levels of the system, such as organization, project, or object. Object-level permissions allow setting permissions on such entities as dashboards, wikis, area paths, shared queries and query folders, pipelines, deployment groups, git repositories and branches, as well as artifacts and feeds. Permissions support explicit and inherited allow and deny. Role-based assignments manage additional permissions, such as team administration and pipeline resource roles. Permissions can be assigned to Azure DevOps groups or users, but not directly to Microsoft Entra ID groups.
 -  **Access level management**: Relies on the user license to determine the visibility of web portal features. Users can be assigned access levels of Stakeholder, Basic, Basic + Test Plans, or Visual Studio Enterprise, depending on the licenses assigned to them. Note that setting the access level for users or groups doesn't provide them with access to a project or the web portal. Only users or groups added to the relevant Azure DevOps groups can connect to the web portal and access the corresponding organization, project, or object level features.

The following security groups are defined by default for each project and organization.

 -  Organization
     -  Project Collection Administrators
     -  Project Collection Build Administrators
     -  Project Collection Build Service Accounts
     -  Project Collection Proxy Service Accounts
     -  Project Collection Service Accounts
     -  Project Collection Test Service Accounts
     -  Project Collection Valid Users
     -  Project-Scoped Users
     -  Security Service Group
 -  Project
     -  Build Administrators
     -  Contributors
     -  Project Administrators
     -  Project Valid Users
     -  Readers
     -  Release Administrators
     -  &lt;Project\_Name&gt; Team (where &lt;Project\_Name&gt; designates the name of the project)

Most Azure DevOps users are added to the Contributors security group and granted Basic access level. The Contributors group provides by default read and write access to the primary DevOps capabilities, including repositories, work tracking, and pipelines. Basic access provides access to all features and tasks for using Azure Boards, Azure Repos, Azure Pipelines, and Azure Artifacts. Users who need to be able to manage Azure Test Plans must be granted the Basic + Test Plans access level.

When you add accounts of users to an Azure DevOps security group, they're automatically added to one of the valid user groups.

 -  **Project Collection Valid Users**: All members added to an organization-level group.
 -  **Project Valid Users**: All members added to a project-level group.

The default permissions assigned to these groups are primarily limited to read access, such as View build resources, View project-level information, and View collection-level information.

## Design and implementation

To design and implement an optimal access control model in Azure DevOps that enhances security while minimizing the management and maintenance overhead, use the following guidance:

1.  **Plan Microsoft Entra ID groups**: Utilize Microsoft Entra ID groups to manage user access, rather than adding users directly to Azure DevOps groups. Create groups based on team roles, project requirements, and access level. Consider the permissions needed for different teams and organize Microsoft Entra ID groups accordingly.
2.  **Automate associating Microsoft Entra ID groups to Azure DevOps groups**: Use Azure DevOps group rules to automatically associate Microsoft Entra ID groups with Azure DevOps groups. Configure group rules to map Microsoft Entra ID groups to project-level Azure DevOps groups and assign the appropriate access level.
3.  **Consider using default Azure DevOps groups**: Avoid creating custom groups unless the default ones do not meet your requirements. Do not modify permissions of the default groups. If you define custom groups, avoid using explicit Deny.
4.  **Delegate management**: If users are tasked with managing project-level features such as, teams, area and iteration paths, repositories, service hooks, and service end points, then consider adding them to the Project Administrators group. If users are tasked with managing organization -level features, such as, projects, policies, processes, retention policies, agent and deployment pools, and extension, consider adding them to the Project Collection Administrators group.
5.  **Review and test permissions**: Regularly review and test permissions to ensure that users have the appropriate level of access to resources. Conduct access reviews, audit logs, and security assessments to identify and remediate any security vulnerabilities or misconfigurations.
6.  **Monitor and audit access**: Monitor user activity, track changes, and audit access to Azure DevOps resources using built-in logging and monitoring features. Use Azure DevOps audit streaming and reporting capabilities to monitor user actions, detect unauthorized access attempts, and investigate security incidents.
