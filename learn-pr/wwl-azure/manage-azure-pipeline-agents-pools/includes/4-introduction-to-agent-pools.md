Instead of managing each agent individually, you organize agents into agent pools. An agent pool defines the sharing boundary for all agents in that pool.

In Azure Pipelines, pools are scoped to the entire organization so that you can share the agent machines across projects.

If you create an Agent pool for a specific project, only that project can use the pool until you add the project pool into another project.

When creating a build or release pipeline, you can specify which pool it uses, organization, or project scope.

Pools scoped to a project can only use them across build and release pipelines within a project.

To share an agent pool with multiple projects, use an organization scope agent pool and add them in each of those projects, add an existing agent pool, and choose the organization agent pool. If you create a new agent pool, you can automatically grant access permission to all pipelines.
