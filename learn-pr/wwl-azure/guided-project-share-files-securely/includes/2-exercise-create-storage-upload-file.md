This guided project consists of the following exercises:

 - **Create storage and upload file**
 - Create access policy and generate SAS
 - Test partner access
 - Revoke partner access
 - Configure lifecycle management

In this exercise, you create a storage account with a private container and upload a sample report file. This sets up the secure foundation that you share with an external partner in the following exercises.

This exercise includes the following tasks:

 - Prepare the environment
 - Create the storage account
 - Create the private container
 - Upload the report file

**Outcome:** A private blob container with a report file uploaded.

> [!TIP]
> Pause after each major action and confirm the page status before moving on. This habit prevents compounding mistakes.

## Task 1: Prepare the environment

Set up your Azure environment and prepare the sample file you'll share with a partner.

> [!WARNING]
> This project creates Azure resources that may incur charges. Complete the clean-up unit when you're done to avoid unintended expenses.

1.  Sign in to the [Azure portal](https://portal.azure.com) with an account that has permissions to create storage resources.
2.  In the portal search bar, search for **Resource groups** and select **Resource groups**.
3.  Select **+ Create**.
4.  For **Name**, enter **rg-gp-file-exchange**.
5.  For **Region**, choose your preferred region.
6.  Select **Review + create** and then select **Create**.

## Task 2: Create the storage account

Set up the foundation for blob storage. The storage account holds your blob containers and files with full encryption at rest and in transit.

1.  In the portal search bar, search for **Storage accounts** and select **Storage accounts**.
2.  Select **+ Create**.
3.  On the **Basics** tab, select **rg-gp-file-exchange** as the resource group.
4.  For **Storage account name**, enter a globally unique name such as **stgpfilexchg** followed by your initials and a number.
5.  For **Region**, choose the same region as the resource group.
6.  For **Preferred Storage Type**, select **Azure Blob Storage or Azure Data Lake Storage Gen 2**.
7.  For **Performance**, select **Standard**.
8.  For **Redundancy**, select **Locally-redundant storage (LRS)**.
9.  Select **Review + create** and then **Create**.
10. After deployment, select **Go to resource**.

> [!NOTE]
> **Validation step:** Verify the storage account is deployed. Confirm the storage account name and region match your configuration.

> [!NOTE]
> Each exercise includes validation steps like this one. Track your results as you go — you'll review them all in the validation unit at the end of this module.

## Task 3: Create the private container

Create a container with private access settings. This ensures that even if someone discovers the container URL, they cannot list or access blobs without explicit permissions like a SAS token.

1.  In the left menu, under **Data storage**, select **Containers**.
2.  Select **+ Container**.
3.  For **Name**, enter **partner-drop**.
4.  For **Anonymous access level**, leave **Private (no anonymous access)** selected.
5.  Select **Create**.

> [!NOTE]
> **Validation step:** Confirm the **partner-drop** container is created with **Private** access level.

## Task 4: Upload the report file

Add your file to the container. Once uploaded, only users with explicit permissions or a valid SAS token will be able to download it.

1.  On your local machine, create a text file named **monthly-report.txt** with the following content:

    ```
    Monthly Partner Report
    Status: Complete
    Items processed: 142
    Storage tier: Standard
    Compliance check: Passed
    Next review: Scheduled
    ```

2.  In the Azure portal, select the **partner-drop** container to open it.
3.  Select **Upload**.
4.  Select **Browse for files**, select **monthly-report.txt**, and then select **Upload**.
5.  Confirm **monthly-report.txt** appears in the blob list.

> [!NOTE]
> **Validation step:** Confirm **monthly-report.txt** is uploaded and visible in the **partner-drop** container.

> [!NOTE]
