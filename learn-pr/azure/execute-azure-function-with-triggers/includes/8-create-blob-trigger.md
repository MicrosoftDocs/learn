In this unit, we're going to create an Azure function that displays the name and size of a blob when it's created or updated.

## Create a blob trigger

Again, let's continue using our existing Azure Functions application and add a blob trigger.

1. Make sure you are signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. On the Azure portal menu or from the **Home** page, select **All resources**.

1. Select your function app.

1. Point to **Functions**, and select the **plus (+)** icon. The **Add function** panel appears.

1. Select **Azure Blob Storage trigger**.

1. If you see a message saying  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes, so please be patient. Wait until the installation completes before continuing.

1. Leave the **New Function** field set to the default value.

1. Leave the **Path** field set to the default value.

1. Select the _new_ link underneath the **Storage account connection** dropdown. In the **Storage Account** selection dialog that appears, select the storage account for this function app.

1. Once you have returned to the New Function screen, select **Add** to create the function.

## Create a blob container

Now that we've created a blob trigger, let's use the Storage Explorer to create a blob and trigger the function.

1. Open the storage account you used (or created) in a new tab.

    > [!TIP]
    > You can duplicate a tab in most browsers by right-clicking on the tab in question and selecting **Duplicate** from the menu that appears. We want to use a new tab so we can switch between the two services we are working with.

1. In the Azure portal, select **All resources**, search for and select **Storage accounts**, and then filter by the storage name you created.

1. In the **Storage account** page, under **Tools and SDKs**, select the **Storage Explorer (preview)**. A new panel opens where you can work with blobs and files.

Remember that our blob trigger is monitoring only the location described in the **Path** field. By default, our path should be:

```
samples-workitems/{name}
```

We need to create a container called **samples-workitems**.

1. Right-click **BLOB CONTAINERS**, and select **Create blob container**. The **New container** panel appears.

1. Enter **samples-workitems** as the name, leave the **Public access level** field at the default **Private** setting, and select **Create**.

## Turn on your blob trigger

Now that we've created our container to monitor, let's run our function so we can see output when a blob is created.

1. Switch back to the browser tab with your Azure Function (or reopen it).

1. Select your blob trigger. In the left nav panel, under **Developer**, select **Code + Test**.

1. Open the **Logs** tab at the bottom of the screen.

## Create a blob

Our blob trigger is now up and listening for activity. Let's create a blob to see if we get a log message.

1. Switch back to the browser tab with Storage Explorer.

1. In Storage Explorer, select the **samples-workitems** container from the **BLOB CONTAINERS** list.

1. Select **Upload** from the toolbar. The **Upload blob** panel opens.

1. From the **Files** field, select any file from your computer.

1. Select **Upload**.

1. Switch back to the Azure Function tab and check the output logs for a message that displays what file was uploaded. Your blob trigger should automatically execute. Note that if you click the **Test/Run** button, and then select **Run** in the function window, it will likely error due to the default value that is specified in the **Test** request body. You will need to change the path in the request body window to a valid file in order for the test dialog to execute successfully.