> [!IMPORTANT]
> Microsoft announced the planned retirement of Azure Sphere on March 20, 2026. The first-generation MT3620 silicon reaches end of life on July 31, 2026, and extended support for the Azure Sphere OS and Security Service ends on July 31, 2031. After that date, Azure Sphere devices no longer receive application or OS updates, bug fixes, or security patches, and device attestation and authentication services cease. Treat this guidance as context for maintaining or understanding existing Azure Sphere deployments, not as a recommendation to select Azure Sphere for a new product design. For new designs or redesigns, review [Retirement of Azure Sphere](https://learn.microsoft.com/azure-sphere/product-overview/retirement?view=azure-sphere-integrated) and evaluate replacement silicon and Azure IoT services such as Azure IoT Hub and Device Update for IoT Hub.
> 
> If you manage an existing Azure Sphere fleet, also plan to use [Azure Sphere (Integrated)](https://learn.microsoft.com/azure-sphere/product-overview/az-sphere-integrated?view=azure-sphere-integrated). The Azure Sphere (Legacy) interfaces, including PAPI and the `azsphere` CLI, retire on September 27, 2027.

Use the following criteria to understand where Azure Sphere fits in an existing or previously designed IoT solution. Azure Sphere was designed for secured, internet-connected, microcontroller-powered devices that need hardware-rooted trust, a secured OS, authenticated cloud connections, over-the-air updates, and error reporting.

## Security requirements

Azure Sphere helps protect connected MCU-powered devices through a secured application platform, a custom Linux-based OS, and the Azure Sphere Security Service. The platform is designed around the [seven properties of highly secured devices](https://learn.microsoft.com/azure-sphere/product-overview/what-is-azure-sphere?view=azure-sphere-integrated#azure-sphere-and-the-seven-properties-of-highly-secured-devices) ([PDF](https://aka.ms/7properties)), including hardware-based root of trust, defense in depth, password-less authentication, error reporting, and renewable security.

Azure Sphere devices perform authentication and attestation with the Azure Sphere Security Service every 24 hours. When attestation succeeds, the device receives a renewed certificate that it can use to authenticate to trusted services, including Azure IoT services that are configured to trust the Azure Sphere catalog certificate.

## Connectivity and update prerequisites

Azure Sphere is a good fit only when the connected device or guardian module can periodically reach the required Azure Sphere endpoints and ports. Devices need that connectivity for basic operation, certificate renewal, prerequisite updates, OS updates, and customer deployment updates. For application and board-configuration updates, the device must also be claimed into an Azure Sphere catalog, must not have the application development capability enabled, and must belong to a device group that is targeted by a deployment and uses the UpdateAll update policy.

For details, see [Azure Sphere OS networking requirements](https://learn.microsoft.com/azure-sphere/network/ports-protocols-domains?view=azure-sphere-integrated) and [About over-the-air updates](https://learn.microsoft.com/azure-sphere/deployment/device-updates?view=azure-sphere-integrated).

## Operations and data flow

Azure Sphere can help support operations by delivering OS and application updates and by reporting device or application errors and events over secured connections. Product telemetry, analytics, and visualization are separate parts of the solution architecture. An Azure Sphere application can send product telemetry to Azure IoT Hub, Azure IoT Central, or another trusted cloud service. Those downstream services, along with Azure Monitor, Log Analytics, dashboards, or customer applications, are where teams analyze data, visualize trends, and trigger maintenance workflows.

## Scenario guidance

In the solar monitoring scenario, Azure Sphere could apply to an existing fleet of Azure Sphere-enabled monitoring controllers, inverters, or gateways that connect solar equipment to cloud services. For brownfield equipment, a guardian module can attach to an existing controller, inverter, or gateway to provide a secured interface between that equipment and the network.

A guardian module securely relays telemetry or commands and receives its own Azure Sphere OS and application updates. It doesn't turn the attached brownfield equipment into an Azure Sphere device, and it doesn't automatically secure, patch, or validate the internal firmware of that equipment. The brownfield equipment remains a separate device with its own security and maintenance requirements.

With that architecture, support teams can use device events, error reports, and downstream product telemetry to investigate abnormal conditions in the solar monitoring system. Engineering teams can analyze telemetry in Azure IoT, Azure Monitor, or customer cloud services to understand long-term trends and plan future products or services.
