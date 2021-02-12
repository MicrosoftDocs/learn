In this unit, you will learn how to remote restart an Azure Sphere from Azure IoT Central.

## Understanding IoT Central commands

Azure IoT Central uses commands to invoke an action on a device. Commands are often used for interactive control of devices, such as turning on a fan, a light, or in the case of this unit, to restart the Azure Sphere.

IoT Central is built on Azure IoT Hub and it sends commands to a device using IoT Hub direct methods. IoT Hub direct methods represent a request-reply interaction with a device similar to an HTTP call in that they succeed or fail immediately (after a user-specified timeout). This approach is useful for scenarios where the course of immediate action is different depending on whether the device was able to respond.

> [!NOTE]
> There are a number of reasons why you might need to remote restart a Azure Sphere. Device certificates, OS updates, and application updates are done on a 24 hour cycle or after the device has been restarted. You may have an operational reason why you need to restart the device to force an update.

## Remote restarting an Azure Sphere

From the IoT Central device commands tab, you can invoke the command to restart the device. You need to set the number of seconds the device will wait before restarting. Azure IoT Central requests Azure IoT Hub to send a direct method message with an optional payload to the device. The device responds with a status code and optionally a message indicating if the command succeeded or failed. IoT Central can display the history of commands that have been invoked on the Azure Sphere.

![The illustration shows a device twin configuration pattern.](../media/azure-direct-method-pattern.png)

### Steps to restarting an Azure Sphere IoT Central

The following steps outline how an Azure IoT Central command uses Azure IoT Hub direct methods for cloud-to-device control.

1. From the Azure IoT Central device commands tab you invoke the **Restart Device** command. IoT Central then requests IoT Hub to send a direct method message to the device.
1. On the Azure Sphere the **RestartDeviceHandler** function is called.
1. Next the device sends a device twin **ReportedRestartUTC** message to Azure IoT to record the time the device was restarted.
1. The direct method responds with an HTTP status code and a response message.
1. The Azure Sphere is then restarted.
1. Azure IoT Central queries and displays the device **ReportedRestartUTC** property .

## Getting started with Direct method bindings

Remember, Azure IoT Central commands are implemented using Azure IoT Hub direct methods. A direct method binding maps a direct method name with a handler function that will be called to implement the action.

The following example declares a Direct Method Binding to restart the Azure Sphere. This declaration maps the Azure IoT Central `RestartDevice` command with a handler function named `RestartDeviceHandler`.

```c
static LP_DIRECT_METHOD_BINDING dm_restartDevice = {
    .methodName = "RestartDevice",
    .handler = RestartDeviceHandler };
```

### Remote restarting the Azure Sphere

The following is the implementation of the handler function `RestartDeviceHandler`. The handler function is called when the device receives a direct method message named `RestartDevice` from Azure IoT Hub.

```c
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

The RestartDeviceHandler function sets up a one shot timer that invokes the **DelayRestartDeviceTimerHandler** function after the specified restart period measured in seconds. In the DelayRestartDeviceTimerHandler function a call is made to the **PowerManagement_ForceSystemReboot** API. The PowerManagement_ForceSystemReboot API requires the **PowerControls** capability to be declared in the app_manifest.json file.

```json
"PowerControls": [
    "ForceReboot"
]
```

## How direct methods are mapped to handlers

All declared direct method bindings must be added by reference to the directMethodBindingSet array. When a direct method message is received by the device from Azure IoT Hub it is checked for a matching *methodName* name in the directMethodBindingSet array. When a match is found, the corresponding handler function is called.

```c
LP_DIRECT_METHOD_BINDING* directMethodBindingSet[] = { &dm_restartDevice };
```

### Opening the direct method binding set

The direct method binding set is initialized in the **InitPeripheralsAndHandlers** function in **main.c**.

```c
lp_directMethodSetOpen(directMethodBindingSet, NELEMS(directMethodBindingSet));
```

### Closing the direct method binding set

The direct method bindings set is closed in the **ClosePeripheralsAndHandlers** function in **main.c**.

```c
lp_directMethodSetClose();
```

## Azure IoT Central commands

IoT Central commands are defined in the device template interface. In this example, the **RestartDevice** command schema type is **Integer**. The direct method payload is an integer which defines the number of seconds before restarting the device. The command name must match the RestartDevice Direct Method Binding declaration on the Azure Sphere.

<!-- > [!div class="mx-imgBorder"]
> ![The illustration shows a device template interface.](../media/iot-central-device-template-interface-restart-device.png) -->

:::image type="content" source="../media/iot-central-device-template-interface-restart-device.png" alt-text="The illustration shows a device template interface.":::
