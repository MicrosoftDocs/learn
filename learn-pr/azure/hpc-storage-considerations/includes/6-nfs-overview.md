Although there are books devoted to NFS, there are some key concepts we want to discuss in the context of choosing your HPC storage solution. The main challenge with NFS is whether or not your target HPC storage environment requires certain configuration elements, network connectivity, or security features. Gathering some specific concepts into your selection criteria will be helpful when assessing the various available solutions. At minimum, accounting for these items will save you valuable time by eliminating anything that doesn't quite fit the specific NFS requirements you may have.

### NFS Considerations ###

There are two main versions of the NFS protocol: NFSv3 and NFSv4.x (v4.1, v4.2). The full scope of these two versions' differences lies outside the goals of this module, but there are a handful of issues related to authentication and authorization that we will identify here. We will also not get into the history of the two protocols, or why there are two other than to say many users are still running NFSv3 in their environments.

We will first discuss some topics specific to the use of NFSv3.

**NFSv3 and Groups**

NFSv3 is a simple file system protocol that passes API requests to NFS servers for data. We mentioned earlier that a user is represented by their UID and have a primary group GID association. We also mentioned that a user may be associated with a larger number of groups. For NFS purposes, these additional group assignments are known as *auxiliary groups*. The UID and GID information are passed with requests, which the NFS server will use to determine the appropriate level of access.

NFSv3 has a limit in terms of the total number of GID values it passes. NFSv3 only supports the passing of 16 auxiliary groups for any given UID. The implication is that if you are currently using greater than 16 group assignments in meaningful ways (such as fine-grained access management), you may run into this limitation. NAS vendors such as NetApp have added an extension to the NFS protocol that supports the communication of all group mappings, known as **extended group** support. If you are assessing hpc storage and are using large numbers of GID assignments, you should very whether or not the proposed solution supports this capability.

The bottom line is that you may have a long-standing NFS environment in your datacenter that has been leveraging many group assignments. You may or may not need to replicate this exactly when running HPC in Azure, but if you do the implication is that the solution you use must support extended groups.

**NFSv3 and network security**

NFSv3 is also limited in terms of security. If you are running NFSv3, you are aware that it doesn't really have many security features. It does not support data encryption or Kerberos authentication, for example. The main mechanisms available in a NFSv3 environment involve the use of **export rules and policies** to limit network-level access to the NFS server. An *export* is the mechanism a NFS server uses to expose a specific directory to clients. Export rules are configured to allow or disallow clients based on their IP network address. You can define host entries in an export rule (for example 1.1.1.1) or networks (for example 1.1.1.0/24) and allow/deny access to the export.  Export rules are gathered into an export policy which is associated to a specific export on the NFS server.

**NFSv3 and network ports**

One particular challenge with NFSv3 is that it does not use a specific standard TCP port for communications. This makes allowing NFSv3 access challenging over a WAN given that while there are standard ports (RPC = 111 and NFS = 2049), other ports for mounting the export are randomly assigned ports.

NFSv3 networking in Azure only becomes a challenge if you require access beyond your Virtual Network, and require security configuration that blocks TCP ports. On the other hand, choosing a solution that provides for export policy configuration will help to lock down the NFS solution directly, no matter what is configured at the edge of your network.

We will discuss a *hybrid* architecture in a future unit where this will become a larger issue.

**Squashing**

*Squashing* refers to the NFS server's ability to force the use of a specific UID when accessing files/folders. For example, an administrator may want to control which UID is used for a specific exported folder. Linux NFS server environments supports the ability to squash root access to a non-root UID. NAS products support specific squashing based on incoming client network/address and UID value. One of the key uses of squashing is to ensure non-root access over remote connections.

If you are intending to replicate your file system in Azure and expect this same behavior, keep in mind that not every solution supports squashing in exactly the same way.

**NFSv3 and encryption**

NFSv3 does not offer support for data encryption. It was originally designed for use within a trusted enterprise environment. Traffic leaving your trusted network must be encrypted by your network encryption solution.

**NFSv3 and file locking**

*Locking* refers to a client's ability to prevent other clients from updating a specific file or section of a file. NFSv3 does not have its own locking mechanism, and what locking that does exist is performed by additional network protocols (NLM and NSM). Further, these locks are not exclusive/mandatory but are rather known as *advisory locks*. The locks are tracked but not enforced. Applications are expected to handle contention and locking issues.

**NFSv4.x**

NFSv4.x introduces some key improvements to NFS. For our purposes we will focus on the some main ones.

**NFSv4 and Kerberos**

NFSv4 introduced full support for the use of Kerberos for authentication of users and encryption of all NFS traffic. There was an attempt to integrate Kerberos with NFSv3 but due to the use of NLM/NSM and other external protocols only the data packets were actually encrypted.

Using Kerberos, you can now authenticate based on trusted machines. NFSv3 assumed all accesses were trusted unless explicitly blocked by export policies.

Encryption of all NFS traffic is supported.  The implication is that you can encrypt all traffic from NFS client to NFS server (rather than just at specific network segments).

The use authentication and encryption via Kerberos requires the deployment of a Kerberos environment.

A key consideration here is that not all NFSv4-compatible services support Kerberos. Without Kerberos you are still able to use other features of NFSv4 but will not authenticate or encrypt data. When choosing your solution be sure to verify whether or not you need this capability and if the options support Kerberos.

**NFSv4 and network ports**

One advantage of NFSv4 over NFSv3 is that NFSv4 uses a single TCP port (port 2049) for all traffic. If you have a NFSv4 environment in an Azure vnet or located in your datacenter and need to provide access between firewalls, it is much simpler to support NFSv4.

**NFSv4 and ACLs**

Say you have a file/folder and you want to offer read-write access to group 1, read-only access to group 2 and append-data to a specific machine account.  NFSv3 permissions (mode bits) cannot satisfy the requirement because v3 permissions do not have the level of granularity desired in this example.

NFSv4 introduced the concept of Access Control Lists (ACLs). Each file/folder can have an ACL applied to it. Each ACL consists of one or more Access Control Entries (ACEs). This model is very familiar to Windows NTFS administrators as it follows the same model.

If your current environment leverages NFSv4 ACLs, you will need to determine which storage solution best matches this requirement.







    NFS v3 versus v4.x security


    Using Kerberos

