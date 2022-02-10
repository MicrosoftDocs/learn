There is a set of general device management stages that are common to all enterprise IoT projects. For Azure IoT, there are five stages within the device lifecycle:

:::image type="content" source="../media/m02-l01-device-lifecycle-diagram-97febb41.png" alt-text="Diagram that shows the five lifecycle stages for an IoT device.":::


Each of the five stages includes goals and activities:

 -  Plan: Enable operators to create a device metadata scheme that enables them to easily and accurately query for, and target a group of devices for bulk management operations. You can use the device twin to store this device metadata in the form of tags and properties.
 -  Provision: Securely provision new devices to IoT Hub and enable operators to immediately discover device capabilities. Use the IoT Hub identity registry to create flexible device identities and credentials, and perform this operation in bulk by using a job. Build devices to report their capabilities and conditions through device properties in the device twin.
 -  Configure: Facilitate bulk configuration changes and firmware updates to devices while maintaining both health and security. Perform these device management operations in bulk by using desired properties or with direct methods and broadcast jobs.
 -  Monitor: Monitor overall device collection health, the status of ongoing operations, and alert operators to issues that might require their attention. Apply the device twin to allow devices to report real-time operating conditions and status of update operations. Build powerful dashboard reports that surface the most immediate issues by using device twin queries.
 -  Retire: Replace or decommission devices after a failure, upgrade cycle, or at the end of the service lifetime. Use the device twin to maintain device info if the physical device is being replaced, or archived if being retired. Use the IoT Hub identity registry for securely revoking device identities and credentials.
