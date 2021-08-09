This exercise provides an overview of setting up the collection and initial processing of IoT telemetry by using Azure IoT Central applications. You'll start by creating an Azure IoT Central application, onboarding simulated IoT devices, and then reviewing the built-in analytics functionality to review the collected telemetry.

In this exercise, you'll:

* Create an Azure IoT Central application.
* Create an IoT device template.
* Integrate a simulated IoT device with an Azure IoT Central application.

## Prerequisites

* An Azure subscription
* A Microsoft account or an Azure Active Directory (Azure AD) account with the Global Administrator role in the Azure AD tenant associated with the Azure subscription and with the Owner or Contributor role in the Azure subscription

## Create an Azure IoT Central application

1. On a web browser, go to the [Welcome to IoT Central](https://apps.azureiotcentral.com/?azure-portal=true) page.
1. On the **Welcome to IoT Central** page, select the avatar icon (next to the circle with the number 1 on the image below).
1. When prompted, sign in to access the Azure subscription you'll be using in this module.
1. On the **Welcome to IoT Central** page, expand the vertical menu (next to the circle with the number 2 on the image below) and select the **My apps** menu (next to the circle with the number 3 in the image below) entry.
1. On the **My apps** page, select **+ New application**.
1. On the **Build your IoT application** page, review the available application templates, and then on the **Custom app** tile, select **Create app**.
1. On the **New application** page, configure the following settings, and then select **Create**.

   | Setting | Configuration |
   | --- | --- |
   | Application Name | Enter **adatum-iot-custom-application**. |
   | Application URL | Enter a unique name that consists of lower-case letters, digits or dashes, and starts with a letter. |
   | Application template | Select **Custom application**. |
   | Pricing plan | Select **Free**. |

   :::image type="content" source="../media/3-create-application-iot-central-portal.png" alt-text="Screenshot of the New application page in the IoT Central Application portal.":::

   > [!NOTE]
   > This will display the **Dashboard** page.

   :::image type="content" source="../media/3-iot-central-portal-dashboard.png" alt-text="Screenshot of the Dashboard page of the IoT Central Application portal.":::

## Create an IoT device template

1. On the **Dashboard** page of the IoT Central Application portal, in the vertical menu, in the **App settings** section, select **Device templates**.
1. On the **Device templates** page, select **Create a device template**.
1. On the **Select type** page, review the available device templates, select **IoT Device**, and then select **Next: Customize**.

   :::image type="content" source="../media/3-iot-custom-application-device-template-select.png" alt-text="Screenshot of the Select type of device template page of the IoT Central Application portal.":::

1. On the **Customize** page, in the **Device template name** text box, enter **Raspberry Pi**, and select **Next: Review**.
1. On the **Review** page, select **Create**.
1. On the **Raspberry Pi** page, select **Custom model**.
1. On the **Raspberry Pi** page, select **+ Add capability**.
1. In the newly displayed **Capabilities** section, specify the following settings:

   | Setting | Value |
   | --- | --- |
   | Display Name | **humidity** |
   | Name | **humidity** |
   | Capability type | **Telemetry** |
   | Semantic type | **Humidity** |

   > [!NOTE]
   > Ensure that you use lowercase characters for the capability name **humidity**.

1. In the **Capabilities** section, next to the humidity line item, select the downward-facing caret.
1. In the newly displayed **Capabilities** subsection, specify the following settings (leave others with their default values):

   | Setting | Value |
   | --- | --- |
   | Schema | **Double** |
   | Unit | **Percent** |
   | Display unit | **%** |

   :::image type="content" source="../media/3-iot-custom-application-device-template-humidity.png" alt-text="Screenshot of the IoT Central Application portal, Raspberry Pi device template page, Humidity capability section.":::

1. On the **Raspberry Pi** page, select **+ Add capability**.
1. In the newly displayed **Capabilities** section, specify the following settings:

   | Setting | Value |
   | --- | --- |
   | Display Name | **temperature** |
   | Name | **temperature** |
   | Capability type | **Telemetry** |
   | Semantic type | **Temperature** |

   > [!NOTE]
   > Ensure that you use lowercase characters for the capability name **temperature**.

1. Next to the **Capabilities** section, select the downward-facing caret.
1. In the newly displayed **Capabilities** subsection, specify the following settings (leave others with their default values):

   | Setting | Value |
   | --- | --- |
   | Schema | **Double** |
   | Unit | **Degree Celsius** |
   | Display unit | **C** |

   :::image type="content" source="../media/3-iot-custom-application-device-template-temperature.png" alt-text="Screenshot of the IoT Central Application portal, Raspberry Pi device template page, Temperature capability section.":::

1. On the **Raspberry Pi** page, select **Save** to save the device template in the draft mode.

   :::image type="content" source="../media/3-iot-custom-application-device-template-confgured-draft.png" alt-text="Screenshot of the IoT Central Application portal, capabilities of the Raspberry Pi device template page.":::

1. On the **Raspberry Pi** page, select **Views**, and on the **Select to add a new view** pane, select **Generate default views**.
1. In the **Select the applicable views to be generated** section, ensure that the following options are selected:

   - **Overview - provides a view with device telemetry, displaying charts and metrics.**
   - **About - provides a view with device information, displaying its properties.**

1. Select **Generate default dashboard view(s)**
1. On the **Raspberry Pi** page, in the **Views** section, select **About**.
1. On the **Raspberry Pi** page, in the **Edit view** section, in the **Telemetry** subsection, in the **Select a telemetry** drop-down list, select **humidity**, and then select **Add title** at the bottom of the page.
1. On the **Raspberry Pi** page, in the **Edit view** section, in the **Telemetry** subsection, in the **Select a telemetry** drop-down list, select **temperature**, and then select **Add title**.
1. On the **Raspberry Pi** page, select **Save** to save the changes to the device template **About** view.
1. On the **Raspberry Pi** page, select **Publish** to make the device template available for IoT device integration, and when presented with the **Publish this device template to the application** window, select **Publish** again.

   :::image type="content" source="../media/3-iot-custom-application-device-template-confgured-published.png" alt-text="Screenshot of the Publish this device template to the application dialog box with the Publish option available.":::

## Integrate a simulated IoT device with an Azure IoT Central application

1. On the **Raspberry Pi** page of the IoT Central Application portal, in the vertical menu, select **Devices**.
1. On the **Devices** page, select **Create a device**.
1. In the **Create a new device** window, specify the following settings, and then select **Create**:

   | Setting | Value |
   | --- | --- |
   | Device Name | **raspberrypi-1** |
   | Device ID | **raspberrypi-1** |
   | Device template | **Raspberry Pi** |
   | Simulate this device | **No** |

   :::image type="content" source="../media/3-iot-new-device-create.png" alt-text="Screenshot of the new Raspberry Pi device window in the IoT Central Application portal.":::

1. On the **Devices** page, select the **raspberrypi-1** entry.
1. On the **raspberrypi-1** page, select **Connect**.
1. In the **Device connection** window, record the values of **ID scope**, **Device ID**, and **Primary key** properties, and then select **Close**.

   > [!NOTE]
   > In general, sending keys to a third party website is not recommended, but it's done here for the sake of convenience.

   :::image type="content" source="../media/3-iot-new-device-connection.png" alt-text="Screenshot of the new Raspberry Pi device connection window in the IoT Central Application portal.":::

1. Start another web browser window and navigate to the [Azure IoT Central Connection String Generator](https://dpsgen.z8.web.core.windows.net/?azure-portal=true) page.
1. On the **Azure IoT Central Connection String Generator** page, paste the values of **Scope**, **Device ID**, and **Device Key** into their respective text boxes, and then select **Get Connection String**.

   > [!NOTE]
   > Use the values of **ID scope**, **Device ID**, and **Primary key** properties you identified.

   :::image type="content" source="../media/3-iot-connection-string-generator.png" alt-text="Screenshot of the Azure IoT Central Connection String Generator page.":::

1. On the **Azure IoT Central Connection String Generator** page, record the value of the newly generated connection string.
1. Start another web browser window and navigate to the [Raspberry Pi Azure IoT Online Simulator](https://azure-samples.github.io/raspberry-pi-web-simulator/#Getstarted?azure-portal=true) page.
1. On the **Raspberry Pi Azure IoT Online Simulator** page, if presented with **Step 1** of the **Overview of Raspberry Pi Simulator**, review its displayed content, select **Next**, review **Step 2** content, select **Next** again, and when presented with **Step 3**, select **Got it**.
1. On the code pane of the **Raspberry Pi Azure IoT Online Simulator** page, replace the entry `[Your IoT hub device connection string]` with the value of the connection string you generated by using the **Azure IoT Central Connection String Generator**.

1. On the **Raspberry Pi Azure IoT Online Simulator** page, directly after the code pane, select **Run**. Verify that the messages containing temperature and humidity telemetry are generated and sent to the target designated by the connection string.

1. Switch back to the web browser window displaying the **About** view of the **raspberrypi-1** page and monitor the charts displaying humidity and temperature telemetry.

   :::image type="content" source="../media/3-iot-raspberrypi-1-view-about.png" alt-text="Screenshot of the raspberrypi-1 device About view in the IoT Central application window.":::

1. On the **raspberrypi-1** page, switch to the **Overview** view tab, review the chart displaying both humidity and temperature telemetry, and identify the average humidity and temperature.

   :::image type="content" source="../media/3-iot-raspberrypi-1-view-overview.png" alt-text="Screenshot of the raspberrypi-1 device Overview view in the IoT Central application window.":::

1. On the **raspberrypi-1** page, select the **Raw data** view tab, select the first timestamp entry, expand its content, and verify that it contains the humidity and temperature telemetry. The same values display in the **humidity** and **temperature** columns.

   :::image type="content" source="../media/3-iot-raspberrypi-1-view-raw-data.png" alt-text="Screenshot of the raspberrypi-1 device telemetry in the IoT Central application window.":::

1. In the IoT Central Application portal, in the vertical menu, select **Analytics**.
1. On the **Analytics** page, in the **Device group** drop-down list, select the **Raspberry Pi - All devices** entry. In the **Telemetry** drop-down list, select **Temperature**, in the **Group by** drop-down list, select **Device ID**, and then select **Analyze**.
1. On the **Analytics** page, next to the **Timeframe** label, select the calendar icon, adjust the **Start** and **End** timestamp to align with the telemetry collection window or simply select **Last 15 minutes**, and then select **Save**.

   :::image type="content" source="../media/3-iot-raspberrypi-1-analytics-timeframe.png" alt-text="Screenshot of the IoT Central application window, raspberrypi-1 device telemetry Analytics timeframe settings.":::

1. On the **Analytics** page, review the resulting graph.

   :::image type="content" source="../media/3-iot-raspberrypi-1-analytics-graph.png" alt-text="Screenshot of the IoT Central application window raspberrypi-1 device telemetry Analytics page.":::

1. Switch to the browser window displaying the **Raspberry Pi Azure IoT Online Simulator** page and after the code pane, select **Stop**. Verify that the simulated device no longer sends messages to the Azure IoT Central application.
1. Keep all the web browser windows open. You'll use them in the next exercise of this module.

## Results

Congratulations! You completed the first exercise of this module. In this exercise, you created an Azure IoT Central application and an IoT device template. You also integrated a Raspberry Pi simulated IoT device with the Azure IoT Central application.
