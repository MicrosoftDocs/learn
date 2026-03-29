## Exercise - Generate a read-only SAS link

**Outcome:** A temporary, read-only SAS URL that grants partner access.

### Task 1: Generate the SAS token

Create a Shared Access Signature that grants time-limited access to your file. SAS tokens are the secure way to share cloud resources without exposing storage account keys.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select the storage account you created (for example, **stgpfilexchg**).
3.  In the left menu, under **Data storage**, select **Containers**.
4.  Select the **partner-drop** container.
5.  Select **monthly-report.txt** to open the blob settings.
6.  Select **Generate SAS**.
7.  Under **Permissions**, select **Read** only.
8.  For **Start**, leave the default time.
9.  For **Expiry**, set the time to 10 minutes from now for test validation.
10. Select **Generate SAS token and URL**.
11. Copy the **Blob SAS URL** and save it securely. You'll use this URL in the next exercise.

> [!NOTE]
> **Validation step:** Confirm the SAS URL is generated with **Read**-only permission and a 10-minute expiry.

> [!NOTE]
> Screenshot opportunity: SAS dialog showing read-only permission and expiry time.
