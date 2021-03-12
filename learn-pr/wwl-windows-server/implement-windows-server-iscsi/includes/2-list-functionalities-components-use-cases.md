Many organizations and businesses, such as Contoso, rely on a wide range of storage mechanisms to accommodate the needs of their workloads. One such popular mechanism is iSCSI.

## What is iSCSI?

iSCSI is a TCP/IP–based storage networking standard for connecting data storage services. It provides an inexpensive and easy to implement block-level access to remote storage by transporting SCSI commands over a standard Ethernet network. Effectively, iSCSI emulates the popular, high-performance, local storage bus–subsystem technology and creates a logical storage area network (SAN).

Unlike some SAN protocols, iSCSI requires no specialized cabling or connectivity devices. You can run it over existing switching and IP infrastructure. However, to ensure sufficient performance, you should operate an iSCSI SAN deployment on a dedicated network.

> [!NOTE]
> By default, iSCSI uses TCP port 3260.

:::image type="content" source="../media/m19-iscsi-concept.png" alt-text="The high level iSCSI architecture, with an iSCSI client connecting to an iSCSI Target Server via TCP/IP." border="false":::

## iSCSI components

From an architectural standpoint, iSCSI implementation includes the following components:

- IP network. You can use standard network interface adapters and standard Ethernet protocol network switches to connect to an iSCSI storage device. To ensure sufficient performance, the network should provide the throughput of at least 1 gigabit per second (Gbps) and include multiple physical paths to the iSCSI target.
- iSCSI targets. iSCSI targets allow access to their storage over IP network, which conceptually is equivalent to SCSI controllers providing access to their local storage via SCSI connectors. Many storage vendors implement hardware-based iSCSI targets. Other devices or applications (such as Windows Storage Server devices) implement iSCSI targets by using a software driver and at least one Ethernet adapter. Windows Server provides the iSCSI Target Server as a role service of the File and Storage Services role.
- iSCSI initiators. The iSCSI initiator is a client-side component that provides connectivity to a remote iSCSI target. The Windows operating system includes the iSCSI initiator software.
- iSCSI Qualified Name (IQN). IQNs are unique identifiers that iSCSI uses to designate and locate initiators and targets on an iSCSI network. When you configure an iSCSI target, you must configure the IQN for the iSCSI initiators that will be connecting to the target. iSCSI initiators also use IQNs to connect to the iSCSI targets.
- Internet Storage Name Service (iSNS). iSNS facilitates discovery, management, and configuration of iSCSI targets.

## iSCSI functionality in Windows Server

Windows Server allows you to implement both the iSCSI Target and iSNS components. All supported versions of Windows operating systems also include the iSCSI initiator.

### iSCSI Target Server

The iSCSI Target Server role service in Windows Server includes the following functionality:

- It provides authentication, allowing you to implement Challenge Handshake Authentication Protocol (CHAP) to authenticate initiator connections and reverse CHAP to enable the initiator to authenticate the iSCSI target.
- It implements iSCSI virtual disks as VHD or VHDX files, with the latter supporting up to 64 terabyte (TB) capacity.
- It supports management by using Server Manager, Windows PowerShell, and System Center Virtual Machine Manager.
- It scales to 256 iSCSI targets and 512 virtual disks per server.

### iSNS

The iSNS role service in Windows Server includes following functionality:

- It hosts a database of active iSCSI nodes, representing initiators, targets, and management systems.
- It supports automatic registration of initiators and targets. This, in turn, allows initiators to query the iSNS server for the list of available targets.
- It implements State Change Notification Service that triggers notifications to registered clients when changes occur to the database of the iSNS server.
- It offers Discovery Domain Service that allow you to restrict connectivity between designated iSCSI initiators and iSCSI targets by grouping them into one or more discovery domains.
