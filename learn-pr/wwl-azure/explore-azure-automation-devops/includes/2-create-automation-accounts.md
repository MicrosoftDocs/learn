To start using **Azure Automation**, you must create an [Automation account](/azure/automation/quickstarts/create-azure-automation-account-portal) from within the **Azure portal**.

Steps to create an **Azure Automation account** are available on the [Create an Azure Automation account](/azure/automation/quickstarts/create-azure-automation-account-portal) page.

**Automation accounts** are similar to **Azure Storage accounts**, serving as a container to store automation artifacts. These artifacts include all your **runbooks**, runbook executions (**jobs**), and the assets on which your runbooks depend.

An **Automation account** allows you to manage all **Azure resources** via an API. To safeguard it, the **Automation account** creation requires subscription-owner access.

:::image type="content" source="../media/create-run-account.png" alt-text="Screenshot of the Add Automation Account blade, with the Yes button for create an Azure Automation account highlighted.":::

## Permissions and requirements

You must be a subscription owner to create the **Run As accounts** that the service creates. If you don't have the proper subscription privileges, you'll see the following warning:

:::image type="content" source="../media/1-2-2-warning-no-permissions-create-azure-run-512ead44.png" alt-text="Screenshot of a warning box alerting the user that they don't have permissions to create an Azure Run As account. The warning includes a link for more information.":::

## Best practices for Automation accounts

You'll need at least one **Azure Automation account** to use **Azure Automation**. However, as a best practice, you should create multiple automation accounts to segregate and limit the scope of access and minimize any risk to your organization.

**Example account structure:**

- **Development account:** Used for testing and developing automation scripts.
- **Production account:** Used for running production workloads.
- **On-premises account:** Used for managing on-premises resources through **Hybrid Runbook Workers**.

You can have up to 30 **Automation accounts** per **Azure subscription**.
