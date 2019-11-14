In this unit, we will add some code to both the device app and back-end service app, to show device twin synchronization in operation.

## Add code to use device twins to synchronize device properties

We will start this time with the back-end service app.

::: zone pivot="node"

1. Open the app.js file for the back-end app.
2. Add the following code to the end of the file. This code sets the desired temperature of the device to 50 degrees F, humidity to 85 percent, and sets two **tags** (information only available to the IoT Hub). To verify the tags, a call is made to query the device twins based on a SQL search.

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

            // Tags aren't shared with the device, they are known only to IoT Hub.
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

3. Save the app.js file.

::: zone-end
::: zone pivot="csharp"

1. Open the Program.cs file, for the back-end app.

2. Add the following code, perhaps to the end of the class.

``` cs
        // Device twins section.
        private static RegistryManager registryManager;

        private static async Task SetTwinProperties()
        {
            var twin = await registryManager.GetTwinAsync("CheeseCaveID");
            var patch =
                @"{
                    tags: {
                        customerID: 'Customer1',
                        cellar: 'Cellar1'
                    },
                    properties: {
                        desired: {
                            patchId: 'set values',
                            temperature: '50',
                            humidity: '85'
                        }
                    }
            }";
            await registryManager.UpdateTwinAsync(twin.DeviceId, patch, twin.ETag);

            var query = registryManager.CreateQuery(
              "SELECT * FROM devices WHERE tags.cellar = 'Cellar1'", 100);
            var twinsInCellar1 = await query.GetNextAsTwinAsync();
            Console.WriteLine("Devices in Cellar1: {0}",
              string.Join(", ", twinsInCellar1.Select(t => t.DeviceId)));

        }
```

3. Now, add the following lines to the `Main` method, before the lines creating a service client.

``` cs
           // A registry manager is used to access the digital twins.
            registryManager = RegistryManager.CreateFromConnectionString(s_serviceConnectionString);
            SetTwinProperties().Wait();

            // Create a ServiceClient to communicate with service-facing endpoint on your hub.
            s_serviceClient = ServiceClient.CreateFromConnectionString(s_serviceConnectionString);
            InvokeMethod().GetAwaiter().GetResult();
```

4. Save the Program.cs file.

::: zone-end

Now we need to add code to the device app.

## Add code to synchronize device twin settings for the device

::: zone pivot="node"

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

4. Save the app.js file.

::: zone-end
::: zone pivot="csharp"

1. Open the Program.cs file for the device app.

2. Add the following method to the class.

``` cs
        private static void UpdateTwinProperties()
        {
            try
            {
                // Get the current state of the device twin.
                Twin deviceTwin = s_deviceClient.GetTwinAsync().GetAwaiter().GetResult();

                // Extract the desired twin properties.
                dynamic data = JObject.Parse(deviceTwin.Properties.Desired.ToJson());

                // Set the desired properties for the device app.
                desiredHumidity = data.humidity;
                desiredTemperature = data.temperature;
                greenMessage("Setting desired humidity to " + desiredHumidity);
                greenMessage("Setting desired temperature to " + desiredTemperature);

                greenMessage("\nTwin state reported");

                // Report the properties back to the IoT Hub.
                var reportedProperties = new TwinCollection();
                reportedProperties["fanstate"] = fanState.ToString();
                reportedProperties["humidity"] = desiredHumidity;
                reportedProperties["temperature"] = desiredTemperature;
                s_deviceClient.UpdateReportedPropertiesAsync(reportedProperties).Wait();

                greenMessage(reportedProperties.ToJson());
            }
            catch
            {
                redMessage("Failed to update device twin");
            }
        }
```

3. Update the `Main` method. Add a call to `UpdateTwinProperties()`, after the statements creating a handler for the device method.

``` cs
            // Create a handler for the direct method call
            s_deviceClient.SetMethodHandlerAsync("SetFanState", SetFanState, null).Wait();

            // Synchronize with the device twin.
            UpdateTwinProperties();
```

4. Add a line to the `SetFanState` task, as the fan state is a reported property. Add it after the `greenMessage` call.

``` cs
                    // Parse the payload, which will trigger an exception if the payload is not valid.
                    fanState = (stateEnum)Enum.Parse(typeof(stateEnum), data);
                    greenMessage("Fan set to: " + data);

                    UpdateTwinProperties();
```

5. Save the Program.cs file.

::: zone-end

## Test the device twins

Now for our final code test of this module.

1. Start the telemetry running, by starting the device app.
1. Start the back-end service app.
1. Check the console window for the device app, confirming the device twin synchronized correctly.

    ![Screenshot showing the output when the device twins are synchronized on the device app](../media/cheesecave-device-twin-received.png)

1. If we let the fan do its work, we should eventually get rid of those red alerts!

    ![Screenshot showing the output when the device twins are synchronized on the back-end service app](../media/cheesecave-device-twin-success.png)

The code given in this module isn't industrial quality. It does show how to use direct methods, and device twins. However, the messages are sent only when the back-end service app is first run. Typically, a back-end service app would require a browser interface, for an operator to send direct methods. Or set device twin properties, when required.

You've nearly completed this module. Just a summary and a knowledge check to go!
