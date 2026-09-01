This module explains how to configure the administrative foundation that makes governed Azure Databricks data available through Databricks Genie in Microsoft Teams and Microsoft Copilot.

## What you learned

- **Architecture and ownership:** The Teams marketplace app connects Microsoft collaboration surfaces to Genie One. SQL warehouses provide compute, while Unity Catalog evaluates data access with each signed-in user's identity.
- **Deployment readiness:** Azure Databricks preview, partner-powered AI, entitlements, compute, network rules, Microsoft 365 app controls, and consent authority must be ready before installation.
- **Workspace preparation:** Account and workspace administrators enable the integration, configure collaboration visibility, assign user entitlements, and accommodate supported network access.
- **Governed agent access:** A shared Genie Agent uses an editor's embedded credential for compute and the business user's Unity Catalog identity for data. Agent ACLs and least-privilege data grants remain separate controls.
- **Permission review:** Microsoft Graph permissions, Teams resource-specific consent, Azure Databricks sign-in consent, and the non-Microsoft data boundary require separate review.
- **Deployment and configuration:** App-centric management defines who can use the app. Workspace, channel-wide, and personal settings determine the Azure Databricks destination and response visibility.

## Learn more

- [Databricks Genie app in Microsoft Teams](/azure/databricks/integrations/msft-teams)
- [Databricks Genie on Microsoft 365 Copilot](/azure/databricks/integrations/msft-m365-copilot)
- [Create and manage a Genie Agent](/azure/databricks/genie-agents/set-up)
- [Partner-powered AI features](/azure/databricks/databricks-ai/partner-powered)
- [Manage access to Teams apps with app-centric management](/microsoftteams/app-centric-management)
- [Grant and manage consent to Teams app permissions](/microsoftteams/manage-consent-app-permissions)
- [Grant tenant-wide admin consent to an application](/entra/identity/enterprise-apps/grant-admin-consent)

> [!IMPORTANT]
> The Databricks Genie app in Microsoft Teams is in Public Preview. Recheck the integration documentation before deployment because requirements and administrative interfaces can change.