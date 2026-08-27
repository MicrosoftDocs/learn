Prepare the Azure Databricks account and workspace before the Microsoft 365 administrator installs the app. These settings determine whether the managed integration can connect and which users can authenticate.

## Enable the account-level preview

The Databricks Genie app in Teams is an account-level Public Preview feature. An account administrator enables it from the Azure Databricks account console:

1. Sign in to the Azure Databricks [account console](https://accounts.azuredatabricks.net/).
2. Open **Previews**.
3. Locate **Databricks Genie for Microsoft Teams**.
4. Enable the preview for the account.

:::image type="content" source="../media/databricks-account-preview.png" alt-text="Screenshot of the account console showing the Databricks Genie for Microsoft Teams preview.":::

Enabling the preview permits use of the integration. It doesn't add users to a workspace, share a Genie Agent, grant Unity Catalog privileges, or install anything in Microsoft 365.

## Confirm partner-powered AI access

Genie uses partner-powered AI features. An account administrator can permit or restrict these features across the account, and workspace settings can apply an additional restriction.

1. Review the account setting for **Partner-powered AI features**.
2. Confirm that the account policy permits the feature for the target workspace.
3. In the target workspace, confirm that the workspace setting permits partner-powered AI features.
4. Review geography and compliance requirements for the models used by Genie.

:::image type="content" source="../media/databricks-account-settings.png" alt-text="Screenshot of the Azure Databricks account console showing partner-powered AI feature settings.":::

If the account or workspace disables partner-powered AI features, users might still see the Genie navigation entry but can't access Genie Agents. Use [Partner-powered AI features](/azure/databricks/databricks-ai/partner-powered) to review the current hosting and geography behavior.

## Configure collaboration-platform access

Workspace security settings control whether external collaboration surfaces can use the workspace and whether channel responses can be public.

1. Open the target workspace as a workspace administrator.
2. Open the workspace security settings.
3. Enable **Allow connection to collaboration platforms**.
4. Decide whether to enable **Allow public messages in collaboration platforms**.

:::image type="content" source="../media/databricks-workspace-security-settings.png" alt-text="Screenshot of Azure Databricks workspace settings for connections and public messages.":::

The public-message setting affects more than response formatting. If public messages are disabled, Teams channels and group chats don't work with the app. Users can use direct messages only.

Select the setting based on the organization's collaboration policy and the sensitivity of expected questions. Unity Catalog still controls source-data access, but a public response can expose an authorized user's returned result to other channel members.

## Assign workspace access and entitlements

Each business user authenticates to Azure Databricks. Add the target users through the organization's established identity and group-management process, then assign the entitlement required for their Genie experience.

For an existing shared Genie Agent, users need either consumer access or the Databricks SQL workspace entitlement. Consumer access provides a limited workspace experience for business users. The data team members who edit the agent need the Databricks SQL entitlement.

:::image type="content" source="../media/databricks-workspace-identity-access.png" alt-text="Screenshot of the Azure Databricks dialog for adding a user to an account and workspace.":::

Keep entitlement assignment group-based where possible. Align the Azure Databricks group with the Microsoft 365 group selected for app availability. Group alignment reduces situations where a person can find the app but can't enter the workspace.

## Validate the SQL warehouse foundation

An existing Genie Agent requires a pro or serverless SQL warehouse. The person who configures the agent's default warehouse needs at least `CAN USE` on that warehouse. Their compute credential becomes embedded in the agent and provides compute access for shared-agent users.

Confirm these conditions:

- The selected warehouse is a pro or serverless SQL warehouse.
- The warehouse is available in the target workspace.
- The editor who last saved the warehouse selection still has valid access.
- The warehouse sizing and availability policy fit the expected business-user workload.

:::image type="content" source="../media/databricks-genie-agent-details.png" alt-text="Screenshot of the Azure Databricks Edit agent details dialog with the warehouse selection.":::

The Teams app doesn't let an administrator or user select a SQL warehouse. Azure Databricks chooses compute according to the active Genie scope and the permissions that apply to it.

## Accommodate IP access lists

If the workspace enforces an IP access list, add the Azure Databricks control-plane outbound addresses for East US 2. Use the live outbound section of [Azure Databricks regions, IP addresses, and domains](/azure/databricks/resources/ip-domain-region#outbound) because address ranges can change.

> [!IMPORTANT]
> Private Link isn't supported by this integration. An environment that requires Private Link for this connection isn't ready for the Databricks Genie app in Teams.

At this point, the account and workspace accept the integration, users can authenticate, and the required compute foundation exists. The next step validates the separate agent and data-authorization path.