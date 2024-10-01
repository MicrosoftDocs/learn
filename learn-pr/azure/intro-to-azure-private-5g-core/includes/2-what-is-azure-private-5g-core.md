*Azure Private 5G Core* is an Azure edge service for deploying and managing 5G core network functions on an [Azure Stack Edge (ASE)](/azure/databox-online) device. The core network functions provide high-performance, low-latency, and secure connectivity for 5G Internet of Things (IoT) devices on standard 4G and 5G standalone radio access networks (RANs).

Azure Private 5G Core is a key component in an [Azure private multi-access edge compute (MEC)](https://azure.microsoft.com/solutions/private-multi-access-edge-compute-mec) solution. Private MEC solutions bring together a portfolio of services and enable operators and system integrators to deliver high-performance connectivity for IoT applications at the enterprise edge where your data is generated.

Azure Private 5G Core enables the instantiation of a single enterprise private mobile network that can be distributed across one or more sites around the world. Each site hosts a packet core instance, which comprises a set of 5G network functions. Packet core instances run on a Kubernetes cluster that is deployed on an Azure Stack Edge device and connected to Azure Arc.

The following diagram shows the key components of a single site powered by an Azure Private 5G Core packet core instance:

:::image type="content" source="../media/site-physical-components.png" alt-text="A diagram that displays the main components of a site in a private mobile network." border="true":::

As shown in the diagram, the packet core instance runs on a Kubernetes cluster deployed on an ASE device. The IoT user equipment (UE) connects to Azure Private 5G Core through the RAN. The packet core handles the communication and processing needs of the network, routing data to and from the data networks. To process the data from UEs, you'll also need to deploy data processing applications. For instance, in the package scanning example discussed in the introduction unit, the warehouse uses computer vision applications to process the data collected from each camera.

## Video: Introduction to Azure Private 5G Core

The following video introduces Azure Private 5G Core and its role in private MEC solutions:

> [!VIDEO 1b3c42e2-d0b1-4a45-885a-31b7502c9230]

## Key components of a private MEC solution

A private MEC solution powered with Azure Private 5G Core typically consists of the following components.

- **Packet core**

  The packet core instance is a cloud-native implementation of the 3GPP standards-defined 5G Next Generation Core (5G NGC or 5GC). Each packet core instance connects to a radio access network (RAN) to provide coverage for UEs. You'll source your RAN from an [Azure private MEC partner](/azure/private-multi-access-edge-compute-mec/partner-programs).

- **Azure Stack Edge and Azure Arc-enabled Kubernetes**

  Before you add a site to your private mobile network, you'll create a *Kubernetes cluster* on the Azure Stack Edge device, which serves as the platform for the packet core instance. The platform provides security and manageability for the entire core network stack from Azure. Additionally, Azure Arc allows Microsoft to provide support at the edge.

- **RANs and SIMs**

  UEs use SIMs or eSIMs to connect to a RAN. They connect to the packet core through the RAN.

  For RANs and SIMs, you can choose vendors based on your business, technology, and spectrum requirements. For more information, see [Azure private multi-access edge compute partner solutions](/azure/private-multi-access-edge-compute-mec/partner-programs).

## Enterprise network structure

Each private mobile network that Azure Private 5G Core deploys can have multiple sites around the world. The following diagram illustrates the structure of a typical multi-site private mobile network:

:::image type="content" source="../media/site-structure.png" alt-text="A diagram that illustrates the sites of a private mobile network." border="true":::

An enterprise that has multiple sites at different geographical locations can centrally manage all the sites from Azure. For example, they can perform provisioning or monitoring tasks from the Azure portal, and they can monitor all sites with applications such as Azure Monitor.
