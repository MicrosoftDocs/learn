In this exercise, you will configure the downstream, child IoT Devices to connect to IoT Hub using their configured Symmetric Keys. The devices will be configured to connect to IoT Hub and the parent IoT Edge Device using a Connection String that contains the Symmetric Key; in addition to the Gateway Hostname for the Parent IoT Edge Device.

The process to authenticate regular IoT devices to IoT Hub with symmetric keys also applies to downstream (or child / leaf) devices. The only difference is that you need to add a pointer to the Gateway Device to route the connection or, in offline scenarios, to handle the authentication on behalf of IoT Hub.

In a previous unit, you created the IoT Device Identities in Azure IoT Hub. You copied the **Connection String** for the IoT Device. Alternatively, the Connection String can be accessed with the Azure portal for the Device ID of the device within Azure IoT Hub.

## Connecting the Child IoT Device to IoT Edge Gateway

1. Copy the azure-iot-test-only.root.ca.cert.pem x.509 certificate file that was downloaded previously (when the IoT Edge Gateway was configured) to the /LabFiles/ChildIoTDevice directory where the source code for the Child IoT Device is located.

1. Open the /LabFiles/ChildIoTDevice directory within **Visual studio Code**.

1. Open the **ChildIoTDevice.cs** source code file.

1. Locate the declaration for the s_connectionString variable and replace the value placeholder with the **IoT Hub Connection String** for the **ChildDevice1** IoT Device.

1. Modify the IoT Hub Connection String to include the GatewayHostName property with the value set to the Hostname for the IoT Edge Gateway (IoTEdgeGateway) virtual machine.

  The Connection String will match the following format:

  ```Bash
      HostName=<iot-hub-name>.azure-devices.net;DeviceId=DownstreamDevice1;SharedAccessKey=<iot-device-key>;GatewayHostName=<iot-edge-gateway-hostname>
  ```
  Be sure to replace the placeholders with the appropriate values:

  -- <iot-hub-name>: The Name of the Azure IoT Hub.
  -- <iot-device-key>: The Primary or Secondary Key for the ChildDevice1 IoT Device in IoT Hub.
  -- <iot-edge-gateway-hostname>: Enter the IP Address for the IoTEdgeGateway virtual machine.

1. Save the file.

1. Open the **Terminal** window within Visual Studio Code.

1. Navigate the **Terminal** to the location of the /LabFiles/ChildIoTDevice directory.

1. Run the following command to build the code for the **ChildIoTDevice** simulated device, and execute it to start sending device telemetry:

  ```Bash
       dotnet run
  ```

1. When the app installed the **x.509 certificate** on the local machine so it can use it to authenticate with the IoT Edge Gateway, it may prompt asking if you would like to install the certificate. Click Yes to allow it and continue.

1. Once the simulated device is running, the console output will display the events being sent to the Azure IoT Edge Gateway.

  The terminal output will look similar to the following:

  ```Bash
     IoT Hub Quickstarts #1 - Simulated device. Ctrl-C to exit.

      User configured CA certificate path: azure-iot-test-only.root.ca.cert.pem
      Attempting to install CA certificate: azure-iot-test-only.root.ca.cert.pem
      Successfully added certificate: azure-iot-test-only.root.ca.cert.pem
      11/27/2019 4:18:26 AM > Sending message: {"temperature":21.768769073192388,"humidity":79.89793652663843}
      11/27/2019 4:18:27 AM > Sending message: {"temperature":28.317862208149332,"humidity":73.60970909409677}
      11/27/2019 4:18:28 AM > Sending message: {"temperature":25.552859350830715,"humidity":72.7897707153064}
      11/27/2019 4:18:29 AM > Sending message: {"temperature":32.81164186439088,"humidity":72.6606041624493}

1. Leave the simulated device running while you move on to the next unit.