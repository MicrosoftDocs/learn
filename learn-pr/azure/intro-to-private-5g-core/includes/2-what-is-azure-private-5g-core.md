*Azure Private 5G Core* is an Azure service for deploying and managing 5G core network functions on an [Azure Stack Edge (ASE)](/azure/databox-online/) device. The core network functions provide high-performance, low-latency, and secure connectivity for 5G Internet of Things (IoT) devices on standard 4G and 5G standalone radio access networks (RANs).

Azure Private 5G Core is a key component in an [Azure private multi-access edge compute (MEC)](/azure/private-multi-access-edge-compute-mec/overview) solution, which brings together a portfolio of services and enables operators and system integrators to deliver high-performance and low-latency connectivity for IoT applications at the enterprise edge.

Azure Private 5G Core works with other components to power private mobile networks. It instantiates a single enterprise private mobile network distributed across one or more sites around the world. Each site contains a packet core instance, which is a complete set of 5G network functions. Packet core instances run on a Kubernetes cluster, which is connected to Azure Arc and deployed on an Azure Stack Edge Pro with GPU device.

The following diagram shows the key components of a single site powered by an Azure Private 5G Core packet core instance:

:::image type="content" source="media/site-physical-components.png" alt-text="Diagram displaying the main components of a site in a private mobile network":::

As shown in the diagram, the packet core instance runs on a Kubernetes cluster deployed on an ASE device. The IoT user equipment (UE) connects to Azure Private 5G Core through RAN. To process the data from UEs, you'll also need to deploy data processing and logic definition applications. For example, in the warehouse camera example discussed in the [introduction unit](introduction.md), they use computer vision applications to process the data collected from each camera.

## Key components in typical private MEC solutions

- **Packet core**
  The packet core instance is a cloud-native implementation of the 3GPP standards-defined 5G Next Generation Core (5G NGC or 5GC). Each packet core instance connects to a radio access network (RAN) to provide coverage for UEs. You'll source your RAN from a third party.

- **Azure Stack Edge and Azure Arc-enabled Kubernetes**
  When you add a site to your private mobile network, you'll create a *Kubernetes cluster* on the Azure Stack Edge device, which serves as the platform for the packet core instance. The platform provides security and manageability for the entire core network stack from Azure. Additionally, Azure Arc allows Microsoft to provide support at the edge.

- **RANs and SIMs**
  UEs connects to the packet core through RAN. Radio vendors who can connect Azure Private 5G Core to a gNodeB (for 5G deployments) or eNodeB (for 4G deployments) allow you to choose from a broad range of options available in different countries.
  
  UEs use SIMs or eSIMs to connect to RAN. SIM vendors offering physical SIM and eSIM services can integrate directly with Azure Private 5G Core through the SIM manager to securely provision physical SIMs and eSIMs.

- **IP networking**
  TBD: Need more information about cloud connection, ports, and VLAN.

## Video: Introduction to Azure Private 5G Core

The following video introduces Azure Private 5G Core and its role in typical private MEC solutions:

[!VIDEO <../media/introduction-video.mp4>]