An IoT Hub will maintain a _device twin_ for each device connected to it. The device twin is a JSON document containing state, configuration data, metadata, and similar information on the device. Device twins are designed for querying, and automatically synchronize with the IoT Hub device.

In this unit, we will add some code to both the device app and back-end service app, to show device twin synchronization in operation.

## Add code to use device twins to synchronize device properties

We will start this time with the back-end service app.

1. Open the app.js file for the back-end app.
1. Add the following code to the end of the file. This code sets the desired temperature of the device to 12 degrees C, humidity to 60 percent, and sets two **tags** (information only available to the IoT Hub). To verify the tags, a call is made to query the device twins based on a SQL search.

``` javascript
// Locate the device twin via the Registry, then update some tags and properties.
const registry = Registry.fromConnectionString(connectionString);

registry.getTwin(deviceId, function (err, twin) {
    if (err) {
        redMessage(err.constructor.name + ': ' + err.message);
    } else {
        const desiredTemp = 50;
        const desiredHumidity = 85;
        const setDesiredValues = {

            // Tags are not shared with the device, they are known only to IoT Hub.
            tags: {
                customerID: 'Customer1',
                cellar: 'Cellar1'
            },

            // Properties are shared with the device.
            properties: {
                desired: {
                    patchId: "Set values",
                    temperature: desiredTemp.toString(),
                    humidity: desiredHumidity.toString()
                }
            }
        };

        // Update the device twin.
        twin.update(setDesiredValues, function (err) {
            if (err) {
                redMessage('Could not update twin: ' + err.constructor.name + ': ' + err.message);
            } else {
                greenMessage(twin.deviceId + ' twin updated successfully');

                // Show how a query to the device twins is handled.
                queryTwins();
            }
        });
    }
});

function queryTwins() {

    // Send a SQL query, to determine all the devices in "Cellar1".
    const query = registry.createQuery("SELECT * FROM devices WHERE tags.cellar = 'Cellar1'", 100);
    query.nextAsTwin(function (err, results) {
        if (err) {
            redMessage('Failed to fetch the results: ' + err.message);
        } else {
            greenMessage("Devices in Cellar1: " + results.map(function (twin) { return twin.deviceId }).join(','));
        }
    });
};

```

Now we need to add code to the device app.

## Add code to synchronize device twin settings for the device

1. Open up the app.js file for the device.

1. Add the following code to the end of the file.

``` javascript
let deviceTwin;                                         // Global reference to device twin.

// Create a patch to send to the hub.
const reportedPropertiesPatch = {
    firmwareVersion: '1.2.3',
    lastPatchReceivedId: '',
    fanState: '',
    currentTemperature: '',
    currentHumidity: ''
};

// Send the reported properties patch to the hub.
function sendReportedProperties() {

    // Prepare the patch.
    reportedPropertiesPatch.fanState = fanState;
    reportedPropertiesPatch.currentTemperature = currentTemperature.toFixed(2);
    reportedPropertiesPatch.currentHumidity = currentHumidity.toFixed(2);

    deviceTwin.properties.reported.update(reportedPropertiesPatch, function (err) {
        if (err) {
            redMessage(err.message);
        } else {
            greenMessage('\nTwin state reported');
            greenMessage(JSON.stringify(reportedPropertiesPatch, null, 2));
        }
    });
}

// Handle changes to the device twin properties.
client.getTwin(function (err, twin) {
    if (err) {
        redMessage('could not get twin');
    } else {
        deviceTwin = twin;
        deviceTwin.on('properties.desired', function (v) {
            desiredTemperature = parseFloat(v.temperature);
            desiredHumidity = parseFloat(v.humidity);
            greenMessage('Setting desired temperature to ' + v.temperature);
            greenMessage('Setting desired humidity to ' + v.humidity);

            // Update the reported properties, after processing the desired properties.
            sendReportedProperties();
        });
    };
});
```

3. Change the `onSetFanState` function, so the success section of the function reports the updated state of the fan.

``` javascript
            } else {
            fanState = request.payload;

            // Report success back to your hub.
            response.send(200, 'Fan state set: ' + request.payload, directMethodResponse);

            // Confirm changes to reported properties.
            sendReportedProperties();
        }
```

## Test the device twin

Now for our final test of this module.

1. Start the telemetry running, by starting the device app.
1. Start the back-end service app.
1. Check the console window for the device app, confirming the device twin synchronized correctly.

    ![Screenshot showing the output when the device twins are synchronized on the device app](../media/cheesecave-device-twin-received.png)

1. If we let the fan do its work, we should eventually get rid of those red alerts!

    ![Screenshot showing the output when the device twins are synchronized on the back-end service app](../media/cheesecave-device-twin-success.png)

The code given in this module is not industrial quality. It does show how to use direct methods, and device twins. However, the messages are sent only when the back-end service app is first run. Typically, a back-end service app would require a browser interface for an operator to send direct methods, or set device twin properties, when they are required.

You have nearly completed this module. Just a summary and a knowledge check to go!
