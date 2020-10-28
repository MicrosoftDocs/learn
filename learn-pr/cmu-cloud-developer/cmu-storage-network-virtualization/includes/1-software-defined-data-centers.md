A typical datacenter architecture consists of many loosely integrated components, including pools of servers (CPU and OS), storage arrays, and a hierarchical physical network to interconnect these components, as well as power and cooling and a management system for each of these components. As we saw in earlier units, sharing of datacenter resources could happen by simply running applications or processes on the same set of servers. However, this provides minimal isolation and restricts all applications to adhere to a single software environment. Another approach to sharing can be where multiple tenants share the datacenter real estate by collocating servers or racks of servers within the same physical space but sharing cooling, power, and networking. Collocation offers improved isolation, but it also increases costs and lowers utilization. 

As we read in earlier modules, with the advent of utility computing and better resource-sharing technologies, such as server virtualization, it is possible for the applications and data of multiple tenants to coexist within the same physical servers while maintaining a certain degree of isolation. This idea was achieved by adding a software layer that enables the sharing of physical resources. Since datacenters also include large-scale storage systems (SANs) and a hierarchical networking fabric (switches and routers), could this same idea of utilizing a software layer be applied to enable the sharing of storage and networking? 

The success of server virtualization at achieving resource sharing, higher utilization, and improved flexibility and elasticity has led to the advent of the idea of a software-defined datacenter (SDDC). An SDDC virtualizes all infrastructure in a manner that can be automated and easy to manage. A virtualized cluster, which includes servers, networking fabric, and storage systems, can be decoupled from the physical resources and provided as software resources that can be configured and managed. Instead of building applications using dedicated servers, storage resources, and networking resources, an SDDC offers the datacenter infrastructure as software services since all of the needed resources can be virtualized. 
<br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4q0ew]

The main technologies that enable an SDDC include:

- Server or compute virtualization
- Software-defined networking (SDN)
- Software-defined storage (SDS)
- Management and automation software 

Earlier, we covered the mature server/compute virtualization technology in detail. In this module, we will briefly introduce the main ideas behind the emerging technologies of SDN and SDS. SDN and SDS can, for example, enable setting up an isolated network with dedicated bandwidth and latency requirements across multiple VMs and provisioning storage for an application with configurable bandwidth and latency requirements. As the cloud computing paradigm continues to evolve, we will see SDN and SDS play a role in enabling improved sharing, isolation, flexibility, QoS guarantees, and management of datacenter resources. 

