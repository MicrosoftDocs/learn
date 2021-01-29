## Overview 

In this unit a custom Logic App connector will be created and used within a Logic App. The Logic App will periodically update the *Logic App* property of the model / Digital Twin.

## Create a custom Logic Apps connector

1. Navigate to the [Logic Apps Custom Connector](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Web%2FcustomApis) page in the Azure portal (you can use this link or search for it in the portal search bar). Hit + Add.

    :::image type="content" source= "..\media\logic-apps-custom-connector.png" alt-text="Add new connector":::

1. In the Create Logic Apps Custom Connector page that follows, select your subscription and resource group, and a name and deployment location for your new connector. Hit Review + create.

    :::image type="content" source= "..\media\create-logic-apps-custom-connector.png" alt-text="Create new connector":::

1. This will take you to the Review + create tab, where you can hit Create at the bottom to create your resource.

    :::image type="content" source= "..\media\review-logic-apps-custom-connector.png" alt-text="Review new connector":::

1. You'll be taken to the deployment page for the connector. When it is finished deploying, hit the **Go to resource** button to view the connector's details in the portal.

## Configure connector for Azure Digital Twins

1. Download a custom Azure Digital Twins Swagger that has been modified to work with Logic Apps. Download the Azure Digital Twins custom Swaggers (Logic Apps connector) sample from [this link](https://docs.microsoft.com/en-us/samples/azure-samples/digital-twins-custom-swaggers/azure-digital-twins-custom-swaggers/) by hitting the Download ZIP button. Navigate to the downloaded Azure_Digital_Twins_custom_Swaggers__Logic_Apps_connector_.zip folder and unzip it.
1. Back in the Azure portal on your connector's Overview page, click on **Edit**

    :::image type="content" source= "..\media\edit-connector.png" alt-text="Edit new connector":::

1. In the Edit Logic Apps Custom Connector page that follows, configure this information:
    - **Custom connectors**
        - API Endpoint: REST (leave default)
        - Import mode: OpenAPI file (leave default)
        - File: This will be the custom Swagger file you downloaded earlier. Hit Import, locate the file on your machine (Azure_Digital_Twins_custom_Swaggers__Logic_Apps_connector_\LogicApps...\digitaltwins.json), and hit Open.
    - **General Information**
        - Icon: Upload an icon that you like
        - Icon background color: Enter hexadecimal code in the format '#xxxxxx' for your color.
        - Description: Fill whatever values you would like.
        - Scheme: HTTPS (leave default)
        - Host: The host name of your Azure Digital Twins instance.
        - Base URL: / (leave default)
1. Click on **Security**

    :::image type="content" source= "..\media\configure-next.png" alt-text="Configure Security":::

1. In the Security step, hit **Edit** and configure this information:

    - Authentication type: OAuth 2.0

    - OAuth 2.0:
        - Identity provider: Azure Active Directory
        - Client ID: The Application (client) ID for your Azure AD app registration
        - Client secret: The Client secret you created in Prerequisites for your Azure AD app registration
        - Login URL: https://login.windows.net (leave default)
        - Tenant ID: The Directory (tenant) ID for your Azure AD app registration
        - Resource URL: 0b07f429-9f4b-4714-9392-cc5e8e80c8b0
        - Scope: 'https://digitaltwins.azure.net/.default'
        - Redirect URL: (leave default for now)

        > [!Note]
        > The Redirect URL field says Save the custom connector to generate the redirect URL.

1. Do this now by hitting Update connector across the top of the pane to confirm your connector settings.

    :::image type="content" source= "..\media\update-connector.png" alt-text="Update connector":::

1. In the **Redirect URL** field and copy the value that has been generated.
1. Close the **Edit Logic Apps Custom Connector** pane.

## Update the Azure AD app

Run the following command to update the reply URL of the Azure AD application created in the first unit.

```azurecli
az ad app update --id <application ID> --reply-urls http://localhost <redirect URL from above>
```

## Create logic app

1. Navigate to the [Logic Apps](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.Logic%2Fworkflows) Pane and click on **Add**
1. In the Logic App page that follows, enter your subscription and resource group. Also, choose a name for your logic app and select the deployment location.
1. Click the Review + create button.
1. You'll be taken to the deployment page for the logic app. When it is finished deploying, hit the Go to resource button to continue to the Logic Apps Designer, where you will fill in the logic of the workflow.

### Design workflow

1. In the Logic Apps Designer, under Start with a common trigger, select **Recurrence**.

    :::image type="content" source= "..\media\logic-apps-designer-recurrence.png" alt-text="Configure connector":::

1. In the Logic Apps Designer page that follows, change the Internal to 1, so that the event is triggered every 1 Minute.
1. Click on + New step
1. This will open a Choose an action box. Switch to the Custom tab.
1. You should see your custom connector from earlier in the top box. Select it to display the list of APIs contained in that connector. Use the search bar or scroll through the list to select **DigitalTwins_SendTelemetry**

   :::image type="content" source= "..\media\custom-action.png" alt-text="Add custom connector to workflow":::

1. In the new DigitalTwins SendTelemetry box, fill the fields as follows:
    - ID: GrindingStep.
    - telemetry: This field is where you'll enter the body that the chosen API request requires. For SendTelemetry, this body is in the form of JSON (see image below)
    - Message-ID: A unique message identifier (in the scope of the digital twin ID) that is commonly used for de-duplicating message.
    - api-version: The latest API version. Currently, this value is 2020-10-31.
1. Click **Save**

    :::image type="content" source= "..\media\save-logic-app.png" alt-text="Save Logic App":::

## Query twin to see the update

Now that your logic app has been created, the twin update event you defined in the Logic Apps Designer should occur on a recurrence of every 1 Minute. To view the data added by the logic app, run the following command:

```azurecli
az dt twin show -n $dtname --twin-id GrindingStep
```

The output should show the following:

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
