Instead of managing each agent individually, you organize agents into agent pools.

An agent pool defines the sharing boundary for all agents in that pool.

In Azure Pipelines, agent pools are scoped to the Azure DevOps organization; so, you can share an agent pool across projects.

A project agent pool provides access to an organization agent pool.

When you create a build or release pipeline, you specify which pool it uses.

Pools are scoped to your project, so you can only use them across build and release pipelines within a project.

To share an agent pool with multiple projects, in each of those projects, you can create a project agent pool pointing to an organization agent pool.

While multiple pools across projects can use the same organization agent pool, multiple pools cannot use the same organization agent pool.

Also, each project agent pool can use only one-organization agent pool.
