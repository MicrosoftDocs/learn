## Clean up resources

Complete these steps to remove the resources and identities you created in this project.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

### Delete the resource group

Deleting the resource group removes all resources and RBAC role assignments scoped to it.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-access-model** from the list.
3.  Select **Delete resource group** from the top menu bar.
4.  In the confirmation field, type **rg-gp-access-model** and select **Delete**.
5.  In the confirmation dialog that appears, select **Delete** again to confirm.
6.  Wait for the notification that confirms the resource group is deleted.

### Delete the user and group

1.  In the portal search bar, search for **Microsoft Entra ID** and select **Microsoft Entra ID**.
2.  In the left menu under **Manage**, select **Users**.
3.  Find and select **Alex Guided Project**.
4.  Select **Delete** from the top menu bar and confirm the deletion.
5.  In the portal search bar, search for **Microsoft Entra ID** and select **Microsoft Entra ID**.
6.  In the left menu under **Manage**, select **Groups**.
7.  Select **All groups**.
8.  Find and select **gp-rg-readers**.
9.  Select **Delete** from the top menu bar and confirm the deletion.

### Disable Temporary Access Pass (if enabled)

> [!NOTE]
> Only complete this section if you enabled Temporary Access Pass during this project. If TAP was already enabled in your tenant before you started, skip this section.

1.  In the portal search bar, search for **Authentication methods** and select **Authentication methods** (under Microsoft Entra ID).
2.  Select **Policies**.
3.  Select **Temporary Access Pass**.
4.  Set **Enable** to **Off**.
5.  Select **Save**.

### Verify cleanup

1.  In the portal search bar, search for **Resource groups** and confirm **rg-gp-access-model** no longer appears in the list.
2.  In **Microsoft Entra ID** > **Users**, confirm the user account no longer appears.
3.  In **Microsoft Entra ID** > **Groups**, confirm **gp-rg-readers** no longer appears.
