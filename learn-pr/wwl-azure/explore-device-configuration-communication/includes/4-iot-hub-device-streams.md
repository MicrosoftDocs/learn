Azure IoT Hub device streams facilitate the creation of secure bi-directional TCP tunnels for various cloud-to-device communication scenarios. A device stream is mediated by an IoT Hub streaming endpoint that acts as a proxy between your device and service endpoints. This setup, depicted in the diagram below, is especially useful when devices are behind a network firewall or reside inside of a private network. As such, IoT Hub device streams help address customers' need to reach IoT devices in a firewall-friendly manner and without the need to broadly opening up incoming or outgoing network firewall ports.

:::image type="content" source="../media/m02-l03-iot-hub-device-streams-overview-4b2a5e19.png" alt-text="Diagram that shows IoT Hub Device Streams connecting to IoT Hub.":::


Using IoT Hub device streams, devices remain secure and will only need to open up outbound TCP connections to IoT hub's streaming endpoint over port 443. Once a stream is established, the service-side and device-side applications will each have programmatic access to a WebSocket client object to send and receive raw bytes to one another. The reliability and ordering guarantees provided by this tunnel is on par with TCP.

## Benefits

IoT Hub device streams provide the following benefits:

 -  Firewall-friendly secure connectivity: IoT devices can be reached from service endpoints without opening of inbound firewall port at the device or network perimeters (only outbound connectivity to IoT Hub is needed over port 443).
 -  Authentication: Both device and service sides of the tunnel need to authenticate with IoT Hub using their corresponding credentials.
 -  Encryption: By default, IoT Hub device streams use TLS-enabled connections. This connection ensures that the traffic is always encrypted regardless of whether the application uses encryption or not.
 -  Simplicity of connectivity: In many cases, the use of device streams eliminates the need for complex setup of Virtual Private Networks to enable connectivity to IoT devices.
 -  Compatibility with TCP/IP stack: IoT Hub device streams can accommodate TCP/IP application traffic. This compatibility ensures that a wide range of proprietary and standards-based protocols can use this feature.
 -  Ease of use in private network setups: Service can communicate with a device by referencing its device ID, rather than device's IP address. This feature is useful in situations where a device is located inside a private network and has a private IP address, or its IP address is assigned dynamically and is unknown to the service side.

## Device stream workflows

A device stream is initiated when the service requests to connect to a device by providing its device ID. This workflow particularly fits into a client/server communication model, including SSH and RDP, where a user intends to remotely connect to the SSH or RDP server running on the device using an SSH or RDP client program.

The device stream creation process involves a negotiation between the device, service, IoT hub's main and streaming endpoints. While IoT hub's main endpoint orchestrates the creation of a device stream, the streaming endpoint handles the traffic that flows between the service and device.

:::image type="content" source="../media/m02-l03-iot-hub-device-streams-workflow-d51f35c3.png" alt-text="Diagram that shows Device Stream Workflows connecting to the cloud.":::


1.  The device application registers a callback in advance to be notified of when a new device stream is initiated to the device. This step typically takes place when the device boots up and connects to IoT Hub.
2.  The service-side program initiates a device stream when needed by providing the device ID (not the IP address).
3.  IoT hub notifies the device-side program by invoking the callback registered in step 1. The device may accept or reject the stream initiation request. This logic can be specific to your application scenario. If the stream request is rejected by the device, IoT Hub informs the service accordingly; otherwise, the steps below follow.
4.  The device creates a secure outbound TCP connection to the streaming endpoint over port 443 and upgrades the connection to a WebSocket. The URL of the streaming endpoint and the credentials that should be used to authenticate are both provided to the device by IoT Hub as part of the request sent in step 3.
5.  The service is notified of the result of device accepting the stream and proceeds to create its own WebSocket client to the streaming endpoint. Similarly, it receives the streaming endpoint URL and authentication information from IoT Hub.

## Connectivity requirements

Both the device and the service sides of a device stream must be capable of establishing TLS-enabled connections to IoT Hub and its streaming endpoint. This requires outbound connectivity over port 443 to these endpoints. The hostname associated with these endpoints can be found on the Overview tab of IoT Hub.
