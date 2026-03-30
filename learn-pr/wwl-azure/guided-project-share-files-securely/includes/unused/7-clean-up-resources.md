Complete these steps to avoid ongoing charges from the resources you created in this project.

> [!WARNING]
> Resource deletion is permanent. Verify that you're deleting only resources created for this guided project before you proceed.

## Delete the resource group

Deleting the resource group removes the storage account, the **partner-drop** and **partner-upload** containers, and all blobs inside them.

1.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
2.  Select **rg-gp-file-exchange** from the list.
3.  Select **Delete resource group** from the top menu bar.
4.  In the confirmation field, type **rg-gp-file-exchange** and select **Delete**.
5.  In the confirmation dialog that appears, select **Delete** again to confirm.
6.  Wait for the notification that confirms the resource group is deleted.

## Clean up local and shared artifacts

1.  Delete the **monthly-report.txt** file from your local machine if you no longer need it.
2.  Clear any copied SAS URLs from your notes, clipboard, or shared documents. Expired SAS URLs no longer grant access, but removing them is good security hygiene.

## Verify cleanup

1.  In the portal search bar, search for **Resource groups** and confirm **rg-gp-file-exchange** no longer appears in the list.
