Cross-cutting needs (or cross-cutting concerns) are aspects of the solution that affect the other subsystem within a solution and which cannot be separated from these subsystems.

There are multiple cross-cutting needs for IoT solutions that are critical for success, including:

 -  Security requirements; including user management and auditing, device connectivity, in-transit telemetry, and at rest security.
 -  Logging and monitoring for an IoT cloud application is critical for determining health and for troubleshooting failures both for individual subsystems and the application as a whole.
 -  High availability and disaster recovery, which is used to rapidly recover from systemic failures.

:::image type="content" source="../media/m01-l02-cross-cutting-needs-subsystems-7d98fb39.png" alt-text="Diagram that shows the Azure IoT Architecture cross-cutting concerns and subsystems.":::


**Security**: Security is a critical consideration in each of the subsystems. Protecting IoT solutions requires secure provisioning of devices, secure connectivity between devices, edge devices, and the cloud, secure access to the backend solutions, and secure data protection in the cloud during processing and storage (encryption at rest).

**Logging and monitoring**: Logging actions and monitoring activity associated with your IoT solution is critical for determining system uptime and troubleshooting failures.

**High availability and disaster recovery**: High availability and disaster recovery (HA/DR) focuses on ensuring an IoT system is always available, including from failures resulting from disasters. The technology used in IoT subsystems has different failover and cross-region support characteristics. For IoT applications, this can result in requiring hosting of duplicate services and duplicating application data across regions depending on acceptable failover downtime and data loss.
