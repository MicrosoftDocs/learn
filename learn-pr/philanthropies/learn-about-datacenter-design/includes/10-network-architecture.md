Learning about network architecture in a datacenter is crucial for understanding how data flows, is managed, and is secured within modern infrastructure.

The three layers of datacenter network architecture:  

| Layer | What it is | Impact on design | Performance | Redundancy and high availability | Scalability | Security |
| - | - | - | - | - | - | - |
| **Access Layer** | The access layer is the entry point for devices, servers, and end-user systems into the datacenter network. It connects the devices (like servers and storage) to the network infrastructure. | • The access layer must support high-density connectivity with minimal latency and high throughput.<br>• Network switches at this layer often have port redundancy to avoid single points of failure and ensure network reliability.<br>• The design must accommodate high-performance servers, which may require multiple connections for load balancing and fault tolerance. | Must support high-throughput and low-latency connections to servers and devices. | Implementing dual-homed servers (multiple network connections to access switches) is common to ensure uptime if one connection fails. | Network connections must be easily scalable to handle increasing numbers of devices. | Typically involves VLANs (Virtual Local Area Networks) to segment traffic and limit access to critical resources. |
| **Aggregation Layer** | The aggregation layer consolidates traffic from the access layer and routes it to the core layer. It also provides advanced services like firewalling, load balancing, and traffic filtering. | • It serves as a point of control for managing data flows between the access and core layers.<br>• Traffic optimization and redundancy are critical considerations to ensure high performance and availability. Network engineers often design this layer with the capability to scale efficiently.<br>• The aggregation layer might include firewalls and intrusion prevention systems to protect sensitive data. | Aggregates traffic efficiently without creating bottlenecks, often incorporating load balancing or traffic shaping. | Must be designed with multiple paths to route traffic in case of a failure, ensuring that the datacenter remains operational. | Needs to support adding more access switches and services (like firewalls, load balancing) as more devices and traffic are added. | Firewalls, Intrusion Detection/Prevention Systems (IDS/IPS), and other security appliances are placed here to protect data as it moves through the network. |
| **Core Layer** | The core layer is responsible for high-speed, low-latency switching between different parts of the datacenter network or between the datacenter and external networks. It connects the aggregation layer to the outside world. | • The core layer should be highly redundant to ensure continuous operation, often using dual-homed connections to avoid single points of failure.<br>• High-capacity backbone switches are deployed to support the massive volume of data transfer and ensure that the network can handle large amounts of traffic without bottlenecks.<br>• Low latency and high bandwidth are key requirements to support real-time data processing, especially for applications like cloud computing, video streaming, or gaming. | Should support extremely high bandwidth and low latency to avoid congestion and provide a high-speed backbone for data transfer across the entire network. | Core switches are often deployed in pairs to ensure network continuity even during hardware failures. | Should be able to scale to accommodate increased bandwidth demand with minimal impact on performance. Often achieved through modular switches that can be upgraded over time. | Firewalls and traffic encryption help secure data as it exits or enters the datacenter and to prevent attacks targeting external connections. |

## Basic network design principles

- Network Topology: Datacenter networks are organized using structures like leaf-spine or three-tier architectures, connecting switches, routers, and servers for performance, scalability, and reliability.
- Redundancy & High Availability: Backup network paths and failover systems minimize downtime during failures.  
- Scalability: Networks grow to handle increasing data traffic without losing performance.

## Core network components

- Switches & Routers: Core, aggregation, and edge switches connect servers and external networks, efficiently routing traffic.  
- Load Balancers: Spread network traffic across multiple servers for better performance and uptime.

## Virtualization & software-defined networking (SDN)

- Virtualized Networks: Virtualization separates network functions from physical hardware, making networks more flexible and scalable.  
- SDN: Software-defined networking uses software to manage and automate networks for faster changes and better control.

## Security considerations

- Network Segmentation: Divides networks into zones (e.g., internal, public) to isolate traffic and protect sensitive data.
- Firewalls & Intrusion Systems: Block unauthorized access and detect cyber threats.  
- Encryption: Keeps data secure during transmission.

## Cloud connectivity

- Hybrid/Multi-cloud: Datacenters connect to multiple cloud services to expand resources seamlessly.  
- Direct Connect: Dedicated, fast connections (e.g., AWS Direct Connect) reduce latency for critical applications.  

## Performance & monitoring

- Quality of Service (QoS): Prioritizes important traffic like video calls to maintain speed and reliability.  
- Network Monitoring: Tracks performance and spots problems early with tools like SNMP and netflow.

## Power & cooling integration

- Energy Efficiency: Efficient switches reduce power use in large datacenters.  
- Thermal Management: Proper cooling keeps equipment stable in high-density environments.
