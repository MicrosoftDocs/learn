The following issue troubleshooting checklists give you some things to try before you file a support ticket.

## Cannot connect to your Azure IoT hub

If your device isn't able to connect to your Azure IoT hub, here are a few things to verify:

1. Are your credentials correct?
     * If you're using X.509 certificates, the thumbprints must match. Make sure the thumbprint in the registry matches the thumbprint of the certificate that you're trying to use.
     * If you're using a connection string with a shared access key, make sure it matches the device or a policy with the DeviceConnect capability.
     * If you're using a shared access signature, make sure the expiry is correct and that you're using the right shared access key to sign it.
1. Review your device registry (using the Azure portal) and ensure that your device is enabled.
1. Can you get through the firewall?
     * The easiest thing to try is to run the [iothub-diagnostics](https://github.com/azure/iothub-diagnostics) tool and see if it manages to connect to your Azure IoT hub with your device's credentials. It tries all supported protocols and WebSockets and displays its test results.
     * If you can't run iothub-diagnostics, you can try to run through the same steps manually:
         * Ping a known website to verify name resolution and outbound traffic works.
         * Change the transport used to instantiate the client (AMQP, AMQPWS, MQTT, MQTTWS, and HTTP).
1. Try running the [default samples](https://github.com/Azure/azure-iot-sdk-node/tree/master/device/samples).
     * If the samples can connect, try finding differences between how your program and the samples instantiate the client. The problem might be as simple as a typo.
     * If the samples can't connect and neither can iothub-diagnostics, the problem is likely to be an issue with the credentials or your network.

## Not detecting disconnections

The hard thing about disconnections is that they often seem random. If the SDK isn't firing an error, there's no way to know what is going on. Or is there?

1. Could the retry logic be delaying things?
     * Be default the retry logic goes on for four minutes. Have you waited that long?
     * If you don't want to wait, try disabling the retry logic by calling `client.setRetryPolicy(new NoRetry())`
1. Need detailed logs? The SDK uses the [debug](https://github.com/debug-js/debug) library for logging:
     * Set the `DEBUG` environment variable and run your application again. Here are a few good values for the `DEBUG` environment variable to get you started:
         * The `azure*` parameter logs SDK activity but not the underlying transport library.
         * The `amqp10*` parameter logs the low-level AMQP library activity.
         * The `*` parameter logs everything.
     * The `debug` parameter logs to `stderr` by default, and can be verbose, especially if set to `*`.
     * If you're saving those logs in order to post them in an issue, be careful to scrape for confidential information!

## Failing to send some messages

Message failures are another tricky one. It looks like some messages are being sent, but not all of them. What gives? The first question to ask is "How do you know some messages aren't being sent?"

1. If it's because the callback is called with an error, the error object might give you more clues than just a message. Pay attention to the type of the error itself:
     * If it's a custom SDK type, it should be explicit. If explicit typing isn't enough, look at the properties of the error and try to see if there's a protocol-specific error in there.
     * If it's a generic `Error`, it means the SDK failed to translate that error. When you get a generic error, [file an issue](https://github.com/azure/azure-iot-sdk-node/issues) and give us as many details as possible, including the values of the error properties and the error stack.
1. If it's because you're not seeing the messages in your cloud application, try checking:
     * On the device side, the arguments passed to the callback of the `send` operation.
     * Try using [Azure IoT extension for Azure CLI](https://github.com/Azure/azure-iot-cli-extension) with the `monitor-events` subcommand to check if the messages show up on the event-hubs compatible endpoint of your IoT Hub. If they do, at least you know that the device is acting properly. If they don't, it's unlikely to be a service issue and you can track down device-side issues.
