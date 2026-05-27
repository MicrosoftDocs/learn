With the platform configured, Alex needs to prepare 200 users for go-live. Before she assigns licenses, she needs to understand which license each person actually needs, and the answer might surprise her. In this unit, you learn how to choose the right license for each role, assign licenses efficiently using groups, and control how users share content within and outside the organization.

## Understand Fabric license types

Two distinct types of licenses work together in Fabric to provide access and compute resources.

Alex already has a **capacity license**, the F64 she purchased. This capacity is shared across the entire organization and provides the compute and storage that Fabric workloads run on. Users don't receive individual capacity licenses. The capacity exists at the tenant level, and workspaces are assigned to it.

**Per-user licenses** determine what each person can create and view. Three types exist, and understanding the differences saves significant costs:

**Fabric free** is automatically assigned the first time a user signs into the Fabric portal, if Fabric is enabled in the tenant. With a Free license, users can create and share non-Power BI Fabric items (lakehouses, notebooks, warehouses, and data pipelines) in workspaces on an F capacity. They can't create Power BI items in shared workspaces. Only in their personal My workspace.

**Power BI Pro** is required for creating and sharing Power BI content like reports and dashboards. Every organization needs at least one Pro user if they use Power BI for reporting. On capacities smaller than F64, users also need Pro to view Power BI content shared with them.

**Power BI Premium Per User (PPU)** provides most Power BI Premium features on a per-user basis. PPU doesn't provision a Fabric capacity. PPU users can't create non-Power BI Fabric items like lakehouses, warehouses, or notebooks without an F capacity backing their workspace.

The most important factor for Contoso is the **F64 threshold**. Because Contoso has an F64 capacity, users with just a Free license can view Power BI reports and dashboards if they have a viewer role on the workspace. On capacities smaller than F64, viewing Power BI content requires Pro or PPU. This changes everything for Alex's license planning.

Alex realizes she doesn't need Pro licenses for the 150 Marketing analysts and Executive viewers who only consume reports on the F64 capacity. She only needs Pro for the 30 data analysts who create and publish Power BI reports. This discovery saves Contoso significant license costs.

| Role | License needed | Reason |
|---|---|---|
| Fabric item creator (lakehouse, notebook, pipeline) | Free | Free license plus F capacity is sufficient for non-Power BI items |
| Power BI report creator | Pro (or PPU) | Required to create and share Power BI content in workspaces |
| Power BI report viewer on F64+ capacity | Free with viewer role | F64 threshold enables free-user viewing of Power BI content |
| Executive viewing dashboards on Contoso's F64 | Free with viewer role | No Pro license needed on F64 or larger capacities |

## Assign licenses

Alex assigns licenses from the **Microsoft 365 admin center**, not the Fabric admin portal. Licensing is an M365 administration responsibility, and Fabric honors the licenses assigned there.

License assignment is typically group-based rather than individual. Alex creates Microsoft Entra ID security groups like "Contoso-Fabric-Pro-Users" and assigns licenses to the groups in the M365 admin center under **Billing > Licenses**. When people join or leave a group, their license is updated automatically. This approach scales efficiently: Alex manages 200 users by managing a handful of groups.

For Fabric Free licenses, Alex doesn't need to pre-assign them. When users first sign into Fabric, if the tenant has Fabric enabled, they automatically receive a Free Fabric license. Alex only needs to explicitly assign Pro licenses to the 30 analysts who create Power BI reports.

The interaction between per-user licenses and **workspace type** (the configuration mode of each workspace) determines what users can actually do. A user with a Pro license in a workspace assigned to an F capacity can create both Power BI items and Fabric items. A user with a Free license in that same workspace can create Fabric items but not Power BI items. The workspace type and the user license work together to grant or restrict capabilities.

## Control how users share and distribute content

With licenses assigned, Alex needs to decide how her users share content. This connects back to the tenant settings she configured earlier, but the focus now is on practical sharing patterns that balance collaboration with governance.

Two main patterns exist for distributing Fabric content. **Workspace apps** provide the recommended pattern for large audiences. When a workspace has an app, workspace admins publish the app to users who don't need workspace access. App consumers get read-only access to reports and dashboards without seeing the underlying workspace contents or work in progress. This pattern works best for finished, production-ready content.

Granting **workspace access** through workspace roles (Admin, Member, Contributor, Viewer) gives users direct access to the workspace and its items. This pattern suits collaboration and development teams. The Viewer role provides read-only access for people who need to see workspace contents without editing. Unlike app consumers, workspace viewers see all items in the workspace, including work in progress.

Alex applies the least-privilege principle: share the read-only app for consumers, and only grant workspace access to people who need to create or edit. The Marketing team has 120 consumers who use reports daily. They get the app. The 30 analysts who build reports get Contributor or Member roles in the workspace.

The Marketing team also wants to share dashboards with external agency partners. Alex reminds the Marketing lead that the tenant settings under **Export and sharing settings** control external sharing. She can enable or disable external sharing and specify which security groups are allowed to share. For external sharing, recipients need the appropriate license, or you must embed the content in an app that handles authentication through Microsoft Entra B2B.

Users are licensed and have the right level of access to workspaces and apps. Alex has balanced broad access for consumers with controlled access for creators. Now she needs to monitor the platform to make sure everything stays healthy after launch. In the next unit, you'll learn how to monitor platform usage and apply governance controls.
