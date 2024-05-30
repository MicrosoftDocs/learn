In the last unit, you examined your network diagram to note all the devices you want to monitor in your car manufacturer organization. You're preparing your OT site and determining what devices and subnets to monitor. This unit explores what devices and subnet information to collect and how to determine interesting traffic to determine the sensors to onboard.

Monitor and mirror traffic to Defender for IoT that's most interesting to you from a security or operational perspective. Examine your OT network diagram with your site engineering, network, and operational teams to define where to find the most relevant traffic for monitoring across network devices and subnets.

## Gather device information

Devices can be divided into:

- **Endpoint devices** - A wide range of devices physically connected to a network, like servers, computers, IoT devices, and more.
- **Network devices** - Hardware components that serve the infrastructure with networking services, including network switches, firewalls, routers, and access points.

For each device you'd like to monitor, gather the following information:

| Specification| Description |
|---------|---------|
| **Vendor**| The device manufacturing vendor |
| **Device name**| A meaningful name for ongoing use and reference |
| **Type**| The device type, such as: *Switch*, *Router*, *Firewall*, or *Access Point*. |
| **Network layer**| The L2 or L3 devices to monitor. L2 devices are within the IP segment and L3 devices are devices outside of the IP segment and might also support L2. |
| **Crossing VLANs**| The IDs of any VLANs that cross the device. |
| **Gateway**| The VLANs that the device acts as a default gateway for. |
| **Network details**| The device's IP address, subnet, D-GW, and DNS host. |
| **Protocols**| Protocols used on the device. Compare your protocols against those protocols supported by Defender for IoT out-of-the-box. |
| **Supported traffic mirroring**| The traffic mirroring methods supported by the device, like SPAN, RSPAN, ERSPAN, or TAP. </br> Use this information to choose traffic mirroring methods for your OT sensors. |
| **Managed by partner services?** | Whether a partner service, such as Siemens, Rockwell, or Emerson, manages the device and the management policy, if relevant. |
| **Serial connections** |The serial communication protocol used, if relevant.|

## Calculate the number of network devices you want to monitor

Calculate the number of devices in each site to determine the right number of Defender for IoT licenses you need. Exclude devices that aren't counted as individual devices for Defender for IoT, like:

- Public internet IP addresses
- Multi-cast groups
- Broadcast groups
- Devices that are inactive for more than 60 days

## Plan for multi-sensor deployment

For a Defender for IoT deployment with multiple sensors, also consider the following points when planning your sensors:

- **Physically (ethernet) connected switches**:  Plan for at least one sensor for every 80 meters of distance between switches.

- **Multiple networks without physical connectivity**: Plan at least one sensor for each individual network.

- **Switches with RSPAN traffic mirroring support**: Plan at least one sensor for every eight switches, with a local SPAN port. Plan to place the sensor close enough to the switches so that you can connect them by cable.

## Create a list of subnets

Using your list of devices to monitor, create an aggregated list of subnets that you want to monitor. Use the subnet list, once you've deployed, to verify whether all the listed subnets are detected correctly.

## Identify interesting traffic points

Usually, the interesting traffic points to monitor, security-wise, are the interfaces that connect between the default gateway entity to the core or distribution switch. Monitoring there ensures that traffic traveling from inside to outside the IP segment is monitored. Consider possible **missing traffic** that is supposed to leave the segment but ends up remaining inside the segment.

Consider the following traffic points in your network:

- **Unique traffic types inside a segment** particularly:

  - **Broadcast / Multicast traffic**: Traffic sent to any entity within the subnet. Broadcast and multicast traffic is typically sent to all entities in the local IP subnet, including the default gateway entity, and is therefore also covered and monitored.
  
  - **Unicast traffic:** Traffic forwarded directly to the destination, without crossing the entire subnet endpoints, including the default gateway. Unicast traffic can be monitored by placing sensors directly on the access switches.

- **Directional traffic streams:** Some vendors and products allow a traffic stream direction, which can cause a data gap. Monitor both traffic directions to get network conversation information about your subnets and better accuracy.

- **A subnet's default gateway:** For each interesting subnet, a connection to the entity that acts as the network subnet default gateway is the interesting point.  Sometimes there's subnet traffic unmonitored by the regular interesting point. Monitoring this otherwise unmonitored type of traffic is useful, especially on sensitive subnets.

- **Atypical traffic:** Monitoring otherwise unmonitored traffic might require extra streaming points and network solutions, such as RSPAN or network tappers.

## List your planned OT sensors

With the information about what traffic you want to monitor with Defender for IoT from your devices and subnets, make a list of all the OT sensors to onboard.

For each sensor include:

- For any cloud-connected sensors, the cloud connection method
- Assigned sensor site and zone

Recall that your car manufacturing organization has offices and production sites across the globe.  The following table shows a sample OT sensor deployment plan for your car manufacturing site, with offices in Paris, Lagos, Dubai, and Tianjin.

|Site | Zones | Sensor name | Cloud connected |
|--- | ---|---|--- |
|**Paris office** |- Ground floor (Guests)<br> - Floor 1 (Sales) <br> - Floor 2 (Executive)|paris-guests<br>paris-sales<br>paris-exec | Yes<br>Yes<br>Yes |
|**Lagos office** |- Ground floor (Guests)<br> - Floor 1 (Sales)  |lagos-offices<br>lagos-factory |Yes <br>No |
|**Dubai office** |- Ground floor (Convention center)<br> - Floor 1 (Sales) <br> - Floor 2 (Offices)|dubai-guests<br>dubai-sales<br>dubai-exec| Yes<br>Yes<br>Yes|
|**Tianjin office** |- Ground floor (Offices)<br> - Floors 1-2 (Factory)| tianjin-office <br>tianjin-factory | Yes <br>No |

In this unit you've learned how to identify the devices and subnets and their interesting traffic to monitor, and created an OT sensor deployment list for your car manufacturer. In the next unit, you'll learn how to determine the traffic mirroring methods to use for your site.
  
## Knowledge check

:::image type="complex" source="../media/4-sample-network-diagram-knowledge-check.png" alt-text="Diagram of a sample network diagram." border="false":::

Figure 1 shows a sample diagram of a network in a building of three floors, where each floor houses both endpoints and switches. The third floor also houses firewalls, core switches, a server, and routers. A blue dotted line depicts traffic traveling outside of the IP segment, traveling throughout floor one and two and up to a server connected to a core server on floor 3. Interesting traffic is depicted in red from two switches on floor two to each of the firewalls on floor three. In addition, there's a Defender for IoT sensor with the question where should the Defender for IoT sensor be connected and three choices: A- to the switch for interesting traffic between on floor two, B- to the switch where traffic is traveling outside of the IP segment on level two, or C- to the switch for traffic is traveling outside of the IP segment on level one.
:::image-end:::
