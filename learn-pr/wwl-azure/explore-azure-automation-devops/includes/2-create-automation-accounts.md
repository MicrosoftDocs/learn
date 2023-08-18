To start using the Microsoft Azure Automation service, you must first create an [Automation account](https://azure.microsoft.com/documentation/articles/automation-security-overview/) from within the Azure portal.

Steps to create an Azure Automation account are available on the [Create an Azure Automation account](/azure/automation/quickstarts/create-azure-automation-account-portal) page.

Automation accounts are like Azure Storage accounts in that they serve as a container to store automation artifacts.

These artifacts could be a container for all your runbooks, runbook executions (*jobs*), and the assets on which your runbooks depend.

An Automation account gives you access to managing all Azure resources via an API. To safeguard it, the Automation account creation requires subscription-owner access.

:::image type="content" source="../media/create-run-account-5a4939c8.png" alt-text="Screenshot of the Add Automation Account blade, with the Yes button for create an Azure automation account highlighted.":::


You must be a subscription owner to create the Run As accounts that the service creates.

If you don't have the proper subscription privileges, you'll see the following warning:

:::image type="content" source="../media/1-2-2-warning-no-permissions-create-azure-run-512ead44.png" alt-text="Screenshot of a warning box alerting the user that they don't have permissions to create an Azure Run As account. The warning includes a link for more information.":::


To use Azure Automation, you'll need at least one Azure Automation account.

However, as a best practice, you should create multiple automation accounts to segregate and limit the scope of access and minimize any risk to your organization.

For example, you might use one account for development, another for production, and another for your on-premises environment. You can have up to 30 Automation accounts.
