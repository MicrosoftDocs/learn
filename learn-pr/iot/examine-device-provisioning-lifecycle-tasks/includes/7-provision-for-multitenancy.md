The allocation policies defined by the provisioning service support various allocation scenarios. Two common scenarios are:

* Geolocation / GeoLatency: As a device moves between locations, network latency is improved by having the device provisioned to the Azure IoT hub closest to each location. In this scenario, a group of Azure IoT hubs, which span across regions, are selected for enrollments. The Lowest latency allocation policy is selected for these enrollments. This policy causes the Device Provisioning Service to evaluate device latency and determine the closet Azure IoT hub out of the group of Azure IoT hubs.
* Multi-tenancy: Devices used within an IoT solution may need to be assigned to a specific Azure IoT hub or group of Azure IoT hubs. The solution may require all devices for a particular tenant to communicate with a specific group of Azure IoT hubs. In some cases, a tenant may own Azure IoT hubs and require devices to be assigned to their Azure IoT hubs.

It's common to combine these two scenarios. For example, a multitenant IoT solution commonly assigns tenant devices using a group of Azure IoT hubs that are scattered across regions. These tenant devices can be assigned to the Azure IoT hub in that group that has the lowest latency based on geographic location.

Provisioning devices for the multitenant scenario across regions, as described in the previous paragraph, involves the following:

* Two (or more) regional Azure IoT hubs.
* An enrollment group that uses a multitenant enrollment and specifies assigning devices based on lowest latency.
* Multiple devices provisioned in each region.

With this configuration in place, devices in each region are provisioned to the same tenant in the closest region.

For instructions that describe how to configure and test this multitenancy scenario, see: [Tutorial: Provision for geo latency](/azure/iot-dps/how-to-provision-multitenant).
