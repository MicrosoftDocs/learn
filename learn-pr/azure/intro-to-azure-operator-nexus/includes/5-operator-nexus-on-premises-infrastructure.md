The Operator Nexus hardware architecture is designed to support the requirements of telecommunications operators’ network functions at scale. The initial design supports network function workloads at operator’s Near Edge and some Far Edge use cases. This approach positions Operator Nexus to support the scalability requirements of today and positions Operator Nexus for the future.

Keeping abreast of hardware evolution will entail a thoughtful balance between supporting the latest hardware technology and allowing the rapid delivery of new software features. This approach may entail introducing bundles of new hardware on a consistent and predictable timeline. This approach reduces the certification timeline by minimizing the number of SKUs required.

:::image type="content" source="../media/multi-rack-architecture.png" alt-text="The Azure Nexus multi-rack architecture" border="false":::

The Operator Nexus BOM uses a refreshed rack hardware design over the earlier generations of Network Cloud. It will:

- Reduce the number of different network elements by using a single network device that can support a TOR-only configuration or CE/TOR configuration.
- Provide uniformity of individual compute racks. This has the following benefits. First, the performance characteristics are deterministic and consistent. Second, the software infrastructure quality and speed of delivery can increase with fewer variations to develop and test. Lastly, such a design allows an integrator to pre-configure racks consistently prior to operator delivery. All racks are configured the same and operators just have to choose the number of compute servers per rack. Operator Nexus supports 8, 12 and 16 servers per rack.
- Operators can define the footprint that fits their capacity needs. Operator Nexus supports 2 - 8 compute racks plus an Aggregator rack per instance.

The fault domain in this design will be a rack with no single point of failure for workloads within the rack. This approach improves flexibility by reducing the unit of incremental compute to one rack. It also enables a lower-cost entry point for operators and lab environments for customers. The uniform single rack design simplifies HW delivery options via the VAR (Value Added Reseller) ecosystem. The space required for this approach continues to work for larger footprints and smaller footprints where there’s limited floor space such as far edge. This approach can meet the various power and cost requirements for operator footprints.

## Network Fabric devices list

### Network Topology

:::image type="content" source="../media/nexus-network-topology.png" alt-text="Nexus network topology" border="false":::

### Network fabric component list

The following components are considered part of the network fabric:

- Terminal Server (TS): provides out of band connectivity to network devices from Azure. It also acts as the Zero Touch Provisioning (ZTP) server to bootstrap network fabric devices.
- Management Switches: enable connectivity towards management plane for network devices, servers, and storage management interfaces.
- Customer Edge Routers (CE): interface with the operator’s network providing ingress and egress connectivity to the Operator Nexus on-prem. These routers connect to the Provider Edge (PE) routers in the operator’s datacenter.
- Top of Rack Switches (TOR): Compute nodes are connected to the ToRs. ToRs support intra-rack communication. ToRs are connected to the CEs for inter-rack connectivity, and for connectivity into the operator’s network.
- Network Packet Broker (NPB): NPBs are used to filter mirrored traffic from select routing domains and forward them to probes. NPBs receive mirrored packets from the ToRs in each rack, and send out filtered traffic to the CEs, to be routed to the probes.

### Network Packet Broker

The Network Packet Broker (NPB) is a packet brokering solution that supports the needs of telco operators hosted on the Operator Nexus platform. During the operation of their telecommunications services, operators depend on the ability to monitor their service traffic flows by tapping into the network and sending copies of the network packets to special probe applications that process the data and provide the network-level visibility to aide with service planning and troubleshooting of service problems.

:::image type="content" source="../media/network-packet-broker-flow.png" alt-text="Network packet broker (NPB) flow" border="false":::

The NPB is configured as part of the fabric configuration. Span port config is static and configured once. Dynamic packet filtering rules are created based on operator’s requirements. Dynamic packet filtering rules are pushed to NPB using fabric orchestration tools. Outbound filtered traffic is forwarded to the security and probe backend systems.
