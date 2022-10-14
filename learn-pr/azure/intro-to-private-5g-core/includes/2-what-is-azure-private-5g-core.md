*Azure Private 5G Core* is an Azure cloud service for deploying and managing 5G core network functions on an Azure Stack Edge device, as part of an on-premises private mobile network for enterprises. The 5G core network functions connect with standard 4G and 5G standalone radio access networks (RANs) to provide high performance, low latency, and secure connectivity for 5G Internet of Things (IoT) devices. Azure Private 5G Core gives enterprises full control and visibility of their private mobile networks.

The following video introduces Azure Private 5G Core:

![Azure Private 5G Core introduction](../media/introduction-video.mp4)

Azure Private 5G Core provides:

- **Complete 5G core network functions**

  Azure Private 5G Core instantiates a single enterprise private mobile network distributed across one or more sites around the world. Each site contains a *packet core instance*, which is a complete set of 5G network functions. These network functions include the subscriber database, policy control, control plane, and user plane. These are all deployed on a multi-access edge compute platform.

  You can also configure packet core instances to operate in 4G mode to support Private Long-Term Evolution (LTE) use cases.

- **Azure service management**
  
  Azure Private 5G Core provides a centralized software lifecycle and service management for the private mobile network across multiple sites. You can use the Azure portal and Azure Resource Manager (ARM) APIs to carry out all management and monitoring tasks.

- **Azure visibility**

  Azure Private 5G Core integrates with Azure Monitor and Log Analytics to collect data from across the sites and provide real-time monitoring of the entire private mobile network. You can extend this capability to capture radio analytics to provide a complete network view from Azure.

You'll also need the following to deploy a private mobile network using Azure Private 5G Core. These aren't included as part of the service.

- **Azure Stack Edge and Azure Arc-enabled Kubernetes**

  Packet core instances run on a Kubernetes cluster, which is connected to Azure Arc and deployed on an Azure Stack Edge Pro with GPU device. These platforms provide security and manageability for the entire core network stack from Azure. Additionally, Azure Arc allows Microsoft to provide support at the edge.

- **RANs and SIMs** 

  The Azure private multi-access edge compute (MEC) solution offers an ecosystem of technology solution partners, including the following:

  - Radio vendors who can connect Azure Private 5G Core to a gNodeB (for 5G deployments) or eNodeB (for 4G deployments), allowing you to choose from a broad range of shared or licensed spectrum options available in different countries.
  - SIM vendors offering physical SIM and eSIM services. These vendors can integrate directly with Azure Private 5G Core through the SIM manager to securely provision physical SIMs and eSIMs.

Each private mobile network contains one or more sites. A site is a physical enterprise location that will provide coverage for user equipment (UEs). The following diagram shows the main components of a single site.

:::image type="content" source="media/site-physical-components.png" alt-text="Diagram displaying the main components of a site in a private mobile network":::

- Each site contains an Azure Stack Edge device that hosts a *packet core instance*, which is deployed using Azure Private 5G Core. The packet core instance is a cloud-native implementation of the 3GPP standards-defined 5G Next Generation Core (5G NGC or 5GC).

    When you add a site to your private mobile network, you'll create a *Kubernetes cluster* on the Azure Stack Edge device. This serves as the platform for the packet core instance.

- Each packet core instance connects to a radio access network (RAN) to provide coverage for UEs. You'll source your RAN from a third party.
