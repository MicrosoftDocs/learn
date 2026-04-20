This guided project focuses on sharing files securely using Azure Blob Storage, shared access signatures (SAS), and lifecycle management.

A shared access signature (SAS) is a token that grants temporary, scoped access to a blob or container without sharing your storage account keys. When you generate a SAS from a stored access policy, the policy acts as a central control point—you can revoke all linked tokens instantly by deleting the policy.

## Scenario

Your internal finance team needs to share monthly reports with an external partner for a short review window. You upload the report to a private container, set up a stored access policy, generate a SAS link from that policy, and then test both sides of the access model—confirming the partner can access the file with the SAS while anonymous access stays blocked. When the review is complete, you revoke access by deleting the policy and configure a lifecycle rule to automatically clean up shared files.

- Exercise 1 - Create a storage account, private container, and upload a file.
- Exercise 2 - Create a stored access policy and generate a SAS link.
- Exercise 3 - Test that SAS access works and direct access is blocked.
- Exercise 4 - Revoke partner access by deleting the stored access policy.
- Exercise 5 - Configure lifecycle management to auto-delete files after 30 days.

:::image type="content" source="../media/overview-architecture.png" alt-text="Diagram showing secure file sharing with private container, stored access policy, SAS token, and lifecycle management." border="false":::

By the end of this project, you can share files securely with time-limited access, revoke that access instantly, and automate cleanup so shared files don't accumulate.

> [!NOTE]
> This is a guided project module where you complete a project by following step-by-step instructions.

## Skilling areas

In this project, you practice skills in the following areas:

**Configure private blob storage**
+ Create a storage account and blob container with private access.
+ Upload files to a container.

**Manage access with stored access policies and SAS**
+ Create a stored access policy on a container.
+ Generate a SAS URL from a stored access policy.
+ Test SAS-based access in an incognito browser window.

**Revoke access and automate cleanup**
+ Delete a stored access policy to instantly invalidate all linked SAS tokens.
+ Verify that revocation blocks access while the file remains intact.
+ Create a lifecycle management rule to auto-delete blobs after a set number of days.

> [!IMPORTANT]
> This project uses the Azure portal for every step. No prior Azure experience is required.
