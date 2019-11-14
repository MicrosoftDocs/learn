At the end of this unit, you'll be sending and receiving telemetry.

## Create an app to send telemetry

::: zone pivot="vscode"

1. To use C# in Visual Studio Code, ensure both [.NET Core](https://dotnet.microsoft.com/download), and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) are installed.

1. Open a terminal in Visual Studio Code, and create a folder called "vibrationdevice" (enter `mkdir vibrationdevice`). Navigate to the vibrationdevice folder.

1. Enter the following command in the terminal: `dotnet new console`. This command creates a **Program.cs** file in your folder, along with a project file.

1. Enter `dotnet restore` in the terminal. This command gives your app access to the required .NET packages.

1. In the terminal, install the required libraries. Enter:
    * **dotnet add package Microsoft.Azure.Devices.Client**
    * **dotnet add package Microsoft.Azure.Devices.Shared**
    * **dotnet add package Newtonsoft.Json**

1. From the **File** menu, open up the **Program.cs** file, and delete the default contents.

1. After you've entered the code below into the **Program.cs** file, you can run the app with the command `dotnet run`. This command will run the **Program.cs** file in the current folder, so ensure you are in the vibrationdevice folder.

::: zone-end

::: zone pivot="vstudio"

1. Open Visual Studio, and create a new **Visual C#/Windows Desktop** project. Select **Console App (.NET Framework)**.

1. Give the project a friendly name, such as "VibrationDevice".

1. Under **Tools/NuGet Package Manager**, select **Manage NuGet Packages for Solution**. Install the following libraries:
    * **Microsoft.Azure.Devices.Client**
    * **Microsoft.Azure.Devices.Shared**
    * **Newtonsoft.Json**

1. Delete the default contents of the **Program.cs** file.

1. Add all the code that follows to the **Program.cs** file.

::: zone-end

> [!NOTE]
> This module doesn't require you to download any code. However, all of the code is available from [GitHub/MicrosoftDocs/mslearn-remotely-monitor-and-control-devices-with-iot-hub](https://github.com/MicrosoftDocs/mslearn-remotely-monitor-and-control-devices-with-iot-hub), if needed.

### Add code to send telemetry

This section adds code to send telemetry from a simulated device. The device sends temperature (in degrees fahrenheit) and humidity (in percentages), regardless of whether any back-end app is listening or not.

1. Open the **Program.cs** file for the device app.

1. Copy and paste the following code.

    ```cs
        // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE file in the project root for full license information.
    
    using System;
    using Microsoft.Azure.Devices.Client;
    //using Microsoft.Azure.Devices.Shared;
    using Newtonsoft.Json;
    using System.Text;
    using System.Threading.Tasks;
    
    namespace simulated_device
    {
        class SimulatedDevice
        {
            enum speedEnum
            {
                stopped,
                slow,
                fast
            }
            // Conveyor belt globals.
            private static int packageCount = 0;                                        // Count of packages leaving the conveyor belt.
            private static speedEnum beltSpeed = speedEnum.stopped;                     // Initial state of the conveyor belt.
            private static double slowPackagesPerSecond = 1;                            // Packages completed at slow speed/ per second
            private static double fastPackagesPerSecond = 2;                            // Packages completed at fast speed/ per second
            private static double beltStoppedSeconds = 0;                               // Time the belt has been stopped.
    
            // Vibration globals.
            private const int intervalInMilliseconds = 3000;                            // Time interval required by wait function.
            private static int intervalInSeconds = intervalInMilliseconds / 1000;       // Time interval in seconds.
            private static double seconds = 0;                                          // Time conveyor belt is running.   
            private static double forcedSeconds = 0;                                    // Time since forced vibration started.
            private static double increasingSeconds = 0;                                // Time since increasing vibration started.
            private static double dampingSeconds = 0;                                   // Time since damping vibration started.
    
            private static bool forcedVibration = false;                                // True if forced vibration is occuring.
            private static bool increasingVibration = false;                            // True if increasing vibration is occuring.
            private static bool dampingVibration = false;                               // True if damping vibration is occuring.
    
            private static double basicConstant;                                        // Constant identifing the severity of normal vibration.
            private static double forcedConstant;                                       // Constant identifing the severity of forced vibration.
            private static double increasingConstant;                                   // Constant identifing the severity of increasing vibration.
            private static double dampingConstant;                                      // Constant identifing the severity of damping vibration.
    
            // IoT Hub global variables.
            private static DeviceClient s_deviceClient;
    
            // The device connection string to authenticate the device with your IoT hub.
            private readonly static string s_deviceConnectionString = "HostName=CheeseCaveHub.azure-devices.net;DeviceId=CheeseCaveIDC;SharedAccessKey=Mysj4rgrA3UbEVVaBtgRnygvGCiEEnPARA6iclJ6uQc=";
    
            private static void colorMessage(string text, ConsoleColor clr)
            {
                Console.ForegroundColor = clr;
                Console.WriteLine(text);
                Console.ResetColor();
            }
            private static void greenMessage(string text)
            {
                colorMessage(text, ConsoleColor.Green);
            }
    
            private static void redMessage(string text)
            {
                colorMessage(text, ConsoleColor.Red);
            }
    
            // Async method to send simulated telemetry.
            private static async void SendDeviceToCloudMessagesAsync(Random rand)
            {
                // Simulate the vibration telemetry of a conveyor belt.
                double vibration;
    
                while (true)
                {
                    // Randomly adjust belt speed.
                    switch (beltSpeed)
                    {
                        case speedEnum.fast:
                            if (rand.NextDouble() < 0.01)
                            {
                                beltSpeed = speedEnum.stopped;
                            }
                            if (rand.NextDouble() > 0.95)
                            {
                                beltSpeed = speedEnum.slow;
                            }
                            break;
    
                        case speedEnum.slow:
                            if (rand.NextDouble() < 0.01)
                            {
                                beltSpeed = speedEnum.stopped;
                            }
                            if (rand.NextDouble() > 0.95)
                            {
                                beltSpeed = speedEnum.fast;
                            }
                            break;
    
                        case speedEnum.stopped:
                            if (rand.NextDouble() > 0.75)
                            {
                                beltSpeed = speedEnum.slow;
                            }
                            break;
                    }
    
                    // Set vibration levels.
    
                    if (beltSpeed == speedEnum.stopped)
                    {
                        // If the belt is stopped, all vibration comes to a halt.
                        forcedVibration = false;
                        increasingVibration = false;
                        dampingVibration = false;
                        vibration = 0;
    
                        // Record how much time the belt is stopped, in case we need to send an alert.
                        beltStoppedSeconds += intervalInSeconds;
                    }
                    else
                    {
                        // Conveyor belt is running.
                        beltStoppedSeconds = 0;
    
                        // Check for random starts in unwanted vibrations.
    
                        // Check forced vibration.
                        if (!forcedVibration)
                        {
                            if (rand.NextDouble() < 0.01)
                            {
                                // Forced vibration starts.
                                forcedVibration = true;
                                forcedConstant = 1 + 6 * rand.NextDouble();             // A number between 1 and 7.
                                if (beltSpeed == speedEnum.slow)
                                    forcedConstant /= 2;                                // Lesser vibration if slower speeds.
                                forcedSeconds = 0;
                                redMessage("Forced vibration starting: " + Math.Round(forcedConstant, 5));
                            }
                        }
                        else
                        {
                            if (rand.NextDouble() > 0.99)
                            {
                                forcedVibration = false;
                                greenMessage("Forced vibration stopped");
                            }
                        }
    
                        // Check increasing vibration.
                        if (!increasingVibration)
                        {
                            if (rand.NextDouble() < 0.01)
                            {
                                // Increasing vibration starts.
                                increasingVibration = true;
                                increasingConstant = 100 + 100 * rand.NextDouble();     // A number between 100 and 200.
                                if (beltSpeed == speedEnum.slow)
                                    increasingConstant *= 2;                            // Longer period if slower speeds.
                                increasingSeconds = 0;
                                redMessage("Increasing vibration starting: " + Math.Round(increasingConstant, 5));
                            }
                        }
                        else
                        {
                            if (rand.NextDouble() > 0.99)
                            {
                                increasingVibration = false;
                                greenMessage("Increasing vibration stopped");
                            }
                        }
    
                        // Check damping vibration.
                        if (!dampingVibration)
                        {
                            if (rand.NextDouble() < 0.01)
                            {
                                // Damping vibration starts.
                                dampingVibration = true;
                                dampingConstant = 0.1 + 0.1 * rand.NextDouble();        // A number between 0.1 and 0.2.
                                if (beltSpeed == speedEnum.slow)
                                    dampingConstant *= 2;                               // Damping quicker at slower speeds.
                                dampingSeconds = 0;
                                redMessage("Damping vibration starting: " + Math.Round(dampingConstant, 5));
                            }
                        }
                        else
                        {
                            if (rand.NextDouble() > 0.99)
                            {
                                dampingVibration = false;
                                greenMessage("Damping vibration stopped");
                            }
                        }
    
                        // Apply the vibrations, starting with basic (normal) vibration.
                        vibration = basicConstant * Math.Sin(seconds);
    
                        if (forcedVibration)
                        {
                            // Add forced vibration.
                            vibration += forcedConstant * Math.Sin(0.75 * forcedSeconds) * Math.Sin(10 * forcedSeconds);
                            forcedSeconds += intervalInSeconds;
                        }
    
                        if (increasingVibration)
                        {
                            // Add increasing vibration.
                            vibration += (increasingSeconds / increasingConstant) * Math.Sin(increasingSeconds);
                            increasingSeconds += intervalInSeconds;
                        }
    
                        if (dampingVibration)
                        {
                            // Multiply vibration by damping vibration, as the equation gives results starting at 1 and slowly decreases to 0.
                            vibration *= Math.Pow(Math.E, -dampingConstant * dampingSeconds) * Math.Cos(2 * Math.PI * dampingSeconds);
                            dampingSeconds += intervalInSeconds;
                        }
                    }
    
                    // Increment the time since the conveyor belt app started.
                    seconds += intervalInSeconds;
    
                    // Count the packages that have completed their journey.
                    switch (beltSpeed)
                    {
                        case speedEnum.fast:
                            packageCount += (int)(fastPackagesPerSecond * intervalInSeconds);
                            break;
    
                        case speedEnum.slow:
                            packageCount += (int)(slowPackagesPerSecond * intervalInSeconds);
                            break;
    
                        case speedEnum.stopped:
                            // No packages!
                            break;
                    }
    
                    // Create the JSON message.
                    var telemetryDataPoint = new
                    {
                        vibration = Math.Round(vibration, 5),
                        packages = packageCount,
                        speed = beltSpeed.ToString()
                    };
                    var messageString = JsonConvert.SerializeObject(telemetryDataPoint);
                    var message = new Message(Encoding.ASCII.GetBytes(messageString));
    
                    // Add custom application properties to the message.
                    message.Properties.Add("sensorID", "VS1");
    
                    // Send an alert if the belt has been stopped for more than five seconds.
                    message.Properties.Add("beltAlert", (beltStoppedSeconds > 5) ? "true" : "false");
    
                    Console.WriteLine("Message data: {0}", messageString);
    
                    // Send the telemetry message.
                    await s_deviceClient.SendEventAsync(message);
                    greenMessage("Message sent\n");
    
                    await Task.Delay(intervalInMilliseconds);
                }
            }
    
            private static void Main(string[] args)
            {
                Random rand = new Random();
                colorMessage("Vibration sensor device app.\n", ConsoleColor.Yellow);
    
                // Connect to the IoT hub using the MQTT protocol.
                s_deviceClient = DeviceClient.CreateFromConnectionString(s_deviceConnectionString, TransportType.Mqtt);
    
                // Create a number between 2 and 4, as a constant for normal vibration levels.
                basicConstant = 2 + 2 * rand.NextDouble();
    
                SendDeviceToCloudMessagesAsync(rand);
                Console.ReadLine();
            }
        }
    }
    ```

    > [!NOTE]
    > Read through the comments in the code, noting how the temperature and humidity settings from the description of the scenario in the introduction have worked their way into the code.

1. Replace the &lt;your device connection string&gt; with the device connection string you saved off in the previous unit. No other lines of code need to be changed.

1. Save the **Program.cs** file.

### Test your code to send telemetry

1. Run the app.
1. You should quickly get a console screen, similar to the following image. Note the use of green text, to show things are working as they should! If you don't get a screen similar to this image, check your device connection string carefully.

    ![Screenshot showing the temperature and humidity telemetry being sent](../media/vibration-telemetry.png)

1. Watch the telemetry for a short while, checking that is it giving temperatures and humidity in the expected ranges.
1. You can leave this app running, as it's needed for the next section.

## Create a second app to receive telemetry

Now we have a device pumping out telemetry, we need to listen for that telemetry with a back-end app, also connected to our IoT Hub.

::: zone pivot="vscode"

1. Open a terminal in Visual Studio Code, and create a folder called "vibrationhub" (enter `mkdir vibrationhub`). Navigate to the vibrationhub folder.

1. Enter the following command in the terminal: `dotnet new console`. This command creates a **Program.cs** file in your folder, along with a project file.

1. Enter `dotnet restore` in the terminal. This command gives your app access to the required .NET packages.

1. In the terminal, enter the following commands:
    * **dotnet add package Microsoft.Azure.EventHubs**
    * **dotnet add package Microsoft.Azure.Device**
    * **dotnet add package Newtonsoft.Json**.

1. From the **File** menu, open up the **Program.cs** file, and delete the default contents.

1. After you've entered the code below into the **Program.cs** file, run the code with the command `dotnet run`. This command will run the **Program.cs** file in the current folder, so ensure you are in the correct folder.

::: zone-end
::: zone pivot="vstudio"

1. Open Visual Studio, and create a new **Visual C#/Windows Desktop** project. Select **Console App (.NET Framework)**.

1. Give the project a friendly name, such as "VibrationHub".

1. Under **Tools/NuGet Package Manager**, select **Manage NuGet Packages for Solution**. Install the following libraries:
    * **Microsoft.Azure.Devices**
    * **Microsoft.Azure.EventHubs**
    * **Newtonsoft.Json**

1. Delete the default contents of **Program.cs**.

1. Add all the code that follows to the **Program.cs** file.

::: zone-end

### Add code to receive telemetry

1. Open the **Program.cs** file for the back-end app.

    ```cs
    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE file in the project root for full license information.
    
    using System;
    using System.Threading.Tasks;
    using System.Text;
    using System.Collections.Generic;
    using System.Linq;
    
    using Microsoft.Azure.EventHubs;
    //using Microsoft.Azure.Devices;
    //using Newtonsoft.Json;
    
    namespace cheesecave_hub
    {
        class ReadDeviceToCloudMessages
        {
            // Global variables.
            // The Event Hub-compatible endpoint.
            private readonly static string s_eventHubsCompatibleEndpoint = "sb://iothub-ns-cheesecave-2368755-e53cd0b18d.servicebus.windows.net/";
    
            // The Event Hub-compatible name.
            private readonly static string s_eventHubsCompatiblePath = "cheesecavehub";
            private readonly static string s_iotHubSasKey = "YqP4WaKpQ5hbY8UtERrr4gf1oULKVXO1KjMQDibuS7U=";
            private readonly static string s_iotHubSasKeyName = "service";
            private static EventHubClient s_eventHubClient;
    
            // Asynchronously create a PartitionReceiver for a partition and then start reading any messages sent from the simulated client.
            private static async Task ReceiveMessagesFromDeviceAsync(string partition)
            {
                // Create the receiver using the default consumer group.
                var eventHubReceiver = s_eventHubClient.CreateReceiver("$Default", partition, EventPosition.FromEnqueuedTime(DateTime.Now));
                Console.WriteLine("Created receiver on partition: " + partition);
    
                while (true)
                {
                    // Check for EventData - this methods times out if there is nothing to retrieve.
                    var events = await eventHubReceiver.ReceiveAsync(100);
    
                    // If there is data in the batch, process it.
                    if (events == null) continue;
    
                    foreach (EventData eventData in events)
                    {
                        string data = Encoding.UTF8.GetString(eventData.Body.Array);
    
                        greenMessage("Telemetry received: " + data);
    
                        // Check for alerts.
                        foreach (var prop in eventData.Properties)
                        {
                            if (prop.Value.ToString() == "true")
                            {
                                redMessage(prop.Key);
                            }
                        }
                        Console.WriteLine();
                    }
                }
            }
    
            public static void Main(string[] args)
            {
                colorMessage("Vibration Sensor Hub\n", ConsoleColor.Yellow);
    
                // Create an EventHubClient instance to connect to the IoT Hub Event Hubs-compatible endpoint.
                var connectionString = new EventHubsConnectionStringBuilder(new Uri(s_eventHubsCompatibleEndpoint), s_eventHubsCompatiblePath, s_iotHubSasKeyName, s_iotHubSasKey);
                s_eventHubClient = EventHubClient.CreateFromConnectionString(connectionString.ToString());
    
                // Create a PartitionReceiver for each partition on the hub.
                var runtimeInfo = s_eventHubClient.GetRuntimeInformationAsync().GetAwaiter().GetResult();
                var d2cPartitions = runtimeInfo.PartitionIds;
    
                // Create receivers to listen for messages.
                var tasks = new List<Task>();
                foreach (string partition in d2cPartitions)
                {
                    tasks.Add(ReceiveMessagesFromDeviceAsync(partition));
                }
    
                // Wait for all the PartitionReceivers to finish.
                Task.WaitAll(tasks.ToArray());
            }
            
            private static void colorMessage(string text, ConsoleColor clr)
            {
                Console.ForegroundColor = clr;
                Console.WriteLine(text);
                Console.ResetColor();
            }
            private static void greenMessage(string text)
            {
                colorMessage(text, ConsoleColor.Green);
            }
    
            private static void redMessage(string text)
            {
                colorMessage(text, ConsoleColor.Red);
            }
        }
    }
    ```

    > [!NOTE]
    > Our implementation only reads messages after the back-end app has been started. Any telemetry sent prior to this isn't handled.

1. Replace the &lt;your service connection string&gt; with the _service_ connection string you saved off in a text file, in the previous unit.

1. Replace the &lt;your event hub endpoint&gt;, &lt;your event hub path&gt;, and the &lt;your event hub Sas key&gt; with the strings you saved off to your text file.

1. Save the **Program.cs** file.

### Test your code to receive telemetry

This test is important, checking whether your back-end app is picking up the telemetry being sent out by your simulated device. Remember your device app is still running, and sending telemetry.

1. Run the service app.
1. A second console window should open up, and immediately respond if it successfully connects to IoT Hub. If not, carefully check your IoT Hub service connection string, noting that this string should be the _service_ connection string, and not any other.

    ![Screenshot showing the temperature and humidity telemetry being received](../media/vibration-telemetry-received.png)

1. Visually compare the telemetry sent and received. Is there an exact match? Is there much of a delay? If it looks good, close both the console windows for now.

Completing this unit is great progress. you've an app sending telemetry from a device, and a back-end app acknowledging receipt of the data. This unit covers the _monitoring_ side of our scenario. The next step handles the _control_ side - what to do when issues arise with the data. Clearly, there are issues, we're getting temperature and humidity alerts!
