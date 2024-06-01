All networks are built on the same principles. You can apply these principles to design and build your organization's local or cloud-based networks. When you build a network, you need to know about the different types of networks, their topologies, and their uses.

In this unit, you explore some of the common types of network topologies that are used to create internet-based networks.

## What is a network?

A network is a collection of network-enabled devices, typically made up of computers, switches, routers, printers, and servers. Networks are a fundamental part of day-to-day life, and exist in homes, workplaces, and public areas. Networks allow all types of network-enabled devices to communicate.

## Network types

Networks vary in size, shape, and usage. To make it easier to identify different network types, they're categorized into one of the following network categories:

- Personal area networks
- Local area networks
- Metropolitan area networks
- Wide area networks

### What is a personal area network?

A personal area network (PAN) provides networking needs around an individual. An example of a PAN is where a smartphone, smartwatch, tablet, and laptop all connect and share data without the need to connect to an access point or other third-party network services. PAN networks typically use Bluetooth to communicate because it provides a low-power, short-range data-sharing capability. The network standards associated with a PAN are Bluetooth and IEEE 802.15.

### What is a local area network?

A local area network (LAN) provides networking needs around a single location. This location might be an organization's office, a school, a university, a hospital, an airport, and many others. Typically, a LAN is privately owned and needs authentication and authorization to access. Of the different classifications of a network, a LAN is by far the most commonly used.

### What is a metropolitan area network?

:::image type="content" source="../media/2-man-diagram.svg" alt-text="Diagram of a metropolitan area network.":::

A metropolitan area network (MAN) provides networking capabilities between two different locations within a city or metropolitan area to provide a single extensive network. Typically, a MAN requires a dedicated and secure connection between each LAN joined to the MAN.

### What is a wide area network?

A wide area network (WAN) provides networking capabilities between two different geographical locations locally or worldwide. For example, a WAN is used to connect an organization's head office with branch offices all over the region. A WAN links multiple LANs together to create one super network. With a WAN, you use a virtual private network (VPN) to manage the connection between different LANs.

### Differences between LAN and WAN networks

Several aspects set a LAN apart from a WAN. Knowing these items makes it easier to plan the services to deploy across these networks.

| LAN | WAN |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| A LAN is a privately operated network typically contained in a single building. | A WAN is used to connect geographically separate offices to each other. Multiple organizations might operate WANs. |
| A LAN operates at speeds of 10 Gbps or higher. | A WAN typically operates at speeds of less than 1 Gbps. |
| A LAN is less congested compared to other network types. | A WAN is more congested compared to other network types. |
| A LAN can be managed and administrated in-house. | A WAN typically requires the use of a third party to configure and set up, which increases cost. |

## Network topologies

A network topology describes the physical composition of a network. Let's look at four topologies from which you can choose when you design a LAN. They are:

- Bus
- Ring
- Mesh
- Star

### Bus topology

:::image type="content" source="../media/2-bus-network.svg" alt-text="A diagram of a bus topology showing five nodes connected to a single network segment.":::

In a bus topology, each network device is connected to a single network cable. Even though it's the simplest type of network to implement, it has limitations. The first limitation is the length of the main cable or bus. The longer it gets, the higher the chance of signal dropout. This limitation constrains the physical layout of the network. All devices have to be physically located near each other; for example, in the same room. Finally, if there's a break in the bus cable, the whole network fails.

### Ring topology

:::image type="content" source="../media/2-ring-network.svg" alt-text="A diagram of a ring topology showing nodes connected in a ring.":::

In a ring topology, each network device is connected to its neighbor to form a ring. This form of network is more resilient than the bus topology. A break in the cable ring also affects the performance of the network.

### Mesh topology

:::image type="content" source="../media/2-mesh-network.svg" alt-text="A diagram of a mesh topology where all nodes are connected to all other nodes.":::

The mesh topology is described as either a physical mesh or a logical mesh.

In a physical mesh, each network device connects to every other network device in the network. It dramatically increases the resilience of a network, but has the physical overhead of connecting all devices. Few networks today are built as a full mesh. Most networks use a partial mesh, where some machines interconnect, but others connect through one device.

There's a subtle difference between a physical mesh network and a logical one. The perception is that most modern networks are mesh based, since each device can see and communicate with any other device on the network. However, this topology describes a logical mesh network, and is primarily made possible by using network protocols.

### Star topology

:::image type="content" source="../media/2-star-network.svg" alt-text="A diagram of a star topology with a single node connected to all other nodes.":::

The star topology is the most commonly used network topology. Each network device connects to a centralized hub or switch. Switches and hubs can be linked together to extend and build more extensive networks. This type of typology is, by far, the most robust and scalable.

## Ethernet

Ethernet is a networking standard that's synonymous with wire-based LAN networks, and also used in MAN and WAN networks. Ethernet has replaced other wired LAN technologies like ARCNET and Token Ring, and is an industry standard.

While Ethernet is associated with wired networks, keep in mind that it's not limited to wire, because it's used over fiber-optic links as well.

The Ethernet standard defines a framework for data transmission, error handling, and performance thresholds. It describes the rules for configuring an Ethernet network and how each element in the network interacts with each other.

Ethernet is used in the OSI model at the data link and physical layers. It formed the basis for the IEEE 802.3 Standard. This standard helped to unify network and hardware development.

Ethernet is a continually evolving standard, and the original version supported a data transmission rate of only 2.94 Mbps. In recent years, several iterations were released to keep up with the demands for increased speed. Today, rates extend up to 400 Gbps.

### Fast Ethernet

Fast Ethernet (IEEE 802.3u) was developed to support data transmission speeds of up to 100 Mbps. Faster Ethernet is also referred to as the 100BASE-TX standard.

### Gigabit Ethernet

Gigabit Ethernet (IEEE 802.3ab) was developed to support faster communication networks that can support services like streaming multimedia and Voice over IP (VoIP). The 1000BASE-T standard runs 10 times faster than the 100BASE-TX standard. Gigabit Ethernet is now included in the 802.3 standards, and recommended for enterprise networks. The new standard is backward compatible with the 100BASE-T and the older 10BASE-T standards.

### 10 Gigabit Ethernet

The 10 Gigabit Ethernet (IEEE 802.3ae) standard has a nominal data transfer speed of 10 Gbps, which is 10 times faster than its predecessor. This speed improvement is made possible only by using fiber optics. The standard now requires that 10-Gigabit Ethernet networks use area-based routing rather than broadcasting data to all nodes. In that way, network noise and traffic are reduced.

### Terabit Ethernet

Terabit Ethernet offers data transfer speeds of 200 Gbps and 400 Gbps. It's expected that Terabit Ethernet will offer speeds of 800 Gbps and 1.6 Tbps in the future.

## Networks in Azure

Azure comes with several networking tools and services.

### Azure Virtual Network

:::image type="content" source="../media/2-virtual-network.svg" alt-text="A diagram showing a virtual network design with a web server and a SQL server assigned IP addresses from a virtual network range to isolate the servers.":::

Using Azure Virtual Network, you can build complex virtual networks that emulate the structure of your actual on-premises networks. You can provision and manage your cloud-based virtual networks. You also can create hybrid virtual networks that integrate with your on-premises networks when you use Azure Virtual Network.

### Connectivity services

When you need to have a low-latency, high-bandwidth connection between your on-premises network and your instance of Azure Virtual Network, you have two options. You can use a VPN connection via an Azure gateway, or you can use a dedicated connection through Azure ExpressRoute. ExpressRoute is a secure point-to-point service. To use this service, you use a third-party connectivity partner to provide and host the ExpressRoute circuits on your behalf.
