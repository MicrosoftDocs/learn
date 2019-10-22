A _direct method_ is a function on the device that can be invoked by the back-end app. The direct method call can include parameters as part of the payload, and are typically used to turn features of the device off and on, or specify settings for the device. In our scenario, we will set up a direct method to turn the fan on and off. There are several error conditions that need to be checked for when a device receives instructions to run a direct method. One of these checks is simply to respond with an error if the fan is in a failed state.

In this unit, we will add code to the device app for the direct method, and then add code to the back-end service app to send the instruction to invoke the method.

## Add code to define a direct method in the device app

1. Open up the app.js file for the device app.

1. Append the following code to the end of the file. This code is the body of the direct method itself, and a single statement to record the direct method with the IoT Hub client.

``` javascript
// Function to handle the SetFanState direct method call from IoT hub.
function onSetFanState(request, response) {

    // Function to send a direct method response to your IoT hub.
    function directMethodResponse(err) {
        if (err) {
            redMessage('An error ocurred when sending a method response:\n' + err.toString());
        } else {
            greenMessage('Response to method \'' + request.methodName + '\' sent successfully.');
        }
    }

    greenMessage('Direct method payload received:' + request.payload);

    // Check that a valid value was passed as a parameter.
    if (fanState == stateEnum.failed) {
        redMessage('Fan has failed and cannot have its state changed');

        // Report failure back to your hub.
        response.send(400, 'Fan has failed and cannot be set to: ' + request.payload, directMethodResponse);
    } else {
        if (request.payload != "on" && request.payload != "off") {
            redMessage('Invalid state response received in payload');

            // Report failure back to your hub.
            response.send(400, 'Invalid direct method parameter: ' + request.payload, directMethodResponse);

        } else {
            fanState = request.payload;

            // Report success back to your hub.
            response.send(200, 'Fan state set: ' + request.payload, directMethodResponse);
        }
    }
}

// Set up the handler for the SetFanState direct method call.
client.onDeviceMethod('SetFanState', onSetFanState);
```

> [!NOTE]
> The fan has three states: _on_, _off_, and _failed_. The method above sets the fan to either of the first two of these states. If the payload text does not match one of these two, or the fan is in a failed state, an error is returned.

You have completed what is needed at the device end of things. Next, we need to add code to the back-end service.

## Add code to call a direct method

When setting up a call to invoke a direct method, it is best to divide the code into three parts: the parameters, a function handling the call, and one or more calls to that function.

1. Open up the back-end service app.js file and add the following code to the end of the file.

``` javascript
const methodParams = {
    methodName: 'SetFanState',
    payload: 'on',
    responseTimeoutInSeconds: 30
};

```

> [!NOTE]
> The `methodName` parameter is an exact match of the first parameter in the `client.onDeviceMethod('SetFanState', onSetFanState);` call you entered into the device app.

2. Now, enter the code to send the message to invoke the method.

``` javascript
function sendDirectMethod() {

    // Call the direct method on your device using the defined parameters.
    client.invokeDeviceMethod(deviceId, methodParams, function (err, result) {
        if (err) {
            redMessage('Failed to invoke method \'' + methodParams.methodName + '\': ' + err.message);
        } else {
            greenMessage('Response from ' + methodParams.methodName + ' on ' + deviceId + ':');
            greenMessage(JSON.stringify(result, null, 2));
        }
    });
}
```

> [!NOTE]
> The first parameter of the `client.invokeDeviceMethod` call identifies the device the call is to go to. With multiple devices, this could be changed to a parameter of the function.

3. Finally, add a call to the `sendDirectMethod` function into the `createFromIotHubConnectionString` function, after the `eventHubClient = client;` line of code.

``` javascript
    // Save the client as a global variable.
    eventHubClient = client;

    // Send a direct method to turn the fan on.
    sendDirectMethod();

    return eventHubClient.getPartitionIds();
```

## Test the direct method

To test the method, start the apps in the correct order.

1. Start the device app. A console window will open up, and telemetry will appear.
1. Start the back-end app. This app immediately calls the direct method. Do you notice it is handled by the device app, with output similar to the following image?
  
    ![Screenshot showing the output when the direct method is run by the back-end service app](../media/cheesecave-direct-method-sent.png)

1. Now check on the console output for the device app, you should see that the fan has been turned on.

    ![Screenshot showing the output when the direct method is run by the device app](../media/cheesecave-direct-method-received.png)

You are now successfully monitoring and controlling a remote device. However, although we have turned on the fan, which will slowly move the environment in the cave to our initial desired settings, we might like to be able to remotely specify those desired settings. We could specify desired settings with a direct method (which is a completely valid approach), or we could use another feature of IoT Hub called _device twins_. Let's look into the technology of IoT Hub device twins.
