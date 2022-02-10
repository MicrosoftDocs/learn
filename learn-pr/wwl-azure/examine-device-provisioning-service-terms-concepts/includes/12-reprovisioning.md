Reprovisioning devices between IoT hubs is common during the lifecycle of an IoT solution. Scenarios that drive reprovisioning include the following:

 -  Geolocation / GeoLatency: As a device moves between locations, network latency is improved by having the device migrated to a closer IoT hub.
 -  Multi-tenancy: A device may be used within the same IoT solution and reassigned to a new customer, or customer site. This new customer may be serviced using a different IoT hub.
 -  Solution change: A device could be moved into a new or updated IoT solution. This reassignment may require the device to communicate with a new IoT hub that's connected to other back-end components.
 -  Quarantine: Similar to a solution change. A device that's malfunctioning, compromised, or out-of-date may be reassigned to an IoT hub that can only update and get back in compliance. Once the device is functioning properly, it's then migrated back to its main hub.

Reprovisioning support within the Device Provisioning Service addresses these needs. Devices can be automatically reassigned to new IoT hubs based on the reprovisioning policy that's configured on the device's enrollment entry.

## Device state data

Device state data is composed of the device twin and device capabilities. This data is stored in the Device Provisioning Service instance and the IoT hub that a device is assigned to.

:::image type="content" source="../media/m03-l01-device-provisioning-service-reprovisioning-state-1-0f06266f.png" alt-text="Diagram that shows device state data stored by the Device Provisioning Service instance and the IoT hub that a device is assigned to.":::


When a device is initially provisioned with a Device Provisioning Service instance, the following steps are done:

1.  The device sends a provisioning request to a Device Provisioning Service instance. The service instance authenticates the device identity based on an enrollment entry, and creates the initial configuration of the device state data. The service instance assigns the device to an IoT hub based on the enrollment configuration and returns that IoT hub assignment to the device.
2.  The provisioning service instance gives a copy of any initial device state data to the assigned IoT hub. The device connects to the assigned IoT hub and begins operations.

Over time, the device state data on the IoT hub may be updated by device operations and back-end operations. The initial device state information stored in the Device Provisioning Service instance stays untouched. This untouched device state data is the initial configuration.

:::image type="content" source="../media/m03-l01-device-provisioning-service-reprovisioning-state-2-ccaf3d23.png" alt-text="Diagram that shows the device state data being updated on the IoT hub and the initial configuration being retained by DPS.":::


Depending on the scenario, as a device moves between IoT hubs, it may also be necessary to migrate device state updated on the previous IoT hub over to the new IoT hub. This migration is supported by reprovisioning policies in the Device Provisioning Service.

## Reprovisioning policies

Depending on the scenario, a device usually sends a request to a provisioning service instance on reboot. It also supports a method to manually trigger provisioning on demand. The reprovisioning policy on an enrollment entry determines how the device provisioning service instance handles these provisioning requests. The policy also determines whether device state data should be migrated during reprovisioning. The same policies are available for individual enrollments and enrollment groups:

 -  Reprovision and migrate data: This policy is the default for new enrollment entries. This policy takes action when devices associated with the enrollment entry submit a new request (1). Depending on the enrollment entry configuration, the device may be reassigned to another IoT hub. If the device is changing IoT hubs, the device registration with the initial IoT hub will be removed. The updated device state information from that initial IoT hub will be migrated over to the new IoT hub (2). During migration, the device's status will be reported as Assigning.

:::image type="content" source="../media/m03-l01-device-provisioning-service-reprovisioning-state-3-499f65e7.png" alt-text="Diagram that shows the device state during a reprovisioning process when device state data is migrated to the new IoT hub.":::


 -  Reprovision and reset to initial config: This policy takes action when devices associated with the enrollment entry submit a new provisioning request (1). Depending on the enrollment entry configuration, the device may be reassigned to another IoT hub. If the device is changing IoT hubs, the device registration with the initial IoT hub will be removed. The initial configuration data that the provisioning service instance received when the device was provisioned is provided to the new IoT hub (2). During migration, the device's status will be reported as Assigning.

This policy is often used for a factory reset without changing IoT hubs.

:::image type="content" source="../media/m03-l01-device-provisioning-service-reprovisioning-state-4-bb4ef6ea.png" alt-text="Diagram that shows the device state during a reprovisioning process when device state data is reset to the initial configuration.":::


 -  Never reprovision: The device is never reassigned to a different hub. This policy is provided for managing backwards compatibility.

### Managing backwards compatibility

Before September 2018, device assignments to IoT hubs had a sticky behavior. When a device went back through the provisioning process, it would only be assigned back to the same IoT hub.

For solutions that have taken a dependency on this behavior, the provisioning service includes backwards compatibility. This behavior is presently maintained for devices according to the following criteria:

1.  The devices connect with an API version before the availability of native reprovisioning support in the Device Provisioning Service. Refer to the API table below.
2.  The enrollment entry for the devices doesn't have a reprovisioning policy set on them.

This compatibility makes sure that previously deployed devices experience the same behavior that's present during initial testing. To preserve the previous behavior, don't save a reprovisioning policy to these enrollments. If a reprovisioning policy is set, the reprovisioning policy takes precedence over the behavior. By allowing the reprovisioning policy to take precedence, customers can update device behavior without having to reimage the device.

The following flow chart helps to show when the behavior is present:

:::image type="content" source="../media/m03-l01-device-provisioning-service-reprovisioning-compatibility-flow-b979c95a.png" alt-text="Diagram that shows backwards compatibility for solutions that rely on old provisioning service behavior.":::
