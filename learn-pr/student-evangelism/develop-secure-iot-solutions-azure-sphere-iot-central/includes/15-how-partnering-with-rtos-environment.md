The upgraded microbiology laboratory temperature, pressure, and humidity sensor is running well on the Azure Sphere real-time core. The customer is happy, and they can run their experiments. The customer would also like to remotely monitor the lab conditions.

In this unit, you will learn how to read data from the upgraded lab sensor and send the data to IoT Central so that can be monitored.

## Solution architecture

The following describes how an Azure Sphere high-level application can read data from the upgraded lab sensor running on one of the Azure Sphere real-time cores. The high-level application will then send this data securely to IoT Central.

![Inter-core communications architecture](../media/intercore-coms.png)

To recap the solution architecture introduced in the Azure RTOS lab.

1. The Azure RTOS real-time environment sensor thread runs every 2 seconds. The thread stores in memory the latest environment temperature, humidity, and pressure data.
2. The high-level telemetry streaming app requests from the real-time core the latest environment data.
3. The Azure RTOS real-time environment service thread responses with the latest environment data.
4. The high-level application serializes the environment data as JSON and sends as a telemetry message to IoT Hub
5. Azure IoT Central subscribes to telemetry messages sent to IoT Hub by the device and displays the data to the user.
6. The IoT Central user can also set the desired temperature for the room by setting a property. The property is set on the device via an IoT Hub device twin message.
7. The Azure Sphere then sets the HVAC operating mode to meet the desired temperature.

## Inter-core message contract

There needs to be a contract that describes the shape of the data being passed between the cores. The following structure declares the inter-core contract used in this unit. You can find this contact in the **IntercoreContract** directory.

```c
typedef enum
{
    LP_IC_UNKNOWN,
    LP_IC_HEARTBEAT,
    LP_IC_ENVIRONMENT_SENSOR,
    LP_IC_SAMPLE_RATE
} LP_INTER_CORE_CMD;

typedef struct
{
    LP_INTER_CORE_CMD cmd;
    float temperature;
    float pressure;
    float humidity;
    int sample_rate;
} LP_INTER_CORE_BLOCK;
```

## Inter-core security

To communicate, applications running across cores must be configured with corresponding Component IDs.

The Component ID for the real-time application can be found in its **app_manifest.json** file.

```json
{
  "SchemaVersion": 1,
  "Name": "AzureSphereIoTCentral",
  "ComponentId": "25025d2c-66da-4448-bae1-ac26fcdd3627",
  ...
}
```

### High-level inter-core capabilities

The **AllowedApplicationConnections** property in the high-level **app_manifest.json** file is set to the Component ID of the Azure RTOS real-time application.

```json
{
    ...
    "AllowedApplicationConnections": [ "6583cf17-d321-4d72-8283-0b7c5b56442b" ]
    ...
}
```

## Initializing inter-core communications

In the **InitPeripheralAndHandlers** a call is made to **lp_interCoreCommunicationsEnable**, passing in the Component ID of the real-time and the inter-core callback function.

The inter-core callback function will be called when a message is received from the real-time core.

```c
lp_interCoreCommunicationsEnable(REAL_TIME_COMPONENT_ID, InterCoreHandler);  // Initialize Inter Core Communications
```

## Sending a request to the real-time core application

To request the environment data from the real-time core then:

1. Set the inter-core control block command to **LP_IC_ENVIRONMENT_SENSOR**.
2. Send the request message by calling **lp_interCoreSendMessage** and passing the inter-core control block.

```c
/// <summary>
/// Read sensor and send to Azure IoT
/// </summary>
static void MeasureSensorHandler(EventLoopTimer* eventLoopTimer)
{
    if (ConsumeEventLoopTimerEvent(eventLoopTimer) != 0)
    {
        lp_terminate(ExitCode_ConsumeEventLoopTimeEvent);
    }
    else {
        // send request to Real-Time core app to read temperature, pressure, and humidity
        ic_control_block.cmd = LP_IC_ENVIRONMENT_SENSOR;
        lp_interCoreSendMessage(&ic_control_block, sizeof(ic_control_block));
    }
}
```

## Receiving inter-core messages

When the high-level application receives a message the inter-core callback function is called passing a reference to the inter-core control block containing the environment data. The application serializes the data as JSON, sends the telemetry message to IoT Hub, and the HVAC status LED is updated. Azure IoT Central subscribes to telemetry messages sent to IoT Hub by the device and displays the data to the user.

```c
/// <summary>
/// Callback handler for Inter-Core Messaging - Does Device Twin Update, and Event Message
/// </summary>
static void InterCoreHandler(LP_INTER_CORE_BLOCK* ic_message_block)
{
    static int msgId = 0;

    switch (ic_message_block->cmd)
    {
    case LP_IC_ENVIRONMENT_SENSOR:
        if (snprintf(msgBuffer, JSON_MESSAGE_BYTES, msgTemplate, ic_message_block->temperature,
            ic_message_block->humidity, ic_message_block->pressure, msgId++) > 0) {

            Log_Debug("%s\n", msgBuffer);
            lp_azureMsgSendWithProperties(msgBuffer, telemetryMessageProperties, NELEMS(telemetryMessageProperties));

            SetHvacStatusColour((int)ic_message_block->temperature);

            // If the previous temperature not equal to the new temperature then update ReportedTemperature device twin
            if (previous_temperature != (int)ic_message_block->temperature) {
                lp_deviceTwinReportState(&dt_reportedTemperature, &ic_message_block->temperature);
                previous_temperature = (int)ic_message_block->temperature;
            }
        }
        break;
    default:
        break;
    }
}
```
