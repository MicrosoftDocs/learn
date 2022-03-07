To emulate real world functionality, you'll use a simulator to replace a real IoT device in your data pipeline for your wind farm. The simulator sends telemetry data to the IoT Hub, which then informs the ADT service, which then interfaces with SignalR, and finally the data is pulled into your mixed reality app.

In your wind farm Digital Twin, the simulator sends a property update to ADT on demand from a user, to signal an alert.  This alert signifies an operational event and is displayed in the mixed reality app experience.  The use user then can resolve the event via a UI interaction (that is, a button press). The communication between ADT and your Digital Twin happens through ADT’s REST API.  Although this isn't a accurate representation of real-world solution architecture, it simplifies the implementation of the simulator for your Digital Twin in this module.  Normally, an IoT device wouldn't communicate directly with ADT, it would do so through Azure IoT Hub.

The pre-built simulator you're running sends telemetry every 5 seconds from the stand-alone console application to ADT.  This telemetry represents a normal state and has turbine OK as the event code. When the user triggers an alert on the simulator, it sends modified telemetry that represents an alert situation.  The simulator sends a property update to ADT, setting the Alert property to **True** on your Digital Twin for a particular turbine.  The simulator begins to poll ADT at a regular interval until the Alert property is set back to **False**, triggered by the user clearing the alert from the app within the device. Once the alert is cleared, the simulator resumes sending normal telemetry again, with the turbine **OK** event code.

The data simulator connects to the ADT REST API for two purposes:
* To send a property update to ADT (that is, to toggle the alert state of turbine T102); and, 
* To poll for an Alert status, once flagged by the user, until it's cleared, and normal telemetry value streams are resumed.

Use the Visual Studio **DeviceSimulator** solution to simulate a wind farm, sending telemetry data to ADT, where your newly configured Digital Twin in Unity receives input and displays operating conditions on the wind farm.

> [!NOTE]
> Remember to stop the simulator whenever it is not needed to avoid unnecessary charges on your Azure account.

## Begin the wind farm device simulation

1. In the Visual Studio IDE, open the previously configured **DeviceSimulator.sln**
2. Run the **DeviceSimulator** by pressing the **Play** button or **F5**
3. Press any key to begin the simulation.  

## Observe overview of wind farm performance

1. Put on your mixed reality device.
2. Summon the Site overview menu.  When running the build on the device, look at either of your hands with a flat palm facing upwards. This will show a floating UI panel with a button to show the **Site Overview** Panel. Click the button.  The Site overview panel will float and follow you as you navigate around the map.

    :::image type="content" source="../media/site-overview.png" alt-text="Screenshot of the site overview menu on HoloLens 2 displaying turbine data.":::

The **DeviceSimulator** is configured to send telemetry messages every 5 seconds from the console application running on your computer to ADT.  By default, telemetry readings are sent along with an event code is sent with each telemetry reading:

```console
Value: 100
Description: OK
```

## Simulate a light icing event on one turbine

1. Flip up your HoloLens 2 or take off your mixed reality headset and return to your PC.
2. In the **DeviceSimulator** window, press the spacebar on your keyboard.  This sends a light icing alert to turbine T102. The ADT object representing turbine T102 receives an update for its Alert property, which is set to **True**.  

A new event code will be sent back to your app via the ADT Connection on your device with the telemetry reading:

```console
Value: 400
Description: Light icing (rotor bl. ice sensor)
```

## Observe the Alert for turbine T102

1. Flip your HoloLens 2 back down or put you mixed reality headset back on and resume your immersive experience.
2. In the mixed reality app, select turbine T102.  An alert icon will appear above the turbine in the map and next to any UI panels for turbine T102 to highlight an Alert condition. 

For this exercise, it's assumed that an action will be taken offline to solve the issue on site (for example, sending a technician to the turbine location).  To simulate normal operating conditions, clear the Alert and return the Digital Twin to full operating service, select the highlighted turbine, and resolve the alert from the turbine panel.

## Clear the Alert for turbine T102

Click the **Send Reset** Command button.  This sends a message to ADT to set the **Alert** property to **False** for the Digital Twin for turbine T102.

## Validate the Alert update for turbine T102

1. Observe the UI panel displaying a message confirming that the update succeeded. 
2. Flip up your HoloLens 2 or take off your mixed reality device and return to your PC.
3. Note the message written to the **DeviceSimulator** console app, indicating that the update succeeded.
4. Observe the **DeviceSimulator** console app sending normal (i.e, non-alert) telemetry messages, with event code 100 instead of 400, and with “Turbine OK” as the description for Turbine T102.

    > [!NOTE]
    > The properties of a Digital Twin can be examined directly in ADT.  Use the ADT Explorer web app or an Azure CLI command to browse Digital Twin properties.

## Stop the DeviceSimulator

Press **Ctrl-C** in the Command Window or the **Stop** button in the Visual Studio IDE

## Exit the app

1. Flip your HoloLens 2 back down or put your mixed reality headset back on and resume your immersive experience.
2. To exit an app that uses an immersive view, use the **Start gesture** to bring up the **Start menu**, then select the Mixed reality **Home** button. 
3. Once you've exited the app, close the app window using the close icon in the top right of the window.