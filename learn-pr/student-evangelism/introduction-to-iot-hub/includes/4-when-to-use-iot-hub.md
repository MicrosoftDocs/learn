In this section, we'll discuss how you can decide whether IoT Hub is the right choice for your solution. We'll list some of the criteria that you can use to create IoT solutions in the cloud that are capable of scaling. Because IoT Hub is central to the use of Azure IoT in the cloud, all IoT solutions will use IoT Hub. However, the exact configuration of IoT Hub you should use depends on selection criteria listed below.

## Decision criteria

The primary considerations for selection include:

|                                                              |                                                              |
| :----------------------------------------------------------: | ------------------------------------------------------------ |
|                  **Application complexity**                  | Azure IoT Hub offers two tiers. If your IoT solution is based around collecting data from devices and analyzing it centrally, then choose the basic tier. For more advanced configurations or to use distributed processing, use the standard tier. The standard tier of IoT Hub enables all features and is required for any IoT solutions that want to make use of the bi-directional communication capabilities. The basic tier enables a subset of the features and is intended for IoT solutions that only need uni-directional communication from devices to the cloud. Both tiers offer the same security and authentication features.			 			  				 		Features of the standard tier are device-to-cloud telemetry, Per-device 			identity, Message routing, message enrichments, Event Grid integration, support for HTTP, AMQP, and MQTT protocol, Device Provisioning Service, Monitoring and diagnostics, Cloud-to-device messaging, Device twins, Module twins, and Device management, Device streams, Azure IoT Edge, and IoT Plug and Play Preview. |
|                     **Data throughput**                      | Data throughout depends on how much data you plan to move daily. Each IoT Hub tier is available in three sizes - numerically identified as 1, 2, and 3. Each unit of a level 1 IoT hub can handle 400 thousand messages a day, and a level 3 unit can handle 300 million. |
| **Securing solution end to end allowing for per-device authentication** | IoT Hub uses permissions to grant access to each IoT hub endpoint. Permissions limit the access to an IoT Hub based on functionality. |
|               **Bi-directional communication**               | Azure IoT Hub can be used to establish bidirectional communication with billions of IoT devices. You can use device-to-cloud telemetry data to understand the state of your devices and define message routes to other Azure services – without writing any code. In cloud-to-device messages, reliably send commands and notifications to your connected devices – and track message delivery with acknowledgement receipts. Automatically resend device messages as needed to accommodate intermittent connectivity. |

A more comprehensive list of considerations includes:

|                               |                                                              |
| :---------------------------: | ------------------------------------------------------------ |
|         **Telemetry**         | Does your solution need only basic telemetry services?       |
|    **Geographic coverage**    | Does your solution need comprehensive geographic coverage?   |
|    **Support for devices**    | Do you need to support a range of devices for your solution? |
| **Manage a range of devices** | Do you need to track and manage data for different kinds of devices? |
|  **Communication protocols**  | Does your solution need to connect over different kinds of communication protocols? |
|      **Message routing**      | How do you ensure that only the right devices talk to each other? |
|         **Security**          | How do you secure the solution?                              |