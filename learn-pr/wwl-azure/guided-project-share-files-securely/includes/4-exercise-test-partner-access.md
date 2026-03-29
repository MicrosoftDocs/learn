This guided project consists of the following exercises:

 - Create storage and upload file
 - Create access policy and generate SAS
 - **Test partner access**
 - Revoke partner access
 - Configure lifecycle management

In this exercise, you test both sides of the access model—first confirming that direct access is blocked, then verifying that the SAS URL grants access to the file. This demonstrates the security boundary between public access and token-based access.

This exercise includes the following tasks:

 - Verify direct access is blocked
 - Test SAS access

**Outcome:** SAS access works while direct anonymous access remains blocked.

## Task 1: Verify direct access is blocked

Confirm that the container's private access setting properly prevents unauthorized direct access without a SAS token.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select your storage account (for example, **stgpfilexchg**).
3.  In the left menu, under **Data storage**, select **Containers**.
4.  Select the **partner-drop** container.
5.  Select **monthly-report.txt** to open the blob properties.
6.  Copy the **URL** field (this is the direct blob URL without a SAS token).
7.  Open a new incognito or private browser window.
8.  Paste the direct URL into the address bar and press **Enter**.
9.  Confirm access is denied with an authentication error.

> [!NOTE]
> **Validation step:** Confirm the direct URL (without SAS token) is denied from an unauthenticated session.

## Task 2: Test SAS access

Now verify that the policy-based SAS token grants access to the same file that was just blocked. This simulates how an external partner would securely access the shared file.

1.  In the same incognito window, paste the SAS URL into the address bar and press **Enter**.
2.  Confirm the file content displays in the browser. Because this is a text file, the browser renders it directly instead of downloading it.
3.  Note that you are not signed in but still have access due to the SAS token.
4.  Keep this incognito window open—you'll use it again in the next exercise.

> [!NOTE]
> **Validation step:** Confirm the SAS URL displays the file content from the same unauthenticated incognito session that was just denied direct access.

> [!NOTE]
