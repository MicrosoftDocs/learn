In this unit, we're going to create an Azure function that displays the name and size of a blob when it's created or updated.

## Create a blob trigger

Again, let's continue using our existing Azure Functions application and add a blob trigger.

1. Make sure you are signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Navigate to the **All resources** screen and select your function app.

1. Point to **Functions** and select the plus (+) icon.

1. Select **Blob trigger**.

1. If you see a message saying  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes, so please be patient. Wait until the installation completes before continuing.

1. Leave the **Name** set to the default value.

1. Leave the **Path** set to the default value.

1. Select the _new_ link next to the **Storage account connection** dropdown. In the **Storage Account** selection dialog that appears, select the storage account for this function app.

1. Once you have returned to the New Function screen, select **Create** to create the function.

## Create a blob container

Now that we've created a blob trigger, let's use the Storage Explorer to create a blob and trigger the function.

1. Open the storage account you used (or created) in a new tab.

    > [!TIP]
    > You can duplicate a tab in most browsers by right-clicking on the tab in question and selecting **Duplicate** from the menu that appears. We want to use a new tab so we can switch between the two services we are working with.

1. Select **Storage accounts** in the sidebar, or select **All resources** in the sidebar and then filter by the name.

1. Click on the **Storage Explorer (preview)** section - this will open a new panel where you can work with blobs and files.

Remember that our blob trigger is monitoring only the location described in the **Path** field. By default, our path should be:

> samples-workitems/{name}

We need to create a container called **samples-workitems**.

1. Right-click **BLOB CONTAINERS** and select **Create Blob Container**.

1. Enter **samples-workitems** as the name, leave the access level at the default **Private** setting, and select **OK**.

## Turn on your blob trigger

Now that we've created our container to monitor, let's run our function so we can see output when a blob is created.

1. Switch back to the browser tab with your Azure Function (or reopen it).

1. Select your blob trigger to open the code screen.

1. Open the **Logs** tab at the bottom of the screen.

## Create a blob

Our blob trigger is now up and listening for activity. Let's create a blob to see if we get a log message.

1. Switch back to the browser tab with Storage Explorer.

1. In Storage Explorer, select the **samples-workitems** container from the **BLOB CONTAINERS** list.

1. Select **Upload** from the toolbar.

1. Select any file from your computer.

1. Under **Authentication type**, select **SAS**.

1. Select **Upload**.

1. Switch back to the Azure Function tab and check the output logs for a message that displays what file was uploaded. Your blob trigger should automatically execute. Note that if you click the **Run** button in the function window, it will likely error due to the default value that is specified in the **Test** request body. You will need to change the path in the request body window to a valid file in order for the test dialog to execute successfully.