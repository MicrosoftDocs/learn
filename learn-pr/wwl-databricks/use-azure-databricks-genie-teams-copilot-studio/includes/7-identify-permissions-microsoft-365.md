You've built the Genie Space. The knowledge store is configured, the tables are selected, and the space is answering questions accurately in the Azure Databricks UI. Now you need to expose it to two external surfaces: **the Databricks app in Teams** and a **Copilot Studio agent**. This unit covers what you need to configure to make both work.

> [!NOTE]
> This unit doesn't cover knowledge store setup—selecting tables, writing instructions, and defining example queries. That configuration is covered in [Configure AI/BI Genie instructions](/training/modules/create-and-organize-objects-in-unity-catalog/configure-ai-bi-genie-instructions).

## Share the Genie Space

First, grant users or groups access to the Genie Space itself. In the Genie Space UI, use the **Share** button to assign one of two permission levels:

- **CAN VIEW:** The user can open the space and chat with it. They can't change space settings or share the space with others.
- **CAN USE:** The user can chat with the space and share it with other users. Appropriate for workspace contributors and team leads.

Assign individuals or Unity Catalog groups. Using groups makes it easier to add users later—anyone added to the group automatically gains access without updating the space directly.

## Grant Unity Catalog data permissions

**Sharing the space doesn't grant data access.** Separately, each user who will interact with the space needs:

1. `SELECT` on every table the Genie Space queries.
2. `CAN USE` on the SQL warehouse assigned to the space.
3. The **consumer access** or **Databricks SQL** entitlement in the workspace.

Grant these at the catalog, schema, or table level in Unity Catalog—whichever scope fits your data model. Unity Catalog inheritance means a grant at the schema level covers all tables within that schema.

## For the Databricks app in Teams

When users connect the Databricks app to their workspace, they authenticate with their own **Entra ID credentials**. Unity Catalog maps those credentials to their Databricks identity and applies their grants automatically. No additional configuration is needed for the data access side—the work is already done through the Genie Space share and the Unity Catalog grants above.

If a user reports that they can query the space in the Databricks UI but get no results in Teams, the most common cause is that the Teams connection is pointing to a different workspace or account than the one where the Genie Space lives.

## For Copilot Studio with OBO flow

The governance unit explains the two authentication modes (OBO and maker-provided) and the risks of each. For the operational setup, OBO requires one of the following before users can authenticate:

- Each user has a **Power Apps connection to Azure Databricks** in your tenant, or
- Your Power Platform admin has enabled **connection parameter sharing** in the Copilot Studio environment.

Without one of these, users can't authenticate and the agent returns no results. Also confirm with your Power Platform admin that the Azure Databricks connector isn't blocked by a data loss prevention (DLP) policy.

## For Copilot Studio with maker-provided credentials

No per-user Power Apps connection is required—queries run as the maker's identity. Verify that the maker's Unity Catalog grants cover exactly the data the agent should expose before publishing the agent.
