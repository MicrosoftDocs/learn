We're now ready to connect our first sensor!  Research and development have informed us that we will be using a modified Azure Kinect device, which will consist of a module for reading the temperature and humidity of our manufacturing floor.  This solution will allow us to easily manage operations that require explicit temperatures during our production phases.

[![Azure Kinect](../media/azure-kinect.png)](../media/azure-kinect.png#lightbox)

In this unit, we'll configure a pre-built Downstream Device to connect to the IoT Edge Gateway. This device will be configured with the certificate we created earlier to ensure communication is secure between the downstream device and the IoT Edge Gateway.

## Connect a Downstream Device to IoT Edge Gateway

1. If necessary, sign in to your Azure portal using your Azure account credentials.

    If you've got more than one Azure account, ensure that you're signed in with the account for the subscription you intend to use for this course

1. At the top of the Azure portal, click on the **Cloud Shell** icon to open up the **Azure Cloud Shell** within the Azure portal. When the pane opens, choose the option for the **Bash** terminal within the Cloud Shell.

1. Within the **Cloud Shell**, run the following command to download the **root CA** X.509 certificate for the Azure IoT Edge Gateway Virtual Machine.

    ```bash
     download certificates/certs/azure-iot-test-only.root.ca.cert.pem
    ```

    The Azure IoT Edge Gateway was configured (within the `/etc/iotedge/config.yaml file`) previously to use this **root CA** X.509 certificate for encrypting communications with any downstream devices connecting to the gateway. This X.509 certificate will need to be copied to the downstream devices to allow for encrypting communications with the gateway.

1. Obtain the contents of the **DownstreamDevice** folder available in the [**AZ-220-Microsoft-Azure-IoT-Developer GitHub Repo**](https://github.com/MicrosoftLearning/AZ-220-Microsoft-Azure-IoT-Developer/tree/master/Allfiles/Labs/12-Setup%20an%20IoT%20Edge%20Gateway/Starter)
       
    Copy the `azure-iot-test-only.root.ca.cert.pem` X.509 certificate file to the **DownstreamDevice** folder where the source code for the downstream IoT device is located.

    Open the DownstreamDevice directory within Visual studio Code.

1. Open **Visual Studio Code** and select **File => Open Folder** and select the path of the **DownstreamDevice** folder/

1. Open the **Program.cs** source code file.

1. Locate the declaration for the `connectionString` variable and replace the value placeholder with the **IoT Hub Connection String** for the **DownstreamDevice1** IoT Device.

1. Modify the **IoT Hub Connection String** to include the `GatewayHostName` property with the value set to the full **DNS name** for the IoT Edge Gateway Device (`AZ-220-VM-EDGEGW`).

    The Connection String will match the following format:

    ```
    HostName=<IoT-Hub-Name>.azure-devices.net;DeviceId=DownstreamDevice1;SharedAccessKey=<IoT-Device-Primary-Key>;GatewayHostName=<IoT-Edge-Device-DNS-Name>
    ```

    Be sure to replace the placeholders with the appropriate values:

    - `<IoT-Hub-Name>`: The Name of the Azure IoT Hub.
    - `<IoT-Device-Primary-Key>`: The Primary Key for the **DownstreamDevice1** IoT Device in Azure IoT Hub.
    - `<IoT-Edge-DNS-Name>`: The DNS name set for the **AZ-220-VM-EDGEGW**.

    The `connectionString` variable with the Connection String value will look similar to the following value:

    ```csharp
     private readonly static string connectionString = "HostName=AZ-220-HUB-1119.azure-devices.net;DeviceId=DownstreamDevice1;SharedAccessKey=ygNT/WqWs2d8AbVD9NAlxcoSS2rr628fI7YLPzmBdgE=;GatewayHostName=AZ-220-VM-EDGEGW.eastus.cloudapp.azure.com";
     ```

1. Save the file.

1. Locate the **Main** method. This method contains the code that instantiates the `DeviceClient` using the configured Connection String, and specifies **MQTT** as the transport protocol to use for communicating with the Azure IoT Edge Gateway.

    ```
    deviceClient = DeviceClient.CreateFromConnectionString(connectionString, TransportType.Mqtt);
    SendDeviceToCloudMessagesAsync();
    ```
    
    This method also executes the **InstallCACert** method, which has some code to automatically install the **root CA** X.509 certificate to the local machine. It also executes the **SendDeviceToCloudMessagesAsync** method that sends event telemetry from the simulated device.

1. Locate the **SendDeviceToCloudMessagesAsync** method. This method contains the code that generates the simulated device telemetry, and sends the events to the IoT Edge Gateway.

1. Locate the **InstallCACert** method and browse the code that installed the **root CA** X.509 certificate to the local machine certificate store.

1. Open a command-prompt / terminal and navigate to the location of the `DownstreamDevice` directory.

1. Run the following command to build the code for the DownstreamDevice1 simulated device, and execute it to start sending device telemetry:

    ```bash
     dotnet run
    ```

1. When the app installed the ***X.509 certificate** on the local machine, it may prompt by asking if you would like to install the certificate. Click **Yes** to allow it and continue.

1. Once the simulated device is running, the console output will display the events being sent to the Azure IoT Edge Gateway.

    The terminal output will look similar to the following output:

    ```bash
     IoT Hub Quickstarts #1 - Simulated device. Ctrl-C to exit.

     User configured CA certificate path: azure-iot-test-only.root.ca.cert.pem
     Attempting to install CA certificate: azure-iot-test-only.root.ca.cert.pem
     Successfully added certificate: azure-iot-test-only.root.ca.cert.pem
     11/27/2019 4:18:26 AM > Sending message: {"temperature":21.768769073192388,"humidity":79.89793652663843}
     11/27/2019 4:18:27 AM > Sending message: {"temperature":28.317862208149332,"humidity":73.60970909409677}
     11/27/2019 4:18:28 AM > Sending message: {"temperature":25.552859350830715,"humidity":72.7897707153064}
     11/27/2019 4:18:29 AM > Sending message: {"temperature":32.81164186439088,"humidity":72.6606041624493}
    ```

1. Leave the simulated device running while you move on to the next module.

Congratulations, that's the end of the unit! In the next unit, we'll verify event flow from downstream device through IoT Edge Gateway to IoT Hub. 