<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m07_software_defined_datacenter\x-oli-workbook_page\_u03_m07_0_module_intro.xml -->

A typical data center architecture consists of many loosely integrated components including pools of servers (CPU and OS), storage arrays, a hierarchical physical network to interconnect these components, as well as power and cooling and a management system for each of these components. As we saw in earlier units, sharing of data center resources could happen by simply running applications or processes on the same set of servers. However, this provides minimal isolation and restricts all applications to adhere to a single software environment. Another approach to sharing can be where multiple tenants share the data center real estate by co-locating servers or racks of servers within the same physical space but sharing cooling, power and networking. Co-location offers improved isolation, however it also increased costs and lowers utilization. 

As we read in earlier, with the advent of utility computing and better resource sharing technologies, such as server virtualization, it is possible for the applications and data of multiple tenants to co-exist within the same physical servers while maintaining a certain degree of isolation. This idea was achieved by adding a software layer that enables the sharing of physical resources. Since data centers also include large scale storage systems (SANs) and hierarchical networking fabric (switches and routers), could this same idea of utilizing a software layer by be applied to enable the sharing of storage and networking? 

The success of server virtualization at achieving resource sharing, higher utilization, improved flexibility and elasticity, has led to the advent of the idea of Software Defined Data Center (SDDC). SDDC virtualizes all infrastructure in a manner which can be automated and easy to manage. A virtualized cluster, which includes servers, networking fabric and storage systems, can be decoupled from the physical resources and provided as software resources that can be configured and managed. Instead of building applications using dedicated servers, storage and networking resources, SDDC offers the data center infrastructure as software services since all of the needed resources can be virtualized. 
> [!VIDEO https://youtube.com/embed/X2Ppt0MG6as]

_Video 3.13: Software Defined Data Centers (SDDC)._


The main technologies that enable an SDDC include:
1. Server/Compute Virtualization
1. Software Defined Networking
1. Software Defined Storage 
1. Management and Automation Software 

Earlier, we covered the mature server/compute virtualization technology in detail. In this module we will briefly introduce the main ideas behind the emerging technologies of Software Defined Networking (SDN) and Software Defined Storage (SDS). SDN and SDS can, for example, enable setting up an isolated network with dedicated bandwidth and latency requirements across multiple VMs and provisioning storage for an application with configurable bandwidth and latency requirements. As the cloud computing paradigm continues to evolve, we will see SDN and SDS play a role in enabling improved sharing, isolation, flexibility, QoS guarantees, and management of data center resources. 