The IoT Edge runtime is a collection of programs that turn a device into an IoT Edge device. Collectively, the IoT Edge runtime components enable IoT Edge devices to receive code to run at the edge and communicate the results.

The IoT Edge runtime is responsible for the following functions on IoT Edge devices:

 -  Install and update workloads on the device.
 -  Maintain Azure IoT Edge security standards on the device.
 -  Ensure that IoT Edge modules are always running.
 -  Report module health to the cloud for remote monitoring.
 -  Manage communication between downstream devices and IoT Edge devices.
 -  Manage communication between modules on the IoT Edge device.
 -  Manage communication between the IoT Edge device and the cloud.
 -  Manage communication between IoT Edge devices.

These responsibilities can be grouped into two categories, communication and module management, which are performed by two corresponding components of the IoT Edge runtime. The **IoT Edge hub** is responsible for communication, while the **IoT Edge agent** deploys and monitors the modules.

Both the IoT Edge hub and the IoT Edge agent are modules, just like any other module running on an IoT Edge device. They're sometimes referred to as the runtime modules.

## IoT Edge hub

The IoT Edge hub acts as a local proxy for IoT Hub by exposing the same protocol endpoints as IoT Hub. This consistency means that clients (whether devices or modules) can connect to the IoT Edge runtime just as they would to IoT Hub.

> [!NOTE]
> IoT Edge hub supports clients that connect using MQTT or AMQP. It does not support clients that use HTTP.

The IoT Edge hub is not a full version of IoT Hub running locally. There are some things that the IoT Edge hub silently delegates to IoT Hub. For example, IoT Edge hub forwards authentication requests to IoT Hub when a device first tries to connect. After the first connection is established, security information is cached locally by IoT Edge hub. Subsequent connections from that device are allowed without having to authenticate to the cloud.

To reduce the bandwidth your IoT Edge solution uses, the IoT Edge hub optimizes how many actual connections are made to the cloud. IoT Edge hub takes logical connections from clients like modules or downstream devices and combines them for a single physical connection to the cloud. The details of this process are transparent to the rest of the solution. Clients think they have their own connection to the cloud even though they are all being sent over the same connection.

:::image type="content" source="../media/m06-l01-iot-edge-hub-682ff0e6.png" alt-text="Diagram that illustrates the IoT Edge hub acting as a local proxy for IoT Hub.":::


IoT Edge hub can determine whether it's connected to IoT Hub. If the connection is lost, IoT Edge hub saves messages or twin updates locally. Once a connection is reestablished, it syncs all the data. The location used for this temporary cache is determined by a property of the IoT Edge hub’s module twin. The size of the cache is not capped and will grow as long as the device has storage capacity.

### Module communication

IoT Edge hub facilitates module to module communication. Using IoT Edge hub as a message broker keeps modules independent from each other. Modules only need to specify the inputs on which they accept messages and the outputs to which they write messages. A solution developer can stitch these inputs and outputs together so that the modules process data in the order specific to that solution.

:::image type="content" source="../media/m06-l01-iot-edge-module-communication-module-endpoints-a729b3b0.png" alt-text="Diagram that illustrates how IoT Edge hub facilitates module to module communication.":::


To send data to the IoT Edge hub, a module calls the SendEventAsync method. The first argument specifies on which output to send the message. The following pseudocode sends a message on output1:

```
ModuleClient client = await ModuleClient.CreateFromEnvironmentAsync(transportSettings);
await client.OpenAsync();
await client.SendEventAsync("output1", message);

```

To receive a message, register a callback that processes messages coming in on a specific input. The following pseudocode registers the function messageProcessor to be used for processing all messages received on input1:

```
await client.SetInputMessageHandlerAsync("input1", messageProcessor, userContext);

```

For more information about the ModuleClient class and its communication methods, see the API reference for your preferred SDK language

The solution developer is responsible for specifying the rules that determine how IoT Edge hub passes messages between modules. Routing rules are defined in the cloud and pushed down to IoT Edge hub in its module twin. The same syntax for IoT Hub routes is used to define routes between modules in Azure IoT Edge.

## IoT Edge agent

The IoT Edge agent is the other module that makes up the Azure IoT Edge runtime. It is responsible for instantiating modules, ensuring that they continue to run, and reporting the status of the modules back to IoT Hub. This configuration data is written as a property of the IoT Edge agent module twin.

The IoT Edge security daemon starts the IoT Edge agent on device startup. The agent retrieves its module twin from IoT Hub and inspects the deployment manifest. The deployment manifest is a JSON file that declares the modules that need to be started.

Each item in the deployment manifest contains specific information about a module and is used by the IoT Edge agent for controlling the module’s lifecycle. Some of the more interesting properties are:

 -  **settings.image** – The container image that the IoT Edge agent uses to start the module. The IoT Edge agent must be configured with credentials for the container registry if the image is protected by a password. Credentials for the container registry can be configured remotely using the deployment manifest, or on the IoT Edge device itself by updating the config.yaml file in the IoT Edge program folder.
 -  **settings.createOptions** – A string that is passed directly to the Moby container daemon when starting a module’s container. Adding options in this property allows for advanced configurations like port forwarding or mounting volumes into a module’s container.
 -  **status** – The state in which the IoT Edge agent places the module. Usually, this value is set to running as most people want the IoT Edge agent to immediately start all modules on the device. However, you could specify the initial state of a module to be stopped and wait for a future time to tell the IoT Edge agent to start a module. The IoT Edge agent reports the status of each module back to the cloud in the reported properties. A difference between the desired property and the reported property is an indicator of a misbehaving device. The supported statuses are:
    
     -  Downloading
     -  Running
     -  Unhealthy
     -  Failed
     -  Stopped
 -  **restartPolicy** – How the IoT Edge agent restarts a module. Possible values include:
    
     -  Never – The IoT Edge agent never restarts the module.
     -  On-failure - If the module crashes, the IoT Edge agent restarts it. If the module shuts down cleanly, the IoT Edge agent does not restart it.
     -  On-unhealthy - If the module crashes or is considered unhealthy, the IoT Edge agent restarts it.
     -  Always - If the module crashes, is considered unhealthy, or shuts down in any way, the IoT Edge agent restarts it.
 -  **imagePullPolicy** \- Whether the IoT Edge agent attempts to pull the latest image for a module automatically or not. If you don't specify a value, the default is onCreate. Possible values include:
    
     -  On-create - When starting a module or updating a module based on a new deployment manifest, the IoT Edge agent will attempt to pull the module image from the container registry.
     -  Never - The IoT Edge agent will never attempt to pull the module image from the container registry. The expectation is that the module image is cached on the device, and any module image updates are made manually or managed by a third-party solution.

The IoT Edge agent sends runtime response to IoT Hub. Here is a list of possible responses:

 -  200 - OK
 -  400 - The deployment configuration is malformed or invalid.
 -  417 - The device doesn't have a deployment configuration set.
 -  412 - The schema version in the deployment configuration is invalid.
 -  406 - The IoT Edge device is offline or not sending status reports.
 -  500 - An error occurred in the IoT Edge runtime.

## The iotedge command-line tool

The **iotedge** tool is a command-line tool that is used to manage the IoT Edge runtime. To view the available subcommands, enter the following command:

```bash
iotedge help

```

:::row:::
  :::column:::
    **SUBCOMMAND**
  :::column-end:::
  :::column:::
    **DESCRIPTION**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    check
  :::column-end:::
  :::column:::
    Check for common config and deployment issues.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    check-list
  :::column-end:::
  :::column:::
    List the checks that are run for 'iotedge check'.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    help
  :::column-end:::
  :::column:::
    Prints this message or the help of the given subcommand(s).
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    list
  :::column-end:::
  :::column:::
    List modules.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    logs
  :::column-end:::
  :::column:::
    Fetch the logs of a module.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    restart
  :::column-end:::
  :::column:::
    Restart a module.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    version
  :::column-end:::
  :::column:::
    Show the version information.
  :::column-end:::
:::row-end:::


To view the details of each of the subcommands, you can specify the `-h` option, for example:

```bash
iotedge check -h

```

### Module management

The **iotedge** command-line tool provides a number of commands to assist in the management of IoT Edge modules that are deployed to the device. To obtain a list of deployed modules, enter the following command:

```bash
sudo iotedge list

```

To restart a specific module, enter the following command:

```bash
sudo iotedge restart <module>

```

To view diagnostic logs relating to a specific module, enter the following command:

```bash
sudo iotedge logs <module>

```

### IoT Edge runtime troubleshooting

The **iotedge** tool is useful for troubleshooting configuration issues and performs a series of checks. For more information about troubleshooting, see [Troubleshoot your IoT Edge device](/azure/iot-edge/troubleshoot).

To view a list of the available checks, enter the following command:

```bash
iotedge check-list

```

These are the available checks:

:::row:::
  :::column:::
    **CATEGORY**
  :::column-end:::
  :::column:::
    **ID**
  :::column-end:::
  :::column:::
    **DESCRIPTION**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    config-yaml-well-formed
  :::column-end:::
  :::column:::
    config.yaml is well formed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    connection-string
  :::column-end:::
  :::column:::
    config.yaml has well formed connection string.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    container-engine-uri
  :::column-end:::
  :::column:::
    Container engine is installed and functional.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    windows-host-version
  :::column-end:::
  :::column:::
    Windows host version is supported.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    hostname
  :::column-end:::
  :::column:::
    config.yaml has correct hostname.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    connect-management-uri
  :::column-end:::
  :::column:::
    config.yaml has correct URIs for daemon mgmt endpoint.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    iotedged-version
  :::column-end:::
  :::column:::
    Latest security daemon.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    host-local-time
  :::column-end:::
  :::column:::
    Host time is close to real-time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    container-local-time
  :::column-end:::
  :::column:::
    Container time is close to host-time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    container-engine-dns
  :::column-end:::
  :::column:::
    DNS server.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    certificates-quickstart
  :::column-end:::
  :::column:::
    Production readiness: certificates.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    certificates-expiry
  :::column-end:::
  :::column:::
    Production readiness: certificates expiry.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    container-engine-is-moby
  :::column-end:::
  :::column:::
    Production readiness: container engine.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Configuration checks
  :::column-end:::
  :::column:::
    container-engine-logrotate
  :::column-end:::
  :::column:::
    Production readiness: logs policy.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    host-connect-dps-endpoint
  :::column-end:::
  :::column:::
    Host can connect to and perform TLS handshake with DPS endpoint.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    host-connect-iothub-amqp
  :::column-end:::
  :::column:::
    Host can connect to and perform TLS handshake with IoT Hub AMQP port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    host-connect-iothub-https
  :::column-end:::
  :::column:::
    Host can connect to and perform TLS handshake with IoT Hub HTTPS / WebSockets port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    host-connect-iothub-mqtt
  :::column-end:::
  :::column:::
    Host can connect to and perform TLS handshake with IoT Hub MQTT port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    container-default-connect-iothub-amqp
  :::column-end:::
  :::column:::
    Container on the default network can connect to IoT Hub AMQP port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    container-default-connect-iothub-https
  :::column-end:::
  :::column:::
    Container on the default network can connect to IoT Hub HTTPS / WebSockets port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    container-default-connect-iothub-mqtt
  :::column-end:::
  :::column:::
    Container on the default network can connect to IoT Hub MQTT port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    container-module-connect-iothub-amqp
  :::column-end:::
  :::column:::
    Container on the IoT Edge module network can connect to IoT Hub AMQP port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    container-module-connect-iothub-https
  :::column-end:::
  :::column:::
    Container on the IoT Edge module network can connect to IoT Hub HTTPS / WebSockets port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    container-module-connect-iothub-mqtt
  :::column-end:::
  :::column:::
    Container on the IoT Edge module network can connect to IoT Hub MQTT port.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connectivity checks
  :::column-end:::
  :::column:::
    edgehub-host-ports
  :::column-end:::
  :::column:::
    Edge Hub can bind to ports on host.
  :::column-end:::
:::row-end:::


To execute the full list of checks, the **iotedge** tool must be run with elevated privileges (for example using the **sudo** command on Linux).

```bash
sudo iotedge check

```

Here is an example of the output for a newly provisioned IoT Edge VM that has yet to be configured:

:::image type="content" source="../media/m06-l02-iot-edge-checklist-output-54fa48cd.png" alt-text="Screenshot that shows the console output for a newly provisioned IoT Edge VM that has yet to be configured.":::
