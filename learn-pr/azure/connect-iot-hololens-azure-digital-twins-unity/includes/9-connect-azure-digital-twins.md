Under real-world conditions, wind farm operations aren't continuous.  At times, turbine assets experience anomalies that may exceed operating thresholds.  Under these circumstances, turbine assets will send an alert signal that operators and Engineers intercept, analyze, and take action upon.  To resolve a turbine asset alert on ADT from the mixed reality app, we send requests to the ADT REST API.

To make requests to the REST API, you first need to authenticate. In the context of this learning module, you'll authenticate using app credentials, corresponding to an **App Registration**. These credentials represent an app, and not an individual, and need to be copied into the Unity Project.  When the app is built, these credentials are compiled directly into the app.  This approach to authentication isn't recommended for production systems because it doesn't require the user to log in. As such, it doesn't prevent unauthorized user access.  You will be using this approach for simplicity’s sake in this learning module.

The ARM template, among other things, creates the required **App Registration**. As part of the output, you created the **AppCredentials.txt** and **Azure_config_settings.txt** text files that contain a number of important variables needed to configure the Unity **Scriptable Objects**. Use these variable mappings to enter the values into Unity:

| Azure_config_settings.txt | Unity |
|---|---|
| adtHostName | Adt Instance URL |

| AppCredentials.txt | Unity |
|---|---|
| appId | Client Id |
| password | Client Secret |
| tenant | Tenant Id |

These credentials and URL need to be transferred to your Unity project, so that your app can authenticate and interact with ADT.  Specifically, you need to assign these values to a **ScriptableObject** in the project and then reference that **ScriptableObject** from a specific **GameObject** in the Scene.

## Add Azure Digital Twins credentials

1. Navigate to the Credentials folder in the Unity Project panel
**Assets > ScriptableObjects > AzureDigitalTwin > Credentials**
2. Create a Scriptable Object for the credentials by selecting the **Assets > Create > Scriptable Objects > Credentials > ADT Rest API Credentials**

    :::image type="content" source="../media/create-credential-asset.png" alt-text="Screenshot of the Unity assets menu open showing the create, scriptable objects, credentials, adt rest api credentials menu selection.":::

3. Select the newly created scriptable object in the Project panel to see its configuration parameters in the Inspector panel.  Transfer the values based on the variable mapping listed above from the **AppCredentials.txt file**.

    :::image type="content" source="../media/credentials-scriptable-object.png" alt-text="Screenshot of the ADT rest api credentials in the Inspector.":::

## Add turbine alert controller to your Scene and authenticate

1. The **ADTTurbineAlertController** changes the Alert property on the Digital Twin for a specific turbine.  Once this property has been changed on ADT, the **ADTConnection** Prefab receives a notification and updates a corresponding Alert value locally.  
2. Drag the **Assets > ADTPrefabs > ADTTurbineAlertController** from the **Project** panel to the **Hierarchy** panel, at the bottom of your list.

    :::image type="content" source="../media/adt-prefabs.png" alt-text="Screenshot of the ADT prefab objects in the Unity project panel.":::

    :::image type="content" source="../media/adt-turbine-alert-controller.png" alt-text="Screenshot of the ADT prefab objects added to the Unity hierarchy panel.":::

3. In the Inspector, find the **ADT Turbine Alert Controller (Script)** component.  Select the circular icon inside the value box for the field named **Adt Connection Info**.

    :::image type="content" source="../media/adt-turbine-alert-controller-inspector.png" alt-text="Screenshot of the ADT turbine alert controller in the Unity inspector.":::

4. Select the **Adt Connection Info** property and assign the **ADTRestAPICredentials** scriptable object.

    :::image type="content" source="../media/adt-turbine-controller-rest-api-so.png" alt-text="Screenshot of the ADT rest api credentials scriptable object in the Unity assets folder.":::

5. Save your file with **File > Save**