Your network diagram allows you to determine the devices and subnets to monitor based on your overall monitoring goals for your automotive manufacturing organization.

Using the diagram you can determine:

- The network segments you should monitor (subnets/VLANs)
- Where to connect
- What devices there are and how they communicate
- The security and operational risks and the most interesting traffic for those risks

## Create a network diagram

Use the following questions to help you prepare your network map diagram that lists all the devices in your network.

### General questions

- What are your overall monitoring goals?
- Do you have any redundant networks? Can you disregard any areas of your network for monitoring?
- Where are your network security and operational risks?

### Network questions

- Which protocols are active on monitored networks?
- Are VLANs configured in the network design?
- Is there any routing in the monitored networks?
- Is there any serial communication in the network?
- Where are firewalls installed in the networks you want to monitor?
- Is there traffic between an industrial control (ICS) network and an enterprise, business network? If so, is this traffic monitored?
- What's the physical distance between your switches and the enterprise firewall?
- Is OT system maintenance done with fixed or transient devices?

### Switch questions

- Can you monitor the traffic from an unmanaged switch from a higher-level switch?
- Can unmanaged switches be replaced with managed switches, or is the use of network TAPs an option?
- Can you monitor the switch's VLAN, or is the VLAN visible in another switch that you can monitor?
- If you connect a network sensor to the switch, will it mirror the communication between the HMI and PLCs?
- If you want to connect a network sensor to the switch, is there physical rack space available in the switch's cabinet?
- What's the cost/benefit of monitoring each switch?

## Identify devices and subnets to monitor

You'll want to monitor and mirror traffic to Defender for IoT that's most interesting to you from a security or operational perspective. Examine your OT network diagram with your site engineers, network, and operational teams to define where you'll find the most relevant traffic for monitoring.

<!-- can site engineers and network and operational teams be combined?-->
## Devices

Devices can be divided into:

- **Endpoint devices** - A wide range of devices physically connected to a network, like servers, computers, IoT (internet of things) devices, and more.
- **Network devices**- Hardware components that serve the infrastructure with networking services, including network switches, firewalls, routers, and access points.

For each device you'd like to monitor, gather the following information:

| Specification| Description |
|---------|---------|
| **Vendor**| The device manufacturing vendor |
| **Device name**| A meaningful name for ongoing use and reference |
| **Type**| The device type, such as: *Switch*, *Router*, *Firewall*, or *Access Point*. |
| **Network layer**| The L2 or L3 devices you'll want to monitor. L2 devices are within the IP segment and L3 devices are devices outside of the IP segment and might also support L2. |
| **Crossing VLANs**| The IDs of any VLANs that cross the device. |
| **Gateway**| The VLANs that the device acts as a default gateway for. |
| **Network details**| The device's IP address, subnet, D-GW, and DNS host. |
| **Protocols**| Protocols used on the device. Compare your protocols against those supported by Defender for IoT out-of-the-box. |
| **Supported traffic mirroring**| The traffic mirroring methods supported by the device, like SPAN, RSPAN, ERSPAN, or TAP. </br> You'll use this to choose traffic mirroring methods for your OT sensors. |
| **Managed by partner services?** | Whether a partner service, such as Siemens, Rockwell, or Emerson, manages the device and the management policy, if relevant. |
| **Serial connections** |The serial communication protocol used, if relevant.|

## Calculate network devices

Calculate the number of devices in each site to determine the right number of Defender for IoT licenses. Exclude devices that aren't individual devices for Defender for IoT like:

- Public internet IP addresses
- Multi-cast groups
- Broadcast groups
- Devices that are inactive for more than 60 days

## Multi-sensor deployment

For multiple network sensor deployments plan the following for:

- **Physically (ethernet) connected switches**: At least one sensor for every 80 meters of distance between switches.

- **Multiple networks without physical connectivity**: At least one sensor for each individual network.

- **Switches with RSPAN traffic mirroring support**: At least one sensor for every eight switches, with a local SPAN port. Plan to place the sensor close enough to the switches so that you can connect them by cable.

## Create a list of subnets

Using your list of devices to monitor, create an aggregated list of subnets that you want to monitor. Use the subnet list, once you've deployed, to verify whether all the listed subnets are detected automatically.

## Identifying interesting traffic points

Usually the interesting traffic points to monitor, security-wise, are the interfaces that connect between the default gateway entity to the core or distribution switch. Monitoring there ensures that traffic traveling from inside the IP segment to outside the IP segment is monitored. Consider possible **missing traffic** that is supposed to leave the segment, but ends up remaining inside the segment.

Consider the following traffic points in your network:

- **Unique traffic types inside a segment** particularly:
    - **Broadcast / Multicast traffic**: Traffic sent to any entity within the subnet. Broadcast and multicast traffic is typically sent to all entities in the local IP subnet, including the default gateway entity, and is therefore also covered and monitored. 
    - **Unicast traffic:** Traffic forwarded directly to the destination, without crossing the entire subnet endpoints, including the default gateway. Unicast traffic can be monitored by placing sensors directly on the access switches.       |
- **Directional traffic streams:** Some vendors and products allow a traffic stream direction, which can cause a data gap. Monitor both traffic directions to get network conversation information about your subnets and better accuracy.|
- **A subnet's default gateway:** For each interesting subnet, a connection to the entity that acts as the network subnet default gateway is the interesting point.  Sometimes there's subnet traffic unmonitored by the regular interesting point. Monitoring this otherwise unmonitored type of traffic is useful, especially on sensitive subnets.
- **Atypical traffic:**   To monitor otherwise unmonitored traffic might require extra streaming points and network solutions, such as RSPAN or network tappers.

## List  your planned OT sensors

With the information about what traffic you want to monitor to Defender for IoT from your devices and subnets, make a list of all the OT sensors to onboard.

For each sensor include:

- Cloud connection method
- Whether appliances are physical or virtual
- Assigned sensor site and zone
- Traffic mirroring method

## Purdue Model

The Purdue Reference Model for Industrial Control System (ICS)/OT network segmentation divides a network into different OT and IT and layers to better isolate IT and OT systems and enhance OT system protection. Levels one through three are OT levels and four and five are IT levels. The levels are as follows:

| Name | Description |
|---------|---------|
|**Level 0**: </br>Cell and area| The wide variety of sensors, actuators, and devices involved in the basic manufacturing process. These devices perform the basic functions of the industrial automation and control system, like driving a motor or key functions like welding and bending.|
|**Level 1:** </br>Process control| Embedded controllers that communicate with Level 0 devices and control and manipulate the manufacturing process. In discrete manufacturing, those devices are programmable logic controllers (PLCs) or remote telemetry units (RTUs). In process manufacturing, the basic controller is called a distributed control system (DCS).|
| **Level 2:** </br>Supervisory|The systems and functions connected to the runtime supervision and operation of an area of a production facility that communicates with the Level 1 controllers, and sometimes with the site or enterprise (Level 4 and 5). The systems and functions can include human-machine interfaces (HMIs), alerting systems, and control room workstations, among other systems.|
| **Levels 3 and 3.5:** </br>Site-level and industrial perimeter network| Manages the site-wide industrial automation and control functions like production scheduling, site level operations management, file server, and Active Directory. These systems communicate with the production zone and share data with Level 4 and 5 systems and applications. Levels through level 3 are considered critical to site operations. |
| **Levels 4 and 5:** </br>Business and enterprise networks|The site or enterprise network where the centralized IT systems and functions exist. The IT organization manages them directly at these levels.|
<!--Level 3.5, should that be added?-->
Generally sensors are placed between levels two and three or between three and 3.5, if it's an industrial demilitarized zone (DMZ). <!-- is this 0 to 3 or 2, 3 and 3,3.5 as vashaka-->

### Network Diagram

The following diagram depicts how devices might be divided into the different OT and IT levels:

:::image type="content" source="../media/2-purdue-only.png" alt-text="Purdue model diagram" border="false":::

## Knowledge check

:::image type="complex" source="../media/2-sample-network-diagram-knowledge-check.png" alt-text="Diagram of a sample network diagram" border="false":::

Figure A shows a sample diagram of a network in a building of three floors, where each floor houses endpoints and switches. The third floor also houses firewalls, core switches, a server, and routers. A blue dotted line depicts traffic traveling outside of the IP segment, traveling throughout floor 1 and 2 and up to a server connected to a core server on floor 3. Interesting traffic is depicted in red from two switches on floor 2 to each of the firewalls on floor 3. In addition, there's a Defender for IoT sensor with the question where should the Defender for IoT sensor be connected and three choices: A- to the switch for interesting traffic between on floor 2, B- to the switch where traffic is traveling outside of the IP segment on level 2, or C- to the switch for traffic is traveling outside of the IP segment on level 1. 
:::image-end:::

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<!-- Do not add a unit summary or references/links -->