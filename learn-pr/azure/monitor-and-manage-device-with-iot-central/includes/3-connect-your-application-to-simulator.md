[!include[](../../../includes/azure-sandbox-activate.md)]

In practice, you will connect Azure IoT Central to a physical device, i.e. an IoT enabled coffee machine. Here, you'll simualate a device with a Node.js application and connect it to the Azure IoT Central application. Telemetry measurements from the simulated coffee machine are sent to IoT Central for monitoring and analysis.

![An illustration showing a Coffee machine.](../media/3-coffee-machine.png) 

## Add the coffee machine in IoT Central 
To add your coffee machine to your application, you use the **Connected Coffee Maker** device template you created in the previous unit.

1. To add a new device, choose **Device Explorer** in the left navigation menu.

	To start connecting your coffee machine, choose **+ New**, **Real**, and then **Create**. When you're finished, you see a list of devices you've created using the same Connected Coffee Maker template.
   
    *	The Connected Coffee Maker is added to the list when you choose **+ New** and then **Real**. 
    *	The Connected Coffee Maker (Simulate) is automatically created by IoT Central for testing purposes. 

1.	Optionally, you can differentiate the newly added coffee machine by appending the word “Real” in its name. To rename your new device, choose the device and edit the name in the name field. 

    ![Screenshot of the connected coffee maker device template with Connect this device option highlighted.](../media/3-connect-device-a.png) 

    Note the location of **Connect this device** for connecting your coffee machine in the next section. For now, the screen displays "Missing Data" because you haven't connected to the coffee machine. The real telemetry begins to populate the screen once the connection is made. 
 
## Generate connection string for the coffee machine from your application
You embed the connection string for your real coffee machine in the code that runs on the device. The connection string enables the coffee machine to connect securely to your Azure IoT Central application. Every device instance has a unique connection string. In the next steps, you generate the connection string as part of creating your node.js application.

## Create a Node.js application
The following steps show you how to create a client application that implements the coffee machine you added to the application.

> [!TIP]
> In this exercise, we'll create the app in the Azure Cloud Shell so that you don't have to install anything on your local machine. 

1. Execute the following command in the Azure Cloud Shell to create a `coffee-maker` folder and navigate to it:

    ```azurecli
    mkdir ~/coffee-maker
    cd ~/coffee-maker
    ```

1. From the `coffee-maker` folder in Cloud Shell, execute the following command to install the DPS key generator: 

   ```azurecli
    npm install dps-keygen
   ```
    This command installs the dps-keygen package to our local folder, `coffee-maker`. We leave out the `-g` option because we don't have permissions to install as a global package.

    <!-- TODO: Add more information about the DPS key generator and what it's used for -->
 
1. Execute the following command in the Cloud Shell to download the DPS connection string utility from GitHub: 

    ```azurecli
    wget https://github.com/Azure/dps-keygen/blob/master/bin/linux/dps_cstr?raw=true -O dps_cstr 
    ```

    > [!NOTE]
    > We downloaded the Linux version of **dps_cstr** because we're running in the Cloud Shell.

1. Execute the following command to give `dps_cstr` execute permissions:

    ```azurecli
    chmod +x dps_cstr
    ```

    To generate a connection string for our device, we need three pieces of information from the Azure IoT Central portal:
    - **Scope ID**
    - **Device ID**
    - **Primary Key**

1. Return to the IoT Central portal. On the device screen for the *Connected Coffee Maker - Real* device, select **Connect** in the top right of the screen.

1. On the Device Connection dialog that opens, save the values **Scope ID**, **Device ID** and **Primary Key** somewhere, because we'll use them later in this exercise. 

1. Execute the following command in the Cloud Shell, replacing **<scope_id>**, **<device_id>**, and **<primary_key>** with the values you saved in the last step. 

   ```azurecli
   ./dps_cstr [scope_id] [device_id] [primary_key] > connection.txt
   ```
  
    This command generates a connection string based on the values you gave it and writes them to a file that we've named **connection.txt**.

    > [!IMPORTANT]
    > The command `dps_cstr` is not in your PATH in the shell. So, make sure to call it with `./dps_cstr`

1. Open the integrated code editor in the Cloud Shell by running the following command: 

    ```azurecli
    code
    ```
1. Select **connection.txt** from the list of files in the **FILES** menu of the editor.

1. Verify that **connection.txt** contains a connection string that starts with ``HostName=``.

1. Close the editor by selecting **Close Editor** from the menu (*...*) at the top right of the editor. 

1. Execute the following command in the Cloud Shell to initialize a Node.js project in our `coffee-maker` folder:

    ```azurecli
    npm init
    ```
    > [!NOTE]
    > The init script prompts you to enter project properties. For this exercise, press ENTER to use all default values.

1. To install the necessary packages, run the following command in our `coffee-maker` folder:

    ```azurecli
    npm install azure-iot-device azure-iot-device-mqtt --save
    ```

1. Execute the following command to create a new file in the Cloud Shell:

    ```azurecli
    touch coffeeMaker.js
    ```
1. Open the integrated code editor by executing the following at the command line in the Cloud Shell: 

     ```azurecli
    code
    ```
    
1. When the code editor opens, select the refresh button on the **FILES** list and select our new file **coffeeMaker.js**. 

1. Copy and paste the following code into the empty editor window:

    ```js
    "use strict";

    // Use the Azure IoT device SDK for devices that connect to Azure IoT Central
    var clientFromConnectionString = require('azure-iot-device-mqtt').clientFromConnectionString;
    var Message = require('azure-iot-device').Message;

    // Connection string (TODO: CHANGE HERE)
    const connectionString = `{your device connection string}`;

    // Global variables
    var client = clientFromConnectionString(connectionString);
    var optimalTemperature = 96;
    var cupState = true;
    var brewingState = false;
    var cupTimer = 20;
    var brewingTimer = 0;
    var maintenanceState = false;
    var warrantyState = Math.random() < 0.5?0:1;

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
            cupState = Math.random() < 0.5?false:true;
        }
        
        // Brewing timer
        if (brewingTimer > 0)
        {
            brewingTimer--;
            
            // Finished brewing
            if (brewingTimer == 0)
            {
                brewingState = false;
            }
        }
    
        // Create the data JSON package
        var data = JSON.stringify(
        { 
            waterTemperature: temperature, 
            airHumidity: humidity, 
        });

        // Create the message with the above defined data
        var message = new Message(data);
        
        // Set the state flags
        message.properties.add('stateCupDetected', cupState);
        message.properties.add('stateBrewing', brewingState);
        
        // Show the information in console
        var infoTemperature = niceNumber(temperature);
        var infoHumidity = niceNumber(humidity);
        var infoCup = cupState ? 'Y' :'N';
        var infoBrewing = brewingState ? 'Y':'N';
        var infoMaintenance = maintenanceState ? 'Y':'N';
        
        console.log('Telemetry send: Temperature: ' + infoTemperature + 
                    ' Humidity: ' + infoHumidity + '%' + 
                    ' Cup Detected: ' + infoCup + 
                    ' Brewing: ' + infoBrewing + 
                    ' Maintenance Mode: ' + infoMaintenance);
        
        // Send the message
        client.sendEvent(message, function (errorMessage) 
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
            propertyWarrantyExpired: warrantyState
        };
        
        console.log(' * Property - Warranty State: ' + warrantyState.toString());
        
        deviceTwin.properties.reported.update(properties, (errorMessage) => 
            console.log(` * Sent device properties ` + (errorMessage ? `Error: ${errorMessage.toString()}` : `(success)`)));
    }

    // Optimal temperature setting
    var settings = 
    {
        'setTemperature': (newValue, callback) => 
        {
            setTimeout(() => 
            {
                optimalTemperature = newValue;
                callback(optimalTemperature, 'completed');
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
                    console.log(` * Received setting: ${setting}: ${desiredChange[setting].value}`);
                    
                    // Update 
                    settings[setting](desiredChange[setting].value, (newValue, status, message) => 
                    {
                        var patch = 
                        {
                            [setting]: 
                            {
                                value: newValue,
                                status: status,
                                desiredVersion: desiredChange.$version,
                                message: message
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
        if (brewingState == true)
        {
            console.log(' - Warning: The device is already brewing.');
        }
        
        if (cupState == false)
        {
            console.log(' - Warning: The cup has not been detected.');
        }
        
        if (maintenanceState == true)
        {
            console.log(' - Warning: The device is in maintenance state.');
        }
        
        // Set state - brew for 30 seconds
        if ((cupState == true) && (brewingState == false) && (maintenanceState == false))
        {
            brewingState = true;
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
            client.onDeviceMethod('cmdSetMaintenance', onCommandMaintenance);
            client.onDeviceMethod('cmdStartBrewing', onCommandStartBrewing);
            
            // Get device twin from Azure IoT Central
            client.getTwin((errorMessage, deviceTwin) => 
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

    // Start the device (connect it to Azure IoT Central)
    client.open(connectCallback);

    ```

    Our coffee machine is written in Node.js. It first connects to Azure IoT Central. Then the app sends initial properties to Azure IoT Central, synchronizes settings, registers two command handlers for maintenance and brewing, and finally starts the timer for sending the telemetry information every second.

1.  Update the placeholder `{your device connection string}` at the top of this code with the connection string you created earlier and saved in **connection.txt**. The connection string begins with `HostName=`.

1. Select the three dots `...` to the top right of the editor to expand the editor menu. Then select **Save** to save the edits we made to `coffeeMaker.js'

1. Execute the following command in the Cloud Shell window to start the app:

    ```azurecli
    node coffeeMaker.js
    ```
1. Verify that the app starts in the Cloud Shell window with the message *Device successfully connected to Azure IoT Central* along with *Telemetry send:* messages. Congratulations! Your app is up and running and communicating with IoT Central!