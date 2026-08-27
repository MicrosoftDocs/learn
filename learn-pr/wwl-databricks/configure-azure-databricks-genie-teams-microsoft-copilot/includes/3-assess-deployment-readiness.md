Assess the complete request path before you change either platform. A readiness review identifies missing ownership, licensing, identity, network, or data prerequisites while the integration is still in Public Preview.

## Confirm the Azure Databricks foundation

Start with the account and workspace that business users connect to.

- **Feature access:** An Azure Databricks account administrator can access the account console and manage account-level previews.
- **Genie access:** Partner-powered AI features are enabled at the account and workspace levels for the target workspace.
- **Workspace access:** Target users are members of the workspace and have an appropriate workspace entitlement, such as consumer access or Databricks SQL access.
- **Governed data:** The data used by the existing Genie Agent is registered in Unity Catalog.
- **Compute:** The agent uses a pro or serverless SQL warehouse with a valid embedded credential from an editor who has `CAN USE` permission.
- **Agent access:** Target users can receive at least `CAN VIEW/CAN RUN` on the Genie Agent and the required Unity Catalog privileges.

The direct Genie One experience and a shared Genie Agent use compute differently. The Teams integration documentation states that Azure Databricks selects a warehouse the user is authorized to access. The Genie Agent documentation states that shared-agent consumers use the editor's embedded compute credential and don't need direct warehouse permission. Confirm the intended Genie scope and current requirements in the target workspace rather than applying one model to both paths.

## Check network and workspace restrictions

The Teams app connects from Azure Databricks control-plane infrastructure. Review these constraints:

- If the workspace uses an IP access list, allow the current Azure Databricks control-plane outbound addresses for the East US 2 region.
- Use the live [Azure Databricks regions, IP addresses, and domains](/azure/databricks/resources/ip-domain-region#outbound) reference. Don't copy address values into long-lived configuration documentation.
- Private Link isn't supported for the Databricks Genie app in Teams.
- Workspace security settings must allow connections to collaboration platforms.
- If the workspace prohibits public collaboration messages, the app supports direct messages only. Channel and group-chat use isn't available.

These requirements can affect architecture approval. A workspace that requires Private Link for every connection doesn't meet the current integration constraints.

## Confirm Microsoft 365 and identity readiness

Identify the administrators and tenant controls needed for installation:

- A Microsoft 365 administrator can acquire the Databricks Genie app from Microsoft Marketplace.
- A Teams administrator can review the app and manage its availability for users and groups.
- A Global Administrator is available if the approved deployment grants organization-wide Microsoft Graph consent through Teams admin center.
- The organization has reviewed whether team owners can grant resource-specific consent (RSC) for apps added to their teams.
- Target users have organizational Microsoft 365 accounts and access to the Microsoft Copilot experience approved by the organization.
- Microsoft Entra consent settings permit the Azure Databricks sign-in flow, or an appropriate administrator can grant consent to the Azure Databricks enterprise application.

The product-specific documentation doesn't state a single Microsoft Copilot license requirement that applies to every Databricks Genie tenant configuration. Verify licensing for the target tenant instead of assuming that app availability proves license eligibility.

## Choose the target deployment scope

Define who should receive the app before installation. For an app-centric management tenant, choose one of these availability scopes:

| Availability | Use when |
|---|---|
| Everyone | Every eligible person in the organization should be able to install and use the app. |
| Specific users or groups | A defined business population should receive access. Guests aren't supported through this assignment option. |
| No one | The app should remain unavailable. |

For Contoso, the designated sales group is the target. This keeps Microsoft 365 access aligned with the group that already has access to the sales Genie Agent and its Unity Catalog data.

## Record the readiness decision

The environment is ready when each control has an owner and the target user population can satisfy both access decisions:

- Microsoft 365 can make the app available to the target users.
- Azure Databricks can authenticate those users and authorize the intended Genie and data resources.

If either decision is unresolved, complete that prerequisite before installing the app.