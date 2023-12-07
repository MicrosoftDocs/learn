In this exercise, you configure a device simulator application. The primary connection string is used to connect the program to the IoT Hub. When executed, the application creates an active connection and generates telemetry. The active connection counts as a connected device that is tracked by the Azure Monitor.

In this exercise, you:

* Create the simulated device project
* Add the connection string for your simulated device and review the project code
* Test your simulated device connection and telemetry communications
* Ensure that telemetry is arriving at your IoT hub

## Task 1: Configure and run device simulator

1. On your development machine, create a working folder for this project named **DeviceSimulator**. You create all Visual Studio Code files for this project within this folder.

1. Open Visual Studio Code.

1. Select **File**, then **Open Folder**. Select the **DeviceSimulator** folder and then select **Select Folder**.

1. Create a file named **Program.cs** in the **DeviceSimulator** folder.

1. Paste the following code into **Program.cs**.

   ```csharp

    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE file in the project root for full license information.

    // This application uses the Azure IoT Hub device SDK for .NET
    // For samples see: https://github.com/Azure/azure-iot-sdk-csharp/tree/master/iothub/device/samples

    // INSERT using statements below here

    using System;
    using System.Text;
    using System.Threading.Tasks;
    using Microsoft.Azure.Devices.Client;
    using Newtonsoft.Json;

    // INSERT namespace below here
    namespace CaveDevice
    {
        class Program
        {
            // INSERT variables below here
            // Contains methods that a device can use to send messages to and receive from an IoT Hub.
            private static DeviceClient deviceClient;

            // The device connection string to authenticate the device with your IoT hub.
            // Note: in real-world applications you would not "hard-code" the connection string
            // It could be stored within an environment variable, passed in via the command-line or
            // store securely within a TPM module.
            private readonly static string connectionString = "<your device connection string>";

            // INSERT Main method below here
            private static void Main(string[] args)
            {
                Console.WriteLine("IoT Hub C# Simulated Cave Device. Ctrl-C to exit.\n");

                // Connect to the IoT hub using the MQTT protocol
                deviceClient = DeviceClient.CreateFromConnectionString(connectionString, TransportType.Mqtt);
                SendDeviceToCloudMessagesAsync();
                Console.ReadLine();
            }

            // INSERT - SendDeviceToCloudMessagesAsync below here
            // Async method to send simulated telemetry
            private static async void SendDeviceToCloudMessagesAsync()
            {
                // Create an instance of our sensor 
                var sensor = new EnvironmentSensor();

                while (true)
                {
                    // read data from the sensor
                    var currentTemperature = sensor.ReadTemperature();
                    var currentHumidity = sensor.ReadHumidity();

                    var messageString = CreateMessageString(currentTemperature, currentHumidity);

                    // create a byte array from the message string using ASCII encoding
                    var message = new Message(Encoding.ASCII.GetBytes(messageString));

                    // Add a custom application property to the message.
                    // An IoT hub can filter on these properties without access to the message body.
                    message.Properties.Add("temperatureAlert", (currentTemperature > 30) ? "true" : "false");

                    // Send the telemetry message
                    await deviceClient.SendEventAsync(message);
                    Console.WriteLine("{0} > Sending message: {1}", DateTime.Now, messageString);

                    await Task.Delay(1000);
                }
            }

            // INSERT CreateMessageString method below here
            private static string CreateMessageString(double temperature, double humidity)
            {
                // Create an anonymous object that matches the data structure we wish to send
                var telemetryDataPoint = new
                {
                    temperature = temperature,
                    humidity = humidity
                };

                // Create a JSON string from the anonymous object
                return JsonConvert.SerializeObject(telemetryDataPoint);
            }
        }


        // INSERT EnvironmentSensor class below here
        /// <summary>
        /// This class represents a sensor 
        /// real-world sensors would contain code to initialize
        /// the device or devices and maintain internal state
        /// a real-world example can be found here: https://bit.ly/IoT-BME280
        /// </summary>
        internal class EnvironmentSensor
        {
            // Initial telemetry values
            double minTemperature = 20;
            double minHumidity = 60;
            Random rand = new Random();

            internal EnvironmentSensor()
            {
                // device initialization could occur here
            }

            internal double ReadTemperature()
            {
                return minTemperature + rand.NextDouble() * 15;
            }

            internal double ReadHumidity()
            {
                return minHumidity + rand.NextDouble() * 20;
            }
        }
    }

   ```

1. Near the top of the **Program** class, locate the declaration of the **connectionString** variable.

    ```csharp
    private readonly static string connectionString = "<your device connection string>";
    ```

1. Replace the `<your device connection string>` placeholder value (including the angle brackets) with the device connection string that you saved earlier.

    > [!Note]
    > This is the only change that you are required to make to this code.

1. On the **File** menu, select **Save**.

1. Create a file named **DeviceSimulator.csproj** in the DeviceSimulator folder.

1. Paste the following code into **DeviceSimulator.csproj**.

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

1. Save your changes to **DeviceSimulator.csproj**.

1. In your Visual Studio Code window, open the **Terminal** menu and select **New Terminal**.

    Examine the command prompt to ensure that the **DeviceSimulator** folder is specified.

1. At the Terminal command prompt, enter the following command to verify that the application builds without errors:

    ```cmd
    dotnet build
    ```

    The output should be similar to the following:

    ```text
    > dotnet build
    MSBuild version 17.7.3+4fca21998 for .NET
    Determining projects to restore...
    All projects are up-to-date for restore.
    DeviceSimulator -> C:\DeviceSimulator\bin\Debug\netcoreapp3.1\DeviceSimulator.dll

    Build succeeded.
        0 Warning(s)
        0 Error(s)

    Time Elapsed 00:00:01.16
    ```

    > [!NOTE]
    > If you receive error messages, start by checking your device connection string.

## Task 2: Test your code to send telemetry

1. At the Terminal command prompt, run the app by entering the following command:

    ```bash
    dotnet run
    ```

   This command runs the **Program.cs** file in the current folder.

1. Console output should be displayed that is similar to the following:

    ```text
    > dotnet run
    IoT Hub C# Simulated Cave Device. Ctrl-C to exit.

    10/25/2023 6:10:12 PM > Sending message: {"temperature":27.714212817472504,"humidity":63.88147743599558}
    10/25/2023 6:10:13 PM > Sending message: {"temperature":20.017463779085066,"humidity":64.53511070671263}
    10/25/2023 6:10:14 PM > Sending message: {"temperature":20.723927165718717,"humidity":74.07808918230147}
   ```

1. Leave the app running, so that a device is connected to your IoT hub and telemetry is being sent.

## Verify your work

In this exercise, you created a device telemetry simulator. The simulator connects to your IoT hub using the device primary connection string, then sends a stream of temperature and humidity readings. These readings are used in the next exercise.

Address any program build or runtime errors before proceeding to the next exercise.
