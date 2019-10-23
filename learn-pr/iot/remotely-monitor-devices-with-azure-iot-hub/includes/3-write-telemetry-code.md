The coding in this module is broken down into three parts: sending and receiving telemetry, sending and receiving a direct method, and managing digital twins.

At the end of this unit, you will be sending and receiving telemetry.

## Create an app to send telemetry

::: zone pivot="vscode"

1. Open Visual Studio Code. From the **Terminal** menu, open a **New Terminal**.

1. In the opened terminal, create an empty folder where you will develop your code, called "CheeseCave", by entering `mkdir CheeseCave`. Then, navigate to that folder with `cd CheeseCave`.

1. From the **File** menu, create a new file. Insert a single line as a comment, such as `// Cheese Cave device app`. Save the file to the "CheeseCave" folder (locating this folder might involve a bit of navigation), with the name "app.js". By using the .js file extension, Visual Studio Code interprets this file as JavaScript and evaluates the contents with the JavaScript language service.

1. Back in the terminal, enter **npm install azure-iot-device**. When this package has installed, enter **npm install chalk**.

1. After you have entered the code below into the app.js file, you can run it from the terminal by entering `node app.js`. Ensure that the CheeseCave folder is the current folder of the terminal, when you run the app.

::: zone-end
::: zone pivot="vstudio"

1. Navigate to the **JavaScript** project types, and create a new **Blank Node.js Console Application** project, called "CheeseCave".

    ![Screenshot showing how to create the blank Node.js Visual Studio project](../media/cheesecave-vs-project.png)

1. In the **Solution Explorer** tab, right click **npm**, and select **Install New npm Packages**. Install **azure-iot-device**, and **chalk**.

    ![Screenshot showing how to install npm packages into your Visual Studio project](../media/cheesecave-vs-npm.png)

1. Delete the default contents of the app.js file. Add the line `// Cheese Cave device app`.

1. When you have entered the code below, you will be able to run the app with the **Start Without Debugging**, or **Start Debugging**, options. In the latter case, you can set breakpoints, examine data, and perform other debugging tasks.

::: zone-end

### Add code to send telemetry

This section adds code to send telemetry from a simulated device. The device sends temperature (in degrees centigrade) and humidity (in percentages) regardless of whether any back-end app is listening or not.

1. With the **app.js** file open, copy and paste the following code.

``` JavaScript
// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

'use strict';
const chalk = require('chalk');
console.log(chalk.yellow('Cheese cave device app'));

// The device connection string to authenticate the device with your IoT hub.
const connectionString = 'HostName=PetersIOTHub.azure-devices.net;DeviceId=CheeseCaveID;SharedAccessKey=4FLs8TsEPyW2aBggXKRlD5QPTea783IJdrrB9ZjMqxs=';
// var connectionString = '<your device connection string>';

// The sample connects to a device-specific MQTT endpoint on your IoT Hub.
const Mqtt = require('azure-iot-device-mqtt').Mqtt;
const DeviceClient = require('azure-iot-device').Client
const Message = require('azure-iot-device').Message;

const client = DeviceClient.fromConnectionString(connectionString, Mqtt);


// Global variables.
const ambientTemperature = 70;                          // Ambient temperature of a southern cave, in degrees F.
const ambientHumidity = 99;                             // Ambient humidity in relative percentage of air saturation.
let desiredTemperature = ambientTemperature-10;         // Initial desired temperature, in degrees F.
const desiredTempLimit = 5;                             // Acceptable range above or below the desired temp, in degrees F.
let desiredHumidity = ambientHumidity - 20;             // Initial desired humidity in relative percentage of air saturation.
const desiredHumidityLimit = 10;                        // Acceptable range above or below the desired humidity, in percentages.
const intervalInMilliseconds = 5000;                    // Interval at which telemetry is sent to the cloud.

// Enum for the state of the fan for cooling/heating, and humidifying/de-humidifying.
const stateEnum = Object.freeze({ "off": "off", "on": "on", "failed": "failed" });
let fanState = stateEnum.off;

let currentTemperature = ambientTemperature;            // Initial setting of temperature.
let currentHumidity = ambientHumidity;                  // Initial setting of humidity.

function greenMessage(text) {
    console.log(chalk.green(text));
}

function redMessage(text) {
    console.log(chalk.red(text));
}

// Send telemetry messages to your hub.
function sendMessage() {

    let deltaTemperature = Math.sign(desiredTemperature - currentTemperature);
    let deltaHumidity = Math.sign(desiredHumidity - currentHumidity);

    if (fanState == stateEnum.on) {

        // If the fan is on the temperature and humidity will be nudged towards the desired values most of the time.
        currentTemperature += (deltaTemperature * Math.random()) + Math.random() - 0.5;
        currentHumidity += (deltaHumidity * Math.random()) + Math.random() - 0.5;

        // Randomly fail the fan.
        if (Math.random() < 0.01) {
            fanState = stateEnum.failed;
            redMessage('Fan has failed');
        }
    }
    else {
        // If the fan is off, or has failed, the temperature and humidity will creep up until they reach ambient values, thereafter fluctuate randomly.
        if (currentTemperature < ambientTemperature - 1) {
            currentTemperature += Math.random() / 10;
        } else {
            currentTemperature += Math.random() - 0.5;
        }
        if (currentHumidity < ambientHumidity - 1) {
            currentHumidity += Math.random() / 10;
        } else {
            currentHumidity += Math.random() - 0.5;
        }
    }

    // Check: humidity can never exceed 100%.
    currentHumidity = Math.min(100, currentHumidity);

    // Prepare the telemetry message.
    const message = new Message(JSON.stringify({
        temperature: currentTemperature.toFixed(2),
        humidity: currentHumidity.toFixed(2),
    }));

    // Add custom application properties to the message.
    // An IoT hub can filter on these properties without access to the message body.
    message.properties.add('sensorID', "S1");
    message.properties.add('fanAlert', (fanState == stateEnum.failed) ? 'true' : 'false');

    // Send temperature or humidity alerts, only if they occur.
    if ((currentTemperature > desiredTemperature + desiredTempLimit) || (currentTemperature < desiredTemperature - desiredTempLimit)) {
        message.properties.add('temperatureAlert', 'true');
    }
    if ((currentHumidity > desiredHumidity + desiredHumidityLimit) || (currentHumidity < desiredHumidity - desiredHumidityLimit)) {
        message.properties.add('humidityAlert', 'true');
    }

    console.log('\nMessage data: ' + message.getData());

    // Send the telemetry message.
    client.sendEvent(message, function (err) {
        if (err) {
            redMessage('Send error: ' + err.toString());
        } else {
            greenMessage('Message sent');
        }
    });
}

// Set up the telemetry interval.
setInterval(sendMessage, intervalInMilliseconds);
```

  > [!NOTE]
  > Read through the comments in the code, noting how the temperature and humidity settings from the description of the scenario in the introduction have worked their way into the code.

2. Replace the &lt;your device connection string&gt; with the device connection string you saved off in the previous unit. No other lines of code need to be changed.

### Test your code to send telemetry

1. For Visual Studio, select **Debug/Start Without Debugging**. For Visual Studio Code, in a terminal, navigate to the "CheeseCave" folder, and type `node app.js`.
1. You should quickly get a console screen, similar to the following image. Note the use of the chalk utility to set some text to green. If you do not get a screen similar to this image, check your device connection string carefully.

    ![Screenshot showing the temperature and humidity telemetry being sent](../media/cheesecave-telemetry.png)

1. Watch the telemetry for a short while, checking that is it giving temperatures and humidity in the expected ranges.
1. You can leave this app running, as it is needed for the next section.

## Create a second app to receive telemetry

Now we have a device pumping out telemetry, we need to listen for that telemetry with a back-end app, also connected to our IoT Hub.

::: zone pivot="vscode"

1. Open Visual Studio Code. From the **Terminal** menu, open a **New Terminal**.

1. In the opened terminal, create an empty folder where you will develop your code, called "CheeseCaveOperator", by entering `mkdir CheeseCaveOperator`. Then, navigate to that folder with `cd CheeseCaveOperator`.

1. From the **File** menu, create a new file. Insert a single line as a comment, such as `// Cheese Cave Operator back-end app`. Save the file to the "CheeseCaveOperator" folder (locating this folder might involve a bit of navigation), with the name "app.js".

1. Back in the terminal, enter **npm install @azure/event-hubs**. When this package has installed, enter **npm install azure-iothub**. Then enter **npm install chalk**.

1. After you have entered the code below into the app.js file, you can run it from the terminal by entering `node app.js`. Ensure that the "CheeseCaveOperator" folder is the current folder of the terminal, when you run the app.

::: zone-end
::: zone pivot="vstudio"

1. Navigate to the **JavaScript** project types, and create a new **Blank Node.js Console Application** project, called "CheeseCaveOperator".

1. In the **Solution Explorer** tab, right click **npm**, and select **Install New npm Packages**. Install **@azure/event-hubs**, **azure-iothub**, and **chalk**.

1. Delete the default contents of the app.js file. Add a comment line such as `// Cheese Cave Operator back-end app`.

1. When you have entered the code below, you will be able to run the app with the **Start Without Debugging**, or **Start Debugging**, options.

::: zone-end

### Add code to receive telemetry

1. With the **app.js** file open, copy and paste the following code.

``` JavaScript
// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

'use strict';

const chalk = require('chalk');
console.log(chalk.yellow('Cheese Cave Operator: the back-end service app'));

// The connection string for the IoT Hub service.
const connectionString = 'HostName=PetersIOTHub.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey=1fRjAms3Y/U4YUs2HvTLSUyeKxGd0hpSe1Cat8792UQ=';
const deviceId = 'CheeseCaveID';

// The sample connects to service-side endpoint to call direct methods on devices.
const Client = require('azure-iothub').Client;
const Registry = require('azure-iothub').Registry;

// Connect to the service-side endpoint on your IoT hub.
const client = Client.fromConnectionString(connectionString);

// The sample connects to an IoT hub's Event Hubs-compatible endpoint to read messages sent from a device.
const { EventHubClient, EventPosition } = require('@azure/event-hubs');

let eventHubClient;

function greenMessage(text) {
    console.log(chalk.green(text));
}

function redMessage(text) {
    console.log(chalk.red(text));
}

function printError(err) {
    redMessage(err.message);
};

// Display the message content - telemetry and properties.
function printMessage(message) {

    greenMessage('Telemetry received: ' + JSON.stringify(message.body));
    if (message.applicationProperties.fanAlert == 'true') {
        redMessage('Fan alert');
    }
    if (message.applicationProperties.temperatureAlert == 'true') {
        redMessage('Temperature alert');
    }
    if (message.applicationProperties.humidityAlert == 'true') {
        redMessage('Humidity alert');
    }
    console.log('');
};

// Connect to the partitions on the IoT Hub's Event Hubs-compatible endpoint.
EventHubClient.createFromIotHubConnectionString(connectionString).then(function (client) {
    greenMessage("Successfully created the EventHub Client from IoT Hub connection string.");

    // Save the client as a global variable.
    eventHubClient = client;

    return eventHubClient.getPartitionIds();
}).then(function (ids) {
    console.log("The partition ids are: ", ids);
    console.log('');
    return ids.map(function (id) {
        return eventHubClient.receive(id, printMessage, printError, { eventPosition: EventPosition.fromEnqueuedTime(Date.now()) });
    });
}).catch(printError);
```

> [!NOTE]
> Our implementation only reads messages after the app has been started. Any telemetry sent prior to this is not handled.

1. Replace the &lt;your service connection string&gt; with the _service_ connection string you saved off in a text file, in the previous unit.

1. Replace the &lt;your device ID&gt; with the device ID from your text file (you may have used the suggested "CheeseCaveID").

### Test your code to receive telemetry

This test is important, checking whether your back-end app is picking up the telemetry being sent out by your simulated device. Remember that your device app is still running, and sending telemetry.

1. Using Visual Studio, select **Debug/Start Without Debugging**. In Visual Studio Code, enter `node app.js` from a terminal opened to the "CheeseCaveOperator" folder.
1. A second console window should open up, and immediately respond if it successfully connects to IoT Hub. If not, carefully check your IoT Hub service connection string, noting that this string should be the _service_ connection string, and not any other.

    ![Screenshot showing the temperature and humidity telemetry being received](../media/cheesecave-telemetry-received.png)

1. Visually compare the telemetry sent and received. Is there an exact match? Is there much of a delay?

If everything is working so far, completing this unit is great progress. You have an app sending telemetry from a device, and a back-end app acknowledging receipt of the data. This unit covers the _monitoring_ side of our scenario. The next step handles the _control_ side - what to do when there are issues with the data. Clearly, there are issues, we are getting temperature and humidity alerts.
