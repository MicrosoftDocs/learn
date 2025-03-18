In the previous unit, you identified the devices and subnets in your automotive manufacturing site to monitor. Now you determine the traffic mirroring methods to use for your site.

Traffic mirroring with Defender for IoT allows you to mirror network traffic to your sensors, where you can monitor and diagnose risks and threats in your network.

## Traffic mirroring methods

Determine what traffic mirroring methods to use based on your network configuration. Defender for IoT supports the following traffic mirroring methods:

|Method  |Description  |
|---------|---------|
|**Switch SPAN port**     |  Mirrors local traffic from interfaces on the switch to a different interface on the same switch.</br></br> |  
|**Remote SPAN (RSPAN) port**     |  Mirrors traffic from multiple, distributed source ports into a dedicated remote virtual local area network (VLAN). </br></br>The VLAN data is delivered through trunked ports, across multiple switches to a specified switch containing the physical destination port.</br></br>|
|**Active or passive aggregation (TAP)** |  Installs an active/passive aggregation terminal access point (TAP) inline to your network cable. The TAP duplicates *Receive* and *Transmit* traffic to the OT network sensor. </br></br>The TAP hardware device allows network traffic to flow between ports without interruption and without compromising network integrity. </br></br>The advantages of TAPs include that they're hardware based, pass all messages, including damaged ones, and aren't processor-sensitive. </br></br>TAPs are recommended for forensic monitoring. </br></br>|
|**Encapsulated remote switched port analyzer (ERSPAN)**  | Secures remote networks by  mirroring input interfaces over an IP network to your OT sensor's monitoring promiscuous interface. Traffic payloads are encapsulated by generic routing encapsulation (GRE) tunnel encapsulation and are analyzed by the sensor. </br></br>ERSPAN is good for when traffic needs to be routed across OSI Layer 3 networks. It can include sources like ethernet ports, VLANs, fabric port channels, and satellite ports.</br></br>|
|**ESXi vSwitch** |  Uses a virtual switch and *Promiscuous mode* as a workaround for configuring a monitoring port, since virtual switches don't have mirroring capabilities. </br></br>Any traffic that goes through the virtual switch is visible to other network interfaces in the same port group. </br></br>|
|**Hyper-V vSwitch** | Uses a virtual switch and *Promiscuous mode* as a workaround for configuring a monitoring port, since virtual switches don't have mirroring capabilities. </br></br>Any traffic that goes through the virtual switch is visible to other network interfaces in the same port group. </br></br>|

Choose your monitoring method based on considerations like your overall monitoring needs, network configuration, sensor connection, and available resources.

## Example scenarios

The following examples visual possible traffic mirroring methods that you might choose to use in your car manufacturing organization based on your network configuration:

### Remote VLAN architecture

In the following example of a Remote VLAN architecture, your source switches are configured with remote SPAN sessions, which distribute the data via intermediate switches to the destination switch. The destination switch monitors traffic from your OT network sensor with Defender for IoT:
<!-- should this be switch or port? -->
:::image type="content" source="../media/5-remote-span-vlan.jpg" alt-text="Diagram of a remote VLAN architecture." border="false":::

### Active or passive aggregation (TAP)

In the following example of a network TAP architecture the TAP is installed inline to the network cable and mirrors traffic to Defender for IoT:

:::image type="content" source="../media/5-active-passive-tap-v2.png" alt-text="Diagram of a network TAP." border="false":::

### ERSPAN architecture

In the following example of an ERSPAN architecture, the source router encapsulates traffic and sends the packet over the OSI layer 3 network to the destination router. Then decapsulates and sends it to the OT network sensor and on to Defender for IoT:

<!-- the packet or the payload?-->

:::image type="content" source="../media/5-erspan-architecture.png" alt-text="Diagram of an ERSPAN network." border="false":::

## Prevent undetected port connections

To prevent rogue devices from connecting undetected to an unmonitored port, configure traffic mirroring from all of your switch's ports. For OT networks that use broadcast or multicast messaging, configure traffic mirroring only for RX (*Receive*) transmissions to prevent unnecessary bandwidth use.

## Knowledge check
