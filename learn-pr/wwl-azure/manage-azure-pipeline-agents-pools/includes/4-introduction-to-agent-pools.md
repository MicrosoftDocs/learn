Instead of managing each agent individually, you organize agents into agent pools. An agent pool defines the sharing boundary for all agents in that pool.

## Agent pool scope

In Azure Pipelines, pools are scoped to the entire organization, allowing you to share agent machines across projects.

**Organization-level pools:** Can be shared across multiple projects
**Project-level pools:** Limited to a single project unless explicitly added to other projects

## Creating and sharing pools

When you create a build or release pipeline, you specify which pool it uses at either the organization or project scope.

**To share an agent pool across multiple projects:**

1. Create an organization-scoped agent pool
2. Add the pool to each project that needs access
3. Choose the organization agent pool when adding an existing pool

**Automatic permissions:** When creating a new agent pool, you can automatically grant access permission to all pipelines, simplifying management for teams.
