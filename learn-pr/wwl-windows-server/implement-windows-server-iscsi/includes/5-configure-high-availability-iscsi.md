For the Windows Server iSCSI-based implementation to function as a viable storage solution for enterprise workloads, it is critical to ensure that it provides sufficient level of resiliency. This resiliency must include not only highly available storage, but also redundant network connectivity.

## Network-level redundancy for iSCSI-based storage

You can implement network-level redundancy for iSCSI storage by using Multiple Connections per Session (MCS) or Multipath Input/Output (MPIO). While they offer similar capabilities, their underlying technologies differ.

Microsoft MCS enables multiple TCP/IP connections from the initiator to the target for the same iSCSI session. I/O payload can flow over the connections to the target. If one connection fails, another connection that is part of the same session can continue processing I/O without interruption to the client-side workload. The Microsoft iSCSI initiator supports load balancing policies that allow you to configure how to allocate I/O across multiple connections. However, MCS requires explicit support by iSCSI SAN devices.

:::image type="content" source="../media/m19-iscsi-mcs.png" alt-text="The architecture of MCS, with a single iSCSI session over multiple redundant network paths." border="false":::

Microsoft MPIO allows the initiator to establish multiple sessions to the same target over different network paths and aggregate multiple devices into a single logical device available to the storage stack. Each session to the target can use different network adapters, network devices, and target ports. If one session fails, another session can continue processing I/O without interruption to the client-side workload. Note that the iSCSI target must support multiple sessions to the same target.

MPIO uses device-specific module (DSM) to manage interaction with third-party SAN devices. Windows Server provides a generic MPIO DSM, available as an operating system feature. Many SANs support the Microsoft DSM without, although there are some that require a vendor-specific DSM implementation. Just as with MCS, the Microsoft iSCSI MPIO DSM supports load balance policies that allow you to configure how to allocate I/O across different sessions.

:::image type="content" source="../media/m19-iscsi-mpio.png" alt-text="The architecture of MCS, with multiple, individual iSCSI sessions over different redundant network paths." border="false":::
