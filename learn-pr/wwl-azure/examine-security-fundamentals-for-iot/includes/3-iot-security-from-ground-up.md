The Internet of Things (IoT) poses unique security, privacy, and compliance challenges to businesses worldwide. Unlike traditional cyber technology where these issues revolve around software and how it is implemented, IoT concerns what happens when the cyber and the physical worlds converge. Protecting IoT solutions requires ensuring secure provisioning of devices, secure connectivity between these devices and the cloud, and secure data protection in the cloud during processing and storage. Working against such functionality, however, are resource-constrained devices, geographic distribution of deployments, and a large number of devices within a solution.

## Microsoft Azure - secure IoT infrastructure for your business

Microsoft Azure offers a complete cloud solution, one that combines a constantly growing collection of integrated cloud services—analytics, machine learning, storage, security, networking, and web—with an industry-leading commitment to the protection and privacy of your data.

Microsoft's systems provide continuous intrusion detection and prevention, service attack prevention, regular penetration testing, and forensic tools that help identify and mitigate threats. Multifactor authentication provides an extra layer of security for end users to access the network. And for the application and the host provider, Microsoft offers access control, monitoring, anti-malware, vulnerability scanning, patches, and configuration management.

The Azure IoT Hub offers a fully-managed service that enables reliable and secure bi-directional communication between IoT devices and Azure services such as Azure Machine Learning and Azure Stream Analytics by using per-device security credentials and access control.

### Secure device provisioning and authentication

Secure device provisioning means providing a unique identity key for each device, which can be used by the IoT infrastructure to communicate with the device while it is in operation. The generated key with a user-selected device ID forms the basis of a token used in all communication between the device and the Azure IoT Hub.

Device IDs can be associated with a device during manufacturing (that is, flashed in a hardware trust module) or can use an existing fixed identity as a proxy (for example CPU serial numbers). Since changing this identifying information in the device is not simple, it is important to introduce logical device IDs in case the underlying device hardware changes but the logical device remains the same. In some cases, the association of a device identity can happen at device deployment time (for example, an authenticated field engineer physically configures a new device while communicating with the solution backend). The Azure IoT Hub identity registry provides secure storage of device identities and security keys for a solution. Individual or groups of device identities can be added to an allowlist, or a blocklist, enabling complete control over device access.

Azure IoT Hub access control policies in the cloud enable activation and disabling any device identity, providing a way to disassociate a device from an IoT deployment when required. This association and disassociation of devices is based on each device identity.

Other device security features include:

 -  Devices do not accept unsolicited network connections. They establish all connections and routes in an outbound-only fashion. For a device to receive a command from the backend, the device must initiate a connection to check for any pending commands to process. Once a connection between the device and IoT Hub is securely established, messaging from the cloud to the device and device to the cloud can be sent transparently.
 -  Devices only connect to or establish routes to well-known services with which they are peered, such as an Azure IoT Hub.
 -  System-level authorization and authentication use per-device identities, making access credentials and permissions near-instantly revocable.

### Secure connectivity

Azure IoT Hub supports secure connectivity using industry proven protocols - HTTPS, AMQP, and MQTT.

Azure IoT Hub offers durability of messaging between cloud and devices through a system of acknowledgments in response to messages. Extra durability for messaging is achieved by caching messages in the IoT Hub for up to seven days for telemetry and two days for commands. This approach enables devices that connect sporadically, due to power or connectivity concerns, to receive these commands. Azure IoT Hub maintains a per-device queue for each device.

Scalability requires the ability to securely interoperate with a wide range of devices. Azure IoT hub enables secure connection to both IP-enabled and non-IP-enabled devices (using an IoT Edge device as a gateway).

Other connection security features include:

 -  The communication path between devices and Azure IoT Hub, or between gateways and Azure IoT Hub, is secured using industry-standard Transport Layer Security (TLS) with Azure IoT Hub authenticated using X.509 protocol.
 -  In order to protect devices from unsolicited inbound connections, Azure IoT Hub does not open any connection to the device. The device initiates all connections.
 -  Azure IoT Hub durably stores messages for devices and waits for the device to connect. These commands are stored for two days, enabling devices connecting sporadically, due to power or connectivity concerns, to receive these commands. Azure IoT Hub maintains a per-device queue for each device.

### Secure processing and storage in the cloud

Using Microsoft Entra ID for user authentication and authorization, Azure IoT Hub can provide a policy-based authorization model for data in the cloud, enabling easy access management that can be audited and reviewed.

Once data is in the cloud, it can be processed and stored in any user-defined workflow. Access to each part of the data is controlled with Microsoft Entra ID, depending on the storage service used.

All keys used by the IoT infrastructure are stored in the cloud in secure storage, with the ability to roll over in case keys need to be reprovisioned. Data can be stored in Azure Cosmos DB or in SQL databases, enabling definition of the level of security desired. Additionally, Azure provides a way to monitor and audit all access to your data to alert you of any intrusion or unauthorized access.

### Secure networks

By default, IoT Hub's hostnames map to a public endpoint with a publicly routable IP address over the internet. This allows different customers to share this IoT Hub public endpoint, and ensures that IoT devices connecting over wide-area networks and on-premises networks can access your hub. However, there are situations where you might want to restrict access to your Azure resources. Azure IoT solutions support both IP filtering and virtual networks to help secure access when needed.

For detailed information on securing network access, see the following resources:

 -  IoT Hub IP filtering: [Use IP filters](/azure/iot-hub/iot-hub-ip-filtering).
 -  Virtual network support: [IoT Hub support for virtual networks with Private Link and Managed Identity](/azure/iot-hub/virtual-network-support)