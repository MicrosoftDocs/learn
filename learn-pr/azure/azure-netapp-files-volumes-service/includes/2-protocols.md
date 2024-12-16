Let's start with a quick overview of supported network attached storage (NAS) protocols in Azure NetApp Files. This overview helps you decide the protocol that best suits your workloads in the Azure cloud.

NAS protocols are used to have conversations between clients and servers. The two NAS protocols used in Azure NetApp Files are:
- Network Files System (NFS)
- Server Message Block (SMB)

## Network File System (NFS)

Azure NetApp Files supports any NFS client that operates within the RFC standards.

### NFSv3 versus NFSv4.x

NFSv4 and NFSv4.x support different features:

| Feature | NFSv3 | NFSv4.x |
| --- | ------ | ------ |
| State of NFS connections | NFSv3 is stateless, meaning that the NFS server doesn't keep track of the states of connections (including locks). | NFSv4.x is a stateful protocol. The client and server keep track of the states of the NFS connections, including lock states. |
| File locking | Locking is handled outside of the NFS protocol, using Network Lock Manager (NLM). | Locking is integrated into the NFS protocol and doesn't require ancillary locking protocols to keep track of NFS locks. |
| Performance | Because NFSv3 is stateless, performance with NFSv3 can be substantially better in workloads with high-metadata operations such as OPEN, CLOSE, SETATTR, and GETATTR. | The statefulness of NFSv4.x has some drawbacks, such as potential disruptions during network outages or storage failovers, and performance overhead in high metadata workload types.|
| File permission | NFSv3 uses a basic file permission model where only the owner of the file, a group and everyone else can be assigned a combination of read/write/execute permissions. |NFSv4.x can use a more robust file permission model. These granular access control lists (ACLs) can be applied to users or groups and allow for permissions to be set on a wider range of operations than basic read/write/execute operations. |
| Security | NFSv3 supports for UNIX mode bits (read, write, and execute). | Azure NetApp Files only supports NFSv4.1 Kerberos encryption. NFSv4.x doesn't use ancillary protocols. Kerberos is applied to the entire NFS conversation when in use. |
| User authentication | NFSv3 uses numeric IDs for its user and group authentication. Usernames and group names aren't required for communication or permissions. NFSv3 can use LDAP for user and group lookups. | NFSv4.x uses a combination of user/group names and domain strings to verify user and group information. |

Additionally, NFSv4.x provides many significant advantages over NFSv3, including:

- Better locking concepts (lease-based locking)
- Better security (fewer firewall ports needed, standard integration with Kerberos, granular access controls)
- More features
- Compound NFS operations (multiple commands in a single packet request to reduce network chatter)
- TCP-only

## Server Message Block (SMB)

SMB is primarily used with Windows clients for NAS functionality. However, it can also be used on Linux-based operating systems such as AppleOS and RedHat.

>[!NOTE]
> Azure NetApp Files has official support for SMB using Windows and macOS. SMB on Linux operating systems can work with Azure NetApp Files, but there's no official support. Azure NetApp Files supports only SMB 2.1 and SMB 3.1 versions.
SMB has the following characteristics:

- SMB is a stateful protocol. The clients and server maintain a state for SMB share connections for better security and locking.
- File locking in SMB is mandatory. When a file is locked, no other client can write to that file until the lock is released.
- SMB supports full Kerberos integration. When Kerberos is unable to be used for authentication, Windows NT LAN Manager (NTLM) may be used as a fallback.
- SMBv3.0 and later supports end-to-end encryption for SMB shares.
- SMBv3.x supports multichannel for performance gains in certain workloads.
- SMB authenticates using user and group names.
- User and group information is provided by an Active Directory domain controller.
- SMB in Azure NetApp Files uses standard Windows New Technology File System (NTFS) ACLs for file and folder permissions.

## Dual protocols

Some organizations have pure Windows or pure UNIX environments (homogenous) in which all data is accessed using either NFS or SMB protocols. 

Many sites must enable data sets to be accessed from both Windows and UNIX clients. For environments with these requirements, Azure NetApp Files has native dual-protocol NAS support. After the user is authenticated on the network, they can access the data from UNIX hosts using NFS or from Windows hosts using SMB.

Using the dual-protocol volumes can provide the following benefits:
- Reduce the overall storage administrator management tasks.
- Require only a single copy of data to be stored for NAS access from multiple client types.
- Protocol agnostic NAS allows storage administrators to control the style of ACL and access control being presented to end users.
- Centralize identity management operations in a NAS environment.
