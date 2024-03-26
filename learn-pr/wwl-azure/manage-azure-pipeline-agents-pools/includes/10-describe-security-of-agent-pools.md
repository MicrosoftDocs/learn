Understanding how security works for agent pools helps you control sharing and use of agents.

## Azure Pipelines

In Azure Pipelines, roles are defined on each agent pool. Membership in these roles governs what operations you can do on an agent pool.

> [!NOTE]
> There are differences between **Organization** and **Project** agent pools.

| **Role on an organization agent pool** | **Purpose**                                                                                                                                                                                                                                                                                                                                                                                                                                |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Reader                                 | Members of this role can view the organization's agent pool and agents. You typically use it to add operators that are responsible for monitoring the agents and their health.                                                                                                                                                                                                                                                             |
| Service Account                        | Members of this role can use the organization agent pool to create a project agent pool in a project. If you follow the guidelines above for creating new project agent pools, you typically don't have to add any members here.                                                                                                                                                                                                           |
| Administrator                          | Also, with all the above permissions, members of this role can register or unregister agents from the organization's agent pool. They can also refer to the organization agent pool when creating a project agent pool in a project. Finally, they can also manage membership for all roles of the organization agent pool. The user that made the organization agent pool is automatically added to the Administrator role for that pool. |

The All agent pools node in the Agent Pools tab is used to control the security of all **organization** agent pools.

Role memberships for individual **organization** agent pools are automatically inherited from the 'All agent pools' node.

Roles are also defined on each organization's agent pool. Memberships in these roles govern what operations you can do on an agent pool.

| **Role on a project agent pool** | **Purpose**                                                                                                                                                                                                           |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Reader                           | Members of this role can view the project agent pool. You typically use it to add operators responsible for monitoring the build and deployment jobs in that project agent pool.                                      |
| User                             | Members of this role can use the project agent pool when authoring build or release pipelines.                                                                                                                        |
| Administrator                    | Also, to all the above operations, members of this role can manage membership for all roles of the project agent pool. The user that created the pool is automatically added to the Administrator role for that pool. |

The All agent pools node in the Agent pools tab controls the security of all **project** agent pools in a project.

Role memberships for individual **project** agent pools are automatically inherited from the 'All agent pools' node.

By default, the following groups are added to the Administrator role of 'All agent pools': Build Administrators, Release Administrators, Project Administrators.
