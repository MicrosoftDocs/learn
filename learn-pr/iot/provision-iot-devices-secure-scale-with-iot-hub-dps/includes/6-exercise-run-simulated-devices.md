In this exercise, you run the simulated device. When the device is started for the first time, it connects to the Device Provisioning Service (DPS) which automatically enrolls it using the configured group enrollment.

Once the device is enrolled into the DPS group enrollment, the device is registered automatically in the IoT Hub device registry. Once the device is enrolled and registered, the device can begin communicating with Azure IoT Hub securely using the configured X.509 device certificate authentication.

### Task 1: Build and run the simulated device projects

1. In Visual Studio Code, open the **sensor-thl-001-device** folder if it isn't open already.

1. In Visual Studio, open the **Terminal** menu, then select **New Terminal** to open the integrated Terminal at the bottom of the Visual Studio Code window.

1. At the Terminal command prompt, ensure that the current working directory is the **\sensor-thl-001-device** folder.

1. Build and run the **ContainerDevice** project:

    ```cmd/sh
    dotnet run
    ```

    > [!NOTE]
    > When you run your simulated device for the first time, the most common error is an *Invalid certificate* error. This error can cause a **ProvisioningTransportException** exception. If you see a message similar to the following example, ensure that the CA certificate in DPS and the device certificate for the simulated device application are configured correctly. In the Verify your work section at the bottom of this web page, there are Cloud Shell commands to show registered CA and device certificate information from DPS that can be used to help diagnose an error.
    >
    > ```text
    > localmachine:LabFiles User$ dotnet run
    > Found certificate: AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001; PrivateKey: True
    > Using certificate AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001
    > RegistrationID = sensor-thl-001
    > ProvisioningClient RegisterAsync . . . Unhandled exception. Microsoft.Azure.Devices.Provisioning.Client.ProvisioningTransportException: {"errorCode":401002,"trackingId":"2e298c80-0974-493c-9fd9-6253fb055ade","message":"Invalid certificate.","timestampUtc":"2019-12-13T14:55:40.2764134Z"}
    >   at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.ValidateOutcome(Outcome outcome)
    >   at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.RegisterDeviceAsync(AmqpClientConnection client, String correlationId, DeviceRegistration deviceRegistration)
    >   at Microsoft.Azure.Devices.Provisioning.Client.Transport.ProvisioningTransportHandlerAmqp.RegisterAsync(ProvisioningTransportRegisterMessage message, CancellationToken cancellationToken)
    >   at X509CertificateContainerDevice.ProvisioningDeviceLogic.RunAsync() in /Users/User/Documents/AZ-220/LabFiles/Program.cs:line 121
    >   at X509CertificateContainerDevice.Program.Main(String[] args) in /Users/User/Documents/AZ-220/LabFiles/Program.cs:line 55
    > ...
    > ```

1. Notice that the simulated device app sends output to the Terminal window.

    When the simulated device application is running correctly, the **Terminal** displays the Console output from the app.

    Scroll up to the top of the information displayed in the Terminal window.

    Notice the X.509 sensor-thl-001 device certificate was loaded, the device was registered with the Device Provisioning Service, it was assigned to connect to the **hub-{your-suffix}** IoT hub, and the device twin desired properties are loaded.

    ```text
    localmachine:LabFiles User$ dotnet run
    Found certificate: AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001; PrivateKey: True
    Using certificate AFF851ED016CA5AEB71E5749BCBE3415F8CF4F37 CN=sensor-thl-001
    RegistrationID = sensor-thl-001
    ProvisioningClient RegisterAsync . . . Device Registration Status: Assigned
    ProvisioningClient AssignedHub: hub-1119.azure-devices.net; DeviceID: sensor-thl-001
    Creating X509 DeviceClient authentication.
    simulated device. Ctrl-C to exit.
    DeviceClient OpenAsync.
    Connecting SetDesiredPropertyUpdateCallbackAsync event handler...
    Loading Device Twin Properties...
    Desired Twin Property Changed:
    {"$version":1}
    Reported Twin Properties:
    {"telemetryDelay":1}
    Start reading and sending device telemetry...
    ```

    To review the source code for the simulated device, open the **Program.cs** source code file. Look for the **Console.WriteLine** statements that are used to output the messages seen to the console.

1. Notice that JSON formatted telemetry messages are being sent to IoT Hub.

    ```text
    Start reading and sending device telemetry...
    12/9/2019 5:47:00 PM > Sending message: {"temperature":24.047539159212047,"humidity":67.00504162675004,"pressure":1018.8478924248358,"latitude":40.129349260196875,"longitude":-98.42877188146265}
    12/9/2019 5:47:01 PM > Sending message: {"temperature":26.628804161040485,"humidity":68.09610794675355,"pressure":1014.6454375411363,"latitude":40.093269544242695,"longitude":-98.22227128174003}
    ```

    Once the simulated device completes the initial startup, provision, and registration tasks, it sends simulated sensor telemetry messages to IoT Hub.

    Notice that the delay between each message sent to IoT Hub, as defined by the **telemetryDelay** device twin property, is currently delaying **1 second** between sending sensor telemetry messages.

1. Leave the simulated device running.

### Task 2: Start the other simulated device

1. Open a new instance of Visual Studio Code.

    You can open the new instance from within Visual Studio Code: open the **File** menu and select **New window**.

1. In the new Visual Studio Code window, on the **File** menu, select **Open Folder**.

1. Navigate to the **sensor-thl-002-device** folder, and then select **Select Folder**.

1. In Visual Studio, open the **Terminal** menu, then select **New Terminal** to open the integrated Terminal at the bottom of the Visual Studio Code window.

1. At the Terminal command prompt, ensure that the current working directory is the **\sensor-thl-002-device** folder.

1. Build and run the **ContainerDevice** project.

    ```cmd/sh
    dotnet run
    ```

### Task 3: Change the device configuration through its twin

When you created the group enrollment in DPS, you set the initial twin configuration for your devices to have a **telemetryDelay** property set to **1 second**. With the simulated devices running, the **telemetryDelay** configuration can be updated by editing the device twin desired state within IoT Hub.

1. In the Azure sandbox, update the desired properties of the **sensor-thl-001** device to send telemetry every 3 seconds.

   ```azurecli
   az iot hub device-twin update --hub-name hub-$suffix --device-id sensor-thl-001 --desired "{'telemetryDelay':'3'}"
   ```

1. Switch back to the **Visual Studio Code** window that is running the **ContainerDevice** project from the **sensor-thl-001-device** folder.

1. Notice that the application has been notified of the updated device twin **telemetryDelay** desired property setting.

   The application outputs messages to the Console that show that the new device twin desired properties are loaded, and that the changes are set and reported back to the Azure IoT hub.

   ```text
   Desired Twin Property Changed:
   {"telemetryDelay":3,"$version":2}
   Reported Twin Properties:
   {"telemetryDelay":3}
   ```

1. Notice the simulated device sensor telemetry messages are now being sent to Azure IoT Hub every 3 seconds.

   ```text
   12/9/2019 5:48:07 PM > Sending message: {"temperature":33.89822140284731,"humidity":78.34939097908763,"pressure":1024.9467544610131,"latitude":40.020042418755764,"longitude":-98.41923808825841}
   12/9/2019 5:48:10 PM > Sending message: {"temperature":27.475786026323114,"humidity":64.4175510594703,"pressure":1020.6866468579678,"latitude":40.2089999240047,"longitude":-98.26223221770334}
   12/9/2019 5:48:13 PM > Sending message: {"temperature":34.63600901637041,"humidity":60.95207713588703,"pressure":1013.6262313688063,"latitude":40.25499096898331,"longitude":-98.51199886959347}
   ```

1. Within the **Terminal** pane, to exit the simulated device app, press **Ctrl-C**.

1. Switch to your other Visual Studio Code window and use the **Terminal** prompt to stop the simulated device app.

   Don't close the Visual Studio Code windows yet, as you come back to rerun the programs in the next exercise.

## Verify your work

1. If either of your programs didn't work, fix the errors before proceeding to the next exercise.

1. Verify that the Device Twin `telemetryDelay` value is `3` seconds.

   ```azurecli
   az iot hub device-twin show --hub-name hub-$suffix --device-id sensor-thl-001
   ```
