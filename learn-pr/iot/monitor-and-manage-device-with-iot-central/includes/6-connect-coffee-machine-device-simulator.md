In practice, you will connect Azure IoT Central to a physical device, such as an IoT enabled coffee machine. Here, you'll simulate a device with a Node.js application and connect it to the Azure IoT Central application. Telemetry measurements from the simulated coffee machine are sent to IoT Central for monitoring and analysis.

![An illustration showing a Coffee machine.](../media/3-coffee-machine.png)

## Add the coffee machine in IoT Central

To add your coffee machine to your application, you use the **Connected Coffee Machine** device template you created before.

1. To add a new device, first browse to the URL for your IoT application that you created in the previous exercise, such as https://coffee-maker-1234.azureiotcentral.com.

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Select **Connected Coffee Machine**, and then **+ New**.

1. On the **Create a new device** form, change the device name to _Connected Coffee Machine - Real - 001_, and the device ID to _ccm-001_. Make sure that **Simulate this device** is **No**, and then select **Create**.

The **Connected Coffee Machine - Real - 001** device now shows in the list of **Connected Coffee Machine** devices with a status of **Registered**.

## Find the connection details

Your real device needs some connection information to connect securely to your IoT Central application:

1. Select **Connected Coffee Machine - Real - 001** from the list of devices to view the device details.

1. Select **Connect** to open the **Device connection groups** panel.

1. Either keep this page open, or make a note of the **ID scope**, **Device ID**, and **Primary key** values; you'll need these values later.

    ![Device connection information.](../media/3-device-connection.png)

## Create a Node.js application

The following steps show you how to create a client application that implements the coffee machine you added to the application.

> [!TIP]
> In this exercise, you create the Node.js app in the Azure Cloud Shell so that you don't have to install anything on your local machine.

1. Execute the following command in the Azure Cloud Shell to create a `coffee-maker` folder and navigate to it:

    ```azurecli
    mkdir ~/coffee-maker
    cd ~/coffee-maker
    ```

1. Execute the following command in the Cloud Shell to initialize a Node.js project in your `coffee-maker` folder:

    ```azurecli
    npm init
    ```

    > [!NOTE]
    > The init script prompts you to enter project properties. For this exercise, press ENTER to accept all the default values.

1. To install the necessary packages, run the following command in the `coffee-maker` folder:

    ```azurecli
    npm install azure-iot-device azure-iot-device-mqtt azure-iot-provisioning-device-mqtt azure-iot-security-symmetric-key --save
    ```

1. Create and open a file called _coffeeMaker.js_ in the integrated Cloud Shell code editor by executing the following command:

     ```azurecli
    code coffeeMaker.js
    ```

1. Copy and paste the following code into the empty editor window:

    ```js
    "use strict";

    // Use the Azure IoT device SDK for devices that connect to Azure IoT Central.
    var iotHubTransport = require('azure-iot-device-mqtt').Mqtt;
    var Client = require('azure-iot-device').Client;
    var Message = require('azure-iot-device').Message;
    var ProvisioningTransport = require('azure-iot-provisioning-device-mqtt').Mqtt;
    var SymmetricKeySecurityClient = require('azure-iot-security-symmetric-key').SymmetricKeySecurityClient;
    var ProvisioningDeviceClient = require('azure-iot-provisioning-device').ProvisioningDeviceClient;

    var provisioningHost = 'global.azure-devices-provisioning.net';
    var idScope = '{ID scope}';
    var registrationId = '{Device ID}';
    var symmetricKey = '{Primary key}';
    var provisioningSecurityClient = new SymmetricKeySecurityClient(registrationId, symmetricKey);
    var provisioningClient = ProvisioningDeviceClient.create(provisioningHost, idScope, new ProvisioningTransport(), provisioningSecurityClient);
    var centralClient;

    // Global variables
    var optimalTemperature = 96;
    var cupState = 'detected';
    var brewingState = 'notbrewing';
    var cupTimer = 20;
    var brewingTimer = 0;
    var maintenanceState = false;
    var warrantyState = Math.random() < 0.5?true:false;

    // Helper function to produce nice numbers (##.#)
    function niceNumber(value) 
    {
        var number = (Math.round(value * 10.0)).toString();
        return number.substr(0, 2) + '.' + number.substr(2, 1);
    }
    
    // Send device simulated telemetry measurements
    function sendTelemetry() 
    {
        // Simulate the telemetry values
        var temperature = optimalTemperature + (Math.random() * 4) - 2;
        var humidity = 20 + (Math.random() * 80);
    
        // Cup timer - every 20 seconds randomly decide if the cup is present or not
        cupTimer--;
    
        if (cupTimer == 0)
        {
            cupTimer = 20;
            cupState = Math.random() < 0.5?'detected':'notdetected';
        }
    
        // Brewing timer
        if (brewingTimer > 0)
        {
            brewingTimer--;
    
            // Finished brewing
            if (brewingTimer == 0)
            {
                brewingState = 'notbrewing';
            }
        }
    
        // Create the data JSON package
        var data = JSON.stringify(
        { 
            WaterTemperature: temperature, 
            AirHumidity: humidity, 
            CupDetected: cupState,
            Brewing: brewingState
        });
    
        // Create the message with the above defined data
        var message = new Message(data);
    
        // Show the information in console
        var infoTemperature = niceNumber(temperature);
        var infoHumidity = niceNumber(humidity);
        var infoCup = (cupState == 'detected') ? 'Y' :'N';
        var infoBrewing = (brewingState == 'brewing') ? 'Y':'N';
        var infoMaintenance = maintenanceState ? 'Y':'N';
    
        console.log('Telemetry send: Temperature: ' + infoTemperature + 
                    ' Humidity: ' + infoHumidity + '%' + 
                    ' Cup Detected: ' + infoCup + 
                    ' Brewing: ' + infoBrewing + 
                    ' Maintenance Mode: ' + infoMaintenance);
    
        // Send the message
        centralClient.sendEvent(message, function (errorMessage) 
        {
            // Error
            if (errorMessage) 
            {
                console.log('Failed to send message to Azure IoT Hub: ${err.toString()}');
            }
        });
    }
    
    // Send device properties
    function sendDeviceProperties(deviceTwin) 
    {
        var properties = 
        {
            DeviceWarrantyExpired: warrantyState
        };
    
        console.log(' * Property - Warranty State: ' + warrantyState.toString());
    
        deviceTwin.properties.reported.update(properties, (errorMessage) => 
            console.log(` * Sent device properties ` + (errorMessage ? `Error: ${errorMessage.toString()}` : `(success)`)));
    }
    
    // Optimal temperature setting
    var settings = 
    {
        'OptimalTemperature': (newValue, callback) => 
        {
            setTimeout(() => 
            {
                optimalTemperature = newValue;
                callback(optimalTemperature, 200, "Successfully updated OptimalTemperature");
            }, 1000);
        }
    };
    
    // Handle settings changes that come from Azure IoT Central via the device twin.
    function handleSettings(deviceTwin) 
    {
        deviceTwin.on('properties.desired', function (desiredChange) 
        {
            // Iterate all settings looking for the defined one
            for (let setting in desiredChange) 
            {
                // Setting we defined
                if (settings[setting]) 
                {
                    // Console info
                    console.log(` * Received setting: ${setting}: ${desiredChange[setting]}`);
    
                    // Update 
                    settings[setting](desiredChange[setting], (newValue, status, message) => 
                    {
                        var patch = 
                        {
                            [setting]: 
                            {
                                value: newValue,
                                ac: status,
                                av: desiredChange.$version,
                                ad: message
                            }
                        }
                        deviceTwin.properties.reported.update(patch, (err) => console.log(` * Sent setting update for ${setting} ` +
                        (err ? `error: ${err.toString()}` : `(success)`)));
                    });
                }
            }
        });
    }
    
    // Maintenance mode command
    function onCommandMaintenance(request, response) 
    {
        // Display console info
        console.log(' * Maintenance command received');
    
        // Console warning
        if (maintenanceState)
        {
            console.log(' - Warning: The device is already in the maintenance mode.');
        }
    
        // Set state
        maintenanceState = true;
    
        // Respond
        response.send(200, 'Success', function (errorMessage) 
        {
            // Failure
            if (errorMessage) 
            {
                console.error('[IoT hub Client] Failed sending a method response:\n' + errorMessage.message);
            }
        });
    }
    
    function onCommandStartBrewing(request, response) 
    {
        // Display console info
        console.log(' * Brewing command received');
    
        // Console warning
        if (brewingState == 'brewing')
        {
            console.log(' - Warning: The device is already brewing.');
        }
    
        if (cupState == 'notdetected')
        {
            console.log(' - Warning: The cup has not been detected.');
        }
    
        if (maintenanceState == true)
        {
            console.log(' - Warning: The device is in maintenance state.');
        }
    
        // Set state - brew for 30 seconds
        if ((cupState == 'detected') && (brewingState == 'notbrewing') && (maintenanceState == false))
        {
            brewingState = 'brewing';
            brewingTimer = 30;
        }
    
        // Respond
        response.send(200, 'Success', function (errorMessage) 
        {
            // Failure
            if (errorMessage) 
            {
                console.error('[IoT hub Client] Failed sending a method response:\n' + errorMessage.message);
            }
        });
    }
    
    // Handle device connection to Azure IoT Central
    var connectCallback = (errorMessage) => 
    {
        // Connection error
        if (errorMessage) 
        {
            console.log(`Device could not connect to Azure IoT Central: ${errorMessage.toString()}`);
        } 
        // Successfully connected
        else 
        {
            // Notify the user
            console.log('Device successfully connected to Azure IoT Central');
    
            // Send telemetry measurements to Azure IoT Central every 1 second.
            setInterval(sendTelemetry, 1000);
    
            // Set up device command callbacks
            centralClient.onDeviceMethod('SetMaintenanceMode', onCommandMaintenance);
            centralClient.onDeviceMethod('StartBrewing', onCommandStartBrewing);
    
            // Get device twin from Azure IoT Central
            centralClient.getTwin((errorMessage, deviceTwin) => 
            {
                // Failed to retrieve device twin
                if (errorMessage) 
                {
                    console.log(`Error getting device twin: ${errorMessage.toString()}`);
                } 
                // Success
                else 
                {
                    // Notify the user
                    console.log('Device Twin successfully retrieved from Azure IoT Central');
    
                    // Send device properties once on device startup
                    sendDeviceProperties(deviceTwin);
    
                    // Apply device settings and handle changes to device settings
                    handleSettings(deviceTwin);
                }
            });
        }
    };
    
    // Start the device (register and connect to Azure IoT Central).
    provisioningClient.register((err, result) => {
      if (err) {
        console.log('Error registering device: ' + err);
      } else {
        console.log('Registration succeeded');
        console.log('Assigned hub=' + result.assignedHub);
        console.log('DeviceId=' + result.deviceId);
        var connectionString = 'HostName=' + result.assignedHub + ';DeviceId=' + result.deviceId + ';SharedAccessKey=' + symmetricKey;
        centralClient = Client.fromConnectionString(connectionString, iotHubTransport);
    
        centralClient.open(connectCallback);
      }
    });
    ```

    The coffee machine is written in Node.js. It first connects to Azure IoT Central. Then the app sends initial properties to Azure IoT Central, synchronizes properties, registers two command handlers for maintenance and brewing, and finally starts the timer for sending the telemetry information every second.

1. Update the placeholders `{ID scope}`, `{Device ID}`, and `{Primary key}` at the top of this code with the connection information you made a note of previously.

1. Select the three dots `...` to the top right of the editor to expand the editor menu. Then select **Save** to save the edits you made to `coffeeMaker.js`

1. Execute the following command in the Cloud Shell to start the app:

    ```azurecli
    node coffeeMaker.js
    ```

1. Verify that the app starts in the Cloud Shell window with the message *Device successfully connected to Azure IoT Central* along with *Telemetry send:* messages. Congratulations! Your app is up and running and communicating with IoT Central!

## Validate your connection

You've now worked with the Azure IoT Central application and connected the coffee machine to Azure IoT Central. You are well on your way to begin to monitor and manage your remote coffee machine. Here, you take a moment to validate your setup and connection by using the **Connected Coffee Machine** template that you defined earlier. You update the optimal temperature on the **Properties** form, run commands to update the state of your machine, and view your connected coffee machine telemetry.

## Update properties to sync your application with the coffee machine

Use the **Properties** form you defined in the device template to send configuration data to the coffee machine from your application.

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Click on **Connected Coffee Machine - Real - 001** in the list of devices to view the device details.

1. Select **Properties** to view the form.

1. Enter _95_ as the optimal temperature. Then select **Save**.

When the property is changed, the property is marked as **Pending: now** in the UI until the coffee machine acknowledges the setting change. The property is then marked as **Accepted: now**.

> [!NOTE]
> Successful updates in the setting indicate data flow and validate your connection. The telemetry measurements will respond to the update in optimal temperature.

## Update cloud properties

Use the **Properties** form you defined in the device template to update configuration data for the coffee machine.

1. Navigate to the **Devices** page in your Azure IoT Central application.

1. Click on **Connected Coffee Machine - Real - 001** in the list of devices to view the device details.

1. Select **Properties** to view the form.

1. Enter _92_ as the **Coffee Maker Min Temperature (&deg;C)** and _99_ as the **Coffee Maker Max Temperature (&deg;C)**. Then select **Save**.

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

    ```
    Device successfully connected to Azure IoT Central
    Device Twin successfully retrieved from Azure IoT Central
     * Property - Warranty State: false
     * Received setting: OptimalTemperature: 95
     * Sent device properties (success)
    Telemetry send: Temperature: 96.1 Humidity: 75.9% Cup Detected: Y Brewing: N Maintenance Mode: N
     * Sent setting update for OptimalTemperature (success)
    Telemetry send: Temperature: 93.7 Humidity: 20.8% Cup Detected: Y Brewing: N Maintenance Mode: N
    Telemetry send: Temperature: 93.9 Humidity: 51.1% Cup Detected: Y Brewing: N Maintenance Mode: N
    Telemetry send: Temperature: 95.3 Humidity: 28.1% Cup Detected: Y Brewing: N Maintenance Mode: N
    Telemetry send: Temperature: 95.2 Humidity: 49.6% Cup Detected: Y Brewing: N Maintenance Mode: N
    Telemetry send: Temperature: 96.2 Humidity: 74.9% Cup Detected: Y Brewing: N Maintenance Mode: N
     * Brewing command received
    Telemetry send: Temperature: 95.2 Humidity: 85.8% Cup Detected: Y Brewing: Y Maintenance Mode: N
    Telemetry send: Temperature: 97.0 Humidity: 29.3% Cup Detected: Y Brewing: Y Maintenance Mode: N
    ```

1. Set maintenance mode by choosing **Run** on the **Commands** page. The coffee machine will set to maintenance if it's *not* already in maintenance.

    Look for confirmation messages in the console log on the coffee machine.

    > [!NOTE]
    > As in real life, when the technician takes the machine offline to perform necessary repairs before switching it back online, the coffee machine continues to stay in the maintenance mode until you reboot the client code.

    ```
    Device successfully connected to Azure IoT Central
    Device Twin successfully retrieved from Azure IoT Central
     * Property - Warranty State: true
     * Received setting: OptimalTemperature: 95
     * Sent device properties (success)
    Telemetry send: Temperature: 94.9 Humidity: 49.2% Cup Detected: Y Brewing: N Maintenance Mode: N
     * Sent setting update for OptimalTemperature (success)
    Telemetry send: Temperature: 96.7 Humidity: 64.4% Cup Detected: Y Brewing: N Maintenance Mode: N
    Telemetry send: Temperature: 95.7 Humidity: 32.4% Cup Detected: Y Brewing: N Maintenance Mode: N
    Telemetry send: Temperature: 94.7 Humidity: 98.6% Cup Detected: Y Brewing: N Maintenance Mode: N
     * Maintenance command received
    Telemetry send: Temperature: 93.2 Humidity: 61.5% Cup Detected: Y Brewing: N Maintenance Mode: Y
    Telemetry send: Temperature: 93.8 Humidity: 64.4% Cup Detected: Y Brewing: N Maintenance Mode: Y
    ```

> [!IMPORTANT]
> It's recommended that you run the Node.js application no more than 60 minutes or so to prevent the application from sending you unwanted notifications/emails. Stopping the application when you're not working on the module also prevents you from exhausting the daily message quota.

## View the coffee machine telemetry

Navigate to the **Telemetry** page for the coffee machine. You defined this page when you created the device template:

![Screenshot showing the Telemetry page for the connected coffee machine device template.](../media/4-telemetry.png)
