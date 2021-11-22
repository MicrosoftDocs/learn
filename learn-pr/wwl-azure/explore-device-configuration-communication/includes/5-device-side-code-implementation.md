Along with the Device SDK, Microsoft has developed sample code projects that illustrate common coding tasks.

The Sample Projects for C\# include:

 -  DeviceStreamingSample
 -  FileUploadSample
 -  ImportExportDevicesSample
 -  KeysRolloverSample
 -  MessageSample
 -  MethodSample
 -  TwinSample
 -  XamarinSample

## MessageSample project

The MessageSample project includes the following code files:

 -  MessageSample.cs
 -  MessageSample.csproj
 -  Program.cs

### Examine Program.cs

The contents of the Program.cs file should be similar to the code shown below. Look for the following within this code:

 -  This class uses a device connection string.
 -  The **DeviceClient** class is used for communication between the device and the **IoT Hub**.

```csharp
// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System;

namespace Microsoft.Azure.Devices.Client.Samples
{
    public class Program
    {
        // String containing Hostname, Device Id & Device Key in one of the following formats:
        //  "HostName=<iothub_host_name>;DeviceId=<device_id>;SharedAccessKey=<device_key>"
        //  "HostName=<iothub_host_name>;CredentialType=SharedAccessSignature;DeviceId=<device_id>;SharedAccessSignature=SharedAccessSignature sr=<iot_host>/devices/<device_id>&sig=<token>&se=<expiry_time>";

        // For this sample either
        // - pass this value as a command-prompt argument
        // - set the IOTHUB_DEVICE_CONN_STRING environment variable
        // - create a launchSettings.json (see launchSettings.json.template) containing the variable

        private static string s_deviceConnectionString = Environment.GetEnvironmentVariable("IOTHUB_DEVICE_CONN_STRING");

        // Select one of the following transports used by DeviceClient to connect to IoT Hub.
        private static TransportType s_transportType = TransportType.Amqp;
        //private static TransportType s_transportType = TransportType.Mqtt;
        //private static TransportType s_transportType = TransportType.Http1;
        //private static TransportType s_transportType = TransportType.Amqp_WebSocket_Only;
        //private static TransportType s_transportType = TransportType.Mqtt_WebSocket_Only;

        public static int Main(string[] args)
        {
            if (string.IsNullOrEmpty(s_deviceConnectionString) && args.Length > 0)
            {
                s_deviceConnectionString = args[0];
            }

            DeviceClient deviceClient = DeviceClient.CreateFromConnectionString(s_deviceConnectionString, s_transportType);

            if (deviceClient == null)
            {
                Console.WriteLine("Failed to create DeviceClient!");
                return 1;
            }

            var sample = new MessageSample(deviceClient);
            sample.RunSampleAsync().GetAwaiter().GetResult();

            Console.WriteLine("Done.\n");

            return 0;
        }
    }
}

```

The `CreateFromConnectionString` static method on the `DeviceClient` class accepts connection string and protocol parameters, and the return type is **DeviceClient**. If successful, the function will return an instance of the **DeviceClient** class. If it fails, it will return null. We use the generated IoT Hub client when invoking other functions.

Notice that we are passing the device connection string and that we also designate the communications protocol that we will be using (this example uses AMQP, but MQTT and HTTPS are also options). If the client is null, we log to the console, otherwise we continue as noted above.

> [!TIP]
> Obviously, logging to the console is not good error handling. In a production system, this should be logged to a storage location that is monitored, or has alerts delivered to support technicians.

You can obtain the device connection string from the Azure portal.

> [!IMPORTANT]
> You will see examples in training materials where connection strings, passwords, and other configuration items are hard-coded into the application. This approach is used to simplify the activity and **is not** a recommended practice. As much as possible, security issues like this will be addressed as they come up in the labs. Security topics (and other important considerations) will be addressed during the instructor presentation and in your Student Handbook content in a manner that supports the overall flow of the course. The two may not always align perfectly. As a result, you may be exposed to topics in the labs that are not covered in detail until later in the course.

> [!NOTE]
> Once you have a valid **DeviceClient** object, you can start calling the APIs to send and receive messages to and from IoT Hub.

### Examine the MessageSample.cs file

The contents of the MessageSample.cs file should be similar to the code shown below.

```csharp
// Copyright (c) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System;
using System.Text;
using System.Threading.Tasks;

namespace Microsoft.Azure.Devices.Client.Samples
{
    public class MessageSample
    {
        private const int MessageCount = 5;
        private const int TemperatureThreshold = 30;
        private static Random s_randomGenerator = new Random();
        private float _temperature;
        private float _humidity;
        private DeviceClient _deviceClient;

        public MessageSample(DeviceClient deviceClient)
        {
            _deviceClient = deviceClient ?? throw new ArgumentNullException(nameof(deviceClient));
        }

        public async Task RunSampleAsync()
        {
            await SendEvent().ConfigureAwait(false);
            await ReceiveCommands().ConfigureAwait(false);
        }

        private async Task SendEvent()
        {
            string dataBuffer;

            Console.WriteLine("Device sending {0} messages to IoTHub...\n", MessageCount);

            for (int count = 0; count < MessageCount; count++)
            {
                _temperature = s_randomGenerator.Next(20, 35);
                _humidity = s_randomGenerator.Next(60, 80);
                dataBuffer = $"{{\"messageId\":{count},\"temperature\":{_temperature},\"humidity\":{_humidity}}}";

                Message eventMessage = new Message(Encoding.UTF8.GetBytes(dataBuffer));

                eventMessage.Properties.Add("temperatureAlert", (_temperature > TemperatureThreshold) ? "true" : "false");

                Console.WriteLine("\t{0}> Sending message: {1}, Data: [{2}]", DateTime.Now.ToLocalTime(), count, dataBuffer);

                await _deviceClient.SendEventAsync(eventMessage).ConfigureAwait(false);
            }
        }

        private async Task ReceiveCommands()
        {
            Console.WriteLine("\nDevice waiting for commands from IoTHub...\n");
            Console.WriteLine("Use the IoT Hub Azure Portal to send a message to this device.\n");

            Message receivedMessage;
            string messageData;

            receivedMessage = await _deviceClient.ReceiveAsync(TimeSpan.FromSeconds(30)).ConfigureAwait(false);

            if (receivedMessage != null)
            {
                messageData = Encoding.ASCII.GetString(receivedMessage.GetBytes());

                Console.WriteLine("\t{0}> Received message: {1}", DateTime.Now.ToLocalTime(), messageData);

                int propCount = 0;
                foreach (var prop in receivedMessage.Properties)
                {
                    Console.WriteLine("\t\tProperty[{0}> Key={1} : Value={2}", propCount++, prop.Key, prop.Value);
                }

                await _deviceClient.CompleteAsync(receivedMessage).ConfigureAwait(false);
            }
            else
            {
                Console.WriteLine("\t{0}> Timed out", DateTime.Now.ToLocalTime());
            }
        }
    }
}

```

Notice that the SendEvent method will generate random weather data, and send messages to the **IoT Hub**. The **MessageCount** property is set to **5**, which will send 5 messages in the **for** loop.

Inspecting the body of the **for** loop, we see that the **\_temperature**, and **\_humidity** variables are set to randomly generated numbers. The temperature between **20** and **35**, whereas the humidity is between **60** and **80**. Next, the **dataBuffer** variable is a **JSON** representation of the data. In the previous lab, you serialized a dynamic object into **JSON**, and this example manually creates the **JSON**. It does not matter which approach you take, but I have found that serializing an object is more accurate, and fewer issues arise.

In the next three lines the message is created, and a custom property is added to the message. Then, a message is written to the console that indicates a message is going out, the current date and time, the message number, and the message body.

The last line in the **for** loop sends the message to the **IoT Hub** by calling the `SendEventAsync` method.

> [!TIP]
> One thing that is missing from this sample is any error handling. If communication issues arise, or the connection string is incorrect, this application will not fail gracefully. It is usually a good idea to include some basic error handling, even in prototypes applications.
