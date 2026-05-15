The three components of the Azure Sphere platform work together to provide defense in depth and end-to-end security for an IoT solution. Each layer helps verify, isolate, or constrain the layers above it so that a weakness in one part of the device is less likely to compromise the full device-to-cloud system.

## Hardware architecture

The hardware architecture provides a secured computing base at the device level. Each Azure Sphere MCU includes the Microsoft-designed Pluton security subsystem, which provides the hardware root of trust, protects device identity, supports secure boot, and enables measured boot for remote attestation.

## Software architecture

The software architecture includes the Azure Sphere OS, the Security Monitor, and application runtime services. This secured software base lets you focus on value-added device features while Microsoft maintains the underlying OS and security components.

## Azure Sphere Security Service

The Azure Sphere Security Service supports authentication, software updates, and error reporting over secured cloud-to-device and device-to-cloud channels. Azure Sphere devices automatically perform authentication and attestation with the Azure Sphere Security Service every 24 hours; successful attestation results in a renewed device certificate that the device can use to authenticate to trusted services.

## Guardian modules and brownfield devices

Azure Sphere also supports legacy IoT scenarios through [guardian modules](/azure-sphere/hardware/guardian-modules?view=azure-sphere-integrated&preserve-view=true). A guardian module is add-on hardware that incorporates an Azure Sphere chip and attaches to a brownfield device.

> [!NOTE]
> Brownfield devices are existing devices already in use that either don't support internet connectivity or don't support it securely.

The guardian module uses the Azure Sphere Security Service for certificate-based authentication, error reporting, and over-the-air software updates for the guardian module itself. It connects downstream to brownfield equipment over interfaces such as UART, RS-485, SPI, private Ethernet, Bluetooth, or ZigBee. The brownfield equipment remains a separate device; Azure Sphere doesn't automatically patch or secure all internal behavior of that equipment.

The following sections show how these components interact in the solar-panel monitoring scenario.

## Security Service updates

Microsoft delivers Azure Sphere OS updates through the Azure Sphere Security Service. The product engineering team builds a new application image for the solar-panel monitoring controller, gateway, or guardian module; uploads the image package; creates a deployment; and targets the deployment to a device group. The Azure Sphere Security Service then rolls the update out to every connected device in that group.

For updates to succeed, devices or guardian modules need periodic internet access to the required Azure Sphere endpoints, ports, and protocols. Application and board-configuration updates also require the device to be claimed by a catalog, assigned to a device group that is targeted by a deployment and uses the UpdateAll update policy, and free of the application development capability.

## Support and services

The Azure Sphere Security Service receives daily error and event data for Azure Sphere devices and high-level applications. Support personnel can use that data to investigate crashes, exits, update events, and OS or hardware events reported by deployed monitoring controllers, gateways, or guardian modules.

Solar-array operating measurements, such as inverter status, power output, environmental readings, or maintenance indicators, are product telemetry rather than Azure Sphere Security Service error reports. A high-level application can send that telemetry over a secured connection to Azure IoT or another customer cloud service, where support teams can run analytics, trigger alerts, and plan maintenance.

## Product engineering

The product engineering team can use downstream cloud services, such as Azure IoT, Azure Monitor, or a customer-specific application, to visualize product telemetry from solar-array monitoring equipment. The team can use these insights, together with Azure Sphere error and event reports, to improve the solution or design new services.

## Support for legacy equipment

Many existing solar sites include controllers, inverters, or other equipment that wasn't designed for secure internet connectivity. A guardian module can attach to that brownfield equipment, securely relay selected telemetry or commands, and receive its own Azure Sphere OS and application updates through the Azure Sphere Security Service.

