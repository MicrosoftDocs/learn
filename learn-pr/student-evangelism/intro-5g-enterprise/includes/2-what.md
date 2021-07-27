To explore the capabilities of 5G networks, we can consider two parts: firstly, the capabilities of 5G networks themselves and secondly, the capabilities of Azure for 5G technologies. We discuss these below.

## 5G network capabilities

In telecommunications, the term '5G' refers to the fifth-generation technology standard for broadband cellular networks. Currently (2021), in most places in the world, the dominant standard is 4G (fourth generation) which is also called LTE (Long Term Evolution). 5G is the successor of LTE. Hence, 5G is the evolution of existing LTE networks. 

We are all used to mobile technology as consumers. But 5G technology has implications for business as well. 5G is similar to its predecessors in that it's a cellular network service comprising of 'cells.' Cells are logical divisions of a geographical service area. All the cellular devices in a cell (service area) are connected to the internet through the cellular network. Thus, the 5G cellular network provides an 'air interface' to connect mobile devices to the internet through the cell tower. Thus, the cellular service acts as a 'last mile' between the cell tower and the end-user device. 

5G provides greater bandwidth than LTE. In addition to greater bandwidth, 5G technology also provides low latency and manages a greater density of devices. These characteristics suit applications like live video analytics and IoT. 

From a telecoms standpoint, as per the ITU (International Telecommunications Union), there are three main application areas for 5G:

- **Enhanced Mobile Broadband (eMBB) provides greater bandwidth** for applications that benefit from higher traffic, such as concert venues. 
- **Ultra-Reliable Low-Latency Communications (URLLC):** involves applications that use the 5G network for mission-critical applications. 
- **Massive Machine-Type Communications (mMTC):** provides the ability to connect to a large number of devices. 

## Azure capabilities

We now consider the capabilities of Azure, which complement and enhance the capabilities of the core 5G network. 

There are three possibilities for deploying 5G and Azure technologies:

- Azure for Operators
- Azure private multi-access edge compute (MEC), implemented over Azure Stack Edge
- Azure Stack HCI (for data centers)

We focus on Azure private MEC because this module is targeted to enterprise developers using Azure technologies. Also, in this module, we focus on low latency-based IoT services, but similar considerations could also apply to a live video analytics service based on Azure private MEC and 5G. 

Traditionally, enterprise applications are network agnostic, that is, they don't consider the unique capabilities of the underlying network. For example, the network may be fixed or wi-fi, but the application itself functions seamlessly over a variety of network types. 

However, in specific cases, your application can benefit by leveraging capabilities for the underlying network. For example, you can create new enterprise services by combining the capabilities provided by 5G networks with Azure technologies, especially IoT Edge services. In traditional 5G terminology, the term ‘edge’ implies the edge of the telecoms network. Azure technologies bring the 5G edge inside the enterprise, thereby making IoT applications network-aware within the enterprise. Such a deployment could potentially provide even lower latency. Azure also provides a suite of technologies familiar to Azure developers.

Azure private multi-access edge compute (MEC) is the mechanism that brings together a portfolio of services from Microsoft to implement 5G technologies in the enterprise. These services include Microsoft compute, networking, and application services – all of which are traditionally managed from the cloud. The Azure private MEC solution enables enterprises, operators, and system integrators to collaborate and deploy low-latency connectivity IoT applications at the enterprise edge. In addition, by processing data closer to the end device, Azure private MEC capabilities help improve latency and help throughput-sensitive user scenarios such as video analytics, real-time robotics, so on. 

There are four classes of services for Azure private MEC in the enterprise:

- Azure Network Functions offered via Marketplace
- Azure Stack hardware and services
- Azure Management services
- Application services

We describe these below:

| Classes of services for Azure private MEC           | Details                                                      |
| --------------------------------------------------- | ------------------------------------------------------------ |
| **Azure Network Functions offered via Marketplace** |                                                              |
| **Metaswitch Fusion Core**                          | is container based 4G and 5G Core solution for IoT devices.  |
| **Affirmed Private Network Service**                | is an Azure Marketplace offering that enables a managed private network service for Mobile Network Operators and managed services providers who want to provide 4G, and 5G managed service offerings to Enterprises. |
| **Azure Management Services**                       |                                                              |
| **Azure Network Functions Manager (NFM)**           | helps to deploy network functions to the edge using consistent Azure tools and interfaces. |
| **Arc Enabled Kubernetes**:                         | enables you to attach and configure Kubernetes clusters located either inside or outside Azure. |
| **Azure Stack hardware and services**               |                                                              |
| **Azure Stack Edge**:                               | Azure Stack Edge comprises of a portfolio of devices that bring compute, storage, and intelligence to the edge where data is created. |
| **Azure Stack HCI**:                                | is a hyper-converged infrastructure (HCI) operating system delivered as an Azure service that provides the security, performance, and feature updates. It enables you to deploy and run Windows and Linux virtual machines (VMs) in your datacenter or at the edge using your existing tools and processes. |
| **Application services**                            |                                                              |
| **Azure IoT Edge Runtime**:                         | enables cloud workloads to be managed and deployed across edge compute appliances using the same tools and security posture as cloud-native workloads. |
| **Azure IoT Hub**                                   | enables cloud workloads to be managed and deployed across edge compute appliances using the same tools and security posture as cloud-native workloads. |
| **Azure IoT Central**:                              | is a managed application platform that enables device management and data ingestion as a service with a predictable pricing model and global scale built-in. |
| **Azure Digital Twins**:                            | enables device sensors to be modeled in their business context considering spatial relationships, usage patterns, and other business context that turns a fleet of devices into a digital replica of a physical asset or environment. |

Thus, new services may be implemented as a partnership between the Enterprise customer, Telco and System Integrator partners, and Application ISVs. 