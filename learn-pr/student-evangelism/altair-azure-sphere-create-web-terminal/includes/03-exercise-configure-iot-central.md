In this exercise, you'll follow detailed steps to customize your Azure IoT Central application.

## Open the Azure IoT Central device explorer

1. Go to [Azure IoT Central](https://azure.microsoft.com/services/iot-central?azure-portal=true).

1. On the left pane, select **Devices**, select the **Altair on Azure Sphere** template, and then select your device.

    It might take a minute or two for your device to be displayed in the devices section of Azure IoT Central.

    The device name is your Azure Sphere device ID. You can display your device ID by running the following command at the Windows PowerShell command prompt or Linux terminal:

   ```azsphere
   azsphere device show-attached
   ```

## Rename your device

Rename your device in Azure IoT Central, ensuring that the name is unique. The web terminal uses this name to retrieve the channel ID property from Azure IoT Central. The channel ID is used to create the unique MQTT topic names that are used by the Altair emulator and the web terminal.

To rename your device, on the left pane, select **Device**, select **Manage device**, and then select **Rename**.

:::image type="content" source="../media/iot-central-device-rename.png" alt-text="Screenshot that shows how to rename a device.":::

## Customize the Altair on Azure Sphere template

### Customize properties

1. On the left pane, select **Device**, select **Manage template**, then select **Edit template**.

1. Select **Customize**, and then expand the **Desired temperature** property. 

   Update the property by using the information from the following table:

    :::image type="content" source="../media/iot-central-template-customize.png" alt-text="Screenshot of the Altair on Azure Sphere pane for customizing a device template.":::

    | Display&nbsp;name | Initial&nbsp;value | Min.&nbsp;value | Max.&nbsp;value | True&nbsp;name | False&nbsp;name |
    | --- |--- | --- |--- | --- |--- |
    | Desired temperature | 20 | -20 | 80 | n/a | n/a |
    | LED brightness | 2 | 0 | 15 | n/a | n/a |
    | CPU state | On | n/a | n/a | Running | Stopped |
    | Local serial port | Enabled | n/a | n/a | Enabled | Disabled |
    | | |

1. Select **Save**.

1. Repeat the preceding steps for the **LED brightness**, **CPU state**, and **Local serial port** properties.

### Add the Properties view

1. On the left pane, select **Views**, and then select the **Editing device and cloud data** tile.

    :::image type="content" source="../media/iot-central-view-properties-create.png" alt-text="Screenshot that shows the tile for editing device and cloud data.":::

1. For **Form name**, enter **Properties**.

1. Expand **Properties**.

    :::image type="content" source="../media/iot-central-template-properties-select-properties.png" alt-text="Screenshot that shows the controls for expanding and viewing the Properties list.":::

1. Select the checkboxes next to the following properties:

    * **Channel ID**
    * **CPU state**
    * **Desired temperature**
    * **LED brightness**
    * **Local serial output**

    :::image type="content" source="../media/iot-central-template-properties.png" alt-text="Screenshot that shows a list of properties that are available for selection.":::
    
1. Select **Add section**.
1. Select **Save**.
1. Select **Back**.


### Add an environment data visualization view

1. On the left pane, select **Views**, and then select the **Visualizing the device** tile.

    :::image type="content" source="../media/iot-central-visualize-create.png" alt-text="Screenshot that shows the tile for visualizing the device.":::
    
1. Name the view **Environment**.
1. In the **Start with a visual** list, select **Line chart**, and then select **Add tile**.
1. Select the **Configure** icon on the tile.
1. Select **Capability**.
1. In the capability list, select **Temperature**.
1. Select **Capability**.
1. In the capability list, select **Pressure**.

    :::image type="content" source="../media/iot-central-visualize-tile-capabilities.png" alt-text="Screenshot that the Telemetry section for selecting capabilities.":::
    
1. Select **Update**.
1. Select **Save**.
1. Select **Back**.

### Publish the template

To publish the template to the Azure IoT Central application, select the **Publish** button.

:::image type="content" source="../media/iot-central-template-publish.png" alt-text="Screenshot of the pane for customizing an interface, with the Publish button.":::

## View your Altair on Azure Sphere device

1. On the left pane, select **Devices**, select the **Altair on Azure Sphere** template, and then select your device.

1. To explore the device views, select the various tabs.

    :::image type="content" source="../media/iot-central-device-tabs.png" alt-text="Screenshot that highlights the available tabs for customizing your device properties.":::

## Update the device properties

1. Select the **Properties** tab.
1. For the Altair emulator initial state, enter the following values:

    * CPU state: **Running**
    * Local serial output: **Disabled**
    * LED brightness (Avnet with LED click): **2**
    * Desired temperature (Celsius): **30**
    * The channel ID is for information only.

## Create an Azure IoT Central API token

The web terminal uses the Azure IoT Central device name to connect to the Altair emulator. The web terminal needs an Azure IoT Central API token to access and set the channel ID property for the device name. The web terminal and the Altair emulator use the channel ID to form unique MQTT topics. Messages flow between the Altair emulator and the web terminal by using these MQTT topics.

1. On the Azure IoT Central left pane, select **Administration**, and then select **API tokens**.
1. Select **New**.
1. Name your token **Altair-Web-Terminal**.
1. Select **Generate**.
1. Copy the generated token to use in the next unit.

    :::image type="content" source="../media/iot-central-api-token-generate.png" alt-text="Screenshot of the API tokens pane with the button for generating a token.":::

## Generate the Azure IoT Central URL

In the next unit, when you create the Altair web terminal, you'll need to add the Azure IoT Central URL to it.

In your browser address bar, copy the base address of your Azure IoT Central application to use in the next unit, as shown in the following screenshot. Be sure to remove the trailing slash (/) character from the URL.

:::image type="content" source="../media/iot-central-application-url.png" alt-text="Screenshot that shows how to copy the Azure IoT Central URL.":::
