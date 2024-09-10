Reprovisioning devices between IoT hubs is common during the lifecycle of an IoT solution. Scenarios that drive reprovisioning include the following:

* Geolocation / GeoLatency: As a device moves between locations, network latency is improved by having the device migrated to a closer IoT hub.
* Multi-tenancy: A device might be used within the same IoT solution and reassigned to a new customer or customer site. This new customer might be serviced using a different IoT hub.
* Solution change: A device could be moved into a new or updated IoT solution. This reassignment might require the device to communicate with a new IoT hub that's connected to other back-end components.
* Quarantine: A device that's malfunctioning, compromised, or out-of-date might be reassigned to an IoT hub that can only update and get back in compliance. Once the device is functioning properly, it's migrated back to its main hub.

Reprovisioning support within the Device Provisioning Service addresses these needs. Devices can be automatically reassigned to new IoT hubs based on the reprovisioning policy on the device's enrollment entry.

## Device state data

Device state data includes the device twin and device capabilities. This data is stored in the Device Provisioning Service instance and the IoT hub that a device is assigned to.

When you create an enrollment in DPS, you can provide the initial device state data. The device state data is passed to the assigned IoT hub once a device connects to DPS and is registered to its IoT hub. At the time of initial registration, both DPS and the assigned IoT hub have the same device state data. We'll call that *v1*.

:::image type="content" source="../media/reprovisioning-state-1.svg" alt-text="Diagram that shows device state data stored by the Device Provisioning Service instance and the IoT hub that a device is assigned to.":::

Over time, the device state data on the IoT hub might be updated by device operations and back-end operations. Now IoT hub has a new version of the device state data, *v2*. The initial device state information stored in the Device Provisioning Service instance, v1, stays untouched. This untouched device state data is the initial configuration.

:::image type="content" source="../media/reprovisioning-state-2.svg" alt-text="Diagram that shows the device state data being updated on the IoT hub and the initial configuration being retained by DPS.":::

Throughout the lifecycle of a device, it might be reprovisioned to new hubs. When that happens, you can choose to migrate device state updated on the previous IoT hub over to the new IoT hub, or you can restore the device to its initial configuration. This behavior is determined by the reprovisioning policies in the Device Provisioning Service.

## Reprovisioning policies

There are several reasons why an already provisioned device would make a provisioning request, a scenario that we call *reprovisioning*. Usually reprovisioning happens whenever the device reboots, or you can manually trigger reprovisioning on demand. In either case, the reprovisioning policy on an enrollment entry determines how the device provisioning service instance handles these provisioning requests. The policy also determines whether device state data should be migrated during reprovisioning. The same policies are available for individual enrollments and enrollment groups:

* **Reprovision and migrate data**: The default policy for new enrollment entries. If the device is assigned to its current IoT hub, no action is taken. If the device is reassigned to a different IoT hub during a reprovisioning request, DPS removes the device registration from the current IoT hub. The updated device state information (v2) from the current IoT hub is migrated to the new IoT hub without changing the initial device state (v1) maintained by DPS.

  :::image type="content" source="../media/reprovisioning-state-3.svg" alt-text="Diagram that shows the device state during a reprovisioning process when device state data is migrated to the new IoT hub.":::

* **Reprovision and reset to initial config**: Regardless of whether the device is assigned to its current IoT hub or reassigned to another, the device registration with the initial IoT hub is removed. The initial configuration data that the provisioning service instance received when the device was provisioned is provided to the current or new IoT hub.

  This policy can be used for a factory reset without changing IoT hubs.

  :::image type="content" source="../media/reprovisioning-state-4.svg" alt-text="Diagram that shows the device state during a reprovisioning process when device state data is reset to the initial configuration.":::

* **Never reprovision**: The device is never reassigned to a different hub. This policy is provided for managing backwards compatibility.

### Managing backwards compatibility

Before September 2018, device assignments to IoT hubs had a sticky behavior. When a device went back through the provisioning process, it would only be assigned back to the same IoT hub.

For solutions that have taken a dependency on this behavior, the provisioning service includes backwards compatibility. This behavior is presently maintained for devices that meet the following criteria:

* The devices connect with an API version before the availability of native reprovisioning support in the Device Provisioning Service. Refer to the API table below.
* The enrollment entry for the devices doesn't have a reprovisioning policy set on them.

This compatibility makes sure that previously deployed devices experience the same behavior that's present during initial testing. To preserve the previous behavior, don't save a reprovisioning policy to these enrollments. If a reprovisioning policy is set, the reprovisioning policy takes precedence over the behavior. By allowing the reprovisioning policy to take precedence, customers can update device behavior without having to reimage the device.

The following flow chart helps to show when the behavior is present:

:::image type="content" source="../media/reprovisioning-compatibility-flow.svg" alt-text="Diagram that shows backwards compatibility for solutions that rely on old provisioning service behavior.":::
