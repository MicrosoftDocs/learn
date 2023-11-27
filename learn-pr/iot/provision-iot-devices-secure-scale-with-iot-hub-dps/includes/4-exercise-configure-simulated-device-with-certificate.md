In this exercise, you generate a device certificate using the root certificate, and configure a simulated device that connects by using the device certificate for attestation.

### Task 1: Generate a device certificate

1. In the Azure sandbox, make sure you're working in the **~/certificates** directory where the **certGen.sh** helper script was downloaded:

   ```sh
   cd ~/certificates
   ```

1. Generate an X.509 device certificate within the CA certificate chain for the first device using the following command:

   ```sh
   ./certGen.sh create_device_certificate sensor-thl-001
   ```

   This command creates a new device X.509 certificate .pem and .pfx pair that are signed by the CA certificate that was generated previously. Notice that the device ID (**sensor-thl-001**) is passed to the **create_device_certificate** command of the **certGen.sh** script. This device ID is set as the *common name*, or *CN=*, value of the device certificate. This command generates a leaf device X.509 certificate for your simulated device, which is used to authenticate the device with the Device Provisioning Service (DPS). This module uses the .pfx certificate file to validate the program that connects to DPS from your computer.

   Once the **create_device_certificate** command is complete, the generated X.509 device certificate pair is named **new-device.cert.pfx** and **new-device.cert.pem** respectively, and is located within the **/certs** subdirectory.

   > [!IMPORTANT]
   > This command overwrites any existing device certificate in the **/certs** subdirectory. If you want to create a certificate for multiple devices, ensure that you save a copy of **new-device.cert.pfx** and **new-device.cert.pem** each time you run the command.

1. Rename the device certificate files to the sensor-thl-001 device name that you created in the last step using the following commands:

    ```sh
    mv ~/certificates/certs/new-device.cert.pfx ~/certificates/certs/sensor-thl-001-device.cert.pfx
    mv ~/certificates/certs/new-device.cert.pem ~/certificates/certs/sensor-thl-001-device.cert.pem
    ```

1. Create and rename certificate files for a second device using the following commands:

    ```sh
    ./certGen.sh create_device_certificate sensor-thl-002
    mv ~/certificates/certs/new-device.cert.pfx ~/certificates/certs/sensor-thl-002-device.cert.pfx
    mv ~/certificates/certs/new-device.cert.pem ~/certificates/certs/sensor-thl-002-device.cert.pem
    ```

1. Download the first generated X.509 device certificate from the Cloud Shell to your local machine, enter the following command:

   ```sh
   download ~/certificates/certs/sensor-thl-001-device.cert.pfx
   ```

   > [!NOTE]
   > Watch for a browser prompt asking you to save the file. Select the **Click here to download your file.** or **Download file** message when prompted. The file will be downloaded to your computer's Download folder.

1. Download the second generated X.509 device certificate from the Cloud Shell to your local machine using the following command:

   ```sh
   download ~/certificates/certs/sensor-thl-002-device.cert.pfx
   ```

   > [!NOTE]
   > Watch for a browser prompt asking you to save the file. Select the **Click here to download your file.** or **Download file** message when prompted. The file will be downloaded to your computer's Download folder.

In the next task, you start building the simulated devices that use the X.509 device certificates to authenticate with the Device Provisioning Service (DPS).

### Task 2: Configure a simulated device

<!-- TODO: GET THIS SAMPLE CODE INTO THE C# REPO -->

In this task, you complete the following:

* Create two project folders
* Copy the downloaded device certificate into the root folder of the application
* Configure the application in Visual Studio Code to use the DPS ID Scope

1. On your development machine, create two folders in your preferred working directory:

   * **sensor-thl-001-device**
   * **sensor-thl-002-device**

1. Move the two certificate files that you downloaded in the previous step into the folders, making sure that the certificate file matches the folder name.

   > [!IMPORTANT]
   > On a production device, the certificate file should be stored securely using a hardware security module (HSM).

1. Open the first folder, **sensor-thl-001-device**, in Visual Studio Code.

1. Create a file named **ContainerDevice.csproj**.

1. Paste the following code and save the file:

   ```csharp
   <Project Sdk="Microsoft.NET.Sdk">

     <PropertyGroup>
       <OutputType>Exe</OutputType>
       <TargetFramework>netcoreapp3.1</TargetFramework>
     </PropertyGroup>
     <ItemGroup>
       <None Update="sensor-thl-001-device.cert.pfx" CopyToOutputDirectory="PreserveNewest" />
       <PackageReference Include="Microsoft.Azure.Devices.Client" Version="1.*" />
       <PackageReference Include="Microsoft.Azure.Devices.Provisioning.Transport.Mqtt" Version="1.*" />
       <PackageReference Include="Microsoft.Azure.Devices.Provisioning.Transport.Amqp" Version="1.*" />
       <PackageReference Include="Microsoft.Azure.Devices.Provisioning.Transport.Http" Version="1.*" />
     </ItemGroup>
   </Project>   
   ```

   This configuration ensures that the **sensor-thl-001-device.cert.pfx** certificate file is copied to the build folder when the C# code is compiled, and made available for the program to access when it executes.

   If you named the certificate file something else, update the variable value to match.

1. Create a file named **Program.cs**.

1. Paste the following code into **Program.cs**:

   ```csharp
   // Copyright (c) Microsoft. All rights reserved.
   // Licensed under the MIT license. See LICENSE file in the project root for full license information.

   using Microsoft.Azure.Devices.Client;
   using Microsoft.Azure.Devices.Provisioning.Client;
   using Microsoft.Azure.Devices.Provisioning.Client.Transport;
   using Microsoft.Azure.Devices.Shared;
   using System;
   using System.IO;
   using System.Text;
   using System.Threading.Tasks;
   using Newtonsoft.Json;
   using System.Security.Cryptography.X509Certificates;

   namespace ContainerDevice
   {
       class Program
       {
           // Azure Device Provisioning Service (DPS) ID Scope
           private static string dpsIdScope = "PASTE_YOUR_DPS_ID_SCOPE_HERE";

           // Certificate (PFX) File Name
           private static string certificateFileName = "sensor-thl-001-device.cert.pfx";

           // Certificate (PFX) Password
           private static string certificatePassword = "1234";
           // NOTE: For the purposes of this example, the certificatePassword is
           // hard coded. In a production device, the password will need to be stored
           // in a more secure manner. Additionally, the certificate file (PFX) should
           // be stored securely on a production device using a Hardware Security Module.

           private const string GlobalDeviceEndpoint = "global.azure-devices-provisioning.net";

           private static int telemetryDelay = 1;

           private static DeviceClient deviceClient;

           public static async Task Main(string[] args)
           {
               X509Certificate2 certificate = LoadProvisioningCertificate();

               using (var security = new SecurityProviderX509Certificate(certificate))
               using (var transport = new ProvisioningTransportHandlerAmqp(TransportFallbackType.TcpOnly))
               {
                   ProvisioningDeviceClient provClient =
                       ProvisioningDeviceClient.Create(GlobalDeviceEndpoint, dpsIdScope, security, transport);

                   using (deviceClient = await ProvisionDevice(provClient, security))
                   {
                       await deviceClient.OpenAsync().ConfigureAwait(false);

                       // INSERT Setup OnDesiredPropertyChanged Event Handling below here
                       await deviceClient.SetDesiredPropertyUpdateCallbackAsync(OnDesiredPropertyChanged, null).ConfigureAwait(false);

                       // INSERT Load Device Twin Properties below here
                       var twin = await deviceClient.GetTwinAsync().ConfigureAwait(false);
                       await OnDesiredPropertyChanged(twin.Properties.Desired, null);

                       // Start reading and sending device telemetry
                       Console.WriteLine("Start reading and sending device telemetry...");
                       await SendDeviceToCloudMessagesAsync();

                       await deviceClient.CloseAsync().ConfigureAwait(false);
                   }
               }
           }

           private static X509Certificate2 LoadProvisioningCertificate()
           {
               var certificateCollection = new X509Certificate2Collection();
               certificateCollection.Import(certificateFileName, certificatePassword, X509KeyStorageFlags.UserKeySet);

               X509Certificate2 certificate = null;

               foreach (X509Certificate2 element in certificateCollection)
               {
                   Console.WriteLine($"Found certificate: {element?.Thumbprint} {element?.Subject}; PrivateKey: {element?.HasPrivateKey}");
                   if (certificate == null && element.HasPrivateKey)
                   {
                       certificate = element;
                   }
                   else
                   {
                       element.Dispose();
                   }
               }

               if (certificate == null)
               {
                   throw new FileNotFoundException($"{certificateFileName} did not contain any certificate with a private key.");
               }

               Console.WriteLine($"Using certificate {certificate.Thumbprint} {certificate.Subject}");
               return certificate;
           }

           private static async Task<DeviceClient> ProvisionDevice(ProvisioningDeviceClient provisioningDeviceClient, SecurityProviderX509Certificate security)
           {
               var result = await provisioningDeviceClient.RegisterAsync().ConfigureAwait(false);
               Console.WriteLine($"ProvisioningClient AssignedHub: {result.AssignedHub}; DeviceID: {result.DeviceId}");
               if (result.Status != ProvisioningRegistrationStatusType.Assigned)
               {
                   throw new Exception($"DeviceRegistrationResult.Status is NOT 'Assigned'");
               }

               var auth = new DeviceAuthenticationWithX509Certificate(
                   result.DeviceId,
                   security.GetAuthenticationCertificate());

               return DeviceClient.Create(result.AssignedHub, auth, TransportType.Amqp);
           }

           private static async Task SendDeviceToCloudMessagesAsync()
           {
               var sensor = new EnvironmentSensor();

               while (true)
               {
                   var currentTemperature = sensor.ReadTemperature();
                   var currentHumidity = sensor.ReadHumidity();
                   var currentPressure = sensor.ReadPressure();
                   var currentLocation = sensor.ReadLocation();

                   var messageString = CreateMessageString(currentTemperature,
                                                        currentHumidity,
                                                        currentPressure,
                                                        currentLocation);
   
                   var message = new Message(Encoding.ASCII.GetBytes(messageString));

                   // Add a custom application property to the message.
                   // An IoT hub can filter on these properties without access to the message body.
                   message.Properties.Add("temperatureAlert", (currentTemperature > 30) ? "true" : "false");

                   // Send the telemetry message
                   await deviceClient.SendEventAsync(message);
                   Console.WriteLine("{0} > Sending message: {1}", DateTime.Now, messageString);

                   // Delay before next Telemetry reading
                   await Task.Delay(telemetryDelay * 1000);
               }
           }

           private static string CreateMessageString(double temperature, double humidity, double pressure, EnvironmentSensor.Location location)
           {
               // Create an anonymous object that matches the data structure we wish to send
               var telemetryDataPoint = new
               {
                   temperature = temperature,
                   humidity = humidity,
                   pressure = pressure,
                   latitude = location.Latitude,
                   longitude = location.Longitude
               };
               var messageString = JsonConvert.SerializeObject(telemetryDataPoint);

               // Create a JSON string from the anonymous object
               return JsonConvert.SerializeObject(telemetryDataPoint);
           }

           private static async Task OnDesiredPropertyChanged(TwinCollection desiredProperties, object userContext)
           {
               Console.WriteLine("Desired Twin Property Changed:");
               Console.WriteLine($"{desiredProperties.ToJson()}");

               // Read the desired Twin Properties
               if (desiredProperties.Contains("telemetryDelay"))
               {
                   string desiredTelemetryDelay = desiredProperties["telemetryDelay"];
                   if (desiredTelemetryDelay != null)
                   {
                       telemetryDelay = int.Parse(desiredTelemetryDelay);
                   }
                   // if desired telemetryDelay is null or unspecified, don't change it
               }

               // Report Twin Properties
               var reportedProperties = new TwinCollection();
               reportedProperties["telemetryDelay"] = telemetryDelay.ToString();
               await deviceClient.UpdateReportedPropertiesAsync(reportedProperties).ConfigureAwait(false);
               Console.WriteLine("Reported Twin Properties:");
               Console.WriteLine($"{reportedProperties.ToJson()}");
           }
       }

       internal class EnvironmentSensor
       {
           // Initial telemetry values
           double minTemperature = 20;
           double minHumidity = 60;
           double minPressure = 1013.25;
           double minLatitude = 39.810492;
           double minLongitude = -98.556061;
           Random rand = new Random();

           internal class Location
           {
               internal double Latitude;
               internal double Longitude;
           }

           internal double ReadTemperature()
           {
               return minTemperature + rand.NextDouble() * 15;
           }
           internal double ReadHumidity()
           {
               return minHumidity + rand.NextDouble() * 20;
           }
           internal double ReadPressure()
           {
               return minPressure + rand.NextDouble() * 12;
           }
           internal Location ReadLocation()
           {
               return new Location { Latitude = minLatitude + rand.NextDouble() * 0.5, Longitude = minLongitude + rand.NextDouble() * 0.5 };
           }
       }
   }
   ```

1. Locate the **GlobalDeviceEndpoint** variable, and notice that its value is set to the global device endpoint for the Device Provisioning Service. You should see code that is similar to the following:

   ```csharp
   private const string GlobalDeviceEndpoint = "global.azure-devices-provisioning.net";
   ```

   All devices that connect to DPS are configured with this global device endpoint DNS name.

   The **ContainerDevice** application uses X.509 certificates as an attestation mechanism. From the application's perspective, it doesn't matter that this device is connecting using a group enrollment rather than an individual enrollment. All the device has to do is connect to its assigned DPS instance and receive its assigned IoT hub information.

1. Locate the **dpsIdScope** variable

1. Update the assigned value using the **DPS ID Scope** that you retrieved when you created the DPS instance.

    When you update your code, it should look similar to the following:

    ```csharp
    private static string dpsIdScope = "0ne00000000";
    ```

    > [!NOTE]
    > If you don't have the DPS ID Scope (idScope) value, you can get a copy by running the CLI command `az iot dps show --name dps-$suffix`.

1. Locate the **certificateFileName** variable, and notice that its value is set to the name of the device certificate file that you generated (**sensor-thl-001-device.cert.pfx**). If you named the certificate file something else, update the variable value to match.

    The device application uses an X.509 certificate for authentication. This variable tells the device code which file contains the X.509 device certificate that it uses when authenticating with the Device Provisioning Service.

1. Locate the **certificatePassword** variable, and notice that its value is set to the default password defined by the **certGen.sh** script.

    The **certificatePassword** variable contains the password for the X.509 device certificate. It's set to **1234**, which is the default password used by the **certGen.sh** helper script when generating the X.509 certificates.

    > [!IMPORTANT]
    > For the purpose of this lab, the password is hard coded. In a *production* scenario, the password needs to be stored in a more secure manner, such as in an Azure Key Vault. Additionally, the certificate file (PFX) should be stored securely on a production device using a hardware security module (HSM).
    >
    > HSM is used for secure, hardware-based storage of device secrets, and is the most secure form of secret storage. Both X.509 certificates and SAS tokens can be stored in the HSM. HSMs can be used with all attestation mechanisms the provisioning service supports.

1. Open the Visual Studio Code **File** menu, then select **Save**.

1. Copy **sensor-thl-001-device.cert.pfx** from your **Downloads** folder into the **sensor-thl-001-device** folder.

1. Copy **sensor-thl-002-device.cert.pfx** from your **Downloads** folder into the **sensor-thl-002-device** folder.

## Verify your work

1. In Visual Studio, open the **Terminal** menu, then select **New Terminal**.

1. At the Terminal command prompt, ensure that the current working directory is the **\sensor-thl-001-device** folder.

1. At the Visual Studio Terminal command prompt, build the code to check for any errors.

   ```bash
   dotnet build ContainerDevice.csproj
   ```

1. If you see any build errors listed, fix them before continuing to the next exercise.
