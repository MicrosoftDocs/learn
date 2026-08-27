Business users can ask questions about governed Azure Databricks data without leaving Microsoft Teams or Microsoft Copilot. Before they can use that experience, administrators must prepare Azure Databricks, review the app's permissions, and make the Databricks Genie app available in Microsoft 365.

## Scenario

Contoso has an existing Genie Agent for sales data. The data team has already defined the agent's source tables and business terminology. Business users now need to access that agent from the collaboration tools they use every day.

As the system engineer responsible for the integration, you coordinate several administrative boundaries. Azure Databricks account and workspace settings control whether the integration can connect. Unity Catalog controls which data each person can query. Microsoft 365 and Microsoft Entra controls determine who can use the app and which permissions it receives.

Your goal is to make the experience available without granting new data privileges. A successful configuration preserves each user's Azure Databricks identity and Unity Catalog permissions when they ask questions from Teams or Microsoft Copilot.

## What this module covers

This module guides you through the managed Databricks Genie marketplace integration. You learn how to:

- Identify the components, identities, and administrative roles involved in the integration.
- Check Azure Databricks, Microsoft 365, identity, and network prerequisites.
- Prepare workspace settings and user entitlements.
- Validate an existing Genie Agent and its governed data path.
- Review the app's Microsoft permissions and consent requirements.
- Deploy the app to selected users and configure its Teams scopes.

This module doesn't cover creating or tuning a Genie Agent, building a custom Teams app, connecting through Power Platform, or building an agent in Microsoft Copilot Studio.

> [!IMPORTANT]
> The Databricks Genie app in Microsoft Teams is in Public Preview. Features, requirements, and administrative interfaces can change before general availability. Confirm current requirements in the [Databricks Genie app in Microsoft Teams documentation](/azure/databricks/integrations/msft-teams) before you configure a production tenant.