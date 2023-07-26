In this unit, we're going to create an Azure function that displays the name and size of a blob when it's created or updated.

## Create a blob trigger

Let's continue using your existing Azure Functions application and add a blob trigger.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you used to activate the sandbox.

1. Under **Azure services**, select **All resources**. The **All resources** pane appears.

1. Select your Function App identified under the *Type* column. Your **Function App** pane appears.

1. On the Function App pane, under **Functions**, select **Functions**. The **Functions** pane appears for your function app.

1. In the top menu bar, select **Create**. The **Create function** pane appears.

1. Under **Select a template**, select **Azure Blob Storage trigger**.

1. If you see a message saying  **Extensions not installed**, select **Install**. Dependency installation can take a couple of minutes. Wait until the installation completes before continuing.

1. Under **Template details**, accept the default value for the **New Function** field.

1. Accept the default value for the **Path** field.

1. Under the **Storage account connection** dropdown list, select the **New** link. In the **New Storage Account connection** dialog box, select the storage account for this function app, and then select **OK**.

1. Select **Create** to create the function.

## Create a blob container

Now that we've created a blob trigger, let's use Storage browser to create a blob and trigger the function.

1. Open the storage account you used (or created) in a new tab.

    > [!TIP]
    > You can duplicate a tab in most browsers by right-clicking the tab and selecting **Duplicate** from the menu. We want to use a new tab so we can switch between the two services we are working with.

1. In the Azure portal, under **Azure services**, select **All resources**. The **All resources** pane appears.

1. Select your storage account identified under the *Type* column. Your **Storage account** pane appears.

1. In the middle menu pane, select the **Storage browser**. The **Storage browser** pane appears where you can work with blobs and files.

The blob trigger is monitoring only the location described in the **Path** field. By default, your path should be:

```
samples-workitems/{name}
```

To create a container called **samples-workitems**:

1. Select **Blob containers**, then select **Add container**. The **New container** pane appears.

1. In the **Name** field, enter *samples-workitems*, accept the default **Private** setting in the **Public access level** field, and then select **Create**.

## Turn on your blob trigger

Now that we've created our container to monitor, let's run our function so we can see output when a blob is created.

1. Switch back to the browser tab with your Azure Function (or reopen it).

1. In the middle menu pane, under **Functions**, select **Functions**. The **Functions** pane appears for your Function App.

1. Select your blob trigger. In the left menu pane, under **Developer**, select **Code + Test**.

1. Expand the **Logs** tab at the bottom of the screen if necessary.

1. Select the **App Insight Logs** drop-down, and then select **Filesystem Logs**. Select **OK** when the **Switching to filesystem based logs...** message displays.

## Create a blob

Our blob trigger is now up and listening for activity. Let's create a blob to see if we get a log message.

1. Switch back to the browser tab with Storage Browser.

1. In Storage Browser, select the **samples-workitems** container from the **Blob containers** list.

1. In the **Authentication method:** link at the top if the list, select **Switch to Access key**.

1. In the top menu bar, select **Upload**. The **Upload blob** pane opens.

1. From the **Files** field, select any file from your computer.

1. Select **Upload**.

1. Switch back to the Azure Function tab and check the output logs for a message that displays which file was uploaded. Your blob trigger should automatically execute. If you select **Test/Run** from the top menu bar, and then select **Run** in the function pane, it might result in an error due to the default value that is specified in the **Test** request body. You'll need to change the path from the *Input* tab in the request **Body** pane to a valid file for the test to run successfully.
