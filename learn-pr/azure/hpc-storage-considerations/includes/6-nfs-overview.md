### NFS Considerations ###

There are two main versions of the NFS protocol: NFSv3 and NFSv4.x. The full scope of these two versions' differences lies outside the goals of this module, but there are a handful of issues related to authentication and authorization that we will identify here. We will also not get into the history of the two protocols, or why there are two other than to say many users are still running NFSv3 in their environments.

**NFSv3 and Groups**

NFSv3 is a simple file system protocol that passes API requests to NFS servers for data. We mentioned earlier that a user is represented by their UID and have a primary group GID association. We also mentioned that a user may be associated with a larger number of groups. For NFS purposes, these additional group assignments are known as *auxiliary groups*. The UID and GID information are passed with requests, which the NFS server will use to determine the appropriate level of access.

NFSv3 has a limit in terms of the total number of GID values it passes. NFSv3 only supports the passing of 16 auxiliary groups for any given UID. The implication is that if you are currently using greater than 16 group assignments in meaningful ways (such as fine-grained access management), you may run into this limitation. NAS vendors such as NetApp have added an extension to the NFS protocol that supports the communication of all group mappings, known as **extended group** support. If you are assessing hpc storage and are using large numbers of GID assignments, you should very whether or not the proposed solution supports this capability.

**NFSv3 and network security**

NFSv3 is also limited in terms of security. If you are running NFSv3, you are aware that it doesn't really have many security features. It does not support data encryption or Kerberos authentication, for example. The main mechanisms available in a NFSv3 environment involve the use of **export rules and policies** to limit network-level access to the NFS server. An *export* is the mechanism a NFS server uses to expose a specific directory to clients. Export rules are configured to allow or disallow clients based on their IP network address. You can define host entries in an export rule (for example 1.1.1.1) or networks (for example 1.1.1.0/24) and allow/deny access to the export.  Export rules are gathered into an export policy which is associated to a specific export on the NFS server.

One particular challenge with NFSv3 is that it does not use a specific standard TCP port for communications. This makes allowing NFSv3 access challenging over a WAN given that while there are standard ports (RPC = 111 and NFS = 2049), other ports for mounting the export are randomly assigned ports.

**NFSv3 and encryption**

NFSv3 does not offer support for data encryption. It was originally designed for use within a trusted enterprise environment. Traffic leaving your trusted network must be encrypted by your network encryption solution.



NFSv4.x




    NFS v3 versus v4.x security

    Use of directory authentication/authorization
    LDAP
    Active Directory

    Using Kerberos

**NAS Security**

    security styles
    export rules and policies
    RFC2307 mapping

