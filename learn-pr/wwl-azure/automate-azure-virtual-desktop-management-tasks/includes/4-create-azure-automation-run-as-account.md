Now that you have an Azure Automation account, you'll also need to set up a [managed identity](/azure/automation/automation-security-overview#managed-identities) if you haven't already. Managed identities will help your runbook access other Azure AD-related resources as well as authenticate important automation processes.<br>

To set up a managed identity, follow the directions in [Using a system-assigned managed identity for an Azure Automation account](/azure/automation/enable-managed-identity-for-automation).

> [!IMPORTANT]
> Azure Automation Run As Account will retire on September 30, 2023 and will be replaced with Managed Identities. Before that date, you'll need to start migrating your runbooks to use [managed identities](/azure/automation/automation-security-overview#managed-identities). For more information, see [migrating from an existing Run As accounts to managed identity](/azure/automation/migrate-run-as-accounts-managed-identity?tabs=run-as-account#sample-scripts) to start migrating the runbooks from Run As account to managed identities before 30 September 2023.
