You've now worked with the Azure IoT Central application and connected the coffee machine to Azure IoT Central. You are well on your way to begin to monitor and manage your remote coffee machine. In this unit, you take a moment to validate your setup and connection by using the **Connected Coffee Machine** template that you defined earlier. You update the optimal temperature on the **Properties** form, run commands to update the state of your machine, and view your connected coffee machine telemetry.

## Update properties to sync your application with the coffee machine

Use the **Properties** form you defined in the device template to send configuration data to the coffee machine from your application.

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Click on **Connected Coffee Machine - Real - 001** in the list of devices to view the device details.

1. Select **Properties** to view the form.

1. Enter _95_ as the optimal temperature. Then select **Save**.

When the property is changed, the property is marked as **syncing** in the UI until the coffee machine acknowledges the setting change. The property is then marked as **synced**.

> [!NOTE]
> Successful updates in the setting indicate data flow and validate your  connection. The telemetry measurements will respond to the update in optimal temperature.

## Update cloud properties

Use the **Properties** form you defined in the device template to update configuration data for the coffee machine.

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Click on **Connected Coffee Machine - Real - 001** in the list of devices to view the device details.

1. Select **Properties** to view the form.

1. Enter _92_ as the **Coffee Maker Min Temperature (Celsius)** and _99_ as the **Coffee Maker Max Temperature (Celsius)**. Then select **Save**.

Cloud properties are not synced with the device, they only exist in the IoT Central application.

## Run commands on the coffee machine

Navigate to the **Commands** page for your device for the following exercise. To validate the commands setup, you remotely run commands on the coffee machine from IoT Central. If the commands are successful, confirmation messages are sent back from the coffee machine.

1. Start brewing remotely by selecting **Run**.

    The coffee machine will start if these three conditions are satisfied:
    - Cup detected
    - Not in maintenance
    - Not brewing already  

    > [!NOTE]
    > When you've successfully started brewing, the state of the machine changes to **Brewing** as indicated on the **Telemetry** page.

    Look for confirmation messages in the console log of the simulated coffee machine.

    ![Screenshot of the console log showing the confirmation messages received after the run command. The messages return the value for temperature, humidity, and Y/N response for whether a cup is detected, if the machine is brewing, and if the maintenance mode is on.](../media/4-commands-brewing.png)

1. Set maintenance mode by choosing **Run** on the **Commands** page. The coffee machine will set to maintenance if it's *not* already in maintenance.

    Look for confirmation messages in the console log on the coffee machine.

    > [!NOTE]
    > As in real life, when the technician takes the machine offline to perform necessary repairs before switching it back online, the coffee machine continues to stay in the maintenance mode until you reboot the client code.

    ![Screenshot of a console log showing the confirmation messages received after the run command. The messages return the value for temperature, humidity, and Y/N response for whether a cup is detected, if the machine is brewing, and if the maintenance mode is on.](../media/4-commands-maintenance.png)

> [!IMPORTANT]
> It's recommended that you run the Node.js application no more than 60 minutes or so to prevent the application from sending you unwanted notifications/emails. Stopping the application when you're not working on the module also prevents you from exhausting the daily message quota.

## View the coffee machine telemetry

Navigate to the **Telemetry** page for the coffee machine. You defined this page when you created the device template:

![Screenshot showing the Telemetry page for the connected coffee machine device template.](../media/4-telemetry.png)
