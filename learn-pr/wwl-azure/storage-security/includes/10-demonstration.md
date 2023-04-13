
Use this Try-This exercise to gain some hands-on experience with Azure.

In this demonstration, we'll explore storage security configurations.

## Task 1: Generate SAS tokens

> [!NOTE]
> This demonstration requires a storage account with a blob container and an uploaded file. For the best results, upload a PNG or JPEG file.

In this task, we'll generate and test a Shared Access Signature.

1.  Open the Azure portal.
2.  Navigate to your **Storage Account**.
3.  Under **Settings,** select **Access keys**.
4.  Explain how Storage Account access keys can be used. Review regenerating keys.
5.  Under **Settings,** select **Shared access signature**.
6.  Explain how an account-level SAS can be used. Review the configuration settings, including **Allowed services**, **Allowed resource type**, **Allowed permissions**, and **Start and expiry date/times**.
7.  Back at the Storage Account page, under **Blob service,** select **Containers**.
8.  Right-click the blob file that you want to share and select **Generate SAS**.
9.  Click **Generate SAS token and URL**.
10. Copy the **Blob SAS URL**. There's a clipboard icon on the far right of the text box.
11. Copy the URL into a browser, and your file should display.

## Task 2: Key Rollover

> [!NOTE]
> Always use the latest version of Azure Storage Explorer.

In this task, we'll use Storage Explorer to test key rollover.

1.  Download and install Azure Storage Explorer - [https://azure.microsoft.com/features/storage-explorer/](https://azure.microsoft.com/features/storage-explorer/)
2.  After the installation, launch the tool.
3.  Review the Release Notes and menu options.
4.  If this is your first time using the tool, you'll need to re-enter your credentials.
5.  After you've been authenticated, you can select the subscriptions of interest. Explain Storage Explorer can also be used for **Local and attached accounts**.
6.  Right-click **Storage Accounts** and select **Connect to Azure storage**. Discuss the various connection options.
7.  Select **Use a storage account name and key**.
8.  In the **portal,** select your storage account.
9.  Under **Settings,** select **Access Keys**. Retrieve the **Storage account name** and **key1** key.
10. In **Storage Explorer**, provide the account and key information, then click **Connect**.
11. Verify that you can navigate to your storage account content.
12. In the **portal** and your storage account.
13. Under **Settings,** select **Access Keys**.
14. Next to **key1** click the **Regenerate** icon.
15. Acknowledge the message that the current key will become immediately invalid and isn't recoverable.
16. In **Storage Explorer,** refresh the storage account.
17. You should receive an error that the server failed to authenticate the request.
18. Reconnect so you can continue with the demonstration.

## Task 3: Storage Access Policies

In this task, we'll create a blob storage access policy.

1.  In the **Portal**, navigate to your Blob container.
2.  Under **Settings**, select **Access Policy**.
3.  Review the two policies: **Storage access policies** and **Blob immutable storage**.
4.  Under **Stored access polices** click **Add policy**.
5.  Create a policy with **Read** and **List** permissions and usable for a restricted period of time.
6.  Under **Blob immutable storage,** click **Add policy**.
7.  Review the two policy types: **Time-based retention** and **Legal hold**.
8.  Create a policy based on time-based retention.
9.  Be sure to **Save** your changes.
10. In Storage Explorer, right-click your container and select **Get shared access signature**.
11. The **Access Policy** drop-down enables you to create a SAS based on a pre-defined configuration.
12. As you have time, show how Storage Explorer can be used to perform security tasks.

## Task 4: Azure AD User Account Authentication

In this task, we will configure Azure AD user account authentication for storage.

1.  In the portal, navigate to and select your blob container.
2.  Notice at the top the authentication method. There are two choices: **Access key** and **Azure AD User Account**. Explain the differences between the two methods.
3.  Switch to **Azure AD User Account**.
4.  You should receive an error stating you don't have access permissions.
5.  Click **Access Control (IAM)**.
6.  Select **Add role assignment**.
7.  Select the **Storage Blob Data Owner** role. Discuss the other storage roles that are shown.
8.  Assign the role to your account and **Save** your changes.
9.  Return to the **Overview** blade.
10. Switch to **Azure AD User Account**.
11. Notice that you're now able to view the container.
12. Take a minute to select **Change access level** and review the **Public access level** choices.

## Task 5: Storage Endpoints (if you haven't already done this in the Network lesson)

> [!NOTE]
> This task requires a storage account and virtual network with subnet. Storage Explorer is also required.

In this task, we'll secure a storage endpoint.

1.  In the **Portal**.
2.  Locate your storage account.
3.  Create a **file share**, and **upload** a file.
4.  Use the **Shared Access Signature** blade to **Generate SAS and connection string**.
5.  Use Storage Explorer and the connection string to access the file share.
6.  Ensure you can view your uploaded file.
7.  Locate your virtual network, and then select a subnet in the virtual network.
8.  Under **Service Endpoints**, view the **Services** drop-down and the different services that can be secured with an endpoint.
9.  Check the **Microsoft.Storage** option.
10. **Save** your changes.
11. Return to your storage account.
12. Select **Firewalls and virtual networks**.
13. Change to **Selected networks**.
14. Add your virtual network and verify your subnet with the new service endpoint is listed.
15. **Save** your changes.
16. Return to the Storage Explorer.
17. **Refresh** the storage account.
18. Verify you can no longer access the file share.
