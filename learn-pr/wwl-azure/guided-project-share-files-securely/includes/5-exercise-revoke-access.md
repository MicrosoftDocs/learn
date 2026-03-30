This guided project consists of the following exercises:

 - Create storage and upload file
 - Create access policy and generate SAS
 - Test partner access
 - **Revoke partner access**
 - Configure lifecycle management

In this exercise, you revoke the partner's access by deleting the stored access policy. This instantly invalidates all SAS tokens generated from the policy—even those that haven't expired yet. You then confirm the file itself is still safely stored.

This exercise includes the following tasks:

 - Confirm SAS still works
 - Delete the stored access policy
 - Verify access is revoked
 - Confirm the file still exists

**Outcome:** Deleting the stored access policy instantly revokes all SAS tokens generated from it.

The partner has finished reviewing the file. Instead of waiting for the SAS token to expire on its own, you'll revoke access immediately by deleting the stored access policy. Every SAS token linked to that policy stops working the moment the policy is deleted—even if the token's expiry time hasn't passed yet.

## Task 1: Confirm SAS still works

Before revoking, verify that the SAS URL is still active so you can see the before-and-after contrast.

1.  In the incognito window you kept open, refresh the SAS URL.
2.  Confirm the file content still displays. The SAS token is still valid.

> [!NOTE]
> If you closed the incognito window, open a new one and paste the SAS URL.

## Task 2: Delete the stored access policy

Remove the policy to instantly revoke all SAS tokens that were generated from it.

1.  Return to the Azure portal in your main browser window.
2.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
3.  Select your storage account (for example, **stgpfilexchg**).
4.  In the left menu, under **Data storage**, select **Containers**.
5.  Select the **partner-drop** container.
6.  In the left menu, under **Settings**, select **Access policy**.
7.  Under **Stored access policies**, select the **...** (more options) menu next to **partner-read-policy**.
8.  Select **Delete**.
9.  Select **Save** at the top of the page.

> [!IMPORTANT]
> You must select **Save** after deleting the policy. The revocation takes effect only after saving.

> [!NOTE]
> **Validation step:** Confirm **partner-read-policy** no longer appears in the stored access policies list.

## Task 3: Verify access is revoked

Test the same SAS URL to confirm it no longer works—even though the token's expiry time hasn't passed.

1.  Return to the incognito window.
2.  Refresh the SAS URL.
3.  Confirm access is now denied with an authorization error.

> [!NOTE]
> **Validation step:** The SAS URL that worked moments ago now returns an authorization error. Deleting the policy revoked access instantly.

## Task 4: Confirm the file still exists

Verify that revoking SAS access only removed the external pathway—the file itself is untouched.

1.  Return to the Azure portal in your main browser window.
2.  Navigate to the **partner-drop** container.
3.  Confirm **monthly-report.txt** still exists in the container.
4.  Close the incognito window.

> [!NOTE]
> **Validation step:** The file remains in the container. Revoking SAS access doesn't delete data—it only removes the access pathway.