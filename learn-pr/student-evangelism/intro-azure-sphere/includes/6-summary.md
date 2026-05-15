> [!IMPORTANT]
> Azure Sphere is scheduled for retirement. The MT3620 silicon reaches end of life on July 31, 2026, and extended support for the Azure Sphere OS and Security Service ends on July 31, 2031. After that date, Azure Sphere devices no longer receive application or OS updates, bug fixes, or security patches, and device attestation and authentication services cease. Use this module as context for existing Azure Sphere deployments and brownfield scenarios; for new designs, follow the official retirement guidance and evaluate current Azure IoT and silicon options.

## Scenario recap

In this module, you explored how Azure Sphere can help secure connected MCU-powered devices in an IoT solution. In the solar monitoring scenario, the engineering team needed a secure way to operate connected monitoring controllers, inverters, gateways, and legacy equipment in the field.

Azure Sphere addressed the scenario by securing the Azure Sphere-enabled devices, authenticating their connections, supporting over-the-air OS and application updates, and reporting device or application errors and events. Guardian modules could attach to brownfield controllers, inverters, or gateways to add secure connectivity for telemetry and commands while the attached equipment remained a separate device.

## Key takeaways

- Azure Sphere combines a secured crossover MCU, Azure Sphere OS, and the Azure Sphere Security Service to provide hardware-rooted trust, defense in depth, password-less authentication, error reporting, and renewable security for connected devices.
- Azure Sphere devices and guardian modules need periodic internet access to the required Azure Sphere endpoints and ports. Application updates also require the device to be claimed into a catalog, not have the application development capability enabled, and belong to a device group that is targeted by a deployment and uses the UpdateAll update policy.
- Azure Sphere secures device connectivity and provides update, authentication, attestation, and error-reporting services. Analytics and visualization for product telemetry happen in downstream services such as Azure IoT Hub, Azure IoT Central, Azure Monitor, Log Analytics, or customer cloud applications.
- Guardian modules add secure connectivity to brownfield equipment and receive their own Azure Sphere updates. They don't automatically secure or patch the internal firmware of the attached brownfield equipment.
- For new product designs or redesigns, review the Azure Sphere retirement guidance and evaluate replacement silicon, Azure IoT Hub, Device Update for IoT Hub, and other current IoT services.

## Learn more

- [Retirement of Azure Sphere](https://learn.microsoft.com/azure-sphere/product-overview/retirement?view=azure-sphere-integrated)
- [What is Azure Sphere?](https://learn.microsoft.com/azure-sphere/product-overview/what-is-azure-sphere?view=azure-sphere-integrated)
- [Guardian modules](https://learn.microsoft.com/azure-sphere/hardware/guardian-modules?view=azure-sphere-integrated)
- [Azure Sphere OS networking requirements](https://learn.microsoft.com/azure-sphere/network/ports-protocols-domains?view=azure-sphere-integrated)
- [About over-the-air updates](https://learn.microsoft.com/azure-sphere/deployment/device-updates?view=azure-sphere-integrated)
- [Use Azure IoT with Azure Sphere](https://learn.microsoft.com/azure-sphere/app-development/use-azure-iot?view=azure-sphere-integrated)
- [What is Azure IoT Hub?](https://learn.microsoft.com/azure/iot-hub/iot-concepts-and-iot-hub)
- [What is Device Update for IoT Hub?](https://learn.microsoft.com/azure/iot-hub-device-update/understand-device-update)
- [Azure Monitor overview](https://learn.microsoft.com/azure/azure-monitor/overview)
