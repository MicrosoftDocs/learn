In this exercise, we're going to create an Azure Function that displays the name and size of a blob when it's created or updated. 

> [!NOTE]
> To complete this exercise make sure you're logged into the [Azure portal](https://portal.azure.com/) with a valid account.

## Create a blob trigger

Again, let's continue using our existing Azure Function application and add a blob trigger.

1. Hover your mouse over **Functions** and click the plus icon.

    ![Functions hover](../media/4-hover-function.png)

1. Click **Blob trigger**.

1. Select **C#** as the language. 

1. Leave the **Name** as its default value.

1. Leave the **Path** as its default value.

1. Select an existing Azure Storage account or let Azure automatically create a new one by clicking **Create**.

## Download Storage explorer

Now that we created a blob trigger, lets download storage explorer, which will allow us to easily create a blob.

1. Download [Storage explorer](http://storageexplorer.com).

## Connect to your Azure Storage account

We now have Storage explorer downloaded, lets login using the credentials we were supplied.

1. In Storage explorer, select the plug icon on the left-hand navigation menu.

1. Select **Use a storage account name and key**.

1. Click **Next**.

1. In Azure, select **Integrate** located under your blob trigger.

1. Select **Documentation** to expand the view.

1. Copy the **Account Name** and **Account Key**.

1. Back in Storage explorer, paste in the **Account Name** and **Account Key**.

1. Enter a **Display name**. This is the name of the connection in Storage explorer.

1. Click **Next**.

1. Click **Connect**. 

## Create a blob container

We are not connected to our Azure Storage account, however, remember that our blob trigger is only monitoring the location described in the **Path** field. By default, our path should be:

> samples-workitems/{name}

This means we need to create a container called **samples-workitems**.

1. In Storage explorer, expand your storage account. This should be whatever you made your **Display name** during the connection process.

1. Right-click on **Blob Containers** and select **Create blob container**.

1. Enter **samples-workitems**.

## Turn on your blob trigger

Now that we created our container that will be monitored, let’s run our function so we can see output when a blob is created.

1. Select your blob trigger to open the code screen.

1. Click **Run**.

## Create a blob

Our blob trigger is now up and listening for activity. Let’s create a blob to see if we get a log message.

1. In Storage explorer, click the **samples-workitems** container.

1. Click **Upload**. 

1. Click **Upload Files...**.

1. Select any file from your computer.

1. Click **Upload**.

1. Go back to Azure and check your logs for a message displaying what file was uploaded.

## Cleanup

To ensure you don't get charged for this function, make sure you select **Pause** above the log window.

![Pause](../media/4-pause-timer.png)


