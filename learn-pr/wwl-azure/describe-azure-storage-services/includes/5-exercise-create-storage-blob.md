## Create a storage account

In this task, you'll create a new storage account.

1.  Sign in to the Azure portal at [https://portal.azure.com](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true)
2.  Select **Create a resource**.
3.  Under Categories, select **Storage**.
4.  Under Storage account, select **Create**.
5.  On the **Basics** tab of the Create a storage account blade, fill in the following information. Leave the defaults for everything else.
    
    | **Setting**          | **Value**                                            |
    | -------------------- | ---------------------------------------------------- |
    | Subscription         | Concierge Subscription                               |
    | Resource group       | Select the resource group that starts with **learn** |
    | Storage account name | Create a unique storage account name                 |
    | Region               | Leave default                                        |
    | Performance          | Standard                                             |
    | Redundancy           | Locally redundant storage (LRS)                      |
6.  On the **Advanced** tab of the Create a storage account blade, fill in the following information. Leave the defaults for everything else.
    
    | **Setting**                                              | **Value** |
    | -------------------------------------------------------- | --------- |
    | Allow enabling anonymous access on individual containers | Checked   |
    
    :::image type="content" source="../media/storage-account-anonymous-containers-5e5f584a.png" alt-text="Screenshot showing how to enable anonymous-access containers on a storage account.":::
    
7.  Select **Review** to review your storage account settings and allow Azure to validate the configuration.
8.  Once validated, select **Create**. Wait for the notification that the account was successfully created.
9.  Select **Go to resource**.

## Work with blob storage

In this section, you'll create a Blob container and upload a picture.

1.  Under **Data storage**, select **Containers**.
    
    :::image type="content" source="../media/storage-account-menu-9472480e.png" alt-text="Screenshot of the Container add section of a storage account.":::
    
2.  Select **+ Container** and complete the information.
    
    | **Setting**         | **Value**                      |
    | ------------------- | ------------------------------ |
    | Name                | Enter a name for the container |
    | Public access level | Private (no anonymous access)  |
3.  Select Create.
    
    > [!NOTE]
    > Step 4 will need an image. If you want to upload an image you already have on your computer, continue to Step 4. Otherwise, open a new browser window and search Bing for an image of a flower. Save the image to your computer.
4.  Back in the Azure portal, select the container you created, then select Upload.
5.  Browse for the image file you want to upload. Select it and then select upload.

    > [!NOTE]
    > You can upload as many blobs as you like in this way. New blobs will be listed within the container.

6.  Select the Blob (file) you just uploaded. You should be on the properties tab.
7.  Copy the URL from the URL field and paste it into a new tab.
    
    You should receive an error message similar to the following.
    
    ```
    <Error>
      <Code>ResourceNotFound</Code>
      <Message>The specified resource does not exist. RequestId:4a4bd3d9-101e-005a-1a3e-84bd42000000</Message>
    </Error>
    
    ```

## Change the access level of your blob

1.  Go back to the Azure portal.
2.  Select Change access level.
3.  Set the Public access level to Blob (anonymous read access for blobs only).
    
    :::image type="content" source="../media/blob-access-level-213a74e6.png" alt-text="Screenshot with Change access level highlighted.":::
    
4.  Select OK.
5.  Refresh the tab where you attempted to access the file earlier.

Congratulations - you've completed this exercise. You created a storage account, added a container to the storage account, and then uploaded blobs (files) to your container. Then you changed the access level so you could access your file from the internet.

<!--- raw content start --->
[!include[](../../../includes/azure-sandbox-cleanup.md)]
<!--- raw content end --->
