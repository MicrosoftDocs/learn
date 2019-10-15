In this section, we will discuss how you can decide whether IoT Hub is the right choice for your application. We will list some of the criteria that you can use to create IoT applications in the cloud that are capable of scaling. Because IoT Hub is central to the use of Azure IoT applications in the cloud, all IoT applications will use IoT Hub.  However, the exact configuration of IoT Hub you should use depends on selection criteria listed below. 

## Decision criteria

There are two primary considerations:

|                            |                                                              |
| -------------------------- | ------------------------------------------------------------ |
| **Application complexity** | Azure IoT Hub offers two tiers. If your IoT application is based around collecting data from devices and analysing it centrally, then choose the basic tier. For more advanced configurations or to use distributed processing, use the standard tier. |
| **Data throughput**        | Data throughout depends on how much data do you plan to move daily. Each IoT Hub tier is available in three sizes - numerically identified as 1, 2, and 3. Each unit of a level 1 IoT hub can handle 400 thousand messages a day, and a level 3 unit can handle 300 million. |


A more comprehensive list of considerations include:

|                               |                                                              |
| ----------------------------- | ------------------------------------------------------------ |
| **Telemetry**                 | Does your application need only basic telemetry services?    |
| **Geographic coverage**       | Does your application need comprehensive geographic coverage? |
| **Support for devices**       | Do you need to support a range of devices for your application? |
| **Manage a range of devices** | Do you need to track and manage data for different kinds of devices? |
| **Communication protocols**   | Does your application need to connect over different kinds of communication protocols? |
| **Message routing**           | How do you ensure that only the right devices talk to each other? |
| **Security**                  | How do you secure the solution?                              |

