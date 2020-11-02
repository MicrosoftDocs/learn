In this module, you'll learn how to remote control an Azure Sphere application by using Azure IoT Central commands.

## Azure IoT direct methods

The following steps outline how an Azure IoT Central command uses Azure IoT Hub direct methods for cloud-to-device control.

1. A user invokes an Azure IoT Central command. Azure IoT Hub sends a direct method message to the device. For example, reset the device. This message includes the method name and an optional payload.
2. The device receives the direct method message and calls the associated handler function.
3. The device implements the direct method; in this case, reset the device.
4. The device responds with an HTTP status code, and optionally a response message.

### The direct method pattern

![The illustration shows a direct method pattern.](../media/azure-direct-method-pattern.png)

## Direct method bindings

Direct method bindings map a direct method with a handler function that implements an action.

### Cloud-to-device commands

In **main.c**, the variable named **dm_restartDevice** of type **DirectMethodBinding** is declared. This variable maps the Azure IoT Central **RestartDevice** command property with a handler function named **RestartDeviceHandler**.

```
static LP_DIRECT_METHOD_BINDING dm_restartDevice = {
    .methodName = "RestartDeviceHandler",
    .handler = RestartDeviceHandler };
```



## Direct method handler function

1. From Azure IoT Central, a user invokes the **Restart Device** command.

   A direct method message named **RestartDevice**, along with the integer payload specifying how many seconds to wait before the restart is sent to the device.

2. The **RestartDeviceHandler** function is called.

   When the device receives a direct method message, the **DirectMethodBindings** set is checked for a matching **DirectMethodBinding** *methodName* name. When a match is found, the associated **DirectMethodBinding** handler function is called.

3. The current UTC time is reported to Azure IoT using a device twin binding property named **ReportedRestartUTC**.

4. The direct method responds with an HTTP status code and a response message.

5. The device is reset.

6. Azure IoT Central queries and displays the device twin's reported property **ReportedRestartUTC**.

![The illustration shows how a direct method works.](../media/azure-sphere-method-and-twin.png)

```
/// <summary>
/// Start Device Power Restart Direct Method 'ResetMethod' integer seconds eg 5
/// </summary>
static LP_DIRECT_METHOD_RESPONSE_CODE RestartDeviceHandler(JSON_Value* json, LP_DIRECT_METHOD_BINDING* directMethodBinding, char** responseMsg)
{
    const size_t responseLen = 60; // Allocate and initialize a response message buffer. The calling function is responsible for the freeing memory
    static struct timespec period;

    *responseMsg = (char*)malloc(responseLen);
    memset(*responseMsg, 0, responseLen);

    if (json_value_get_type(json) != JSONNumber) { return LP_METHOD_FAILED; }

    int seconds = (int)json_value_get_number(json);

    // leave enough time for the device twin dt_reportedRestartUtc to update before restarting the device
    if (seconds > 2 && seconds < 10)
    {
        // Report Device Restart UTC
        lp_deviceTwinReportState(&dt_reportedRestartUtc, lp_getCurrentUtc(msgBuffer, sizeof(msgBuffer))); // LP_TYPE_STRING

        // Create Direct Method Response
        snprintf(*responseMsg, responseLen, "%s called. Restart in %d seconds", directMethodBinding->methodName, seconds);

        // Set One Shot LP_TIMER
        period = (struct timespec){ .tv_sec = seconds, .tv_nsec = 0 };
        lp_timerOneShotSet(&restartDeviceOneShotTimer, &period);

        return LP_METHOD_SUCCEEDED;
    }
    else
    {
        snprintf(*responseMsg, responseLen, "%s called. Restart Failed. Seconds out of range: %d", directMethodBinding->methodName, seconds);
        return LP_METHOD_FAILED;
    }
}
```

## Azure Sphere PowerControls Capability

The **RestartDeviceHandler** function sets up a one shot timer that invokes the **DelayRestartDeviceTimerHandler** function after the specified restart period measured in seconds. In the DelayRestartDeviceTimerHandler function a call is made to the **PowerManagement_ForceSystemReboot** API. The PowerManagement_ForceSystemReboot API requires the **PowerControls** capability to be declared  in the app_manifest.json file.

```
"PowerControls": [
    "ForceReboot"
]
```

## Working with direct method binding

Direct method bindings must be added to **directMethodBindingSet**. When a direct method message is received from Azure, this set is checked for a matching *methodName* name. When a match is found, the corresponding handler function is called.

```
LP_DIRECT_METHOD_BINDING* directMethodBindingSet[] = { &dm_restartDevice };
```

### Opening

Sets are initialized in the **InitPeripheralsAndHandlers** function found in **main.c**.

```
lp_directMethodSetOpen(directMethodBindingSet, NELEMS(directMethodBindingSet));
```

### Dispatching

When a direct method message is received, the set is checked for a matching *methodName* name. When a match is found, the corresponding handler function is called.

### Closing

Sets are closed in the **ClosePeripheralsAndHandlers** function found in **main.c**.

```
lp_directMethodSetClose();
```


## Azure IoT Central commands

Azure IoT Central commands are defined in device templates.

![The illustration shows a device template interface.](../media/iot-central-device-template-interface-fan1.png)

1. From Azure IoT Central, navigate to **Device template**, and select the **Azure Sphere** template.
2. Click on **Interface** to list the interface capabilities.
3. Scroll down and expand the **RestartDevice** capability.
4. Review the definition of **RestartDevice**. The capability type is **Command**.
5. The schema type is **Integer**. The direct method payload is an integer which defines the number of seconds before restarting the device.