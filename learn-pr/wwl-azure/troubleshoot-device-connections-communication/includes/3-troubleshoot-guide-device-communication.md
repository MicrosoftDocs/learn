The following issue troubleshooting checklists give you some things to try before you file a support ticket.

## Cannot connect to your Azure IoT hub

If your device is not able to connect to your Azure IoT hub, here are a few things to verify:

1.  Are your credentials correct?
    
     -  If you are using X.509 certificates, the thumbprints must match. Make sure the thumbprint in the registry matches the thumbprint of the certificate you are trying to use.
     -  If you are using a connection string with a shared access key, make sure it matches the device or a policy with the DeviceConnect capability.
     -  If you are using a shared access signature, make sure the expiry is correct and that you are using the right shared access key to sign it.
2.  Review your device registry (using the Azure portal) and ensure that your device is enabled.
3.  Can you get through the firewall?
    
     -  The easiest thing to try first is to run a tool that uses your device credentials and checks for a connection using all supported protocols. The iothub-diagnostics tool: [https://github.com/azure/iothub-diagnostics](https://github.com/azure/iothub-diagnostics) is designed to do just that and provides the results in the form of a report.
     -  If you cannot run iothub-diagnostics, you can try to run through the same steps manually:
        
         -  Ping a known website to verify name resolution and outbound traffic works.
         -  Change the transport used to instantiate the client (AMQP, AMQPWS, MQTT, MQTTWS, and HTTP).
4.  Try running the default samples: [https://github.com/Azure/azure-iot-sdk-node/tree/master/device/samples](https://github.com/Azure/azure-iot-sdk-node/tree/master/device/samples).
    
     -  If the samples can connect, try finding differences between how you instantiate the client and how the samples do. it might be a typo.
     -  If the samples cannot connect and neither can iothub-diagnostics, the problem is likely to be an issue with the credentials or your network.

## Not detecting disconnections

The hard thing about disconnections is that they often seem random. Also, if the SDK is not firing an error, there is no way to know what is going on. Or is there?

1.  Could the retry logic be delaying things?
    
     -  Be default the retry logic will go on for 4 minutes. Have you waited that long?
     -  If you do not want to wait, try disabling the retry logic by calling `client.setRetryPolicy(new NoRetry())`;
2.  Need detailed logs? The SDK uses the debug library for logging:
    
     -  Set the `DEBUG` environment variable and run your application again. A few good values for the `DEBUG` environment variable to get you started:
        
         -  The `azure*` parameter will log SDK activity but not the underlying transport library.
         -  The `amqp10*` parameter will log the low-level AMQP library activity.
         -  The `*` parameter will log everything.
     -  The `debug` parameter logs to `stderr` by default, and can be verbose, especially if set to `*`.
     -  If you are saving those logs in order to post them in an issue, be careful to scrape for confidential information!

## Failing to send some messages

Message failures are another tricky one. It looks like some messages are being sent, but not all of them. What gives? The first question to ask is How do you know some messages are not being sent?

1.  If it is because the callback is called with an error, the error object might give you more clues than just a message. Pay attention to the type of the error itself:
    
     -  If it is a custom SDK type, it should be explicit. If explicit typing is not enough, look at the properties of the error and try to see if there is a protocol-specific error in there.
     -  If it is a generic Error, it means the SDK failed to translate that error. When you get a generic error, create an error ticket and give us as many details as possible, including the values of the error properties and the error stack.
2.  If it is because you are not seeing the messages in your cloud application, try checking:
    
     -  On the device side, the arguments passed to the callback of the send operation.
     -  Try using iothub-explorer [https://github.com/azure/iothub-explorer](https://github.com/azure/iothub-explorer) with the `monitor-events` subcommand to check if the messages show up on the event-hubs compatible endpoint of your IoT Hub. If they do, at least you know that the device is acting properly. If they do not, it is unlikely to be a service issue and can track down device-side issues.
