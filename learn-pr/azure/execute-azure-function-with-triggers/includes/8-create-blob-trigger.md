In this unit, we're going to create an Azure function that displays the name and size of a blob when it's created or updated.

## Create a blob trigger

Let's continue using your existing Azure Functions application and add a blob trigger.

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services** select **All resources**.

1. On the **All resources** page, sort by Type and select your function app.

1. On the Function App page, scroll to **Functions** section and select **Functions**. The **Functions** pane appears for your function app.

1. In the top menu bar, select **Add**. The **Add function** pane appears.

1. Under *Select a template*, Select **Azure Blob Storage trigger**.

1. If you see a message saying  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes, so please be patient. Wait until the installation completes before continuing.

1. Under Template details, let the **New Function** field be set to the default value.

1. Let the **Path** field be set to the default value.

1. Under the **Storage account connection** list box, select _New_. In the **New Storage Account connection** dialog box, select the storage account for this function app, and then select **OK**.

1. In the *Add function* pane, select **Add** to create the function.

## Create a blob container

Now that we've created a blob trigger, let's use Storage Explorer to create a blob and trigger the function.

1. Open the storage account you used (or created) in a new tab.

    > [!TIP]
    > You can duplicate a tab in most browsers by right-clicking the tab and selecting **Duplicate** from the menu. We want to use a new tab so we can switch between the two services we are working with.

1. In the Azure portal, under **Azure services**, select **All resources**, and in the **Filter for any field** enter **Storage account**, and **Enter**. Double-click the storage name you created to open the *Storage account* page.

1. In the middle menu pane, select the **Storage Explorer (preview)**. The **Storage Explorer (preview)** pane appears where you can work with blobs and files.

The blob trigger is monitoring only the location described in the **Path** field. By default, your path should be:

```
samples-workitems/{name}
```

To create a container called **samples-workitems**.

1. Right-click **BLOB CONTAINERS**, and select **Create blob container**. The **New container** pane appears.

1. Enter **samples-workitems** as the name, leave the **Public access level** field at the default **Private** setting, and select **Create**.

## Turn on your blob trigger

Now that we've created our container to monitor, let's run our function so we can see output when a blob is created.

1. Switch back to the browser tab with your Azure Function (or reopen it).

1. Select your blob trigger. In the left menu pane, under **Developer**, select **Code + Test**.

1. Open the **Logs** tab at the bottom of the screen.

## Create a blob

Our blob trigger is now up and listening for activity. Let's create a blob to see if we get a log message.

1. Switch back to the browser tab with Storage Explorer.

1. In Storage Explorer, select the **samples-workitems** container from the **BLOB CONTAINERS** list.

1. Select **Upload** from the toolbar. The **Upload blob** pane opens.

1. From the **Files** field, select any file from your computer.

1. Select **Upload**.

1. Switch back to the Azure Function tab and check the output logs for a message that displays what file was uploaded. Your blob trigger should automatically execute. Note that if you select **Test/Run** from the top menu bar, and then select **Run** in the function pane, it will likely error due to the default value that is specified in the **Test** request body. You will need to change the path in the request body pane to a valid file for the test dialog to run successfully.