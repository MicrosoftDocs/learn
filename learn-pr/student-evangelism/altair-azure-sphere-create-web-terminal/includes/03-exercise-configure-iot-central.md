In this exercise, you'll configure your Altair IoT Central application.

## Open IoT Central device explorer

1. Switch back to the **IoT Central** [web portal](https://azure.microsoft.com/services/iot-central?azure-portal=true).

1. From the sidebar menu, select **Devices**, then the **Altair on Azure Sphere** template, then your **device**.

    It may take a minute or two from when your device started to it appearing in the devices section of IoT Central.

    The device name is your Azure Sphere Device ID. You can display your Device ID by running the following command from the Windows **PowerShell command line** or Linux **Terminal**.

   ```azsphere
   azsphere device show-attached
   ```

## Rename your device

Rename your device in IoT Central ensuring that the name is unique. The Web Terminal uses this name to retrieve the Channel ID property from IoT Central. The Channel ID is used to create unique MQTT topic names used by the Altair emulator and the Web Terminal.

From the Device menu bar, select **Manage device**, then **Rename**.

:::image type="content" source="../media/iot-central-device-rename.png" alt-text="Screenshot that shows how to rename a device.":::

## Customize the Altair on Azure Sphere template

### Customize properties

From the Device menu bar, select **Manage template**, then select **Edit template**.

1. Select **Customize**, and expand the **Desired temperature** property. Update the property using the information from the table below and select **Save**.

    :::image type="content" source="../media/iot-central-template-customize.png" alt-text="Screenshot that shows how to customize a device template.":::

    | Display name     | Initial value      | Min value | Max value | True name | False name |
    |----------------|---------------|----------------|---------------|----------------|---------------|
    | Desired Temperature | 20 | -20 | 80 | n/a | n/a |
    | LED brightness | 2 | 0 | 15 | n/a | n/a |
    | CPU State | On | n/a | n/a | Running | Stopped |
    | Local Serial Port | Enabled | n/a | n/a | Enabled | Disabled |

1. Repeat for the **LED brightness**, **CPU State**, and **Local Serial Port** properties, be sure to **Save** your updates.

### Add Properties view

1. Select **Views** and then select **Editing device and cloud data**.

    :::image type="content" source="../media/iot-central-view-properties-create.png" alt-text="Screenshot that shows how to view and create properties.":::

1. Name the properties form **Properties**.
1. Expand **Properties**

    :::image type="content" source="../media/iot-central-template-properties-select-properties.png" alt-text="Screenshot that shows selecting the Properties button.":::

1. Select the following properties.
    * Channel ID
    * CPU State
    * Desired temperature
    * LED Brightness
    * Local serial output
1. Select **Add section**.
1. Select **Save**.
1. Select **Back**.

    :::image type="content" source="../media/iot-central-template-properties.png" alt-text="Screenshot that shows setting properties.":::
    
### Add an environment data visualization view

1. Select **Views** and then select **Visualizing the device**.

    :::image type="content" source="../media/iot-central-visualize-create.png" alt-text="Screenshot that shows how to select visualizing the device.":::
    
1. Name the view **Environment**.
1. From the **Start with a visual** list, select **Line chart**, scroll to the end of the list, and select **Add tile**.
1. Select the **Configure** icon on the tile.
1. Select **+ Capability**.
1. From the capability list, select **Temperature**.
1. Select **+ Capability**.
1. From the capability list, select **Pressure**.

    :::image type="content" source="../media/iot-central-visualize-tile-capabilities.png" alt-text="Screenshot that shows how to expand properties.":::
    
1. Select **Update**.
1. Select **Save**.
1. 1. Select **Back**.

### Publish template

1. Finally, select **Publish** to publish the template into the IoT Central application.
1. Select **Publish**.

    :::image type="content" source="../media/iot-central-template-publish.png" alt-text="Screenshot that shows selecting the Publish button.":::

## View your Altair on Azure Sphere device

1. From the sidebar menu, select **Devices**, then the **Altair on Azure Sphere** template, and finally your device.

1. Navigate the tabs to explore the device views.

    :::image type="content" source="../media/iot-central-device-tabs.png" alt-text="Screenshot that shows how to display measurements.":::

## Update the Device properties tab

1. Select **Properties** tab.
1. Set the initial state for the Altair emulator:

    * CPU state: **Running**
    * Desired Temperature (Celsius): **30**
    * LED Brightness (Avnet with LED Click): **2**
    * Local serial output: **Disabled**
    * The Channel ID is for information only.

## Create an IoT Central API Token

The Web Terminal uses the IoT Central device name to connect to the Altair emulator. The Web Terminal needs an IoT Central API Token to access and set the Channel ID property for the device name. The Web Terminal and the Altair emulator use the Channel ID to form unique MQTT topics. Messages flow between the Altair emulator and the Web Terminal using these MQTT topics.

1. From the IoT Central sidebar menu, navigate to **Administration**, then **API Token**.
1. Select **+ New**.
1. Name your token **Altair-Web-Terminal**.
1. Select **Generate**
1. **Copy** the generated token to Notepad as you'll need for the next step.

    :::image type="content" source="../media/iot-central-api-token-generate.png" alt-text="Screenshot that shows the API Tokens tab.":::

## Generate the IoT Central URL

You need the IoT Central URL for the Altair Web Terminal.

1. From your browser address bar, **copy** the base address of your IoT Central application to Notepad as you'll need for the next step.
1. Ensure you **remove** the trailing '**/**' from the URL.

    :::image type="content" source="../media/iot-central-application-url.png" alt-text="Screenshot that shows how to copy the IoT Central URL.":::

In the next unit, you will create the Altair Web Terminal.

