Intro

## Key components

The following diagram shows the key components of Azure Private 5G Core: 

:::image type="content" source="media/azure-private-5g-core-components.png" alt-text="Diagram showing the components of Azure Private 5G Core" border="false":::

Diagram showing the components of Azure Private 5G Core. They're split between cloud components and components provided on premises. The cloud components include Azure portal, ARM APIs, Azure Monitor, SIM Manager, Service Manager, and RAN Monitor. The on-premises components include Subscriber Database and Policy Control, 4G Interworking Function, 5G Core Control Plane, 5G User Plane, Arc-enabled Kubernetes, and Azure Stack Edge.

## Packet core architecture

Azure Private 5G Core instantiates a single private mobile network distributed across one or more enterprise sites across the world. Each site contains a packet core instance, which is a cloud-native implementation of the 3GPP standards-defined 5G Next Generation Core (5G NGC or 5GC). A packet core instance authenticates end devices and aggregates their data traffic over 5G Standalone wireless and access technologies. Each packet core instance includes the following components:

- A high performance (25 Gbps rated load) and highly programmable 5G User Plane Function (UPF).
- Core control plane functions including policy and subscriber management.
- A portfolio of service-based architecture elements.
- Management components for network monitoring.

You can also deploy packet core instances in 4G mode to support Private Long-Term Evolution (LTE) use cases. For example, you can use the 4G Citizens Broadband Radio Service (CBRS) spectrum. 4G mode uses the same cloud-native components as 5G mode (such as the UPF). This is in contrast to other solutions that need to revert to a legacy 4G stack.

The following diagram shows the network functions supported by a packet core instance. It also shows the interfaces these network functions use to interoperate with third-party components.

:::image type="content" source="media/packet-core-architecture.png" alt-text="Diagram of the packet core architecture displaying each of the supported network functions and their interfaces":::

Each packet core instance is connected to the local RAN network to provide coverage for cellular wireless devices. You can choose to limit these devices to local connectivity. Alternatively, you can provide multiple routes to the cloud, internet, or other enterprise data centers running IoT and automation applications.

## Azure Private 5G Core resources

The following diagram shows the key resources you'll use to manage your private mobile network through Azure.

:::image type="content" source="media/private-5g-core-resources.png" alt-text="Diagram displaying the resources used to manage a private mobile network":::

- The *mobile network* resource represents the private mobile network as a whole.
- Each *SIM* resource represents a physical SIM or eSIM. The physical SIMs and eSIMs are used by UEs that will be served by the private mobile network.
- *SIM group* resources serve as containers for SIM resources and allow you to sort SIMs into categories for easier management. Each SIM must be a member of a SIM group, but can't be a member of more than one. If you only have a small number of SIMs, you may want to add them all to the same SIM group. Alternatively, you can create multiple SIM groups to sort your SIMs. For example, you could categorize your SIMs by their purpose (such as SIMs used by specific UE types like cameras or cellphones), or by their on-site location.
- *SIM policy* resources are a key component of Azure Private 5G Core's customizable policy control, which allows you to provide flexible traffic handling. You can determine exactly how your packet core instance applies quality of service (QoS) characteristics to service data flows (SDFs) to meet your deployment's needs. You can also use policy control to block or limit certain flows.

    Each SIM policy defines a set of policies and interoperability settings. You'll need to assign a SIM policy to a SIM before the UE using that SIM can access the private mobile network.

    A SIM policy will also reference one or more *services*. Each service is a representation of a set of QoS characteristics that you want to offer to UEs on SDFs that match particular properties, such as their destination, or the protocol used. You can also use services to limit or block particular SDFs based on these properties.

- The *mobile network site* and *packet core* resources allow you to manage the sites in your private mobile network and the packet core instances that run in them.
- Each *attached data network* resource allows you to manage how its associated packet core instance will connect to the data network.
