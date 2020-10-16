In this unit, we'll first create an IoT Hub and add three devices to that hub:

- an IoT sensor within the shipment container,
- an IoT sensor in the truck,
- an IoT sensor in the airplane.

In a second step, we'll code and execute a program to simulate data coming from these devices.

## Setup IoT Hub and devices

1. Make sure you've activated the sandbox, using the button above. The sandbox will give you access to free Azure resources for the duration of this module.
2. In the following code, we're using the [Azure IoT extension for Azure CLI](https://github.com/Azure/azure-iot-cli-extension). To install the extension, type the following command in the terminal:
    > [!NOTE]
    > In order to paste code and commands in the Azure Shell terminal, you need to right click and select "Paste"

    ```Azure CLI
    az extension add --name azure-iot

    ```

3. Open a text file, copy the following code in. Replace `{your iot hub name}` with a name for your IoT Hub. You can then run this command to create a new IoT Hub instance.
    >[!IMPORTANT]
    >Your hub names are publicly discoverable, so take this into account when entering names. Hub names must also be unique, as they form part of the Azure URL. You can use a name like *cheesecavesmanager-anID*

    ```Azure CLI
    iotHubName='{your iot hub name}'
    az iot hub create --name $iotHubName --resource-group <rgn>[sandbox resource group name]</rgn> --sku S1
    ```

    > [!NOTE]
    > Across the module you will have to execute command like the above one in the Azure Shell that might take some time to execute. Be patient as Azure creates and configures resources for you.
4. Run this command to create the three devices.

    ```Azure CLI
    az iot hub device-identity create --hub-name $iotHubName --device-id TruckDevice
    az iot hub device-identity create --hub-name $iotHubName --device-id AirplaneDevice
    az iot hub device-identity create --hub-name $iotHubName --device-id ContainerDevice
    ```

5. Run this command to get connection string for the three devices. Don't close or clean the window, as you'll need these values in the next step. You can copy them in a text file for convenience.

    ```Azure CLI
    az iot hub device-identity connection-string show --hub-name $iotHubName --device-id TruckDevice --output tsv
    az iot hub device-identity connection-string show --hub-name $iotHubName --device-id AirplaneDevice --output tsv
    az iot hub device-identity connection-string show --hub-name $iotHubName --device-id ContainerDevice --output tsv

    ```

## Create the device simulator app

As Time Series Insights needs time-stamped data, we'll write some code to simulate data coming from IoT devices with IoT Hub Client SDK.

> In the following we will be using the sandbox with the Azure Shell, but you can use Visual Studio Code on your local machine to do the same. If you decide to use Visual Studio Code locally, you need to ensure both [.NET Core](https://dotnet.microsoft.com/download), and the [C# extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.csharp) are installed.

1. In the Azure Shell terminal, create a folder called **simulator** and navigate to it:

    ```Azure CLI
    mkdir simulator
    cd simulator

    ```

2. Enter the following commands in the terminal. The first command creates a **Program.cs** file in your folder, along with a project file and the second one gives your app access to the required .NET packages.

    ```Azure CLI
    dotnet new console
    dotnet restore

    ```

3. In the terminal, install the required libraries using the following commands:

    ```Azure CLI
    dotnet add package Microsoft.Azure.Devices.Client
    dotnet add package Microsoft.Azure.Devices.Shared
    dotnet add package Newtonsoft.Json

    ```

At this point, your project is ready for coding.

## Add code to your app

1. Open the **Program.cs** file for the device app typing the following command in the Azure shell:

    ```Azure CLI
    code Program.cs

    ```

2. Delete all the content form the document.

3. Copy and paste the following code.

    ```cs
    // Copyright (c) Microsoft. All rights reserved.
    // Licensed under the MIT license. See LICENSE file in the project root for full license information.

    // This application uses the Azure IoT Hub device SDK for .NET
    // For samples see: https://github.com/Azure/azure-iot-sdk-csharp/tree/master/iothub/device/samples

    using System;
    using Microsoft.Azure.Devices.Client;
    using Newtonsoft.Json;
    using System.Text;
    using System.Threading.Tasks;
    
    namespace device_simulation
    {
        class DeviceSimulation
        {
    
            // The three connection string for the different IoT Devices being simulated (Truck, Airplane, Container)
    
            private readonly static string connectionString_Truck = "{Your Truck device connection string here}";
            private readonly static string connectionString_Airplane = "{Your Airplane device connection string here}";
            private readonly static string connectionString_Container = "{Your Container device connection string here}";
    
    
            // The DeviceClient's for the three different IoT Devices being simulated
            private static DeviceClient deviceClient_Truck;
            private static DeviceClient deviceClient_Airplane;
            private static DeviceClient deviceClient_Container;
    
    
            private static void Main(string[] args)
            {
                Console.WriteLine("Device Simulation");
                Console.WriteLine("This app simulations Temperature and Humidity sensors from the following devices:");
                Console.WriteLine(" - Container: The shipping container.");
                Console.WriteLine(" - Truck: The truck transporting the container.");
                Console.WriteLine(" - Airplain: The airplane transporting the container.");
                Console.WriteLine(string.Empty);
                Console.WriteLine("The Container is being shipped via Truck and Airplain, and the container sensor readings will vary depending on which transport vehicle is currently transporting the container.");
                Console.WriteLine(string.Empty);
                Console.WriteLine("Press Ctrl-C to exit.");
                Console.WriteLine(string.Empty);
    
                // Connect to the IoT hub using the MQTT protocol
                // Create a DeviceClient for each IoT Device being simulated
                deviceClient_Truck = DeviceClient.CreateFromConnectionString(connectionString_Truck, TransportType.Mqtt);
                deviceClient_Airplane = DeviceClient.CreateFromConnectionString(connectionString_Airplane, TransportType.Mqtt);
                deviceClient_Container = DeviceClient.CreateFromConnectionString(connectionString_Container, TransportType.Mqtt);
                
                SendDeviceToCloudMessagesAsync();
                
                Console.ReadLine();
            }
    
    
            // Truck transport sensor values
            const double truckTemperature_min = 20;
            const double truckTemperature_max = 40;
            static double truckTemperature = 20;
            const double truckHumidity_min = 45;
            const double truckHumidity_max = 65; 
            static double truckHumidity = 60;
    
            // Airplane transport sensor values
            const double airplaneTemperature_min = 0;
            const double airplaneTemperature_max = 25;
            static double airplaneTemperature = 15;
            const double airplaneHumidity_min = 35;
            const double airplaneHumidity_max = 50;
            static double airplaneHumidity = 45;
    
            // Container sensor values
            static double containerTemperature = 20;
            static double containerHumidity = 45;
            static bool containerTransportIsTruck = true;
    
    
            // Variables used to automate the change in Transport for the Container between Truck and Airplane
            static double transportMaxDuration = 30; // 30 seconds
            static DateTime lastTransportChange = DateTime.Now;
    
    
            // Random number generator
            static Random rand = new Random();
    
    
            private static double GenerateSensorReading(double currentValue, double min, double max)
            {
                double percentage = 5; // 5%
    
                // generate a new value based on the previous supplied value
                // The new value will be calculated to be within the threshold specified by the "percentage" variable from the original number.
                // The value will also always be within the the specified "min" and "max" values.
                double value = currentValue  * (1 + ((percentage / 100) * (2 * rand.NextDouble() - 1)));
    
                value = Math.Max(value, min);
                value = Math.Min(value, max);
        
                return value;
            }
    
    
            static string CreateJSON(double temperature, double humidity)
            {
                var telemetry = new {
                    temperature = temperature,
                    humidity = humidity
                };
    
                return JsonConvert.SerializeObject(telemetry);
            }
    
            // Generate Telemetry message containing JSON data for the specified values
            static Message CreateMessage(string messageString)
            {
                var message = new Message(Encoding.ASCII.GetBytes(messageString));
    
                // MESSAGE CONTENT TYPE
                message.ContentType = "application/json";
                message.ContentEncoding = "UTF-8";
    
                return message;
            }
    
            // Async method to send simulated telemetry
            private static async void SendDeviceToCloudMessagesAsync()
            {
                while (true)
                {
                    // /////////////////////////////////////////////////////////////////////////////////////////////////
                    // SEND SIMULATED TRUCK SENSOR TELEMETRY
    
                    // Generate simulated Truck sensor readings
                    truckTemperature = GenerateSensorReading(truckTemperature, truckTemperature_min, truckTemperature_max);
                    truckHumidity = GenerateSensorReading(truckHumidity, truckHumidity_min, truckHumidity_max);
    
                    // Create Truck JSON message
                    var truckJson = CreateJSON(truckTemperature, truckHumidity);
                    var truckMessage = CreateMessage(truckJson);
    
                    // Send Truck telemetry message
                    await deviceClient_Truck.SendEventAsync(truckMessage);
                    Console.WriteLine("{0} > Sending TRUCK message: {1}", DateTime.Now, truckJson);
    
    
                    // /////////////////////////////////////////////////////////////////////////////////////////////////
                    // SEND SIMULATED AIRPLANE SENSOR TELEMETRY
    
                    // Generate simulated Airplane sensor readings
                    airplaneTemperature = GenerateSensorReading(airplaneTemperature, airplaneTemperature_min, airplaneTemperature_max);
                    airplaneHumidity = GenerateSensorReading(airplaneHumidity, airplaneHumidity_min, airplaneHumidity_max);
    
                    // Create Airplane JSON message
                    var airplaneJson = CreateJSON(airplaneTemperature, airplaneHumidity);
                    var airplaneMessage = CreateMessage(airplaneJson);
    
                    // Send Airplane telemetry message
                    await deviceClient_Airplane.SendEventAsync(airplaneMessage);
                    Console.WriteLine("{0} > Sending AIRPLANE message: {1}", DateTime.Now, airplaneJson);
    
                    
                    // /////////////////////////////////////////////////////////////////////////////////////////////////
                    // SEND SIMULATED CONTAINER SENSOR TELEMETRY
    
    
                    // Change Transport between Truck and Airplane based on duration set
                    TimeSpan transportDuration = DateTime.Now - lastTransportChange;
                    if (transportDuration.TotalSeconds > transportMaxDuration)
                    {
                        containerTransportIsTruck = !containerTransportIsTruck;
                        lastTransportChange = DateTime.Now;
                        Console.WriteLine("{0} > CONTAINER transport changed to: {1}", DateTime.Now, containerTransportIsTruck ? "TRUCK" : "AIRPLANE");
                    }
    
                    // Container Telemetry min/max thresholds
                    double minTemperature = containerTransportIsTruck ? truckTemperature_min : airplaneTemperature_min;
                    double maxTemperature = containerTransportIsTruck ? truckTemperature_max : airplaneTemperature_max;
                    double minHumidity = containerTransportIsTruck ? truckHumidity_min : airplaneHumidity_min;
                    double maxHumidity = containerTransportIsTruck ? truckHumidity_max : airplaneHumidity_max;
                
                    // Generate simulated Container sensor readings
                    containerTemperature = GenerateSensorReading(containerTemperature, minTemperature, maxTemperature);
                    containerHumidity = GenerateSensorReading(containerHumidity, minHumidity, maxHumidity);
    
                    // Create Container JSON message
                    var containerJson = CreateJSON(containerTemperature, containerHumidity);
                    var containerMessage = CreateMessage(containerJson);
    
                    // Send Container telemetry message
                    await deviceClient_Container.SendEventAsync(containerMessage);
                    Console.WriteLine("{0} > Sending CONTAINER message: {1}", DateTime.Now, containerJson);
    
                    await Task.Delay(1000);
                }
            }
        }
    }
    ```

4. Locate the following code at the top of the file and fill the connection string values with the output

    ```csharp
    private readonly static string connectionString_Truck = "{Your Truck device connection string here}";
    private readonly static string connectionString_Airplane = "{Your Airplane device connection string here}";
    private readonly static string connectionString_Container = "{Your Container device connection string here}";
    ```
    
    At the end, the code should look like the following code

    ```csharp
    private readonly static string connectionString_Truck = "HostName=chmaiotlearn.azure-devices.net;DeviceId=ContainerDevice;SharedAccessKey=ABCDeFgHijkLJ2rNffx2SSEdEWtgaxeDYKwVflBuQJY=";
    ```

5. Save the **Program.cs** file and close the editor. To close the editor, find the ellipse "..." menu on the right-hand side of the editor and click **Close Editor**.


## Simulate data

This program will generate data for the three sensors. To start sending data to IoT Hub, you just need to run the following command in Azure Cloud Shell.

```Azure CLI
dotnet run

```

> [!NOTE]
> You need to run this program for a couple of minutes in order to get sufficient data.
> You can leave this terminal window open while doing the next steps by opening the next unit in a new tab.

Once the DeviceSimulation app is running, it will begin outputting sensor data to the terminal. It's the same data that's sent to Azure IoT Hub.

When the DeviceSimulation app is running, the Terminal output will look similar to the following output:

```bash
    12/27/2019 8:51:30 PM > Sending TRUCK message: {"temperature":35.15660452608195,"humidity":48.422323938240865}
    12/27/2019 8:51:31 PM > Sending AIRPLANE message: {"temperature":17.126545186374237,"humidity":36.46941012936869}
    12/27/2019 8:51:31 PM > Sending CONTAINER message: {"temperature":21.986403302500637,"humidity":47.847680384455096}
    12/27/2019 8:51:32 PM > Sending TRUCK message: {"temperature":36.10474464823629,"humidity":48.82029906486022}
    12/27/2019 8:51:32 PM > Sending AIRPLANE message: {"temperature":16.55005930170971,"humidity":36.49988437459935}
    12/27/2019 8:51:32 PM > Sending CONTAINER message: {"temperature":21.811727088543286,"humidity":50.0}
```

You're now sending sensor data to IoT Hub. In the next unit, we'll create a Time Series Insights environment and connect it to IoT Hub.