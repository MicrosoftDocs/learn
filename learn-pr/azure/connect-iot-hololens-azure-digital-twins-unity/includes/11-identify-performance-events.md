To emulate real world functionality, use a simulator to replace a real IoT device in your data pipeline for your wind farm. The simulator sends telemetry data to the IoT Hub. IoT Hub informs the Azure Digital Twins service, which interfaces with the Azure SignalR Service. The data is then pulled into your mixed reality app.

In your wind farm digital twin, the simulator sends a property update to Azure Digital Twins on demand from a user to signal an alert. This alert signifies an operational event and is displayed in the mixed-reality app experience. The user can resolve the event by using the UI, for instance by pressing a button. The communication between Azure Digital Twins and your digital twin happens through the Azure Digital Twins REST API. Although this information isn't an accurate representation of real-world solution architecture, it simplifies the implementation of the simulator for your digital twin in this module. Normally, an IoT device wouldn't communicate directly with Azure Digital Twins. It would do so through Azure IoT Hub.

The prebuilt simulator that you're running sends telemetry every five seconds from the stand-alone console application to Azure Digital Twin. This telemetry represents a normal state and has `turbine OK` as the event code. When the user triggers an alert on the simulator, it sends modified telemetry that represents an alert situation. The simulator sends a property update to Azure Digital Twins. The update sets the Alert property to `True` on your digital twin for a particular turbine. The simulator begins to poll Azure Digital Twins at a regular interval until the Alert property is set back to `False`, triggered by the user clearing the alert from the app within the device. After the alert is cleared, the simulator resumes sending normal telemetry again with the `turbine OK` event code.

The data simulator connects to the Azure Digital Twin REST API for two purposes:

* To send a property update to Azure Digital Twins. That is, the property update to toggle the alert state of turbine T102.
* To poll for an Alert status, once flagged by the user, until it's cleared, and normal telemetry value streams are resumed.

Use the Visual Studio **DeviceSimulator** solution to simulate a wind farm that sends telemetry data to Azure Digital Twins. Your newly configured digital twin in Unity receives input and displays operating conditions on the wind farm.

> [!NOTE]
> Remember to stop the simulator whenever it is not needed to avoid unnecessary charges on your Azure account.

## Begin the wind farm device simulation

1. In Visual Studio, open the previously configured `DeviceSimulator.sln`.
1. Run the **DeviceSimulator** by pressing the **Play** button or **F5**.
1. Press any key to begin the simulation.

## Observe overview of wind farm performance

1. Put on your mixed-reality device.
1. Access the **Site overview** menu. When running the build on the device, look at either of your hands with a flat palm facing upwards. This action shows a floating UI panel with a button to show the **Site Overview** panel. Select the button. The **Site overview** panel floats and follows you as you navigate around the map.

   :::image type="content" source="../media/site-overview.png" alt-text="Screenshot of the site overview menu on HoloLens 2 displaying turbine data.":::

The **DeviceSimulator** is configured to send telemetry messages every five seconds from the console application that runs on your computer to Azure Digital Twins. By default, telemetry readings are sent along with an event code:

```output
Value: 100
Description: OK
```

## Simulate a light icing event on one turbine

1. Flip up your HoloLens 2 or take off your mixed-reality headset and return to your PC.
1. In the **DeviceSimulator** window, press space on your keyboard. This action sends a light icing alert to turbine T102. The Azure Digital Twins object that represents turbine T102 receives an update for its Alert property, which is set to `True`.

A new event code is sent back to your app by the Azure Digital Twins connection on your device with the telemetry reading:

```output
Value: 400
Description: Light icing (rotor bl. ice sensor)
```

## Observe the alert for turbine T102

1. Flip your HoloLens 2 back down or put your mixed-reality headset back on and resume your immersive experience.
1. In the mixed-reality app, select turbine T102. An alert icon appears above the turbine in the map and next to any UI panels for turbine T102 to highlight an Alert condition.

For this exercise, an action is taken offline to solve the issue on site. For example, you might send a technician to the turbine location. To simulate normal operating conditions, clear the Alert and return the digital twin to full operating service, select the highlighted turbine, and resolve the alert from the turbine panel.

## Clear the alert for turbine T102

Select the **Send Reset Command** button. This action sends a message to Azure Digital Twin to set the **Alert** property to **False** for the digital twin for turbine T102.

## Validate the alert update for turbine T102

1. Observe the UI panel that displays a message confirming that the update succeeded.
1. Flip up your HoloLens 2 or take off your mixed-reality device and return to your PC.
1. Note the message written to the **DeviceSimulator** console app, which indicates that the update succeeded.
1. Observe the **DeviceSimulator** console app sending normal, or nonalert, telemetry messages, with event code 100 instead of 400, and with *Turbine OK* as the description for Turbine T102.

   > [!NOTE]
   > The properties of a digital twin can be examined directly in Azure Digital Twins. Use the Azure Digital Twins Explorer web app or an Azure CLI command to browse digital twin properties.

## Stop the DeviceSimulator

Press **Ctrl**+**C** in the Command Window or the **Stop** button in Visual Studio.

## Exit the app

1. Flip your HoloLens 2 back down or put your mixed-reality headset back on and resume your immersive experience.
1. To exit an app that uses an immersive view, use the **Start gesture** to bring up the **Start menu**, then select the mixed-reality **Home** button.
1. After you exit the app, close the app window using the close icon in the top right of the window.
