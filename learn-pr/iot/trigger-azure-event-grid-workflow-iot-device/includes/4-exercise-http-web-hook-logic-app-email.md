# Create HTTP Web Hook logic app that sends an email

In this unit, you will create a new logic app that will be triggered via an HTTP Web Hook, then send an email using an Outlook.com email address.

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) (which you may still have open), click **+Create a resource** to open the Azure Marketplace.
1. On the **New** page, in the **Search the Marketplace** box, type in and search for **Logic App**.
1. In the search results, select the **Logic App** item.
1. On the **Logic App** item, click **Create**.
1. On the **Create Logic App** page, for **Subscription**, select **Concierge Subscription**.
1. In the **Resource group** dropdown, select **Use Existing**, then select the <rgn>[sandbox resource group name]</rgn> resource group.
1. For **Logic App Name**, enter a globally unique name in the Registry **name** field.

    To provide a globally unique name, enter **CheeseCaveLogicApp-&lt;your ID&gt;**.

    > [!IMPORTANT]
    > Your logic app names are publicly discoverable, so take this into account when entering names. Logic app names must also be unique, as they form part of the Azure URL. As a suggestion, replace &lt;your ID&gt; with your initials followed by the current date in year, month, day format - e.g. **AB20200213** resulting in a resource name **CheeseCaveLogicApp-AB20200213**

1. For the **Select the location** option, you have two choices **Region** and **Integration Service Environment** - select **Region**.

    > [!TIP]
    > For scenarios where your logic apps and integration accounts need access to an Azure virtual network, you would create and use an integration service environment (ISE). An ISE is an isolated environment that uses dedicated storage and other resources that are kept separate from the public, "global", multi-tenant Logic Apps service. This separation also reduces any impact that other Azure tenants might have on your apps' performance. An ISE also provides you with your own static IP addresses. You can learn more about ISEs [here](https://docs.microsoft.com/azure/logic-apps/connect-virtual-network-vnet-isolated-environment-overview).

1. In the **Location** dropdown, choose the same Azure region that was used for the IoT Hub created earlier.

1. Now, select **Review + create** - this option gives you a chance to verify your choices before clicking **Create**, and building the logic app.

    > [!NOTE]
    > It will take a minute or two for the Logic App deployment to complete.

1. Navigate to the **Logic App** resource that was just deployed.

1. When navigating to the **Logic App** for the first time, the **Logic Apps Designer** pane will be displayed.

    > [!TIP]
    > If the **Logic Apps Designer** pane doesn't open automatically, click on the **Logic app designer** link under the **Development Tools** section on the **Logic App** blade.

1. The Logic App we are creating will be triggered via an HTTP request that will be sent from an Event Grid so, select the **When a HTTP request is received** trigger under the **Start with a common trigger** section to get started.

1. The **Logic Apps Designer** surface will open with the visual designer displayed, and with the **When a HTTP request is received** trigger selected.

    [![Logic apps designer with HHTP request trigger](../media/logic-apps-designer1.png)](../media/logic-apps-designer1.png#lightbox)
    
1. On the **When a HTTP request is received** trigger, click the **Use sample payload to generate schema** link.

1. When prompted, paste in the following sample JSON into the textbox and click **Done**.

    ```json
     [{
      "id": "56afc886-767b-d359-d59e-0da7877166b2",
      "topic": "/SUBSCRIPTIONS/<subscription ID>/RESOURCEGROUPS/<resource group name>/PROVIDERS/MICROSOFT.DEVICES/IOTHUBS/<hub name>",
      "subject": "devices/LogicAppTestDevice",
      "eventType": "Microsoft.Devices.DeviceCreated",
      "eventTime": "2018-01-02T19:17:44.4383997Z",
      "data": {
        "twin": {
          "deviceId": "LogicAppTestDevice",
          "etag": "AAAAAAAAAAE=",
          "deviceEtag": "null",
          "status": "enabled",
          "statusUpdateTime": "0001-01-01T00:00:00",
          "connectionState": "Disconnected",
          "lastActivityTime": "0001-01-01T00:00:00",
          "cloudToDeviceMessageCount": 0,
          "authenticationType": "sas",
          "x509Thumbprint": {
            "primaryThumbprint": null,
            "secondaryThumbprint": null
          },
          "version": 2,
          "properties": {
            "desired": {
              "$metadata": {
                "$lastUpdated": "2018-01-02T19:17:44.4383997Z"
              },
              "$version": 1
            },
            "reported": {
              "$metadata": {
                "$lastUpdated": "2018-01-02T19:17:44.4383997Z"
              },
              "$version": 1
            }
          }
        },
        "hubName": "egtesthub1",
        "deviceId": "LogicAppTestDevice"
      },
      "dataVersion": "1",
      "metadataVersion": "1"
    }]
    ```

    This sample JSON is an example of the JSON that Event Grid will POST to the Web Hook endpoint for the Logic App once it's created.

1. Notice the **Request Body JSON Schema** box is now populated with a JSON Schema that was automatically generated based on the Sample JSON that was pasted in.

1. Click the **+New step** button below the **When a HTTP request is received** trigger.

1. Enter "**Outlook.com**" into the search box, then locate and select the **Send an email (V2)** action for the **Outlook.com** connector.

    > [!NOTE]
    > These instructions walk through configuring the Logic App to send an email using an **Outlook.com** email address. Alternatively, the Logic App can also be configured to send email using the Office 365 Outlook or Gmail connectors as well.

1. On the **Outlook.com Connector**, click the **Sign in** button, and follow the prompts to authenticate with an existing Outlook.com account.

1. In the **To** field, on the **Send an email** action, enter an email address to send email messages to.

    Enter an email address where you can receive emails; such as the Outlook.com Account used for this connector.

    The Outlook.com Account that was authenticated will be used to send the emails from that account. You can actually enter any email address you want to send the notifications to.

1. Build your email template.

   * **To**: Enter the email address to receive the notification emails. For this tutorial, use an email account that you can access for testing.

   * **Subject**: Fill in the text for the subject. When you click on the Subject text box, you can select dynamic content to include. Type in `IoT Hub alert:`. If you can't see Dynamic content, select the **Add dynamic content** hyperlink -- this toggles it on and off.

   * **Body**: Write the text for your email. Select JSON properties from the selector tool to include dynamic content based on event data. For this lab, add the following text and dynamic content: `This is an automated email to inform you that: {eventType} occurred at {eventTime} IoT Hub: {hubName} Device ID: {deviceID} Connection state: {connectionState}`.  If you can't see the Dynamic content, select the **Add dynamic content** hyperlink under the **Body** text box. If it doesn't show you the fields you want, click *more* in the Dynamic content screen to include the fields from the previous action.

    [![Fill out email information](../media/email_content.png)](../media/email_content.png#lightbox)

  1. Click **Save** to save all changes to the Logic App Workflow.

1. Expand the **When a HTTP request is received** trigger, copy the value for the **HTTP POST URL** that is displayed, and save it for future referent. This is the Web Hook endpoint URL for the Logic App that will be used by Event Grid to trigger the execution of the Logic App workflow.

    [![HTTP request info](../media/http_post.png)](../media/http_post.png#lightbox)

    The **HTTP POST URL** will be similar to the following:

    ```text
    https://prod-87.eastus.logic.azure.com:443/workflows/b16b5556cbc54c97b063479ed55b2669/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=ZGqYl-R5JKTugLG3GR5Ir1FuM0zIpCrMw4Q2WycJRiM
    ```

    This URL is the Web Hook endpoint to call the Logic App trigger via HTTPS. Notice the **sig** query string parameter and it's value. The **sig** parameter contains the shared access key that is used to authenticate requests to the Web Hook endpoint.

    > [!TIP]
    > Make a note of the Web Hook endpoint URL - you will need it as part of the scenario to integrate IoT Hub and the Event Grid.

## Next Steps

The next unit reviews the key features of Event Grid that allow easy integration with business applications using an event-grid architecture.
