Azure Sphere is a secured, high-level application platform with built-in communication and security features for internet-connected devices. The Azure Sphere platform comprises three components:

- A secured, connected, crossover microcontroller unit (MCU)
- A custom high-level Linux-based operating system (OS)
- A cloud-based security service that provides continuous, renewable security

> [!NOTE] 
> Embedded processing typically includes two categories: application processors and MCUs. MCU-based designs are affordable and support real-time, low-power operation, but some connected-product requirements exceed traditional MCU constraints. Crossover processors combine application-processor capabilities with MCU characteristics, so they can run higher-level software while retaining embedded-device usability.

Each Azure Sphere MCU includes the Microsoft-designed Pluton security subsystem. Pluton provides the hardware-based root of trust, protects each device's cryptographic identity, supports secure boot, and enables measured boot for remote attestation with the Azure Sphere Security Service.

The Azure Sphere platform provides an ecosystem to develop, deploy, and maintain secure internet-connected IoT solutions. Security is the main value proposition for Azure Sphere. Based on that security foundation, the platform provides benefits that include:

- The ability to securely and remotely **maintain connected IoT devices** in the field
- **Protection from different kinds of security risks**, such as spoofing, rogue software, or denial-of-service attacks
- **The ability to receive software updates automatically** to address the latest security threats. Software updates can be deployed from the cloud to connected Azure Sphere devices to fix problems, provide new functionality, or counter emerging methods of attack
- **Improved productivity** for support personnel through automated software updates
- The ability to **report operational data over secured connections** so downstream services, such as Azure IoT, Azure Monitor, or customer cloud applications, can help diagnose problems, analyze product telemetry, and support future product design
- **Overall benefits** to the value chain, including customer satisfaction, product support, and future development
- **Support for legacy IoT devices** through [guardian modules](https://learn.microsoft.com/azure-sphere/hardware/guardian-modules?view=azure-sphere-integrated)

> [!NOTE]
> Azure Sphere updates require connectivity and deployment configuration. Pre-requisite and OS updates require the device or guardian module to have periodic internet access to the required Azure Sphere endpoints, ports, and protocols. Application and board-configuration updates also require the device to be claimed by a catalog, assigned to a device group that is targeted by a deployment and uses the UpdateAll update policy, and free of the application development capability. For details, see [Azure Sphere OS networking requirements](https://learn.microsoft.com/azure-sphere/network/ports-protocols-domains?view=azure-sphere-integrated) and [About over-the-air updates](https://learn.microsoft.com/azure-sphere/deployment/device-updates?view=azure-sphere-integrated).
