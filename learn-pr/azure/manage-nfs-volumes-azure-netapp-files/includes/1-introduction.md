Azure NetApp Files supports creating volumes using NFS (NFSv3 or NFSv4.1), SMB3, or dual protocol (NFSv3 and SMB, or NFSv4.1 and SMB). A volume's capacity consumption counts against its pool's provisioned capacity.

NFS is primarily used with Linux/UNIX based clients such as Red Hat, SUSE, Ubuntu, AIX, Solaris, and Apple OS. Azure NetApp Files supports any NFS client that operates within the RFC standards.

### NFSv3 vs NFSv4

| Protocols | NFSv3 | NFSv4.x |
| --- | --- | --- |
| **State of NFS connections** | NFSv3 is stateless, meaning that the NFS server doesn't keep track of connection states (including locks). | NFSv4.x is stateful, which means that the client and server keep track of NFS connection states, including lock states. |
| **File locking** | Locking is handled outside of NFS by using Network Lock Manager (NLM). | Locking is integrated into NFS and doesn't require ancillary locking protocols. |
| **Performance** | Because NFSv3 is stateless, performance can be better in high-metadata workloads such as OPEN, CLOSE, SETATTR, and GETATTR. | Statefulness in NFSv4.x can cause potential disruption during outages or failovers and add overhead for high metadata workloads. |
| **File permission** | NFSv3 uses a basic permission model for owner, group, and others with read/write/execute combinations. | NFSv4.x can use a more robust ACL-based permission model with more granular operations. |
| **Security** | NFSv3 can use Kerberos, but ancillary protocols are not included in the Kerberos conversation. | Azure NetApp Files supports NFSv4.1 Kerberos encryption. NFSv4.x doesn't use ancillary protocols; Kerberos can apply to the full NFS conversation. |
| **User authentication** | NFSv3 uses numeric IDs for user and group authentication. | NFSv4.x uses user and group names with domain strings to verify user and group information. |
