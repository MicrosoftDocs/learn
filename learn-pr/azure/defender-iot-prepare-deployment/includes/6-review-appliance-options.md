In the previous unit, you determine the traffic mirroring methods to use for your site. Now prepare to choose the right appliances for your system and the hardware profiles that best fit your organization's network monitoring needs.

## Appliance types

The following appliance types are available to use with your Microsoft Defender for IoT OT sensors:

- Pre-configured physical appliances
- Virtual appliances
- Self-configured physical appliances

## Pre-configured physical appliances

Microsoft partnered with Arrow Electronics to provide pre-configured physical appliances validated for Defender for IoT OT system monitoring. The advantages of pre-configured appliances are:

- **Better performance** over the total assets monitored.
- **Compatibility** with new Defender for IoT releases, with validations for upgrades and driver support.
- **Stability** due to traffic monitoring and packet loss tests
- **In-lab experience** by training Microsoft support teams, who gain a working knowledge of the hardware.
- **Long term world-wide availability** of selected components.

 The following deployment configurations influence what processors, memory, network cards, and storage amounts you choose for your appliances:

- Raw network speed
- The size of the network to monitor
- Application configuration
- Data amount, type, and length of storage

### Pre-configured appliances for OT network sensors

The following table shows an example of supported hardware profiles and pre-configured appliances:

|Hardware profile |Appliance |SPAN/TAP throughput |Used for |
|---------|---------|---------|---------|
| **C5600** |HPE ProLiant DL360 |**Max bandwidth:** Up to 3 Gbps</br>**Max devices**: 12,000 16C[32T] CPU/32G RAM/5.6TB | Corporate environments |
| **E1800** |HPE ProLiant DL20 Gen10 Plus (4SFF) </br>Dell PowerEdge R350 |**Max bandwidth:** Up to 1 Gbps</br>**Max devices:** 10,000 4C[8T] CPU/32G RAM/1.8TB | Large enterprises |
| **E500** |Dell Edge 5200 (Rugged MIL-STD-810G) |**Max bandwidth:** Up to 1 Gbps</br> **Max devices:** 10,000 8C[8T] CPU/32G RAM/512GB | Large enterprises |
| **L500** |HPE ProLiant DL20 Gen10 Plus (NHP 2LFF) |**Max bandwidth:** Up to 200 Mbps</br>**Max devices:** 1,000 4C[8T] CPU/8G RAM/500GB | Production line |
| **L100** |YS-Techsystems YS-FIT2 (Rugged MIL-STD-810G) |**Max bandwidth:** Up to 10 Mbps</br>**Max devices:** 100 4C[4T] CPU/8G RAM/128GB | Production lines|

## Virtual appliances

You may want to use virtual appliances for your sensors, such as for simpler maintenance and reduced costs.

The *hypervisors* or virtual machine hosts supported by Defender for IoT to run guest operating systems are:

- **VMware ESXi** (version 5.0 and later)
- **Microsoft Hyper-V** (VM configuration version 8.0 and later)

Other hypervisor types aren't supported for production environments due to their lack of exclusive hardware control and resource reservation.

Use the following considerations when choosing virtual appliance components:

|Specification  |Considerations  |
|---------|---------|
|**CPU**     |   Assign dedicated CPU cores with at least 2.4 GHz, which aren't dynamically allocated. The appliance continuously records and analyzes network traffic so CPU usage is high. CPU performance is critical to capturing and analyzing network traffic. Any slowdown could lead to packet drops and performance degradation.</br></br>   |
|**Memory**     | Allocate RAM statically for the required capacity, not dynamically. Sensors have high RAM usage due to the sensor's constant network traffic recording and analytics. </br></br>|
|**Network interfaces**  |  Physical mapping provides best performance, lowest latency, and efficient CPU usage. Physically map Network Interface Cards (NIC)s to the virtual machines with Single Root Input/Output Virtualization (SR-IOV) or a dedicated NIC. Given the high traffic monitoring levels, expect high network utilization. </br></br>Set the promiscuous mode on your vSwitch to **Accept**, which allows all traffic to reach the virtual machine. Some vSwitch implementations might block certain protocols they aren't configured correctly.</br></br>|
|**Storage**     | Make sure to allocate enough read and write IOPs and throughput to match the performance of the virtual appliances. Expect high storage usage due to the large traffic monitoring volumes.   </br>   |

### Requirements

Bandwidth results for virtual machines can vary based on your protocol distribution and the specifications configured for your virtual machines. Specific requirements vary depending on the hardware profile you assign to each sensor.

The sensor installation includes an operating system image for the virtual machine.

## Knowledge check
