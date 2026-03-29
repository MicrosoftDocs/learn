## Validate success

Review the validation steps you completed during the exercises. Confirm that each item below is true before moving on.

-   [ ] The storage account is deployed and the **partner-drop** container is created with **Private** access level.
-   [ ] **monthly-report.txt** is uploaded and visible in the container.
-   [ ] A stored access policy named **partner-read-policy** is created with **Read** permission.
-   [ ] The SAS URL is generated from the stored access policy (permissions inherited, not set manually).
-   [ ] The direct URL (without SAS token) is denied from an unauthenticated incognito session.
-   [ ] The SAS URL displays the file content from the same unauthenticated session.
-   [ ] After deleting the stored access policy, the SAS URL is instantly denied—even before the token's expiry time.
-   [ ] The file still exists in the container after access is revoked—only the access pathway was removed.
-   [ ] A lifecycle management rule named **delete-shared-files** is configured to delete blobs in **partner-drop/** after 30 days.

If any item is not true, return to the relevant exercise and troubleshoot before continuing.
