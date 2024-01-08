
In this exercise, you'll investigate Service Hooks.

## Steps

Let's now look at how a release pipeline can communicate with other services by using service hooks.

Azure DevOps can be integrated with a wide variety of other applications. It has built-in support for many applications and generic hooks for working with other applications. Let's look.

1.  Below the main menu for the **Parts Unlimited** project, click **Project Settings**.

    :::image type="content" source="../media/10-01-project-settings-fc61b1a6.png" alt-text="Project settings.":::


2.  In the **Project settings** menu, click **Service hooks**.

    :::image type="content" source="../media/10-02-service-hooks-f021cc6d.png" alt-text="Service hooks.":::


3.  Click **+Create subscription**.

    :::image type="content" source="../media/10-03-available-applications-c0156614.png" alt-text="Available applications.":::


    By using service hooks, we can notify other applications that an event has occurred within Azure DevOps. We could also send a message to a team in **Microsoft Teams** or **Slack**. We could also trigger an action in **Bamboo** or **Jenkins**.

4.  Scroll to the bottom of the list of applications and click on **Web Hooks**.

    :::image type="content" source="../media/10-04-web-hooks-d579cc76.png" alt-text="New web hook.":::


    Suppose the application that you want to communicate with isn't in the list of available application hooks.

    In that case, you can almost always use the **Web Hooks** option as a generic way to communicate. It allows you to make an HTTP POST when an event occurs.

    So, if, for example, you wanted to call an Azure Function or an Azure Logic App, you could use this option.

    To demonstrate the basic process for calling web hooks, we'll write a message into a queue in the Azure Storage account that we have been using.

5.  From the list of available applications, click **Azure Storage**.

    :::image type="content" source="../media/10-05-azure-storage-94b4676d.png" alt-text="Azure Storage.":::


6.  Click **Next**. On the **Trigger** page, we determine which event causes the service hook to be called. Click the drop-down for **Trigger on this type of event** to see the available event types.

    :::image type="content" source="../media/10-06-available-events-03d6a7ea.png" alt-text="Available events.":::


7.  Ensure that **Release deployment completed** is selected, then in the **Release pipeline name** select **Release to all environments**. For **Stage**, select **Production**. Drop down the list for **Status** and see the available options.

    :::image type="content" source="../media/10-07-status-options-947ac990.png" alt-text="Status Options.":::


8.  Ensure that **Succeeded** is selected, then click **Next**.

    :::image type="content" source="../media/10-08-release-trigger-completed-689bd43c.png" alt-text="Release trigger completed.":::


9.  On the **Action** page, enter the name of your Azure storage account.
10. Open the Azure portal, and from the settings for the storage account, copy the value for Key in the **Access keys** section.

    :::image type="content" source="../media/10-09-access-key-e9ef3965.png" alt-text="Access key.":::


11. Back in the **Action** page in Azure DevOps, paste in the key.

    :::image type="content" source="../media/10-10-action-storage-account-and-key-a0c7438f.png" alt-text="Action storage account and key.":::


12. For **Queue name,** enter **deploymentmessages**, then click **Test**.

    :::image type="content" source="../media/10-11-test-succeeded-6fd21392.png" alt-text="Test succeeded.":::


13. Make sure that the test succeeded, then click **Close**, and on the **Action** page, click **Finish**.

    :::image type="content" source="../media/10-12-service-hook-added-37b5f2b4.png" alt-text="Service hook added.":::


## Create a release to test the service hook

Now that you've successfully added the service hook, it's time to test it.

1.  From the **Parts Unlimited** project's main menu, click Pipelines, click **Releases**, then click **Create release**, and in the **Create a new release** pane, enter **Test the queue service hook** for **Release description**, and click **Create**.

    :::image type="content" source="../media/10-13-create-release-to-test-the-hook-d2988fee.png" alt-text="Create a release to test the hook.":::


2.  Click to view the release details.

    :::image type="content" source="../media/10-14-view-release-details-068cb39c.png" alt-text="View release details.":::


3.  If the release is waiting for approval, click to approve it and wait for the release to complete successfully.

    :::image type="content" source="../media/10-15-all-succeeded-2ca6cca1.png" alt-text="All succeeded.":::


## Check the queue contents

1.  In the **Azure portal**, click **Queues** from the **Queue service** section in the blade for the storage account.

    :::image type="content" source="../media/10-16-queues-listed-ac98f61d.png" alt-text="Queues listed.":::


2.  Click to open the **deploymentmessages** queue.
    
    :::image type="content" source="../media/10-17-message-list-42551fc3.png" alt-text="Message list":::
    
    
    > [!NOTE]
    > If you have run multiple releases, you might have various messages.

3.  Click the latest message (usually the bottom of the list) to open it and review the message properties, then close the **Message properties** pane.

    :::image type="content" source="../media/10-18-message-properties-60cfde3c.png" alt-text="Message properties.":::


You've successfully integrated this message queue with your Azure DevOps release pipeline.
