## Validate success

Review the validation steps you completed during the exercises. Confirm that each item below is true before moving on.

-   [ ] The storage account is deployed and the **partner-drop** container is created with **Private** access level.
-   [ ] **monthly-report.txt** is uploaded and visible in the container.
-   [ ] The read-only SAS URL is generated with a 10-minute expiry.
-   [ ] The direct URL (without SAS token) is denied from an unauthenticated incognito session.
-   [ ] The SAS URL displays the file content from the same unauthenticated session.
-   [ ] The expired SAS URL returns an authorization error after the expiry time passes.
-   [ ] The file still exists in the container after SAS expiry — only external access was revoked.
-   [ ] The **partner-upload** container is created with **Private** access level.
-   [ ] A write-only SAS is generated with only **Write** and **Create** permissions.
-   [ ] A file is uploaded via Cloud Shell using the write SAS URL.
-   [ ] The uploaded file appears in the **partner-upload** container.
-   [ ] The write SAS URL returns an authorization error when used for reading.

If any item is not true, return to the relevant exercise and troubleshoot before continuing.
