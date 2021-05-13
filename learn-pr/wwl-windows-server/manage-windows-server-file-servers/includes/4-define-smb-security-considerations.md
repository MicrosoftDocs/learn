Managing collaboration and data sharing is an important part of an IT administrator's responsibilities. To fulfill these responsibilities, it is helpful to understand technologies that serve as the basis for Windows file sharing, such as the Server Message Block (SMB) protocol.

## What is SMB?

SMB is a TCP/IP-based network file sharing protocol that allows applications on a computer to read and write to files, and to request services from server programs in a computer network. Using the SMB protocol, an application (or the user of an application) can access files or other resources at a remote server. This allows applications to read, create, and update files on the remote server.

## What are the benefits of SMB 3.x?

Microsoft developed Server Message Block (SMB) in the 1980s. The original specification, SMB 1, was bandwidth inefficient and lacked sufficient level of security. The subsequent SMB versions addressed these shortcomings through such features as built-in encryption, SMB Multichannel, and SMB Direct.

SMB 2.0, which Microsoft introduced in Windows Server 2008, offered meaningful performance improvements, however, didn't address in any significant manner the security challenges.

SMB 3.0, which Microsoft introduced in Windows Server 2012, includes the following features:

- SMB Transparent Failover. This feature enables you to perform the hardware or software maintenance of nodes in a clustered file server without interrupting server applications that are storing data on file shares.
- SMB Scale Out. In clustered configurations, you can create file shares that provide simultaneous access to data files, with direct input/output (I/O), through all the nodes in a file server cluster.
- SMB Encryption. This feature provides the end-to-end encryption of SMB data on untrusted networks, and it helps to protect data from eavesdropping.
- Windows PowerShell commands for managing SMB. You can manage file shares on the file server, end to end, from the command line.
- SMB Multichannel. This feature enables you to aggregate network bandwidth and network fault tolerance if multiple paths are available between the SMB 3.x client and server.
- SMB Direct. This feature supports network adapters that have the Remote Direct Memory Access (RDMA) capability and can perform at full speed with very low latency and by using very little central processing unit (CPU) processing time.

SMB 3.1.1, which Microsoft introduced in Windows Server 2016, offers several additional enhancements, including:

- Preauthentication integrity. Preauthentication integrity provides improved protection from a man-in-the-middle attack that might tamper with the establishment and authentication of SMB connection messages.
- SMB Encryption improvements. SMB Encryption, introduced with SMB 3.0, uses a fixed cryptographic algorithm, AES-128-CCM. However, AES-128-GCM, available with SMB 3.1.1 performs better with most modern processors.
- The removal of the **RequireSecureNegotiate** setting. Because some third-party implementations of SMB don't perform this negotiation correctly, Microsoft provides a switch to disable Secure Negotiate. However, the default for SMB 3.1.1 servers and clients is to use preauthentication integrity, as described earlier.

### What are the most common use cases of SMB 3.x performance enhancements?

SMB Direct and SMB Multichannel enable you to deploy cost-efficient, continuously available, and high-performance storage for server applications on file servers. Both SMB Multichannel and SMB Direct are enabled by default on Windows Server. You can use multiple network connections simultaneously with SMB Multichannel, which enhances overall file-sharing performance. SMB Direct ensures that multiple network adapters can coordinate the transfer of large amounts of data at line speed while using fewer CPU cycles.

SMB Direct and SMB Multichannel-based file shares provide an alternative to storing files on Internet Small Computer System Interface (iSCSI) or Fibre Channel storage area network (SAN) devices. When creating a VM in Hyper-V on Windows Server, you can specify a network share when choosing the VM location and the virtual hard disk location. You can also attach disks stored on SMB 3.x file shares. By using this approach, you can achieve high availability not by clustering Microsoft Hyper-V nodes, but by using clustered file servers that host VM files on their file shares. This is referred to as a Scale-Out File Server. With this capability, Hyper-V can store all VM files, including configuration files, .vhd files, and checkpoints on highly available SMB file shares.

> [!NOTE]
> Cluster Dialect Fencing, available starting with SMB 3.1.1, provides support for cluster upgrades between consecutive operating system versions for the Scale-Out file Servers.
