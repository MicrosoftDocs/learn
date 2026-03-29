## Clean up resources

Complete these steps to avoid ongoing charges from the resources you created in this project.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

### Remove the policy assignment

Remove the policy assignment before deleting the resource group. Active policy assignments can block deletion of related resources.

1.  In the portal search bar, search for **Policy** and select **Policy**.
2.  In the left menu, select **Assignments**.
3.  Find the **Allowed locations** assignment scoped to **rg-gp-cost-guardrails**.
4.  Select the **...** (ellipsis) menu on the right and select **Delete assignment**.
5.  Select **Yes** to confirm.

### Delete the budget

1.  In the portal search bar, search for **Cost Management + Billing** and select **Cost Management + Billing**.
2.  In the left menu, select **Budgets**.
3.  Find **gp-pilot-budget** in the list.
4.  Select the **...** (ellipsis) menu on the right and select **Delete**.
5.  Select **Yes** to confirm.

### Delete the resource group

Deleting the resource group removes any storage accounts or test resources you created.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-cost-guardrails** from the list.
3.  Select **Delete resource group** from the top menu bar.
4.  In the confirmation field, type **rg-gp-cost-guardrails** and select **Delete**.
5.  In the confirmation dialog that appears, select **Delete** again to confirm.
6.  Wait for the notification that confirms the resource group is deleted.

### Verify cleanup

1.  In the portal search bar, search for **Resource groups** and confirm **rg-gp-cost-guardrails** no longer appears in the list.
2.  In **Policy** > **Assignments**, confirm the **Allowed locations** assignment no longer appears.
3.  In **Cost Management** > **Budgets**, confirm **gp-pilot-budget** no longer appears.
