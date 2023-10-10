Under real-world conditions, wind farm operations aren't continuous. At times, turbine assets experience anomalies that might exceed operating thresholds. Under these circumstances, turbine assets send an alert signal that operators and engineers receive, analyze, and take action upon. To resolve a turbine asset alert on Azure Digital Twins from the mixed-reality app, send requests to the Azure Digital Twins REST API.

To make requests to the REST API, you need to authenticate. In the context of this learning module, you authenticate using app credentials, corresponding to an *App Registration*. These credentials represent an app, not an individual, and need to be copied into the Unity project. When the app is built, these credentials are compiled directly into the app. We don't recommend this approach to authentication for production systems because it doesn't require the user to sign in. As such, it doesn't prevent unauthorized user access. Use this approach for simplicity's sake in this learning module.

The ARM template, among other things, creates the required app registration. As part of the output, you created the *AppCredentials.txt* and *Azure_config_settings.txt* text files that contain important variables needed to configure the Unity scriptable objects. Use these variable mappings to enter the values into Unity:

| Azure_config_settings.txt | Unity |
|---|---|
| adtHostName | Adt Instance URL |

| AppCredentials.txt | Unity |
|---|---|
| appId | Client Id |
| password | Client Secret |
| tenant | Tenant Id |

These credentials and URL need to be transferred to your Unity project, so that your app can authenticate and interact with Azure Digital Twins. Specifically, you need to assign these values to a scriptable object in the project and then reference that `ScriptableObject` from a specific `GameObject` in the Scene.

## Add Azure Digital Twins credentials

1. Navigate to the **Credentials** folder in the Unity project panel: **Assets** > **ScriptableObjects** > **AzureDigitalTwin** > **Credentials**.
1. Create a scriptable object for the credentials by selecting **Assets** > **Create** > **ScriptableObjects** > **Credentials** > **ADT Rest API Credentials**.

   :::image type="content" source="../media/create-credential-asset.png" alt-text="Screenshot of the Unity assets menu open showing Create > ScriptableObjects > Credentials > ADT Rest API Credentials menu selection.":::

1. Select the newly created scriptable object in the project panel to see its configuration parameters in the **Inspector** panel. Transfer the values based on the variable mapping in the previous section from the *AppCredentials.txt* file.

   :::image type="content" source="../media/credentials-scriptable-object.png" alt-text="Screenshot of the ADT Rest API Credentials in the Inspector.":::

## Add turbine alert controller

To add turbine alert controller to your scene and authenticate:

1. The `ADTTurbineAlertController` changes the Alert property on the digital twin for a specific turbine. Once this property has been changed on Azure Digital Twins, the **ADTConnection** prefab receives a notification and updates a corresponding Alert value locally.
1. Drag the **Assets** > **ADTPrefabs** > **ADTTurbineAlertController** from the **Project** panel to the **Hierarchy** panel at the bottom of your list.

   :::image type="content" source="../media/adt-prefabs.png" alt-text="Screenshot of the ADT prefab objects in the Unity project panel.":::

   :::image type="content" source="../media/adt-turbine-alert-controller.png" alt-text="Screenshot of the ADT prefab objects added to the Unity hierarchy panel.":::

1. In the **Inspector**, find the **ADT Turbine Alert Controller (Script)** component. Select the circular icon inside the value box for the field named **Adt Connection Info**.

   :::image type="content" source="../media/adt-turbine-alert-controller-inspector.png" alt-text="Screenshot of the ADT turbine alert controller in the Unity inspector.":::

1. Select the **Adt Connection Info** property and assign the **ADTRestAPICredentials** scriptable object.

   :::image type="content" source="../media/adt-turbine-controller-rest-api-so.png" alt-text="Screenshot of the ADT Rest API Credentials scriptable object in the Unity assets folder.":::

1. Save your file with **File** > **Save**.
