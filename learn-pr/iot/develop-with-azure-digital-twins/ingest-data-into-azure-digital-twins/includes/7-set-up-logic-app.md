In this unit, you'll create a custom Azure Logic Apps connector and use it within a logic app. The logic app will periodically update the **Logic App** property of the model and digital twin.

## Create a custom Logic Apps connector

1. Go to the [Logic Apps Custom Connector](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2FcustomApis) page in the Azure portal. You can use this link or search for it in the portal search bar.

1. Select **+ Add**.

    :::image type="content" source= "..\media\logic-apps-custom-connector.png" alt-text="Screenshot of Logic Apps Custom Connector page in Azure portal, with Add button highlighted.":::

1. The **Create Logic Apps Custom Connector** page appears. Select your subscription and resource group, and a name and deployment location for your new connector. Then, select **Review + create**.

    :::image type="content" source= "..\media\create-logic-apps-custom-connector.png" alt-text="Screenshot of Create Logic Apps Custom Connector page with Review plus create button highlighted.":::

1. On the **Review + create** tab, select **Create** at the bottom of the screen to create your resource.

    :::image type="content" source= "..\media\review-logic-apps-custom-connector.png" alt-text="Screenshot of the Review plus create tab with the Create button highlighted.":::

1. You're taken to the deployment page for the connector. When deployment is finished, select **Go to resource** to view the connector's details in the portal.

## Configure the connector for Azure Digital Twins

1. Download a custom Azure Digital Twins Swagger that has been modified to work with Logic Apps: 
    1. On the [Azure Digital Twins custom Swaggers (Logic Apps connector)](https://docs.microsoft.com/samples/azure-samples/digital-twins-custom-swaggers/azure-digital-twins-custom-swaggers/) page, select **Download ZIP** to download the sample.

    1. Go to the downloaded Azure_Digital_Twins_custom_Swaggers__Logic_Apps_connector_.zip folder and unzip it.

1. Back in the Azure portal, on your connector's **Overview** page, select **Edit**:

    :::image type="content" source= "..\media\edit-connector.png" alt-text="Screenshot of Logic Apps Custom Connector page with Edit button highlighted.":::

1. On the **Edit Logic Apps Custom Connector** page that follows, configure this information:
    - **Custom connectors**
        - **API Endpoint**: REST (Accept the default value.)
        - **Import mode**: OpenAPI file (Accept the default value.)
        - **File**: Specify the custom Swagger file that you downloaded earlier. Select **Import**, locate the file on your machine (Azure_Digital_Twins_custom_Swaggers__Logic_Apps_connector_\LogicApps...\digitaltwins.json), and select **Open**.
    - **General Information**
        - **Icon**: Upload an icon that you like.
        - **Icon background color**: Enter hexadecimal code for your color, in the format `#xxxxxx`.
        - **Description**: Specify whatever information you want.
        - **Scheme**: HTTPS (Accept the default value.)
        - **Host**: The host name of your Azure Digital Twins instance.
        - **Base URL**: / (Accept the default value.)
1. Select **Security**

    :::image type="content" source= "..\media\configure-next.png" alt-text="Screenshot of the lower part of the Edit Logic Apps Custom Connector page, with the Security button highlighted.":::

1. In the Security step, select **Edit** and configure this information:

    - **Authentication type**: OAuth 2.0

    - **OAuth 2.0**:
        - **Identity provider**: Azure Active Directory
        - **Client ID**: The application (client) ID for your Azure AD app registration.
        - **Client secret**: The client secret you created in Prerequisites for your Azure AD app registration.
        - **Login URL**: https://login.windows.net (Accept the default value.)
        - **Tenant ID**: The Directory (tenant) ID for your Azure AD app registration.
        - **Resource URL**: 0b07f429-9f4b-4714-9392-cc5e8e80c8b0
        - **Scope**: 'https://digitaltwins.azure.net/.default'
        - **Redirect URL**: (Accept the default for now.)

        > [!Note]
        > The **Redirect URL** field says "Save the custom connector to generate the redirect URL."

1. Save the connector now by selecting **Update connector** at the top of the pane to confirm your connector settings.

    :::image type="content" source= "..\media\update-connector.png" alt-text="Partial screenshot of the Edit Logic Apps Custom Connector page with the Update connector button highlighted.":::

1. In the **Redirect URL** field, copy the value that has been generated.
1. Close the **Edit Logic Apps Custom Connector** pane.

## Update the Azure AD app

Run the following command to update the reply URL of the Azure AD application that you created in the first unit:

```azurecli
az ad app update --id <application ID> --reply-urls http://localhost <redirect URL from above>
```

## Create the logic app

1. Go to the [Logic Apps](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Logic%2Fworkflows) Pane and select **Add**.
1. On the **Logic App** page that follows, enter your subscription and resource group. Also, choose a name for your logic app and select the deployment location.
1. Select **Review + create**.
1. You're taken to the deployment page for the logic app. When deployment is finished, select **Go to resource** to continue to the Logic Apps Designer, where you'll fill in the logic of the workflow.

## Design the workflow

1. In the Logic Apps Designer, under **Start with a common trigger**, select **Recurrence**.

    :::image type="content" source= "..\media\logic-apps-designer-recurrence.png" alt-text="Screenshot of Logic Apps Designer with Recurrence option highlighted.":::

1. In the Logic Apps Designer page that follows, change the Internal to 1, so that the event is triggered every 1 minute.
1. Select **+ New step**. This action opens the **Choose an operation** dialog box.
1. Switch to the **Custom** tab.
1. In the top box, you should see your custom connector from earlier. Select it to display the list of APIs contained in that connector. Use the search bar or scroll through the list to select **DigitalTwins_SendTelemetry**.

   :::image type="content" source= "..\media\custom-action.png" alt-text="Screenshot of the Choose an operation dialog box with the custom connector highlighted.":::

1. In the new **DigitalTwins SendTelemetry** box, fill in the fields as follows:
    - **id**: GrindingStep
    - **telemetry**: The body that the chosen API request requires. For **SendTelemetry**, this body is in JavaScript Object Notation (JSON) format. (See example JSON in the screenshot in the next step.)
    - **Message-Id**: A unique message identifier (in the scope of the digital twin ID) that is commonly used for deduplicating messages.
    - **api-version**: The latest API version. Currently, this value is 2020-10-31.
1. Select **Save**.

    :::image type="content" source= "..\media\save-logic-app.png" alt-text="Screenshot of saved SendTelemetry fields and values.":::

## Query twin to see the update

Now that your logic app has been created, the twin update event that you defined in the Logic Apps Designer should occur every one minute. To view the data added by the logic app, run this command:

```azurecli
az dt twin show -n $dtname --twin-id GrindingStep
```

The output should look like this:

```json
{
  "$dtId": "GrindingStep",
  "$etag": "W/\"c1e3b0b6-2483-4dae-90c4-24b321f4a9de\"",
  "$metadata": {
    "$model": "dtmi:com:microsoft:iot:e2e:digital_factory:production_step_moulding;1",
    "ChasisTemperature": {
      "lastUpdateTime": "2020-10-26T19:33:40.5172646Z"
    }
  },
  "ChasisTemperature": 70.7414711544949
}
```
