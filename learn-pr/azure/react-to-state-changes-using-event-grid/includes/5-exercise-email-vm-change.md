You're ready to perform an action based on receiving a published event within your logic app.

You've finished the initial setup of the logic app. You now need to send an email notification that contains details whenever any change occurs to the virtual machines in your resource group.

You're going to learn how to set up a condition that enables the logic app to inspect an event, respond with a logic app action, and send an email.

## Add a condition

First, let's create a condition that runs the logic app whenever a certain event is published. 

1. Select the Logic app you just created. Select **Home**, then **Logic apps**, and then select the Logic app name from the Recent resources list.

1. In the left menu pane, under **Development Tools**, select **Logic app designer**.

1. In the Logic Apps Designer pane for your app, an **Event Grid** trigger **When a resource event occurs** appears. Select **+ New step**.

    :::image type="content" source="../media/5-choose-new-step-condition.png" alt-text="Button for a new logic app step.":::

1. Under **Choose an operation**, in the search box, enter **condition** as your filter. Select **Control**.

1. On the **Actions** tab, select **Condition** *Control*.

    :::image type="content" source="../media/5-select-condition.png" alt-text="Selections for choosing an action.":::

    The Logic app designer adds an empty condition to your workflow, including action paths to follow, based on a true or false condition.

    :::image type="content" source="../media/5-empty-condition.png" alt-text="Empty condition."::: 

1. Select ellipsis on the right side of the **Condition** text box, select **Rename**, and enter **If a virtual machine in your resource group has changed**.

    :::image type="content" source="../media/5-rename-condition.png" alt-text="Selections for renaming a condition.":::

1. In the area under the new name, select the check box under **And** to generate a checkmark, and then select the **Choose a value** box. In the Dynamic content list, select the **Expression** tab.

    :::image type="content" source="../media/5-condition-choose-expression.png" alt-text="Selections for choosing an expression as a value.":::

1. In the expression editor, enter `triggerBody()?['data']['operationName']`, and select **OK**.

    :::image type="content" source="../media/5-condition-add-data-operation-name.png" alt-text="Entered expression for a data operation.":::

1. Leave the middle box as **is equal to**, select the right box, and enter `Microsoft.Compute/virtualMachines/write`.

    :::image type="content" source="../media/5-complete-condition.png" alt-text="Completed condition."::: 

1. In the **Logic app designer** menu bar, select **Save**.

## Send an email notification

Next, we'll add an email action based on the logic app being triggered. The following steps use the Office 365 Outlook action. If you don't have an Office 365 account, you can also use Outlook.com or Gmail. The configuration for these may be slightly different, so you may need to adjust accordingly.

1. In the condition's **True** box, select **+Add an action**.

    :::image type="content" source="../media/5-condition-true-add-action.png" alt-text="Add an action button.":::

1. In the search box under **Choose an operation**, enter **send an email** as your filter, and select the **Office 365 Outlook** provider.

    :::image type="content" source="../media/5-logic-app-send-email.png" alt-text="Selections for sending an email action.":::

1. If you don't already have a connection for your email provider, sign in to your email account when you're asked for authentication.

1. On the action's title bar to the right, rename the action to **Send email when virtual machine updated**.

    :::image type="content" source="../media/5-send-email-vm-update.png" alt-text="Selections for sending an email when vm updates.":::

1. Select each box in the email form, and on the **Dynamic content** tab, search for and select the appropriate content type according to the following screenshot, adding text to label the items in the email body. In the *To* box, add your own email address to test the workflow in the next section.

    :::image type="content" source="../media/5-logic-app-empty-email-action.png" alt-text="Selections for adding a subject as a dynamic email field.":::

1. Your email action should look similar to the following. If you selected a different email account type (Outlook.com or Gmail), your inputs might be different.

    :::image type="content" source="../media/5-logic-app-send-email-details.png" alt-text="Email action view.":::

1. Your finished logic app should now look similar to the following screenshot.

    :::image type="content" source="../media/5-logic-app-completed.png" alt-text="View of a finished logic app.":::

1. Select **Save** to save your logic app.

## Test your workflow

You've created and configured a logic app to listen for virtual machine events and send an email notification. Event details are dynamically written into the body of the email.

The final step is to test the complete workflow.

1. In the search bar at the top of the Azure portal, search for **vm1**, and select the virtual machine in the results.

1. In the left menu pane, under **Settings**, select **Size**.

1. Select a new size of **DS2_v2** for the virtual machine, and then select **Resize**. 

1. Wait to be notified that your virtual machine has been resized, allowing time for the email to be generated and processed. After a few minutes, you should receive an email that looks similar to the following:

    :::image type="content" source="../media/5-email.png" alt-text="Email notification example":::
