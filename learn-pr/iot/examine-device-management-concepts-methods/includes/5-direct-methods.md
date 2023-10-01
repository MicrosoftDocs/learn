IoT Hub gives you the ability to invoke direct methods on devices from the cloud. Direct methods represent a request-reply interaction with a device similar to an HTTP call in that they succeed or fail immediately (after a user-specified timeout). This approach is useful for scenarios where the course of immediate action is different depending on whether the device was able to respond.

> [!NOTE]
> To implement Direct Methods, you need to be running the standard tier of the IoT Hub service.

Direct methods have the following features:

- Each direct method targets a single device. You can use IoT Hub jobs to invoke direct methods on multiple devices, and schedule method invocation for disconnected devices.
- Anyone with service connect permissions on IoT Hub may invoke a method on a device.
- Direct methods follow a request-response pattern and are meant for communications that require immediate confirmation of their result. For example, interactive control of the device, such as turning on a fan.

## Method lifecycle

Direct methods are implemented on the device and may require zero or more inputs in the method payload to correctly instantiate. You invoke a direct method through a service-facing URI (`{iot hub}/twins/{device id}/methods/`). A device receives direct methods through a device-specific MQTT topic (`$iothub/methods/POST/{method name}/`) or through AMQP links (the `IoThub-methodname` and `IoThub-status` application properties).

> [!NOTE]
> When you invoke a direct method on a device, property names and values can only contain US-ASCII printable alphanumeric, except any in the following set: `$ ( ) < > @ , ; : \ " / [ ] ? = { } SP HT`

Direct methods are synchronous and either succeed or fail after the timeout period (default: 30 seconds, can be set within the range of 5-300 seconds). Direct methods are useful in interactive scenarios where you want a device to act if and only if the device is online and receiving commands. For example, turning on a light from a phone. In these scenarios, you want to see an immediate success or failure so the cloud service can act on the result as soon as possible. The device may return some message body as a result of the method, but it isn't required for the method to do so. There is no guarantee on ordering or any concurrency semantics on method calls.

Direct methods are HTTPS-only from the cloud side and MQTT, AMQP, MQTT over WebSockets, or AMQP over WebSockets from the device side.

The payload for method requests and responses is a JSON document up to 128 KB.

## Invoke a direct method from a back-end app

### Method invocation

Direct method invocations on a device are HTTPS calls that are made up of the following items:

- The request URI specific to the device along with the API version:

  ```http
   https://fully-qualified-iothubname.azure-devices.net/twins/{deviceId}/methods?api-version=2021-04-12
  ```

- The POST method
- Headers that contain the authorization, content type, and content encoding.
- A transparent JSON body in the following format:

  ```json
    {
    "connectTimeoutInSeconds": 200,
    "methodName": "reboot",
    "responseTimeoutInSeconds": 200,
    "payload": {
        "input1": "someInput",
        "input2": "anotherInput"
        }
    }
  ```

The value provided as `responseTimeoutInSeconds` in the request is the amount of time that IoT Hub service must await for completion of a direct method execution on a device. Set this timeout to be at least as long as the expected execution time of a direct method by a device. If timeout is not provided, the default value of 30 seconds is used. The minimum and maximum values for `responseTimeoutInSeconds` are 5 and 300 seconds, respectively.

#### Example

The following is a barebones example using `curl`.

```bash
  curl -X POST \
  https://iothubname.azure-devices.net/twins/myfirstdevice/methods?api-version=2021-04-12 \
  -H 'Authorization: SharedAccessSignature sr=iothubname.azure-devices.net&sig=x&se=x&skn=iothubowner' \
  -H 'Content-Type: application/json' \
  -d '{
    "methodName": "reboot",
    "responseTimeoutInSeconds": 200,
    "payload": {
        "input1": "someInput",
        "input2": "anotherInput"
        }
    }'

```

### Response

The back-end app receives a response that is made up of the following items:

- HTTP status code, which is used for errors coming from the IoT Hub, including a 404 error for devices not currently connected.
- Headers that contain the ETag, request ID, content type, and content encoding.
- A JSON body in the following format:

  ```json
    {
        "status" : 201,
        "payload" : {...}
    }

  ```

Both `status` and `body` are provided by the device and used to respond with the device's own status code and/or description.

### Method invocation for IoT Edge modules

Invoking direct methods on a module is supported by the Invoke module method REST API or its equivalent in one of the IoT Hub service SDKs.

The `moduleId` is passed along with the `deviceId` in the request URI when using the REST API or as a parameter when using a service SDK. For example, `https://<iothubName>.azure-devices.net/twins/<deviceId>/modules/<moduleName>/methods?api-version=2021-04-12`. The request body and response is similar to that of direct methods invoked on the device.

## Handle a direct method on a device

A direct method on a device can receive requests using either the MQTT or AMQP protocol.

### MQTT

The following section is for the MQTT protocol.

#### Method invocation

Devices receive direct method requests on the MQTT topic: `$iothub/methods/POST/{method name}/?$rid={request id}`. However, the `request id` is generated by IoT Hub and cannot be known ahead of time, so subscribe to `$iothub/methods/POST/#` and then filter the delivered messages based on method names supported by your device. (You'll use the `request id` to respond.)

The body that the device receives is in the following format:

```json
  {
        "input1": "someInput",
        "input2": "anotherInput"
  }

```

Method requests are QoS 0.

#### Response

The device sends responses to `$iothub/methods/res/{status}/?$rid={request id}`, where:

- The `status` property is the device-supplied status of method execution.
- The `$rid` property is the request ID from the method invocation received from IoT Hub.

The body is set by the device and can be any status.

### AMQP

The following section is for the AMQP protocol.

#### Method invocation

The device receives direct method requests by creating a receive link on address `amqps://{hostname}:5671/devices/{deviceId}/methods/deviceBound`.

The AMQP message arrives on the receive link that represents the method request. It contains the following sections:

- The correlation ID property, which contains a request ID that should be passed back with the corresponding method response.
- An application property named `IoThub-methodname`, which contains the name of the method being invoked.
- The AMQP message body containing the method payload as JSON.

#### Response

The device creates a sending link to return the method response on address `amqps://{hostname}:5671/devices/{deviceId}/methods/deviceBound`.

The method response is returned on the sending link and is structured as follows:

- The correlation ID property, which contains the request ID passed in the method request message.
- An application property named `IoThub-status`, which contains the user supplied method status.
- The AMQP message body containing the method response as JSON.
