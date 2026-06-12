A medallion architecture creates a natural access control boundary: different teams need different layers. Data engineers work in bronze and silver; analysts and business users consume gold. Enforcing those boundaries requires a deliberate approach to permissions and change management.

## Control access by layer

Fabric gives you two levels of access control.

**Workspace and item permissions** control who can see and interact with Fabric items in a workspace. Workspace roles (Admin, Member, Contributor, Viewer) apply to everything in that workspace. Item permissions are more targeted — you can share a specific lakehouse with a colleague without giving them access to the whole workspace.

For stronger layer isolation, you can put each medallion layer in its own workspace. This gives each layer its own capacity, its own role assignments, and a clear ownership boundary. The tradeoff is more workspaces to manage.

**OneLake data access roles** give you granular control within a single lakehouse — without requiring separate workspaces. You can scope a role to specific tables or folders, so a gold layer consumer can query gold tables but can't see bronze or silver. Every lakehouse comes with a built-in `DefaultReader` role that grants all ReadAll users access to all data; modify or delete it to restrict default access.

To configure OneLake security, open the lakehouse and select **Manage OneLake security**. From there, create a role, define its scope, and assign members.

| Approach | When to use |
| --- | --- |
| OneLake data access roles | Teams sharing a workspace who need different table access per layer |
| Separate workspaces per layer | Strong isolation, compliance boundaries, or separate capacity required |

## Manage change with Git

A medallion architecture involves code: pipeline definitions, notebook transformations, and schema definitions that all need to stay in sync. Without version control, a bad deployment can corrupt data mid-layer with no easy way to recover.

Fabric's Git integration connects your workspace to a Git repository, so your notebooks, pipelines, and lakehouse definitions are versioned alongside each other. If a transformation change breaks the silver layer, you can revert to the previous commit. Teams can work in branches and merge changes through a pull request process — the same workflow used for application code.

Deployment pipelines extend this further: you can promote your medallion workspace from development to test to production in a controlled sequence, with the ability to compare environments and catch differences before they reach production data.