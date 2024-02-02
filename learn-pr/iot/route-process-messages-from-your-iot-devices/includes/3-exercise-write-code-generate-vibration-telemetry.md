Both long term and real-time data analysis are required to automate the monitoring of the conveyor belt system and enable predictive maintenance. Since no historical data exists, your first step is to generate simulated data that mimics vibration data and data anomalies in a realistic manner. Company engineers developed an algorithm to simulate vibration over time and embedded the algorithm within a code class for you to implement. The engineers agreed to support any future updates required to adjust the algorithms.

During your initial prototype phase, you implement a single IoT device that generates telemetry data. In addition to the vibration data, your device creates some other values (packages delivered, ambient temperature, and similar metrics) that are sent to Blob Storage. This extra data simulates the data that is used to develop machine learning modules for predictive maintenance.

In this exercise, you:

* Create the simulated device project
* Add the connection string for your simulated device and review the project code
* Test your simulated device connection and telemetry communications
* Ensure that telemetry is arriving at your IoT hub

### Task 1: Open your simulated device project

<!-- TODO: MOVE THE SAMPLE CODE INTO GITHUB -->

1. On your development machine, create a working folder for this project named **VibrationDevice**. You create all Visual Studio Code files for this project within this folder.

1. Open Visual Studio Code.

1. In Visual Studio Code, select **File**, then **Select Folder**, then navigate to your **VibrationDevice** folder, then select **Open Folder**.

1. Create a file named **Program.cs** in the **VibrationDevice** folder.

1. Paste the following code into the **Program.cs** file.

   This simulated device application uses Symmetric key authentication, sends both telemetry and logging messages to the IoT hub, and simulates the implementation of sensor inputs.

   ```csharp
   // Copyright (c) Microsoft. All rights reserved.
   // Licensed under the MIT license. See LICENSE file in the project root for full license information.

   using System;
   using Microsoft.Azure.Devices.Client;
   using Newtonsoft.Json;
   using System.Text;
   using System.Threading.Tasks;

   namespace VibrationDevice
   {
       class Program
       {
           // Telemetry globals.
           private const int intervalInMilliseconds = 2000; // Time interval required by wait function.

           // IoT Hub global variables.
           private static DeviceClient deviceClient;

           // The device connection string to authenticate the device with your IoT hub.
           private readonly static string deviceConnectionString = "<your device connection string>";

           private static void Main(string[] args)
           {
               ConsoleHelper.WriteColorMessage("Vibration sensor device app.\n", ConsoleColor.Yellow);

               // Connect to the IoT hub using the MQTT protocol.
               deviceClient = DeviceClient.CreateFromConnectionString(deviceConnectionString, TransportType.Mqtt);

               SendDeviceToCloudMessagesAsync();
               Console.ReadLine();
           }

           // Async method to send simulated telemetry.
           private static async void SendDeviceToCloudMessagesAsync()
           {
               var conveyor = new ConveyorBeltSimulator(intervalInMilliseconds);

               // Simulate the vibration telemetry of a conveyor belt.
               while (true)
               {
                   var vibration = conveyor.ReadVibration();

                   await CreateTelemetryMessage(conveyor, vibration);

                   await CreateLoggingMessage(conveyor, vibration);

                   await Task.Delay(intervalInMilliseconds);
               }
           }

           private static async Task CreateTelemetryMessage(ConveyorBeltSimulator conveyor, double vibration)
           {
               var telemetryDataPoint = new
               {
                   vibration = vibration,
               };
               var telemetryMessageString = JsonConvert.SerializeObject(telemetryDataPoint);
               var telemetryMessage = new Message(Encoding.ASCII.GetBytes(telemetryMessageString));

               // Add a custom application property to the message. This is used to route the message.
               telemetryMessage.Properties.Add("sensorID", "VSTel");

               // Send an alert if the belt has been stopped for more than five seconds.
               telemetryMessage.Properties.Add("beltAlert", (conveyor.BeltStoppedSeconds > 5) ? "true" : "false");

               Console.WriteLine($"Telemetry data: {telemetryMessageString}");

               // Send the telemetry message.
               await deviceClient.SendEventAsync(telemetryMessage);
               ConsoleHelper.WriteGreenMessage($"Telemetry sent {DateTime.Now.ToShortTimeString()}");
           }  

           private static async Task CreateLoggingMessage(ConveyorBeltSimulator conveyor, double vibration)
           {
               // Create the logging JSON message.
               var loggingDataPoint = new
               {
                   vibration = Math.Round(vibration, 2),
                   packages = conveyor.PackageCount,
                   speed = conveyor.BeltSpeed.ToString(),
                   temp = Math.Round(conveyor.Temperature, 2),
               };
               var loggingMessageString = JsonConvert.SerializeObject(loggingDataPoint);
               var loggingMessage = new Message(Encoding.ASCII.GetBytes(loggingMessageString));

               // Add a custom application property to the message. This is used to route the message.
               loggingMessage.Properties.Add("sensorID", "VSLog");

               // Send an alert if the belt has been stopped for more than five seconds.
               loggingMessage.Properties.Add("beltAlert", (conveyor.BeltStoppedSeconds > 5) ? "true" : "false");

               Console.WriteLine($"Log data: {loggingMessageString}");

               // Send the logging message.
               await deviceClient.SendEventAsync(loggingMessage);
               ConsoleHelper.WriteGreenMessage("Log data sent\n");
           }
       }

       internal class ConveyorBeltSimulator
       {
           Random rand = new Random();

           private readonly int intervalInSeconds;

           // Conveyor belt globals.
           public enum SpeedEnum
           {
               stopped,
               slow,
               fast
           }
           private int packageCount = 0;                                        // Count of packages leaving the conveyor belt.
           private SpeedEnum beltSpeed = SpeedEnum.stopped;                     // Initial state of the conveyor belt.
           private readonly double slowPackagesPerSecond = 1;                   // Packages completed at slow speed/ per second
           private readonly double fastPackagesPerSecond = 2;                   // Packages completed at fast speed/ per second
           private double beltStoppedSeconds = 0;                               // Time the belt has been stopped.
           private double temperature = 60;                                     // Ambient temperature of the facility.
           private double seconds = 0;                                          // Time conveyor belt is running.

           // Vibration globals.
           private double forcedSeconds = 0;                                    // Time since forced vibration started.
           private double increasingSeconds = 0;                                // Time since increasing vibration started.
           private double naturalConstant;                                      // Constant identifying the severity of natural vibration.
           private double forcedConstant = 0;                                   // Constant identifying the severity of forced vibration.
           private double increasingConstant = 0;                               // Constant identifying the severity of increasing vibration.

           public double BeltStoppedSeconds { get => beltStoppedSeconds; }
           public int PackageCount { get => packageCount; }
           public double Temperature { get => temperature; }
           public SpeedEnum BeltSpeed { get => beltSpeed; }

           internal ConveyorBeltSimulator(int intervalInMilliseconds)
           {
               // Create a number between 2 and 4, as a constant for normal vibration levels.
               naturalConstant = 2 + 2 * rand.NextDouble();
               intervalInSeconds = intervalInMilliseconds / 1000;  // Time interval in seconds.
           }

           internal double ReadVibration()
           {
               double vibration;

               // Randomly adjust belt speed.
               switch (beltSpeed)
               {
                   case SpeedEnum.fast:
                       if (rand.NextDouble() < 0.01)
                       {
                           beltSpeed = SpeedEnum.stopped;
                       }
                       if (rand.NextDouble() > 0.95)
                       {
                           beltSpeed = SpeedEnum.slow;
                       }
                       break;

                   case SpeedEnum.slow:
                       if (rand.NextDouble() < 0.01)
                       {
                           beltSpeed = SpeedEnum.stopped;
                       }
                       if (rand.NextDouble() > 0.95)
                       {
                           beltSpeed = SpeedEnum.fast;
                       }
                       break;

                   case SpeedEnum.stopped:
                       if (rand.NextDouble() > 0.75)
                       {
                           beltSpeed = SpeedEnum.slow;
                       }
                       break;
               }

               // Set vibration levels.
               if (beltSpeed == SpeedEnum.stopped)
               {
                   // If the belt is stopped, all vibration comes to a halt.
                   forcedConstant = 0;
                   increasingConstant = 0;
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
                   if (forcedConstant == 0)
                   {
                       if (rand.NextDouble() < 0.1)
                       {
                           // Forced vibration starts.
                           forcedConstant = 1 + 6 * rand.NextDouble();             // A number between 1 and 7.
                           if (beltSpeed == SpeedEnum.slow)
                               forcedConstant /= 2;                                // Lesser vibration if slower speeds.
                           forcedSeconds = 0;
                           ConsoleHelper.WriteRedMessage($"Forced vibration starting with severity: {Math.Round(forcedConstant, 2)}");
                       }
                   }
                   else
                   {
                       if (rand.NextDouble() > 0.99)
                       {
                           forcedConstant = 0;
                           ConsoleHelper.WriteGreenMessage("Forced vibration stopped");
                       }
                       else
                       {
                           ConsoleHelper.WriteRedMessage($"Forced vibration: {Math.Round(forcedConstant, 1)} started at: {DateTime.Now.ToShortTimeString()}");
                       }
                   }

                   // Check increasing vibration.
                   if (increasingConstant == 0)
                   {
                       if (rand.NextDouble() < 0.05)
                       {
                           // Increasing vibration starts.
                           increasingConstant = 100 + 100 * rand.NextDouble();     // A number between 100 and 200.
                           if (beltSpeed == SpeedEnum.slow)
                               increasingConstant *= 2;                            // Longer period if slower speeds.
                           increasingSeconds = 0;
                           ConsoleHelper.WriteRedMessage($"Increasing vibration starting with severity: {Math.Round(increasingConstant, 2)}");
                       }
                   }
                   else
                   {
                       if (rand.NextDouble() > 0.99)
                       {
                           increasingConstant = 0;
                           ConsoleHelper.WriteGreenMessage("Increasing vibration stopped");
                       }
                       else
                       {
                           ConsoleHelper.WriteRedMessage($"Increasing vibration: {Math.Round(increasingConstant, 1)} started at: {DateTime.Now.ToShortTimeString()}");
                       }
                   }

                   // Apply the vibrations, starting with natural vibration.
                   vibration = naturalConstant * Math.Sin(seconds);

                   if (forcedConstant > 0)
                   {
                       // Add forced vibration.
                       vibration += forcedConstant * Math.Sin(0.75 * forcedSeconds) * Math.Sin(10 * forcedSeconds);
                       forcedSeconds += intervalInSeconds;
                   }

                   if (increasingConstant > 0)
                   {
                       // Add increasing vibration.
                       vibration += (increasingSeconds / increasingConstant) * Math.Sin(increasingSeconds);
                       increasingSeconds += intervalInSeconds;
                   }
               }

               // Increment the time since the conveyor belt app started.
               seconds += intervalInSeconds;

               // Count the packages that have completed their journey.
               switch (beltSpeed)
               {
                   case SpeedEnum.fast:
                       packageCount += (int)(fastPackagesPerSecond * intervalInSeconds);
                       break;

                   case SpeedEnum.slow:
                       packageCount += (int)(slowPackagesPerSecond * intervalInSeconds);
                       break;

                   case SpeedEnum.stopped:
                       // No packages!
                       break;
               }

               // Randomly vary ambient temperature.
               temperature += rand.NextDouble() - 0.5d;
               return vibration;
           }
       }

       internal static class ConsoleHelper
       {
           internal static void WriteColorMessage(string text, ConsoleColor clr)
           {
               Console.ForegroundColor = clr;
               Console.WriteLine(text);
               Console.ResetColor();
           }
           internal static void WriteGreenMessage(string text)
           {
               WriteColorMessage(text, ConsoleColor.Green);
           }

           internal static void WriteRedMessage(string text)
           {
               WriteColorMessage(text, ConsoleColor.Red);
           }
       }
   }
   ```

1. At the top of the **Program.cs** file, find the `deviceConnectionString` parameter. Replace the placeholder value with the **Primary connection string** you copied to Notepad for your **sensor-v-3000** device.

1. Save your changes to **Program.cs**.

1. Create a file named **VibrationDevice.csproj** in the **VibrationDevice** folder.

1. Paste the following code into **VibrationDevice.csproj**.

   ```csharp
   <Project Sdk="Microsoft.NET.Sdk">

     <PropertyGroup>
       <OutputType>Exe</OutputType>
       <TargetFramework>netcoreapp3.1</TargetFramework>
     </PropertyGroup>

     <ItemGroup>
       <PackageReference Include="Microsoft.Azure.Devices.Client" Version="1.*" />
     </ItemGroup>

   </Project>   
   ```

1. Save your changes to **VibrationDevice.csproj**.

1. In your Visual Studio Code window, open the **Terminal** menu and select **New Terminal**.

    Examine the command prompt to ensure that the **VibrationDevice** folder is specified. Switch the terminal folder location to **VibrationDevice** if necessary. You do not want to start building this project from the wrong folder location.

1. At the Terminal command prompt, enter the following command to verify that the application builds without errors:

    ```cmd
    dotnet build
    ```

    The output should be similar to:

    ```text
    ❯ dotnet build
    MSBuild version 17.7.3+4fca21998 for .NET
    Determining projects to restore...
    All projects are up-to-date for restore.
    VibrationDevice -> C:\VibrationDevice\bin\Debug\netcoreapp3.1\VibrationDevice.dll

    Build succeeded.
        0 Warning(s)
        0 Error(s)

    Time Elapsed 00:00:01.16
    ```

    > [!NOTE]
    > If you receive error messages, start by checking your device connection string.

### Task 2: Run your code to send telemetry

1. At the Terminal command prompt, enter the following command to run the app:

   ```bash
   dotnet run
   ```

   This command runs the **Program.cs** file in the current folder.

   In the Terminal window, you see simulated IoT device telemetry and program output. Green text is used to show that telemetry and log data are sent and red text when there is a vibration problem being simulated for the production conveyor belt.

   Console output should be displayed that is similar to the following:

   ```text
   Vibration sensor device app.

   Telemetry data: {"vibration":0.0}
   Telemetry sent 10:29 AM
   Log data: {"vibration":0.0,"packages":0,"speed":"stopped","temp":60.22}
   Log data sent

   Telemetry data: {"vibration":0.0}
   Telemetry sent 10:29 AM
   Log data: {"vibration":0.0,"packages":0,"speed":"stopped","temp":59.78}
   Log data sent

   Forced vibration: 5.7 started at: 10:29 AM
   Increasing vibration: 264.9 started at: 10:29 AM
   Telemetry data: {"vibration":2.1613931376054074}
   ```

1. Leave this app running for the next task.

   If you won't be continuing to the next task, you can enter **Ctrl+C** in the Terminal window to stop the app. You can start it again later by using the **dotnet run** command.

### Task 3: Verify that IoT Hub is receiving telemetry

In this task, you use the Azure portal to verify that your IoT Hub is receiving telemetry.

1. In the Azure portal, navigate to your IoT hub.

1. On the **Overview** pane, scroll down to view the metrics tiles.

    The **Device to cloud messages** tile should be plotting some current activity. If no activity is shown, wait a short while, as there can be some latency.

    With your device sending telemetry and your hub receiving the telemetry, the next step is to route the messages to their correct endpoints.

## Verify your work

Before you move to the next unit page, verify the following items:

* The program compiles without errors.
* The program is running and producing telemetry output in your Visual Studio Code Terminal window.
* You can see device activity in the Azure portal **Device to cloud messages** window.
