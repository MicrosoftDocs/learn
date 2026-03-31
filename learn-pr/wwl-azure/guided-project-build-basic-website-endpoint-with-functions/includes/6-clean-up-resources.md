Complete these steps to avoid ongoing charges from the resources you created in this project.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

## Delete the resource group

Deleting the resource group removes the Function App, its backing storage account, and the Application Insights resource.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-functions-endpoint** from the list.
3.  Select **Delete resource group** from the top menu bar.
4.  In the confirmation field, type **rg-gp-functions-endpoint** and select **Delete**.
5.  In the confirmation dialog that appears, select **Delete** again to confirm.
6.  Wait for the notification that confirms the resource group is deleted.

## Delete the Application Insights resource group

When you enabled Application Insights, Azure created a Log Analytics workspace in a separate resource group named **DefaultResourceGroup-{region}** (for example, **DefaultResourceGroup-canadaeast**).

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Look for a resource group matching the **DefaultResourceGroup-{region}** pattern.
3.  Open the resource group and check its contents.
    - If the only resource is the Log Analytics workspace matching the name you noted earlier (check the last four characters), delete the resource group using the same steps as above.
    - If the resource group contains other resources, delete only the Log Analytics workspace that matches your noted name. Select the workspace, select **Delete**, and confirm.

> [!WARNING]
> Do not delete a Log Analytics workspace used by other services in your subscription—doing so would break monitoring for those services.

## Clean up Cloud Shell files

The function project folder you created in Cloud Shell persists across sessions in a storage account. Remove it to avoid leaving unnecessary files behind.

1.  In the Azure portal, select the **Cloud Shell** icon in the top toolbar.
2.  Run the following command to delete the project folder:

    ```bash
    cd ~ && rm -rf func-gp-endpoint
    ```

## Verify cleanup

1.  In the portal search bar, search for **Resource groups** and confirm **rg-gp-functions-endpoint** no longer appears in the list.
2.  Confirm no additional resource groups created for this project remain in the list.
3.  Try browsing to the function endpoint URL you copied earlier. Confirm it no longer responds.
