The processor in a standard Windows computer has a *kernel mode* and a *user mode*. The core OS components and most device drivers run in kernel mode, and apps run in user mode. When you implement containers on your computer, each container creates an isolated, lightweight environment to run apps on the host OS. The container shares most of the host OS kernel for access to the file system and registry.

Windows containers need a container OS. The container depends on the OS kernel to manage services like the file system, network, process scheduling, and memory management. The container OS is the OS that's part of the packaged runtime. You can use different versions of Windows with your containers to enable access to specific OS features or other required software.

## Network isolation and security

Windows containers support two types of runtime isolation: **Process** and **Hyper-V**. The primary difference is the extent of isolation created between the container, the host OS, and the other containers on the host.

Process isolation is the most common approach. Multiple container instances running on the same host achieve isolation through the namespace and resource control settings, along with other process isolation functions.

- Each container shares the same kernel with the host OS and other containers on the host.
- Each container has a virtual network adapter that connects to a virtual switch.
- Each container endpoint is placed in its own network namespace. The default network namespace is the location of the host virtual network adapter and host network stack.

Hyper-V isolation provides enhanced security and broader compatibility between the host and containers. Multiple container instances run on the same host, but each container runs in an optimized virtual machine. The virtual machine provides hardware-level isolation between each container and the container host.

- Each container essentially has its own kernel.
- To enforce network isolation between the containers on the host, a network namespace is created for each container.
- Containers run under Hyper-V isolation into which the virtual network adapter for the container is installed. Windows Server containers use a host virtual network adapter to attach to the virtual switch. Hyper-V isolation uses a synthetic virtual machine network adapter (not exposed to the utility virtual machine) to attach to the virtual switch.

:::image type="content" source="../media/windows-hyper-v-host-network.jpg" alt-text="Diagram showing how the virtual machine provides hardware-level isolation between each container and the container host." border="false":::

## Network management with Host Network Service (HNS)

Windows uses the Host Networking Service (HNS) and Host Compute Service (HCS) to create containers and attach endpoints to the network.

- **Network**: HNS creates a Hyper-V virtual switch for each network, and HNS creates the required NAT and IP pools.
- **Endpoints**: HNS creates the network namespace for each container endpoint, and HNS/HCS adds the virtual network adapter to the namespace. HNS creates virtual switch ports. HNS assigns the IP address, Domain Name System (DNS) information, routes, and so on, to the endpoint according to the configured network driver mode.
- **Policies**: For the default NAT network, HNS creates the WinNAT port forwarding rules and mappings with the corresponding Windows Firewall ALLOW rules. For all other networks, HNS uses the Virtual Filtering Platform (VFP) to create policies for load balancing, ACLs, and encapsulation.

## Firewall interaction

Depending on your container configuration and the type of network driver, port ACLs are enforced by a combination of the Windows Firewall and Azure Virtual Filtering Platform (VFP). The following values use the Windows hosts' firewall (enlightened with network namespaces) and VFP:

- Default Outbound: ALLOW ALL.
- Default Inbound: ALLOW ALL (TCP, UDP, ICMP, IGMP) unsolicited network traffic. DENY ALL other network traffic not from these protocols.

## Network drivers

Windows supports five different networking drivers or modes for Docker containers: NAT, Transparent, Overlay, L2Bridge, and L2Tunnel. In addition to the default NAT network created by Docker on Windows, you can also define custom container networks by using the ```docker network create``` command from the Docker CLI.

The following table summarizes the network driver types available for Docker containers on Windows. Choose the network driver that satisfies the requirements of your physical network infrastructure and host (single or multiple node) configuration.

| Network driver | Typical uses | Container-to-container (Single node) | Container-to-external (single node + multi-node) | Container-to-container (multi-node) |
|-|-|-|-|-|
| **NAT (Default)** | Good for Developers | Same Subnet: Bridged connection through Hyper-V virtual switch<br><br>Cross subnet: Not supported (only one NAT internal prefix) | Routed through Management virtual network adapter (bound to WinNAT) | Not directly supported: requires exposing ports through host |
| **Transparent** | Good for Developers or small deployments | Same Subnet: Bridged connection through Hyper-V virtual switch<br><br>Cross Subnet: Routed through container host. | Routed through container host with direct access to (physical) network adapter | Routed through container host with direct access to (physical) network adapter |
| **Overlay** | Good for multi-node; required for Docker Swarm, available in Kubernetes | Same Subnet: Bridged connection through Hyper-V virtual switch<br><br>Cross Subnet: Network traffic is encapsulated and routed through management virtual network adapter. | Not directly supported - requires second container endpoint attached to NAT network on Windows Server 2016 or VFP NAT rule on Windows Server 2019. | Same/Cross Subnet: Network traffic is encapsulated by using VXLAN and routed through management virtual network adapter |
| **L2Bridge** | Used for Kubernetes and Microsoft Software Designed Network (SDN) | Same Subnet: Bridged connection through Hyper-V virtual switch<br><br>Cross Subnet: Container MAC address rewritten on ingress and egress and routed. | Container MAC address 
rewritten on ingress and egress | Same Subnet: Bridged connection<br><br>Cross Subnet: routed through management virtual network adapter on WSv1809 and above |
| **L2Tunnel** | Azure only | Same/Cross Subnet: Hair-pinned to physical host's Hyper-V virtual switch to where policy is applied. | Traffic must go through Azure virtual network gateway | Same/Cross Subnet: Hair-pinned to physical host's Hyper-V virtual switch to where policy is applied |

## Advanced networking options

You can take advantage of several network driver options for Windows specific capabilities and features. Here are some examples:

- Access Switch Embedded Teaming for container host networks by specifying multiple network adapters for your Windows container.
- Set the VLAN ID for a network to configure VLAN isolation for any container endpoints that attach to the network.
- Specify the **OutboundNAT** policy for a network to allow your container access to the outside world.

For more information, see [Advanced Network Options in Windows](/virtualization/windowscontainers/container-networking/advanced).
